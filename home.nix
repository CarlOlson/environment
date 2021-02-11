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
      exa        # ls alternative
      fd
      fpp
      gitAndTools.hub
      htop
      hyperfine  # benchmarking
      jq         # for json
      lazydocker # docker management
      lsd        # ls alternative
      nano
      pup        # html
      ripgrep
      tldr
      unrar
      unzip
    ];

  home.file.".nanorc".source = dotfiles/.nanorc;
  home.file.".config/awesome/rc.lua".source = awesome/rc.lua;
  home.file.".config/kitty/kitty.conf".source = dotfiles/kitty.conf;
  home.file.".config/broot/conf.hjson".source = dotfiles/broot.hjson;
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

  programs.git = {
    enable = true;
    userName = "CarlOlson";
    userEmail = "CarlOlson@users.noreply.github.com";
    delta = {
      enable = true;
      options = {
        syntax-theme                  = "Solarized (light)";
        minus-style                   = "normal 224";
        minus-non-emph-style          = "normal 224";
        minus-emph-style              = "normal 217";
        minus-empty-line-marker-style = "normal 224";
        zero-style                    = "syntax";
        plus-style                    = "syntax 194";
        plus-non-emph-style           = "syntax 194";
        plus-emph-style               = "syntax 157";
        plus-empty-line-marker-style  = "normal 194";
        whitespace-error-style        = "reverse magenta";
      };
    };
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
