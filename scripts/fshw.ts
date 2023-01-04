#!/usr/bin/env -S deno run -A

import { exec } from "https://deno.land/x/exec/mod.ts";

await exec("nmcli connection up MyEvaluations");
await exec("code .");
await exec("docker compose up");
