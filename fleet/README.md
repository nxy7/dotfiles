# fleet — Raspberry Pi 4 GitHub Actions Runners

NixOS SD image that boots into **2 isolated self-hosted GitHub Actions
runners** for [nxy7/cogni](https://github.com/nxy7/cogni).

Each runner is a separate systemd service with strong isolation:
- **DynamicUser** — ephemeral UID per runner, no shared home directory
- **PrivateTmp** — isolated `/tmp` mount per runner
- **ProtectHome / ProtectSystem=strict** — runners can't read user homes or write to `/`
- **NoNewPrivileges, PrivateDevices, RestrictNamespaces** — locked-down capabilities

They share a single PAT file but run completely independently. To change
the count, edit `runnerCount` in `fleet/flake.nix`.

## Prerequisites

1. **Linux builder** — Building an `aarch64-linux` SD image from macOS
   requires a Linux builder.  The `nix.linux-builder.enable = true` option
   in `darwin/default.nix` spins up a lightweight NixOS VM via Apple
   Virtualization Framework.  Apply it once:

   ```bash
   darwin-rebuild switch --flake ~/dotfiles
   ```

   After the first switch the builder VM starts automatically.  Subsequent
   `nix build` calls for Linux targets are transparently forwarded to it.

2. **SD card** — Any microSD ≥ 8 GB.

## Build

```bash
cd ~/dotfiles

# WIFI_PASSWORD is baked into the image so it can join your network on
# first boot.  --impure lets the flake read the environment variable.
WIFI_PASSWORD="your-wifi-password" nix build ./fleet#sdImage --impure
```

The result is a compressed image at `./result/sd-image/nixos-sd-image-*.img.zst`.

## Flash

```bash
# Find your SD card
diskutil list external

# Unmount (do NOT eject)
diskutil unmountDisk /dev/diskN

# Flash (use /dev/rdiskN for raw speed)
zstdcat ./result/sd-image/nixos-sd-image-*.img.zst | sudo dd of=/dev/rdiskN bs=4M status=progress

# Eject safely
diskutil eject /dev/diskN
```

## First boot

1. Insert the SD card into the Pi 4 and power it on.
2. Wait ~60 s for it to get a DHCP lease and advertise via mDNS.
3. SSH in:

   ```bash
   ssh admin@pi-runner.local
   ```

4. Drop the GitHub PAT (a fine-grained token with `Administration: Read & Write`
   scope on `nxy7/cogni`, or a classic PAT with `repo` scope):

   ```bash
   sudo bash -c 'echo "ghp_YOUR_TOKEN" > /var/lib/github-runner-token'
   sudo chmod 600 /var/lib/github-runner-token

   # Both runner services start automatically once the file exists.
   sudo systemctl start github-runner-cogni-1
   sudo systemctl start github-runner-cogni-2
   ```

5. Verify:

   ```bash
   systemctl status 'github-runner-cogni-*'
   ```

   Two runners appear as **pi-runner-1** and **pi-runner-2** with the
   `rpi` label in the repo's Settings → Actions → Runners page.

## Updating

Edit `fleet/flake.nix`, rebuild the image, and reflash.  For in-place
updates after the first boot you can also `nixos-rebuild switch` on the
Pi itself (or remotely via `--target-host`).
