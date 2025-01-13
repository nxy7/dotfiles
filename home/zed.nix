{ pkgs, ... }: {
  programs.zed-editor.enable = true;
  programs.zed-editor.package = pkgs.zed-editor;
  programs.zed-editor.userSettings = {
    "inline_completion_provider" = "supermaven";
    "vim_mode" = true;
    "ui_font_family" = "FiraCode Nerd Font";
    "autosave" = "on_focus_change";
    "use_smartcase_search" = true;
    "ui_font_size" = 16;
    "buffer_font_size" = 16;
    "relative_line_numbers" = true;
    "bindings" = { "escape" = [ "vim::SwitchMode" "HelixNormal" ]; };
    "theme" = {
      "mode" = "system";
      "light" = "One Light";
      "dark" = "Github Dark Dimmed";
    };
    "lsp" = { "elixir-ls" = { "settings" = { "projectDir" = "backend"; }; }; };
  };

  programs.zed-editor.extensions = [ "git-firefly" "sql" "svelte" ];
}
