{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  targets.genericLinux.enable = true;

  nixpkgs.config = {
    # only active inside home-manager
    allowBroken = pkgs.stdenv.isDarwin;
    allowUnfree = true;
    allowUnsupportedSystem = pkgs.stdenv.isDarwin;
  };

  home.packages = with pkgs;
    stdenv.lib.optionals ((builtins.getEnv "Distro") != "Ubuntu") [
      # GNU utils (not needed on Ubuntu)
      coreutils findutils diffutils gnused gnugrep wget
    ] ++ [
      exa        # currently prefer lsd
      fd
      fpp
      gitAndTools.hub
      htop
      hyperfine  # benchmarking
      jq         # for json
      kitty
      lazydocker # docker management
      nano
      pup        # html
      ripgrep
      tldr
      unrar
      unzip
    ] ++ stdenv.lib.optionals stdenv.isLinux [
      # X11 utils
      # xclip xorg.xhost xorg.xkbcomp xpra

      # Other
      # libreoffice
      # okular
    ];

  home.file.".nanorc".source = dotfiles/.nanorc;
  home.file.".config/awesome/rc.lua".source = awesome/rc.lua;
  home.file.".config/kitty/kitty.conf".source = dotfiles/kitty.conf;
  home.file.".config/nixpkgs/config.nix".text = "{ allowUnfree = true; }";

  programs.bat = {
    enable = true;
  };

  # interactive find
  programs.broot = {
    enable = true;
  };

  programs.emacs = {
    enable = true;
  };

  programs.fish = {
    enable = true;
    shellInit = "source $HOME/git/environment/fish/config.fish";
  };

  programs.fzf = {
    enable = true;
  };

  # prefered ls alternative
  programs.lsd = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "CarlOlson";
    userEmail = "CarlOlson@users.noreply.github.com";
    extraConfig = {
      core = {
        editor = "nano";
      };
      pager = {
        branch = false;
      };
    };
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    newSession = true;
    secureSocket = !pkgs.stdenv.isDarwin;
    terminal = "xterm-256color";
    shortcut = "x";
    extraConfig = ''
      unbind-key -a -T prefix
      bind-key -T prefix o last-pane
      bind-key -T prefix ? list-keys
      bind-key -T prefix d detach-client
      bind-key -T prefix n next-window
      bind-key -T prefix p previous-window
      bind-key -T prefix c new-window
      bind-key -T prefix 0 break-pane -d
      bind-key -T prefix 1 break-pane
      bind-key -T prefix 2 split-window
      bind-key -T prefix 3 split-window -h
      bind-key -T prefix k confirm-before -p "kill #W:#P? (y/n)" kill-pane
      bind-key -T prefix : command-prompt
      bind-key -T prefix r refresh-client
    '';
    plugins = with pkgs.tmuxPlugins; [
      # copycat yank fpp
    ];
  };

  programs.z-lua = {
    enable = true;
    options = [ "fzf" ];
  };
}
