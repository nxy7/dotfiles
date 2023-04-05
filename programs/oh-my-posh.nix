{
  enable = true;
  useTheme = "M365Princess";
  settings = builtins.fromJSON (builtins.readFile './posh-config.json');
}
