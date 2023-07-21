#!/bin/bash

BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'
RED='\033[0;31m'

rm -r ~/.config/systemd-scripts/

mkdir -p ~/.config/systemd/user
mkdir -p ~/.config/systemd-scripts/

echo "#!/bin/bash" >>~/.config/systemd-scripts/garbage.sh
echo "" >>~/.config/systemd-scripts/garbage.sh
echo "$HOME/.nix-profile/bin/nix-collect-garbage" >>~/.config/systemd-scripts/garbage.sh
chmod +x ~/.config/systemd-scripts/garbage.sh

echo "#!/bin/bash" >>~/.config/systemd-scripts/update.sh
echo "" >>~/.config/systemd-scripts/update.sh
echo -e "rm ~/.config/home-manager/*.nix" >>~/.config/systemd-scripts/update.sh
echo -e "cp $(pwd)/home-manager/*.nix ~/.config/home-manager/" >>~/.config/systemd-scripts/update.sh
chmod +x ~/.config/systemd-scripts/update.sh

bash systemd/create-service.sh

echo -e "${RED}run these commands now:"
echo -e "${BLUE}systemctl --user daemon-reload"
echo -e "${BLUE}systemctl --user enable --now collect-garbage.timer"
echo -e "${BLUE}systemctl --user enable --now homemngr-update.path${NC}"
