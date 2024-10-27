{ config, pkgs, ... }:

let
  cargoPath = "/home/j2/.cargo/bin";
  pnpmHome = "/home/j2/.local/share/pnpm";
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "j2";
  home.homeDirectory = "/home/j2";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  services.caffeine.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   "Hello, ${config.home.username}!"
    # '')
    
    steam
    vscode-fhs
    pkgs.kdePackages.kdeconnect-kde
    pkgs.prismlauncher
    kdenlive
    krita
    brave
    tenacity
    protontricks
    yt-dlp
    pkgs.godot_4
    pkgs.openai-whisper
    xorg.xev
    wev
    xorg.xwininfo
    godot_4
    obsidian
    syncthing
    zsh
    firefox
    kdePackages.discover
    mpv
    kuro
    bottles-unwrapped
    davinci-resolve
    p7zip
    pcsx2
    vkbasalt
    obs-studio-plugins.obs-vkcapture
    usbimager
    rpcs3
    heroic
    gogdl
    thunderbird
    pianobooster
    ckan
    piper-tts
    pyenv
    f3
    (tetrio-desktop.override {
      withTetrioPlus = false;
    })
    (retroarch.override {
      cores = with libretro; [
        snes9x
        mgba
        fceumm
      ];
    })
    (pkgs.writeShellScriptBin "nixsave" ''
      cd /etc/nixos
      printf "Welcome to nixsave!\\n"
      printf "This will create a Git commit for the repo in /etc/nixos"
      printf "If there are no changes to add since the last commit, nothing will happen."
      printf "%s\\n" "Please name this commit: " && read name
      sudo git add .
      sudo git commit -m "$name"
      printf "nixsave has finished executing.\\n\\n\\n"
    '')
    (pkgs.writeShellScriptBin "nixrbld" ''
      printf "Welcome to nixrbld!\\n"
    
      printf "This will rebuild the NixOS system using the current configuration, in /etc/nixos\\n\\n\\n"
    
      printf "You can try to create a new Git commit for the config repo."
      printf "%s\\n" "Do you want to try to create a new commit?" && read commit
      case "$commit" in
        y|Y|yes) printf "Got it. Running nixsave... \\n\\n\\n" && nixsave && printf "Welcome back to nixrbld!\\n";;
        n|N|no) printf "Got it.\\n";;
        *) printf "Invalid. Try again!" && exit;;
      esac
    
      printf "%s\\n" "Try to update? This will not update anything if no updates are found." && read update
      case "$update" in
        y|Y|yes) printf "Got it. Proceeding to rebuild...\\n" && sudo nixos-rebuild switch --upgrade && printf "Thank you for using nixrbld!";;
        n|N|no) printf "Got it. Proceeding to rebuild...\\n" && sudo nixos-rebuild switch && printf "Thank you for using nixrbld!";;
        *) printf "Invalid. Try again!" && exit;;
      esac
    '')
    (pkgs.writeShellScriptBin "nixcfg" ''
      cd /etc/nixos
      printf "Welcome to nixcfg!\\n"
      printf "What would you like to configure?"
      choices=("System" "Packages" "Audio" "Graphics" "Fonts")
      select choice in "''${choices[@]}"; do
        case $choice in
          "System")
            sudo nano configuration.nix;;
          "Packages")
            sudo nano packages.nix;;
          "Audio")
            sudo nano audio.nix;;
          "Graphics")
            sudo nano graphics.nix;;
          "Fonts")
            sudo nano fonts.nix;;
          *)
            printf "Invalid. Try again!" && exit;;
        esac
      done
      printf "You can try to create a new Git commit for the config repo."
      printf "%s\\n Do you want to try to create a new commit?" && read commit
      case "$commit" in
        y|Y|yes ) printf "Got it. Running nixsave... \\n\\n\\n" && nixsave;;
        n|N|no ) printf "Got it.\\n";;
        *) printf "Invalid. Try again!" && exit;;
      esac
      printf "Thank you for using nixcfg!"
    '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/j2/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    CARGO_PATH = cargoPath;
    PNPM_HOME = pnpmHome;
    PATH = "${cargoPath}:${pnpmHome}:${builtins.getEnv "PATH"}";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --upgrade";
      bashrc = "nano ~/.bashrc";
      zshrc = "nano ~/.zshrc";
      nixchk = "(cd /etc/nixos && sudo git status)";
      hmrbld = "home-manager switch";
      hmcfg = "home-manager edit";
    };

    oh-my-zsh = {
    enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "robbyrussell";
    };
  };

  wayland.windowManager = {
    hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
         bind =
         [
           "$mod, F, exec, firefox"
           ", Print, exec, grimblast copy area"
         ]
         ++ (
           # workspaces
           # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
           builtins.concatLists (builtins.genList (
             x: let
               ws = let
                 c = (x + 1) / 10;
               in
               builtins.toString (x + 1 - (c * 10));
             in [
               "$mod, ${ws}, workspace, ${toString (x + 1)}"
               "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
             ]
           )
           10)
        );
      };
    };
  };
}
