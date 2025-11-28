{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles/.config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  # Standard .config/directory
  configs = {
    nvim = "nvim";
  };
in

{
  home.username = "chavi";
  home.homeDirectory = "/home/chavi";
  programs.git.enable = true;
  home.stateVersion = "25.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nix-btw";
    };
    initExtra = ''
    export PS1="\[\033[32m\]\u@\h \[\e[1;34m\]\w\[\e[33m\] \[\e[1;35m\]>\[\e[0m\] "
    '';
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.packages = with pkgs; [
    neovim
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    jq
    yq
  ];

}
