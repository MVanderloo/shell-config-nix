{
  description = "My home-manager shell environment";

  outputs = { self, ... }: {
    homeModules = {
      default = import ./modules;
    };
  };
}
