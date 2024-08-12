{inputs, config, pkgs, ...}: {
  
  imports = [
    inputs.nvchad4nix.homeManagerModule
  ];

  home.username = "dogth";
  home.homeDirectory = "/home/dogth";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    firefox
    foot fuzzel yazi
    niri
    brightnessctl wl-clipboard bottom
    libva-utils
    devenv direnv
    git
  ];

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Dogth";
    userEmail = "dogth@kitteth.com";
    extraConfig = {
      user.signingKey = "6C1C958FC7058A2E";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "direnv" ];
    };
  };

  programs.foot = {
    enable = true;
    server.enable = true;
    settings.main = {
      dpi-aware = false;
      font = "JetBrainsMono Nerdfont:size=12";
      pad = "6x6";
    };
  };

  programs.nvchad = {
    enable = true;
    extraPackages = with pkgs; [
      nodePackages.bash-language-server
      docker-compose-language-service
      dockerfile-language-server-nodejs
      emmet-language-server
      nixd
      (python3.withPackages(ps: with ps; [
        python-lsp-server
        flake8
      ]))
    ];
    extraConfig = inputs.puppydog;
    hm-activation = true;
    backup = true;
  };
}
