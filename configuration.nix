# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:


let
    unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in 
{
  #Packages
  environment.systemPackages = with pkgs; [
    pkgs.appimage-run
    unstable.ani-cli
    google-chrome
    nix-search-cli
    gparted
    wl-clipboard
    wget
    corefonts
    vistafonts
    unstable.vscode
    unstable.bluetuith
    unstable.xboxdrv
    unstable.python312Packages.pushbullet-py
    thunderbird
    fd
    zip
    vlc
    unstable.kdePackages.kdenlive
    unstable.davinci-resolve
    unstable.unityhub
    unstable.pnpm
    gh
    hollywood
    unstable.geckodriver
    hyprshot
    linuxKernel.packages.linux_6_6.vmware
    unstable.shutter
    unstable.obs-studio
    unstable.discord
    unstable.vulkan-tools
    unstable.vulkan-loader
    unstable.haskellPackages.vulkan
    unstable.vulkan-volk
    unstable.rust-analyzer
    unstable.pixelorama
    unstable.godot_4
    swaylock-fancy
    chromium
    git
    linuxKernel.packages.linux_6_6.cpupower
    unzip
    unstable.ipfetch
    unstable.onlyoffice-bin
    unstable.cargo
    htop
    curl
    neovide
    rofi-calc
    unstable.fastfetch
    root
    unstable.neovim
    unstable.waybar
    unstable.rustc
    unstable.rustup
    lua51Packages.lua
    unstable.jdk22
    unstable.libgcc
    unstable.go
    unstable.php
    unstable.nodejs_22
    unstable.php84Packages.composer
    unstable.rocmPackages_5.llvm.clang
    unstable.python312Packages.cmake
    unstable.gnumake
    unstable.dotnetCorePackages.sdk_8_0_3xx
    unstable.typescript
    unstable.luajitPackages.luarocks-nix
    unstable.ruby
    unstable.julia_19
    unstable.python312Packages.pip
    unstable.ripgrep
    unstable.tree-sitter
    unstable.hyprlock
    unstable.nextcloud-client
    unstable.greetd.tuigreet
    unstable.protonup
    unstable.python3
    unstable.greetd.greetd
    brightnessctl
    unstable.mangohud
    dunst
    swww
    helvum
    unstable.firefox
    unstable.scrcpy
    kitty
    rofi-wayland

  ];

  #VPN
  programs.openvpn3.enable = true;

  #Optimization
    nix.optimise.automatic = true;
    nix.settings.auto-optimise-store = false;
    
  #Garbage Collection
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

  #Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443];
    allowedUDPPorts = [ 5353 ];
  };

  #VMware
  virtualisation.vmware.host.enable = true; 

  #Updates
  system.autoUpgrade.enable  = true;
  system.autoUpgrade.allowReboot  = false;
    
  #Printing
  services.printing.enable = true;

  #SWAP
  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024;
  }];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  #Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  #Steam/Game Settings
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  #Nerd Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];
  
  #GPU Settings
  hardware = {
   opengl.enable = true;
   opengl.driSupport = true;
   opengl.driSupport32Bit = true;
   nvidia.modesetting.enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  #Hyprland and Settings
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    #WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = 
      "/home/ext4/.steam/root/compatibilitytools.d";
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  #Sound
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };


  #Hardware for XPS15
  imports =
  [ # Include the results of the hardware scan.
      <nixos-hardware/dell/xps/15-9560/nvidia>
      ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  nixpkgs.config.allowUnfree = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ext4 = {
    isNormalUser = true;
    description = "ext4";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
