{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # GNU utils
    coreutils findutils diffutils gnused gnugrep

    # Everything else
    diskus
    exa
    fd
    fpp
    gitAndTools.hub
    htop
    hyperfine
    kitty
    lazydocker
    nano
    ripgrep
    tldr
  ] ++ stdenv.lib.optionals stdenv.isLinux [
    # X11 utils
    xclip xhost xkbcomp xpra

    # Other
    libreoffice
    okular
  ];

  home.file.".nanorc".source = dotfiles/.nanorc;
  home.file.".config/awesome/rc.lua".source = awesome/rc.lua;
  home.file.".config/kitty/kitty.conf".source = dotfiles/kitty.conf;

  programs.bat = {
    enable = true;
  };

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

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;

    autocd = true;
    defaultKeymap = "emacs";
    initExtra = ''
      source $HOME/git/environment/zsh/.zshrc
      if [[ "$OSTYPE" == "darwin"* ]]; then
        source $HOME/.nix-profile/etc/profile.d/nix.sh
      fi
    '';

    history = {
      ignoreDups = false;
      extended = true;
      save = 1000000;
      size = 1000000;
    };

    oh-my-zsh = {
      enable = true;
      theme = "sunrise";
      plugins = [ "git" "wd" "colored-man-pages" "kubectl" "docker" "zsh-autosuggestions" "zsh-syntax-highlighting" ];
    };
  };

  programs.z-lua = {
    enable = true;
    options = [ "fzf" ];
  };
}
