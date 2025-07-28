# Jux's NixOS configuration

Jux's opinionatedly organized configuration for his NixOS install. NOT meant to be imported from a flake, not because it's a bad idea but because idk what that would do. If you want to then I mean sure go ahead

## Main features

- [SDDM](https://github.com/sddm/sddm)
- [KDE Plasma 6](https://kde.org/plasma-desktop)
- [Niri](https://github.com/YaLTeR/niri)
- [Hyprland](https://hypr.land)
- [Wayland](https://wayland.freedesktop.org)
- [Lix](https://lix.systems)
- [Feral GameMode](https://github.com/FeralInteractive/gamemode)
- [Floorp](https://floorp.app/en)
- [Steam](https://steampowered.com)
- [NUR](https://nur.nix-community.org)
- VFIO passthrough specialisation
- nix-ld
- Disabled mouse debounce, for gaming
- Bluetooth

## Relevant packages, modules and programs

- [Thunderbird](https://thunderbird.net)
- [Ollama](https://ollama.com) w/ [Open WebUI](https://openwebui.com)
- [Docker](https://docker.com)
- [Podman](https://podman.io)
- [Distrobox](https://distrobox.it)
- [OnlyOffice](https://onlyoffice.com)
- [Node.js](https://nodejs.org) w/ [pnpm](https://pnpm.io)
- [Wine](https://winehq.org) Staging, w/ [Winetricks](https://github.com/Winetricks/winetricks)
- [Python](https://python.org) w/ [Conda](https://anaconda.com/anaconda/conda)
- [Mono](https://mono-project.com)
- [gcc](https://gcc.gnu.org)
- [FFmpeg](https://ffmpeg.org)
- [Haxe](https://haxe.org) w/ [Neko/NekoVM](https://nekovm.org)
- [Carla](https://kx.studio/Applications:Carla)
- [yabridge](https://github.com/robert-vdh/yabridge) w/ yabridgectl
- [git](https://git-scm.com)
- [zsh](https://zsh.org)
- [musnix](https://github.com/musnix/musnix)
- [Forgejo](https://forgejo.org)
- [LSP](https://lsp-plug.in/)
- [DISTRHO Ports](https://github.com/DISTRHO/DISTRHO-Ports)
- [VCV Rack](https://vcvrack.com/)
- [Scrcpy](https://github.com/Genymobile/scrcpy)
- [QtScrcpy](https://github.com/barry-ran/QtScrcpy)
- [KeePassXC](https://keepassxc.org)
- [Eclipse Temurin](https://adoptium.net/temurin)
- [nh](https://github.com/nix-community/nh)
- [qBittorrent](https://qbittorrent.org)
- [kitty](https://sw.kovidgoyal.net/kitty)
- [virt-manager](https://virt-manager.org)
- [OpenTabletDriver](https://opentabletdriver.net)

## Important, if you wanna use this config

- **After first booting into passthrough mode, some apps seem to break in normal NixOS, such as OBS, where we can't capture the display or windows. This is being worked on.**
- It looks like `hardware-configuration.nix` has to be tracked by git, so if you wanna use this config you'll have to replace it with your own `hardware-configuration.nix` in `/etc/nixos/`. This also goes for setting up passthrough.
- Configured with an NVIDIA RTX 3070 Ti Mobile
- Timezone: America/Santiago
- Uses GRUB
- Unfree packages allowed
- Auto optimise store enabled
- NVIDIA drivers are version 535, because of a problem there was. Not sure if that's fixed now but oh well
- There's a libinput configuration to remove the debounce time for mice. This was done for Minecraft PvP
- Change the users to your liking, you're obviously not "j" or "j2" (unless you are ig)
- I made a virtual device, with my specific mic ID (i think that's what it is). Either take it out or change it to fit yours

## Contributing

If there's something you think could be improved about my config, just open an issue!

## License

This repository is distributed under the terms of the [replicense](https://github.com/JuxGD/replicense) (rpli).

- [Markdown](https://github.com/JuxGD/nixconfig/tree/main/LICENSE.md)
- [Plain text](https://github.com/JuxGD/nixconfig/tree/main/LICENSE)
