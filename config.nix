{config, lib, pkgs, ...}:

{

environment = {
    defaultPackages = [ ];
    systemPackages = with pkgs; [
      acpi tlp git
      neovim wget 
      ifuse tpm2-tss 
      libimobiledevice
      pinentry-curses
    ];
  };

  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      roboto
      openmoji-color
      nerdfonts
    ];

    fontconfig = {
      hinting.autohint = true;
      defaultFonts = {
        emoji = [ "OpenMoji Color" ];
      };
    };
  };

  nix = {
    settings = {
      trusted-users = [ "root" "dogth" ];
      allowed-users = [ "dogth" ];
      experimental-features = [ "nix-command" "flakes" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  programs.zsh.enable = true;

  users.users.dogth = {
    isNormalUser = true;
    initialPassword = "woof";
    extraGroups = [ "input" "wheel" "tss" ];
    shell = pkgs.zsh;
  };

  security = {
    polkit.enable = true;
    tpm2.enable = true;
    tpm2.pkcs11.enable = true;
    tpm2.tctiEnvironment.enable = true;
  };

  hardware = {
    graphics = {
      enable = true;

      extraPackages = with pkgs; [
        amdvlk
        rocmPackages.clr.icd 
      ];
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Enable = "Source,Sink,Media,Socket";
    };
};

  networking = {
    hostName = "wuffmachine";
    networkmanager.enable = true;
    nameservers = [
      "1.1.1.1"
      "192.168.1.1"
    ];
  };

  programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

  services = {
    blueman.enable = true;
    ntp.enable = true;
    openssh.enable = true;
    usbmuxd.enable = true;
    libinput.enable = true;
    pcscd.enable = true;
    pipewire = {
      enable = true;
    };

  };

  fileSystems = {
	  "/".options = [ "subvol=root" "noatime" "compress=zstd" ];

	  "/home".options = [ "subvol=home" "noatime" "compress=zstd" ];

	  "/nix".options = [ "subvol=nix" "noatime" "compress=zstd" ];
  
	  "/persist" = {
	    neededForBoot = true;
	    options = [ "subvol=persist" "noatime" "compress=zstd" ];
	  };

	  "/var/log" = {
	    neededForBoot = true;
	    options = [ "subvol=log" "noatime" "compress=zstd" ];
	  };
  };

  system.stateVersion = "24.05";

}
