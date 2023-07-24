{ config
, pkgs
, ...
}: {
  home = {
    homeDirectory = "/home/yoolayn";

    packages = with pkgs; [
		bat
		bat-extras.batman
		btop
		coursier
		delta
		erdtree
		exa
		fd
		font-awesome
		fzf
		gh
		glow
		jdk17
		lazygit
		lua
		lua54Packages.luarocks
		neofetch
		nodejs_20
		qmk
		ripgrep
		rustup
		starship
		stow
		tree-sitter
        yarn
		yt-dlp
		zellij
    ];

    stateVersion = "23.05";
    username = "yoolayn";
  };
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  programs.home-manager.enable = true;
}
