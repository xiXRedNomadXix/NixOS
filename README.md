## Razer Blade-15 Laptop with Nvidia GeForce RTX 3060 Mobile / Max-Q (rev a1)

Nvidia configuration file for NixOS on a Razer Blade 15 Laptop using a Gefore RTX 3060 Mobile graphics card and an 11th Gen Intel(R) Core(TM) i7-11800. Most of this configuration was pulled from the NixOS Nvidia wiki located [here](https://nixos.wiki/wiki/Nvidia). This Readme assumes you are already using NixOS.

### Instalation
If you don't already have wget or dont want it as part of your packages, you can use a temporary nix-shell:
```
nix-shell -p wget
```

Now, copy the blade-15-nvidia.nix file and move it into the /etc/nixos/blade-15-nvidia.nix directroy:
```
sudo wget https://raw.githubusercontent.com/xiXRedNomadXix/NixOS/main/blade-15-nvidia.nix -o /home/$USER/Downloads/blade-15-nvidia.nix

mv ~/Downloads/blade-15-nvidia.nix /etc/nixos/blade-15-nvidia.nix
```

Next, find the PCI Bus ID for Nvidia and Intel cards with the following comand:
```
lspci -nn | grep VGA
```
This is what mine looks like, make sure to use your own PCI Bus ID's or it might not work.
```
~~~~ BEGIN OUTPUT ~~~~
00:02.0 VGA compatible controller: Intel Corporation TigerLake-H GT1 [UHD Graphics] (rev 01)
01:00.0 VGA compatible controller: NVIDIA Corporation GA106M [GeForce RTX 3060 Mobile / Max-Q] (rev a1)
~~~~ END OUTPUT ~~~~
```
In the /etc/nixos/blade-15-nvidia.nix file, replace 'Your nvidia bus ID here' with the PCI Bus ID and save the file. ***DO NOT remove the quotation marks!!!***

Next, add the following to your /etc/nixos/configuration.nix file in the import string:
```
./blade-15-nvidia.nix
```
Once this is done run the following command to apply the changes:
```
sudo nixos-rebuild switch
```
Your laptop should boot up successfully and you should be able to use your Nvidia GPU.


### Volume Control
For audio, you can use pipewire by adding this to your nix config:
```

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
```
To control your audio, I personally also recommend including pulseaudio in your environment.systemPackages, as this should work natively with razer's function keys (fn+F1/F2/F3) on the Razer Blade Advanced 15, and should also work with the standard Razer Blade.

##### Tested with Hashcat benchmarking
```
nix-shell -p hashcat
```

```
hashcat -b
```

