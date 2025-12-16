{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles/.config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

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
      rand = "openssl rand -base64 12";
      v = "nvim";
      l = "ls -lh";
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -iv";
    };
    initExtra = ''
    __git_ref() {
      if git rev-parse --git-dir >/dev/null 2>&1; then
        local REF=$(
          git symbolic-ref --short HEAD --quiet || \
          git describe --tags --exact-match 2>/dev/null || \
          git rev-parse --short HEAD
        )
        echo " ($REF)" | awk -v len=15 '{ if (length($0) > len) print substr($0, 1, len-3) ".."; else print; }'
      fi
    }

    __git_status() {
      if [[ -n "$(__git_ref)" ]]; then
        local STATUS=$(git status 2>&1)
        if [[ $STATUS = *'Untracked files'* || $STATUS = *'Changes not staged for commit'* ]]; then echo -n "?"; fi
        if [[ $STATUS = *'Changes to be committed'* ]]; then echo -n "*"; fi
        if [[ $STATUS = *'Your branch is ahead'* ]]; then echo -n "^"; fi
      fi
    }

    export PS1='\[\033[32m\]\u@\h \[\e[1;34m\]\w\[\e[33m\]$(__git_ref)$(__git_status) \[\e[1;35m\]>\[\e[0m\] '
    export EDITOR=nvim

    source ~/.nix-profile/etc/profile.d/nix.sh
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
    nodejs
    zig
    jq
    yq
    git
    curl
    kubectl
    kustomize
    tree
  ];

}
