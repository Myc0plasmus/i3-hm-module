{
  description = "Home Manager i3 configuration of myc0plasmus";

  inputs = {
    # nixpkgs.url = "github:/nixos/nixpkgs?ref=nixos-unstable"; # Technically not needed, nixpkgs not used directly
    polybar-spotify = {
      url = "github:PrayagS/polybar-spotify";
      flake = false;
    };
    polybar-calendar = {
      url = "github:nevarman/polybar-calendar";
      flake = false;
    };
    polybar-scripts = {
      url = "github:/polybar/polybar-scripts";
      flake = false;
    };
  };

  outputs = inputs:
    {
      i3Module = {config, pkgs, lib, ...}:
      import ./i3wm-module.nix {
        inherit  config pkgs lib inputs;
      };
    };
}
