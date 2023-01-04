#!/usr/bin/env -S deno run -A

import { exec, OutputMode } from "https://deno.land/x/exec/mod.ts";

const { output } = await exec(
  "kubectl get secret -n argocd argocd-initial-admin-secret -o json",
  { output: OutputMode.Capture }
);

const parsed = JSON.parse(output);
const password = parsed["data"]["password"];

await exec(`wl-copy ${password}`);

console.log("argo pw copied to clipboard");
