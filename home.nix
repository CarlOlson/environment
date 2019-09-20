{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # GNU utils
    coreutils findutils diffutils gnused gnugrep

    # Everything else
    asdf
    aspell
    aspellDicts.en
    aspellDicts.en-computers
    diskus
    exa
    fd
    fpp
    htop
    hyperfine
    lazydocker
    lua
    nano
    ripgrep
    tldr
  ];

  home.file.".nanorc".source = dotfiles/.nanorc;
  home.file.".config/awesome/rc.lua".source = awesome/rc.lua;

  programs.bat = {
    enable = true;
  };

  programs.broot = {
    enable = true;
  };

  programs.emacs = {
    enable = true;
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
    plugins = with pkgs.tmuxPlugins; [
      copycat
      yank
      fpp
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
