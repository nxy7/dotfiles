{ pkgs, ... }: {
  programs.broot = {
    enable = true;

    enableNushellIntegration = true;
    settings.verbs = [{
      # [[verbs]]
      invocation = "edit";
      key = "enter";
      shortcut = "e";
      execution = "$EDITOR {file}:{line}";
      apply_to = "text_file";
      leave_broot = false;
    }];

  };
}
