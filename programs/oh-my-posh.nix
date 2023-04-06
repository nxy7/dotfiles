{
  enable = true;
  useTheme = "M365Princess";
  settings = builtins.fromJSON (builtins.readFile ./1_shell_posh.json);
}
