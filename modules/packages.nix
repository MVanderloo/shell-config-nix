{ pkgs, ... }:

{
  config.home.packages = with pkgs; [
    choose
    coreutils
    diffnav
    fd
    just
    parallel
    prek
    readline
    rename
    rsync
    sd
    unzip
    watchexec
  ];
}
