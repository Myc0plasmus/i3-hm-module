{
  description = "Home Manager configuration of myc0plasmus";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:/nixos/nixpkgs?ref=nixos-unstable";
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
