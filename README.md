# Nix

```bash
# install nix - https://nixos.wiki/wiki/Nix_Installation_Guide
sudo install -d -m755 -o $(id -u) -g $(id -g) /nix
curl -L https://nixos.org/nix/install | sh
source $HOME/.nix-profile/etc/profile.d/nix.sh
mkdir -p $HOME/.config/nix && echo 'experimental-features = nix-command flakes' >> $HOME/.config/nix/nix.conf

# clone dots
git clone https://github.com/chavisr/dotfiles

# enjoy :) 
git clone https://github.com/chavisr/nix
nix run github:nix-community/home-manager -- switch --flake .#chavi -b backup
# or
nix run github:nix-community/home-manager -- switch --flake github:chavisr/nix#chavi -b backup --no-write-lock-file
```
