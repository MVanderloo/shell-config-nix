{ pkgs, lib, ... }:

{
  config = {
    home.shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      la = "eza -a";
      ll = "eza -la";
      ls = "eza";
      trea = "eza -a --tree --level=3";
      tree = "eza --tree --level=3";
    };

    programs = {
      atuin = {
        enable = true;
        flags = [ "--disable-up-arrow" ];
        forceOverwriteSettings = true;
        daemon.enable = lib.mkDefault true;
        settings = {
          update_check = false;
          style = "compact";
          inline_height = 15;
          show_numeric_shortcuts = false;
          max_preview_height = 4;
          show_help = false;
          show_tabs = false;
          prefers_reduced_motion = true;
          ui.columns = [
            "exit"
            "time"
            "duration"
            "command"
          ];
          search_mode = lib.mkDefault "daemon-fuzzy";
          secrets_filter = true;
          enter_accept = true;
          command_chaining = true;
          filter_mode = "host";
          search.filters = [
            "workspace"
            "host"
            "directory"
            "global"
          ];
          filter_mode_shell_up_key_binding = "session";
        };
      };

      bat = {
        enable = true;
        config.theme = "ansi";
      };

      btop = {
        enable = true;
        settings = {
          theme_background = true;
          vim_keys = true;
          rounded_corners = true;
          update_ms = 200;
          base_10_sizes = false;
          background_update = true;
          base_10_bitrate = "Auto";
          graph_symbol = "braille";
          proc_sorting = "memory";
          show_battery = true;
          show_battery_watts = true;
        };
      };

      eza = {
        enable = true;
        colors = "auto";
        icons = "auto";
        extraOptions = [
          "--classify"
          "--color-scale=size"
          "--color-scale-mode=fixed"
          "--group-directories-first"
          "--time-style=long-iso"
        ];
      };

      fd = {
        enable = true;
        hidden = true;
        ignores = [
          ".git/"
          ".jj/"
          ".venv/"
          "node_modules/"
        ];
        extraOptions = [ "--no-ignore-vcs" ];
      };

      fzf = {
        enable = true;
        defaultCommand = "fd";
        changeDirWidget = {
          command = "fd --type d";
          options = [ "--preview 'eza --tree --level=3 --color=always {}'" ];
        };
        fileWidget = {
          command = "fd";
          options = [
            "--preview 'bat --color=always --style=plain {} 2>/dev/null || eza --tree --level=2 --color=always {}'"
            "--preview-window=right:60%:border-left"
          ];
        };
        historyWidget.command = "";
        defaultOptions = [
          "--border=bold"
          "--color=border:7"
          "--color=prompt:2"
          "--scrollbar=''"
          "--gutter=' '"
          "--info=inline-right"
          "--color=info:8"
          "--marker=' '"
          "--color=marker:1"
          "--pointer='󰁕'"
          "--color=pointer:9"
          "--color=label:15:bold"
          "--color=spinner:9"
          "--color=header:4"
          "--color=fg:8:bold,fg+:15,selected-fg:15:bold"
          "--color=bg:-1,bg+:-1,selected-bg:-1"
          "--color=hl:10:bold,hl+:10:bold,selected-hl:10:bold"
        ];
      };

      less = {
        enable = true;
        config = "#command\nh left-scroll\nl right-scroll";
      };

      man = {
        enable = true;
        generateCaches = false;
        package = pkgs.man-db;
      };

      starship = {
        enable = true;
        presets = [ "nerd-font-symbols" ];
      };

      tealdeer.enable = true;

      ripgrep.enable = true;

      yazi.enable = true;

      zoxide.enable = true;
    };
  };
}
