{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
		# antibody
		# zsh-powerlevel10k
  ];
  
  programs.zsh = {
    enable = true;
      dotDir = ".config/zsh";
      history = {
        path = "$HOME/.config/zsh/.zsh_history";
        expireDuplicatesFirst = true;
        extended = true;
        ignoreDups = true;
        ignoreSpace = true;
      };
      defaultKeymap = "emacs";
      enableVteIntegration = true;
      autocd = true;
      shellAliases = {
        cat = "bat";
        less = "bat --paging=always";
        ls  = "exa -lh --git --group-directories-first --sort=type --classify -s extension --icons";
        l = "ls -lF --time-style=long-iso --grid --icons";
        la = "ls -lha";
        tree = "ls --tree";
        nv = "nvim";
        vi = "nvim";
        vim = "nvim";
        x = "startx";
      };
      shellGlobalAliases = {
        G = "| egrep -e";
      };
      dirHashes = {
        dl = "$HOME/Downloads";
        cf = "/media/data/00-09-config/01-NixOS";
      };
      sessionVariables = {
        BROWSER="brave";
        EDITOR="kak";
        VISUAL="emacs";
        PAGER="less";
      };
      initExtra = ''
        export PATH=$HOME/.yarn/bin:$HOME/.local/bin:$PATH
        export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
        export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --info=inline --border --margin=1 --padding=1"
        export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
        # source <(antibody init)
        # antibody bundle romkatv/powerlevel10k
      '';
      # plugins = [
      #   {
      #     name = "powerlevel10k";
      #     src = pkgs.zsh-powerlevel10k;
      #     file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      #   }
      #   {
      #     name = "powerlevel10k-config";
      #     src = lib.cleanSource ./.config/zsh/p10k.config;
      #     file = "p10k.zsh";
      #   }
      # ];
  };
}
