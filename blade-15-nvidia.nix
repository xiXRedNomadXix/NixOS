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

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  # Packages
  environment.systemPackages = with pkgs; [
  linuxKernel.packages.linux_zen.nvidia_x11_production
  # Packages for running GPU for pure computing
  cudaPackages.cudnn
  cudaPackages.cudatoolkit
  cudaPackages.cudnn_8_8
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

  };


  hardware.nvidia.prime = {
    sync.enable = true;

    # Make sure to use the correct Bus ID values for your system!
    nvidiaBusId = "PCI:Your nvidia bus ID here";
    intelBusId = "PCI:Your intel bus ID here";
  };
}
