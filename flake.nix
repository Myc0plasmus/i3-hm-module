{
  description = "Home Manager i3 configuration of myc0plasmus";

  inputs = {
    # nixpkgs.url = "github:/nixos/nixpkgs?ref=nixos-unstable"; # Technically not needed, nixpkgs not used directly
    nixpkgs.url = "github:nixos/nixpkgs/c0b0e0fddf73fd517c3471e546c0df87a42d53f4"; #for clipit
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
    let
      mkPkgs = system:
        import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
    in
    {
      i3Module = {config, pkgs, lib, ...}:
      let
        pkgs' = mkPkgs pkgs.system;
      in
      import ./i3wm-module.nix {
        inherit  config pkgs lib inputs;
        internalPkgs = pkgs';
      };
    };
}
