Nvidia configuration file for NixOS on a Razer Blade 15 Laptop using a Gefore RTX 3060 Mobile graphics card and an 11th Gen Intel(R) Core(TM) i7-11800. All of this configuration was pulled from the NixOS Nvidia wiki located [here](https://nixos.wiki/wiki/Nvidia).

First:
```
nix-shell -p wget
```

Now, copy the blade-15-nvidia.nix file into the /etc/nixos/ directory with the following ommand:
```
sudo wget https://raw.githubusercontent.com/xiXRedNomadXix/NixOS/main/blade-15-nvidia.nix?token=GHSAT0AAAAAACSGJSSAMVK7QRIRIYRCGDKWZSBOFMA -o /etc/nixos/blade-15-nvidia.nix
```

Next, find the PCI Bus ID for Nvidia and Intel cards with the following comand:
```
lspci -nn | grep VGA
```
```
~~~~ BEGIN OUTPUT ~~~~
00:02.0 VGA compatible controller: Intel Corporation TigerLake-H GT1 [UHD Graphics] (rev 01)
01:00.0 VGA compatible controller: NVIDIA Corporation GA106M [GeForce RTX 3060 Mobile / Max-Q] (rev a1)
~~~~ END OUTPUT ~~~~
```
In the /etc/nixos/blade-15-nvidia.nix file, replace 'Your nvidia bus ID here' with the PCI Bus ID. ***DO NOT remove the quotation marks!!!***

Next, add the following to your /etc/nixos/configuration.nix file in the import string:
```
./blade-15-nvidia.nix
```
Once this is done run the following command to apply the changes:
```
sudo nixos-rebuild switch
```
Your laptop should boot up successfully and you should be able to use your Nvidia GPU.
