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
    bat
    broot
    diskus
    exa
    fd
    htop
    hyperfine
    lazydocker
    lsd
    lua
    nano
    ripgrep
    tldr
    tmux
  ];

  home.file.".nanorc".source = dotfiles/.nanorc;

  programs.emacs = {
    enable = true;
  };

  programs.fzf = {
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
