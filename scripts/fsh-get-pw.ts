#!/usr/bin/env -S deno run -A

import { parse } from "jsr:@std/yaml";
import { exec } from "https://deno.land/x/exec/mod.ts";
import dir from "https://deno.land/x/dir/mod.ts";

const dotfilesDir = `${dir("home")}/dotfiles`;

const text = await Deno.readTextFile(`${dotfilesDir}/s`);

const parsed = parse(text) as Record<string, string>;

const password = parsed["Password"];

await exec(`wl-copy ${password}`);

console.log("fsh password copied to clipboard");
