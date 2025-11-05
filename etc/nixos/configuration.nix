{ config, pkgs, ... }:
#
{
  imports = [
    ./hardware-configuration.nix
  ];

    # === Bootloader ===
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 3;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;

  #boot.loader.grub = {
    #enable = true;
    #efiSupport = true;
    #devices = [ "nodev" ];
    #useOSProber = true;
    #configurationLimit = 3;
    #timeout = 0;
  #};

  # === Kernel ===
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.tmp.cleanOnBoot = true;

  boot.initrd.kernelModules = [ "nvidia" "i915" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  boot.kernelParams = [
  "nvidia-drm.modeset=1"
  #"acpi_osi=Linux"
  ];

  #boot.extraModprobeConfig = ''
  #  options nvidia NVreg_OpenRmEnableUnsupportedGpus=1
  #'';

  # Bagian di configuration.nix
nix = {
  binaryCaches = [ "https://cache.nixos.org/" ];
  # ...
};

  nix.gc = {
  automatic = true;
  dates = "daily";
  options = "--delete-older-than 2d --max-freed 10G";
  };
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";

  # === Audio ===
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # === Display Server & Desktop ===
  services.xserver = {
    enable = false;
    videoDrivers = [ "nvidia" "intel" ];
  };

  services.displayManager.sddm = {
    enable = false;
    wayland.enable = true;
  };
  services.displayManager.defaultSession = "hyprland";
  services.desktopManager.plasma6.enable = true;
  services.getty.autologinUser = "regawaras";
  
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # === GPU & NVIDIA ===
  hardware.graphics = {
    enable = true;
    extraPackages = with config.boot.kernelPackages; [
    nvidiaPackages.stable
    ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    dynamicBoost.enable = false;
    nvidiaPersistenced = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      sync.enable = false;
    };
  };

  nixpkgs.config.cudaSupport = true;
  nixpkgs.config.allowUnfree = true;

  # === User ===
  users.users.regawaras = {
    isNormalUser = true;
    description = "regawaras";
    extraGroups = [ "networkmanager" "wheel" "video" "adbusers" "docker" ];
    shell = pkgs.bash;
  };

    security.sudo.extraRules = [
    {
      # This rule allows myusername to run any command with sudo without a password
      users = [ "regawaras" ];
      commands = [ {
        command = "ALL";
        options = [ "NOPASSWD" ];
      } ];
    }
  ];

  #virtualisation.docker = {
  #  enable = true;
  #  enableNvidia = true;
  #  enableOnBoot = true;
  #  package = pkgs.docker_25;
  #};

  hardware.nvidia-container-toolkit.enable = true;

  # === Packages ===
  environment.systemPackages = with pkgs; [
    # Qt5 packages
    #qt5.qtbase
    #qt5.qtdeclarative
    #qt5.qtwebsockets
    #qt5.qtwebchannel
    #qt5.qtmultimedia
    #qt5.qtwebengine

    # Qt6 packages
    #qt6.qtbase
    #qt6.qtdeclarative
    #qt6.qtwebsockets
    #qt6.qtwebchannel
    #qt6.qtmultimedia
    #qt6.qtwebengine   

    #pkgs.ly
    vim
    #emacs
    #neovim
    #zed-editor
    #wget
    git
    gemini-cli
    efibootmgr
    ffmpeg
    aichat
    htop
    nvtopPackages.nvidia
    mpv
    #neofetch
    fastfetch
    jp2a
    cava
    brightnessctl
    cmatrix
    #nmap
    #whois
    #sqlmap
    #wireshark
    #exiftool
    grim
    #slurp

    #pkgs.cudaPackages_11_8
    #pip
    #lynx

    obsidian
    krita
    #blender
    brave
    #davinci-resolve
    ntfs3g
    #steam
    #steam-run
    #discord
    pkgs.tty-clock
    #docker
    

    networkmanagerapplet
    qt5.qtwayland
    qt6.qtwayland
    kitty
    waybar
    wofi
    rofi
    swww
    nwg-look

    kdePackages.polkit-kde-agent-1
    #kdePackages.kdenlive
    kdePackages.partitionmanager

    #mpd
    #dunst
    #spotify

    pkgs.cudatoolkit
    #pkgs.cudaPackages.cuda_11_8.cudatoolkit
    cudaPackages.cudnn
    mesa-demos # Menyediakan glxinfo
    vulkan-tools # Menyediakan vulkaninfo untuk Vulkan
    clinfo
    nvidia-vaapi-driver
    #scrcpy
    #android-tools
  ];

fonts.packages = with pkgs; [
  noto-fonts
  noto-fonts-cjk-sans
  noto-fonts-emoji
  liberation_ttf
  fira-code
  fira-code-symbols
  mplus-outline-fonts.githubRelease
  roboto-mono
  open-sans
];

  # === Environment Variables (Wayland + NVIDIA) ===
  environment.sessionVariables = {
    GBM_BACKEND = "nvidia-drm";
    NIXOS_OZONE_WL = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
    QT_QPA_PLATFORM = "wayland";
    OBS_USE_EGL = "1";
  };

  # === Applications ===
  programs.adb.enable = true;
  programs.kdeconnect.enable = true;
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;
  };
  programs.steam.enable = true;
  programs.obs-studio.enable = true;
  #programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    zlib
    stdenv.cc.cc.lib
 ];

  # === Hyprland ===
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # === Random Services ===
  services.resolved.enable = true; #for DNS
  #services.printing.enable = true;
  services.upower.enable = true;
  services.fwupd.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services.devmon.enable = true;
  services.gvfs.enable = true;
  security.polkit.enable = true;
  services.udisks2.enable = true;

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # === System services ===
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    xdgOpenUsePortal = true;
    config.common.default = "hyprland";
  };

  system.stateVersion = "25.05";
}
