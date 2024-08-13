{inputs, config, pkgs, ...}: {
  
  imports = [
    inputs.nvchad4nix.homeManagerModule
    inputs.niri.homeModules.niri
  ];

  home.username = "dogth";
  home.homeDirectory = "/home/dogth";
  home.stateVersion = "24.05";

##  environment.variables.NIXOS_OZONE_WL = "1";

  home.packages = with pkgs; [
    firefox
    foot fuzzel yazi
    brightnessctl wl-clipboard bottom
    libva-utils
    devenv direnv
    git
    thefuck
  ];

  programs.home-manager.enable = true;

  programs.thefuck = {
    enable = true;
  };

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
      plugins = [ "git" "direnv" "thefuck" ];
      theme = "agnoster";
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

  programs.fuzzel = {
    enable = true;
    settings.main.terminal = "foot";
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
    extraConfig = pkgs.fetchFromGitHub {
      owner = "Dogth";
      repo = "puppydog";
      rev = "63ca6d59394c22d93e3a4fcc404f1a967198b39a";
      sha256 = "sha256-vlHyILaMfmsUaKH7+29H8yDALtDwquZRCj0ooWqv+P8=";
      name = "puppy-configs";
    };
    hm-activation = true;
    backup = false;
  };

  programs.niri = {
    enable = true;
    settings = {

      outputs."eDP-1".scale = 1.0;

      input.keyboard.xkb.layout = "us";
      input.touchpad = {
        tap = true;
        dwt = false;
      };

      prefer-no-csd = true;
      
      layout = {
        gaps = 8;
        border.width = 0;
        default-column-width ={proportion = 1.0 / 2.0;};
      };

      hotkey-overlay.skip-at-startup = true;

      binds = with config.lib.niri.actions; {
        "Mod+D".action.spawn = "fuzzel";
        "Mod+Tab".action.spawn = "foot";
        "Mod+Plus".action = set-column-width "+10%";
        "Mod+F".action = maximize-column;
        "Mod+Q".action = close-window;
        "Mod+Shift+F".action = fullscreen-window;
      };
    };
  };
}
