# Most of this is from the NixOS wiki
# 1. sudo nano /etc/nixos/blade-15-nvidia.nix
# 2. copy and paste this configuration into the file.
# 3. Save and exit the file
# 4. sudo nano /etc/nixos/configuration.nix
# 5. Add "./blade-15-nvidia.nix" to the import string at the top of the configuration.
# 6. Run the following command: sudo nixos-rebuild switch


{ config, lib, pkgs, ... }:
{

  # Nvidia Driver
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Disable Novue
  services.xserver.videoDrivers = [ "nvidia" ]

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  # Packages
  environment.systemPackages = with pkgs; [
  nvidia-x11
  nvidia-settings
  nvidia-persistenced
];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
        # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  ...

{
  hardware.nvidia.prime = {
    sync.enable = true;

    # Make sure to use the correct Bus ID values for your system!
    nvidiaBusId = "PCI:14:0:0";
    intelBusId = "PCI:0:2:0";
  };
}



}
