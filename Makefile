wezterm:
	tempfile=$(mktemp) \
			 && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo \
			 && tic -x -o ~/.terminfo $tempfile \
			 && rm $tempfile

zsh:
	bash ./scripts/zsh.sh

bob:
	bash ./scripts/bob-nvim.sh

nvim:
	bash ./scripts/nvim.sh

stow:
	bash ./scripts/prestow.sh
	bash ./scripts/stow.sh

hack:
	bash ./scripts/font.sh

all: bob stow hack wezterm nvim zsh
