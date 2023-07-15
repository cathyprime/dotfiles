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
      gh
      glow
      lazygit
      lua54Packages.luarocks
      neofetch
      nodejs_20
      qmk
      ripgrep
      rustup
      jdk17
      starship
      stow
      tree-sitter
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
