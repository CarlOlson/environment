{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # GNU utils
    coreutils findutils diffutils gnused gnugrep

    # Everything else
    asdf
    htop
    lazydocker
    lsd
    lua
    tldr
    tmux
  ];

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
      . $HOME/git/environment/zsh/.zshrc
      . $HOME/.nix-profile/etc/profile.d/nix.sh
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
