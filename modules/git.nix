{ pkgs, config, ... }:

{
  config = {
    assertions = [
      {
        assertion = config.programs.git.settings.user.name != "";
        message = "shell-env: programs.git.settings.user.name is required";
      }
      {
        assertion = config.programs.git.settings.user.email != "";
        message = "shell-env: programs.git.settings.user.email is required";
      }
    ];

    home.packages = with pkgs; [
      git-filter-repo
    ];

    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      enableJujutsuIntegration = true;
      options = {
        syntax-theme = "ansi";
        navigate = true;
        max-line-distance = 1;
        relative-paths = true;
        inspect-raw-lines = false;
        hyperlinks = true;
        hyperlinks-file-link-format = "nvim +{line} {path}";
        zero-style = "dim normal";
        plus-style = "green normal";
        plus-emph-style = "brightgreen normal reverse";
        plus-non-emph-style = "green";
        minus-style = "red normal";
        minus-emph-style = "brightred normal reverse";
        minus-non-emph-style = "red";
        file-style = "bold";
        hunk-header-style = "omit";
        hunk-header-file-style = "normal";
        hunk-header-line-number-style = "normal";
        line-numbers = true;
        line-numbers-left-style = "normal";
        line-numbers-right-style = "normal";
        line-numbers-minus-style = "red";
        line-numbers-plus-style = "green";
        line-numbers-zero-style = "dim normal";
        side-by-side = false;
        line-numbers-left-format = " {nm:>}│";
        line-numbers-right-format = "{np:<} │";
        blame-code-style = "syntax";
        blame-palette = "normal";
        blame-format = "{author} - {timestamp}";
      };
    };

    programs.git = {
      enable = true;
      extraPackages = with pkgs; [ glab ];
      ignores = [
        "*.env"
        ".DS_Store"
        "Thumbs.db"
      ];
      settings = {
        alias = {
          co = "checkout";
          sm = "submodule";
          sw = "switch";
          st = "status";
          graph = "log --graph --all";
          ignore = "!f() { IFS=','; curl -sL \"https://www.toptal.com/developers/gitignore/api/$*\"; }; f";
          stashgrep = "!f() { for i in $(git stash list --format='%gd'); do git stash show -p $i | grep -H --label=\"$i\" \"$@\"; done; }; f";
        };
        url = {
          "git@github.com:".insteadOf = "gh:";
          "git@gitlab.com:".insteadOf = "gl:";
          "git@codeberg.org:".insteadOf = "cb:";
        };
        branch.autosetupmerge = "always";
        branch.autosetuprebase = "remote";
        branch.sort = "-committerdate";
        commit.verbose = true;
        core = {
          compression = 9;
          logAllRefUpdates = true;
          preloadindex = true;
          whitespace = "trailing-space";
        };
        diff = {
          algorithm = "histogram";
          colorMoved = "zebra";
          colorMovedWS = "allow-indentation-change";
          context = 8;
          interHunkContext = 10;
          mnemonicPrefix = true;
          renames = "copies";
          tool = "nvimdiff";
          guitool = "nvimdiff";
          prompt = false;
        };
        interactive.singleKey = true;
        difftool = {
          prompt = false;
          "nvimdiff".cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";
        };
        blame.coloring = "highlightRecent";
        format.pretty = "format:%C(yellow)%h%C(reset)%C(auto)%d%C(reset) - %C(white)%s%C(reset) %C(blue)(%ar)%C(reset) %C(dim white)- %an%C(reset)";
        init.defaultBranch = "main";
        maintenance.auto = true;
        maintenance.strategy = "incremental";
        merge.autoStash = true;
        merge.conflictStyle = "zdiff3";
        merge.tool = "nvimdiff";
        mergetool = {
          prompt = false;
          keepBackup = false;
          "nvimdiff".layout = "LOCAL,BASE,REMOTE / MERGED";
        };
        push.autoSetupRemote = true;
        push.default = "current";
        pull.rebase = "merges";
        rerere.autoUpdate = true;
        rerere.enabled = true;
        rebase.autoSquash = true;
        rebase.autoStash = true;
        submodule.fetchJobs = 0;
        submodule.recurse = true;
        status.branch = true;
        status.showStash = true;
        status.showUntrackedFiles = "all";
        tag.sort = "-version:refname";
      };
    };

    programs.gh = {
      enable = true;
      settings.protocol = "ssh";
    };

    programs.lazygit = {
      enable = true;
      shellWrapperName = "lag";
    };
  };
}
