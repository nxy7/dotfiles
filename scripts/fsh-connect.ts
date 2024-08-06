#!/usr/bin/env -S deno run -A

import { exec } from "https://deno.land/x/exec/mod.ts";
import { sleep } from "https://deno.land/x/sleep/mod.ts";

let retry = 0;
while (retry < 20) {
  await exec("nmcli connection down MyEvaluations");
  const out = await exec("nmcli connection up MyEvaluations");
  if (out.status.code === 0) {
    await exec(`spd-say 'Connected to VPN'`);
    break;
  } else {
    retry = retry + 1;
    console.log(`Retry no. ${retry}`);
  }
  if (retry > 20) {
    await exec(`spd-say 'too many retries'`);
    break;
  }
  await sleep(1);
}
