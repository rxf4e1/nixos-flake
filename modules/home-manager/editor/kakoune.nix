{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.kakoune;
in {
  options = {
    modules.kakoune = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable Kakoune Editor.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.kakoune = {
      enable = true;
      plugins = with pkgs; [
        kak-lsp
        kakounePlugins.prelude-kak
        kakounePlugins.connect-kak
        kakounePlugins.kakoune-buffers
        kakounePlugins.kakboard
        kakounePlugins.kakoune-vertical-selection
      ];
      config = {
        colorScheme = "tomorrow-night";
        autoReload = "ask";

        alignWithTabs = false;
        tabStop = 2;
        indentWidth = 2;

        showMatching = true;
        # showWhitespace.enable = true;

        scrollOff.lines = 8;
        scrollOff.columns = 3;

        numberLines = {
          enable = false;
          relative = true;
          separator = ''" "''; # ⋮ ⦙ ⋅ ∘ ⌋ ∣
        };

        ui = {
          enableMouse = true;
          # assistant = "none";
          statusLine = "bottom";
        };

        wrapLines = {
          enable = true;
          indent = true;
          marker = "⎁";
        };

        hooks = [
          # kak-lsp
          {
            commands = "lsp-enable-window";
            name = "WinSetOption";
            option = "filetype=(sh|javascript|typescript|lua|nix)";
          }
          {
            commands = "enable-auto-pairs";
            name = "WinCreate";
            option = ".*";
          }
          # nix
          {
            commands = ''
              set-option buffer formatcmd nixfmt
            '';
            name = "WinCreate";
            option = ".*.nix";
          }
          {
            commands = "format";
            name = "BufWritePre";
            option = ".*.nix";
          }
          # kakboard
          {
            commands = "kakboard-enable";
            name = "WinCreate";
            option = ".*";
          }
        ];

        keyMappings = [
          # vertical-selection
          {
            mode = "user";
            key = "v";
            effect = ": vertical-selection-down<ret>";
            docstring = "vertical selection down";
          }

          {
            mode = "user";
            key = "<a-v>";
            effect = ": vertical-selection-up<ret>";
            docstring = "vertical selection up";
          }

          {
            mode = "user";
            key = "V";
            effect = ": vertical-selection-up-and-down<ret>";
            docstring = "vertical selection up and down";
          }

          {
            mode = "user";
            key = "l";
            effect = ": enter-user-mode lsp<ret>";
            docstring	= "lsp";
          }
        ];

      };

      extraConfig = ''
        # Plug
        # ────────────────────────────────────────────────────
        evaluate-commands %sh{
          plugins="$kak_config/plugins"
          mkdir -p "$plugins"
          [ ! -e "$plugins/plug.kak" ] && \
            git clone -q https://github.com/andreyorst/plug.kak.git "$plugins/plug.kak"
            printf "%s\n" "source '$plugins/plug.kak/rc/plug.kak'"
        }
        plug "andreyorst/plug.kak" noload
        
        # Loads & Sources
        # ────────────────────────────────────────────────────
        source "%val{config}/kakrc.local"
        require-module prelude
        require-module connect
        
        # Default Options
        # ────────────────────────────────────────────────────
        set-option global makecmd 'make -j 8'
        set-option global grepcmd 'rg --column'
        set-option global ui_options terminal_assistant=none
        
        # LSP Server
        # ────────────────────────────────────────────────────
        try %sh{
         kak-lsp --kakoune -s $kak_session
        }
        
        # Auto-Pairs
        # ────────────────────────────────────────────────────
        plug "https://github.com/alexherbo2/auto-pairs.kak"
        
        # Plugins
        # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
        # plug "https://github.com/alexherbo2/alacritty.kak" config %{
        #   alacritty-integration-enable
        # }

        # Buffers
        # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
        try %{
          map global normal ^ q
          map global normal <a-^> Q
          map global normal q b
          map global normal Q B
          map global normal <a-q> <a-b>
          map global normal <a-Q> <a-B>
          map global normal b ': enter-buffers-mode<ret>' -docstring 'buffers'
          map global normal B ': enter-user-mode -lock buffers<ret>' -docstring 'buffers (lock)'
        }

        # KakTreeFM
        # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
        plug "https://github.com/andreyorst/kaktree" defer kaktree %{
          map global user 'f' ": kaktree-toggle<ret>" -docstring "toggle filetree panel"
          set-option global kaktree_show_help false
          set-option global kaktree_double_click_duration "0.5"
          set-option global kaktree_indentation 1
          set-option global kaktree_dir_icon_open  "▾  "
          set-option global kaktree_dir_icon_close "▸  "
          set-option global kaktree_file_icon      "⠀⠀"
          set-option global kaktree_split vertical
          set-option global kaktree_size 30%
        } config %{
          hook global WinSetOption filetype=kaktree %{
            remove-highlighter buffer/numbers
            remove-highlighter buffer/matching
            remove-highlighter buffer/wrap
            remove-highlighter buffer/show-whitespaces
          }
          kaktree-enable
        }

        # Fuzzy-Finder
        # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
        plug "https://github.com/andreyorst/fzf.kak" config %{
          map global normal <c-p> ': fzf-mode<ret>' -docstring "fzf mode"
        }

        # Snippets
        # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
        plug "https://github.com/occivink/kakoune-snippets" config %{
          # set-option -add global snippets_directories "%opt{plug_install_dir}/kakoune-snippet-collection/snippets"
        }
        # plug "https://github.com/andreyorst/kakoune-snippet-collection"
        # Emmet
        # ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
        plug "https://github.com/JJK96/kakoune-emmet" config %{
          map global insert <a-e> "<esc>x: emmet<ret>"
        }
        '';
    };
  };
}
