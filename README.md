# Nix

```bash
curl -L https://nixos.org/nix/install | sh
mkdir -p ~/.config/nix && echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf

source ~/.nix-profile/etc/profile.d/nix.sh

nix run github:nix-community/home-manager -- switch --flake .#chavi -b backup
```
