# fleet — G5 GitHub Actions runner

NixOS config that turns the Gigabyte G5 laptop into a dedicated, headless,
lid-closed self-hosted GitHub Actions runner for
[WCEEN/cogni](https://github.com/WCEEN/cogni).

| File | What it does |
|---|---|
| `g5-runner/configuration.nix` | Laptop as a server: no sleep, lid ignored, panel off, 80% battery cap, Ethernet with Wi-Fi fallback, SSH, Nix GC |
| `g5-runner/runners.nix` | The runners and their rootless Docker |
| `g5-runner/hardware-configuration.nix` | Generated on the laptop: disks by UUID, kernel modules |

The RTX 4060 is powered off entirely (nixos-hardware `common-gpu-nvidia-disable`).

## Isolation

- Each runner is its own system user (`runner-1`, …), in neither `docker`
  nor `wheel`.
- Each runner user has its **own rootless Docker daemon**. Job containers,
  including service containers like Postgres, run inside that user's
  namespace, so a job can't get root on the host through Docker.
- **Ephemeral**: one job per registration, then the runner deregisters and
  re-registers with a wiped state and work directory. The Nix store and each
  runner's Docker images persist, so caches survive between jobs.
- The GitHub token is read by root at startup and hidden from the runner
  process.
- Only SSH (key-only) is open in the firewall. Rootless Docker's published
  ports don't bypass the firewall the way rootful Docker's do.

Five runners (`runnerCount` in `g5-runner/runners.nix`), so up to five jobs
run at once. Job steps run directly on the laptop, so they share its ports:
workflows have to publish service containers on random host ports
(`ports: - 5432`), and anything else a job listens on can't use a fixed port
either.

## Switching the existing NixOS install (keeps the disk)

The G5 already runs NixOS with systemd-boot, so it can switch to this config
in place. Do it at the laptop's keyboard, because the desktop config has no
SSH server.

1. Pull this repo on the laptop (push it from the Mac first).
2. Use the laptop's real disk layout instead of the label-based file:

   ```bash
   cd ~/dotfiles
   cp /etc/nixos/hardware-configuration.nix fleet/g5-runner/hardware-configuration.nix
   grep -n luks fleet/g5-runner/hardware-configuration.nix   # should print nothing
   getent passwd 901                                          # should print nothing
   ```

   If `grep` finds `luks`, the disk is encrypted. The runner would then stop
   at a passphrase prompt after every reboot or power cut. Use the reinstall
   below instead.

   Commit and push the copied file. Otherwise the next deploy from the Mac
   brings back the label-based file, and that generation won't find its disks.
3. Plug in Ethernet. Wi-Fi saved in NetworkManager doesn't carry over.
4. Build the runner config and make it the next boot. Use `boot`, not
   `switch`: switching live would stop GDM and NetworkManager halfway through.

   ```bash
   sudo nixos-rebuild boot --flake ./fleet#g5-runner
   sudo reboot
   ```

5. Continue with [First boot](#first-boot) from the Mac.

What changes:

- The `nxyt` account is removed. `/home/nxyt` and the old rootful Docker
  data in `/var/lib/docker` stay on disk. Once nothing in them is needed:
  `sudo rm -rf /home/nxyt /var/lib/docker` (this also frees the Nix store
  paths that nxyt's Home Manager generations keep alive).
- `admin` has no password, only the SSH key. For keyboard login at the
  laptop, run `sudo passwd admin` once you're in over SSH.
- **Rollback**: the desktop generations stay in the systemd-boot menu until
  the weekly GC deletes generations older than 7 days.
- The desktop kept the hardware clock in local time
  (`time.hardwareClockInLocalTime`), which leaves the runner config an hour
  off at boot. Run `sudo timedatectl set-local-rtc 0` once.

## Fresh install (wipes the laptop)

Back up anything you still need from the laptop first.

1. Push this directory to GitHub (the installer pulls the config from there).
2. Boot the [NixOS 26.05 minimal ISO](https://nixos.org/download/) from USB,
   with Ethernet plugged in.
3. Partition. Check the disk name with `lsblk` first; it's usually
   `/dev/nvme0n1`, but the G5 has room for a second SSD.

   ```bash
   sudo -i
   DISK=/dev/nvme0n1
   parted $DISK -- mklabel gpt
   parted $DISK -- mkpart ESP fat32 1MiB 1GiB
   parted $DISK -- set 1 esp on
   parted $DISK -- mkpart root ext4 1GiB 100%
   mkfs.fat -F 32 -n boot ${DISK}p1
   mkfs.ext4 -L nixos ${DISK}p2
   mount /dev/disk/by-label/nixos /mnt
   mkdir -p /mnt/boot
   mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
   ```

4. New partitions get new UUIDs, so replace
   `g5-runner/hardware-configuration.nix` with this output, then commit and
   push it:

   ```bash
   nixos-generate-config --root /mnt --show-hardware-config
   ```

5. Install, with no root password (log in as `admin` with your SSH key):

   ```bash
   export NIX_CONFIG="experimental-features = nix-command flakes"
   nixos-install --no-root-passwd --flake 'github:nxy7/dotfiles?dir=fleet#g5-runner'
   reboot
   ```

## First boot

```bash
ssh admin@g5-runner.local
```

1. **GitHub token.** Create a fine-grained PAT with resource owner `WCEEN`,
   repository access limited to `cogni`, and permission
   **Administration: Read and write** (needed to register runners; the org
   may have to approve the token). Ephemeral runners re-register after every
   job, so this has to be a PAT, not a one-hour registration token.

   `read -s` keeps the token out of the terminal and shell history:

   ```bash
   read -rsp 'PAT: ' t; printf '%s\n' "$t" | sudo install -m 600 /dev/stdin /var/lib/github-runner-token; unset t
   sudo systemctl start github-runner-cogni-{1..5}
   ```

2. **Wi-Fi fallback** (optional; Ethernet works without it):

   ```bash
   read -rsp 'Wi-Fi password: ' p; printf 'home_psk=%s\n' "$p" | sudo install -D -m 600 /dev/stdin /var/lib/wireless/secrets; unset p
   sudo systemctl restart wpa_supplicant
   ```

3. **Check it:**

   ```bash
   systemctl status github-runner-cogni-1        # registered and listening
   systemctl status battery-charge-limit          # "skipped" = firmware has no charge limit
   sudo -u runner-1 DOCKER_HOST=unix:///run/user/901/docker.sock docker info   # rootless Docker is up
   ```

   The runners show up as **g5-runner-1** to **g5-runner-5** under
   WCEEN/cogni → Settings → Actions → Runners. If `battery-charge-limit` was skipped, look for a charge
   limit in the BIOS, or take the battery out (it runs fine on AC alone).

## Deploying changes

Push to GitHub. Every night at 04:00 the laptop rebuilds from
`github:nxy7/dotfiles?dir=fleet#g5-runner` (`system.autoUpgrade`; the repo is
public, so it needs no credentials). To apply a push right away:

```bash
ssh admin@g5-runner.local sudo systemctl start nixos-upgrade   # waits until done
ssh admin@g5-runner.local journalctl -u nixos-upgrade -e        # if it failed
```

To try a change before pushing, build it on the G5 from the Mac checkout (no
Linux builder needed on the Mac). The next nightly rebuild replaces it with
whatever is on GitHub.

```bash
cd ~/dotfiles
git add fleet   # flakes only see files git tracks
nix run nixpkgs#nixos-rebuild-ng -- switch \
  --flake ./fleet#g5-runner \
  --target-host admin@g5-runner.local \
  --build-host admin@g5-runner.local \
  --sudo
```

## Sending jobs to it

Nothing in cogni targets it yet. A job opts in with:

```yaml
runs-on: [self-hosted, nixos, g5]
```

Things that differ from GitHub's hosted `ubuntu-24.04-arm` runners:

- **Architecture**: the G5 is x86_64. cogni's flake builds for both, so
  Nix-based jobs (backend tests, tsz-quality) work. Jobs that publish arm64
  images should stay on hosted ARM runners.
- **No apt or sudo**: steps like `playwright install-deps` (which runs
  `sudo apt-get`) won't work on NixOS and have to be skipped here.
- **Downloaded binaries** (Playwright's Chromium, NuGet native assets) run
  through nix-ld. If one fails with "error while loading shared libraries:
  libfoo.so", add the package providing it to `programs.nix-ld.libraries` in
  `g5-runner/runners.nix`.
- **Nix is already installed**, so steps that install Nix should be skipped
  on this runner.

## Retiring the Raspberry Pi

The Pi config that used to live here has been removed. To finish:

1. Remove the Pi's runners (**pi-runner-1**, **pi-runner-2**) from the repo
   they registered with (`nxy7/cogni`) under Settings → Actions → Runners.
2. Revoke the PAT stored on the Pi, then power it off.
