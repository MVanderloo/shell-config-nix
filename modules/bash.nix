{ lib, config, ... }:

{
  config = {
    home.file = {
      ".bash_logout".enable = lib.mkForce false;
      ".bash_profile".enable = lib.mkForce false;
      ".bashrc".enable = lib.mkForce false;
      ".profile".enable = lib.mkForce false;
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
