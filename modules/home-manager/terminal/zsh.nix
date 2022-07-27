{ config, pkgs, ... }:
{
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
        x = "sway";
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
        EDITOR="nano";
        VISUAL="emacs";
        PAGER="less";
      };
      initExtra = ''
        export PATH=$HOME/.yarn/bin:$HOME/.local/bin:$PATH
        export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
        export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --info=inline --border --margin=1 --padding=1"
        export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
      '';
  };
}
