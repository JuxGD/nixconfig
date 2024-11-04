# Jux's NixOS configuration

Jux's opinionatedly organized configuration for his NixOS install. NOT meant to be imported from a flake, not because it's a bad idea but because idk what that would do. If you want to then I mean sure go ahead

## Main features

- [KDE Plasma 6](https://kde.org/plasma-desktop) w/ [Wayland](https://wayland.freedesktop.org)
- [Hyprland](https://hyprland.org) is installed too but idk how to configure it

## Relevant packages, modules and programs

- [Floorp](https://floorp.app/en)
- [Thunderbird](https://thunderbird.net)
- [Ollama](https://ollama.com)
- [Distrobox](https://distrobox.it)
- [OnlyOffice](https://onlyoffice.com)
- [Node.js](https://nodejs.org) w/ [pnpm](https://pnpm.io)
- [Wine](https://winehq.org) Staging, w/ [Winetricks](https://github.com/Winetricks/winetricks)
- [Python](https://python.org) w/ [Conda](https://anaconda.com/anaconda/conda)
- [Mono](https://mono-project.com)
- [gcc](https://gcc.gnu.org)
- [FFmpeg](https://ffmpeg.org)
- [Haxe](https://haxe.org) w/ [Neko/NekoVM](https://nekovm.org/) & [HashLink](https://hashlink.haxe.org)
- [Carla](https://kx.studio/Applications:Carla)
- [Ryujinx](https://ryujinx.org) (R.I.P. :c)
- [yabridge](https://github.com/robert-vdh/yabridge) w/ yabridgectl
- [git](https://git-scm.com)
- [zsh](https://zsh.org)
- [Steam](https://steampowered.com)
- [musnix](https://github.com/musnix/musnix)
- [Forgejo](https://forgejo.org)
- Some libraries, for AppImages

## Important

- `hardware-configuration.nix` is NOT in the repo, since it's specific to each system
- Configured with an NVIDIA RTX 3070 Ti Mobile
- Timezone: America/Santiago
- Uses GRUB
- Unfree packages allowed
- Auto optimise store enabled
- NVIDIA drivers are version 535, because of a problem there was. Not sure if that's fixed now but oh well
- A libinput override was attempted, to remove the debounce time for mice. This was done for Minecraft PvP
