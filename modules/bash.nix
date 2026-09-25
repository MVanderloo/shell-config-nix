{ lib, config, ... }:

{
  config = {
    home.file = {
      ".bash_logout".enable = lib.mkForce false;
      ".bash_profile".enable = lib.mkForce false;
      ".bashrc".enable = lib.mkForce false;
      ".profile".enable = lib.mkForce false;
    };

    # Keep the generated startup files available to the host's XDG Bash hooks.
    xdg.configFile = {
      "bash/bash_logout" = lib.mkIf (config.programs.bash.logoutExtra != "") {
        source = config.home.file.".bash_logout".source;
      };
      "bash/bashrc".source = config.home.file.".bashrc".source;
      "bash/profile".source = config.home.file.".profile".source;
    };

    programs = {
      bash = {
        enable = true;
        historyControl = [
          "erasedups"
          "ignoredups"
        ];
        historyFile = "${config.xdg.stateHome}/bash/history";
        historyFileSize = 100000;
        historySize = 100000;
        shellOptions = [
          "histappend"
          "extglob"
          "globstar"
          "dirspell"
        ];
        initExtra = ''
          PROMPT_COMMAND=""
          PS1="\[\\033[01;34m\\]\\u@\\h:\\w\\$\\[\\033[00m\\] "

          cd() {
            builtin cd "$@" && ls -a
          }
        '';
      };

      dircolors.enableBashIntegration = true;
      direnv.enableBashIntegration = true;
      yazi.enableBashIntegration = true;
      zoxide.enableBashIntegration = true;
    };
  };
}
