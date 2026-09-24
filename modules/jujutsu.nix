{ pkgs, lib, config, ... }:

with lib;

{
  config = {
    assertions = [
      {
        assertion = config.programs.jujutsu.settings.user.name != "";
        message = "shell-env: programs.jujutsu.settings.user.name is required";
      }
      {
        assertion = config.programs.jujutsu.settings.user.email != "";
        message = "shell-env: programs.jujutsu.settings.user.email is required";
      }
    ];

    home.packages = with pkgs; [ tuicr worktrunk ];

    programs.jujutsu = {
      enable = true;
      settings = {
        ui.default-command = "logstatus";
        ui.editor = "nvim";
        git.pushNewBookmarks = true;
        aliases = {
          accuse = [ "file" "annotate" ];
          fetch = [ "git" "fetch" ];
          logstatus = [ "log" "-T" "log_with_current_files" ];
          push = [ "git" "push" ];
          rebase-all = [ "rebase" "-s" "(::trunk())+" "-d" "trunk()" ];
          update-branch = [ "bookmark" "move" "--to" "@-" ];
        };
        template-aliases.log_with_current_files = "builtin_log_compact ++ if(current_working_copy, diff.summary())";
      };
    };
  };
}
