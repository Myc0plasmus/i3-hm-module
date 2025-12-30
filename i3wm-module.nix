{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

let
  lockscript = import ./scripts/lockscript.nix { inherit pkgs; };
  monitorScript = import ./scripts/monitorScript.nix { inherit pkgs; };
  batteryScript = import ./scripts/batteryScript.nix { inherit pkgs; };
  launchPolybar = import ./scripts/launchPolybar.nix { inherit pkgs; };
  resetWallpaperLock = import ./scripts/resetWallpaperLock.nix { inherit pkgs; };
in
{
  imports = [
    ./i3wm-config/i3-config.nix
    ./i3wm-config/polybar.nix
    ./i3wm-config/i3-rofi.nix
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    lockscript
    monitorScript
    batteryScript
    launchPolybar
    resetWallpaperLock

    pkgs.brave
    pkgs.ripgrep
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/user-wallpapers".source = ./dotfiles/user-wallpapers;
    ".config/polybar-spotify".source = inputs.polybar-spotify;
    ".config/polybar-calendar".source = inputs.polybar-calendar;
    ".config/polybar-scripts".source = inputs.polybar-scripts;

    #linking those scripts to .local/bin doesn't seem to put them in path
    # ".local/bin/lockscript".source = "${lockscript}/bin/lockscript";
    # ".local/bin/monitorScript".source = "${monitorScript}/bin/monitorScript";
    # ".local/bin/batteryScript".source = "${batteryScript}/bin/batteryScript";
    # ".local/bin/launchPolybar".source = "${launchPolybar}/bin/launchPolybar";
    # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };


  stylix.image = ./dotfiles/user-wallpapers/wp12329536-nixos-wallpapers.png;

  stylix.targets = {
    i3.enable = false;
    rofi.enable = false;
  };

  stylix.cursor = {
    package = pkgs.catppuccin-cursors.frappeDark;
    name = "catppuccin-frappe-dark-cursors";
    size = 25;
  };
}
