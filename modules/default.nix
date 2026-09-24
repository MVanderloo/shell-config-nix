{
  pkgs,
  lib,
  config,
  ...
}:

{
  config = lib.mkMerge [
    (import ./bash.nix { inherit pkgs lib config; })
    (import ./fish.nix { inherit pkgs lib config; })
    (import ./git.nix { inherit pkgs lib config; })
    (import ./jujutsu.nix { inherit pkgs lib config; })
    (import ./packages.nix { inherit pkgs lib config; })
    (import ./shell-aliases.nix { inherit pkgs lib config; })
  ];
}
