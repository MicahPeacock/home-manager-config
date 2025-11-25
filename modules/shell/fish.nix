{ config, lib, pkgs, ... }:
let
  cfg = config.local.programs.fish;
in
{
  options.local.programs.fish = {
    enable = lib.mkEnableOption "Enable fish interactive shell";
  };

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        set -g fish_greeting
        source ${../../files/.config/fish/conf.d/terminal.fish}

        if type -q starship
          starship init fish | source
          set -gx STARSHIP_CACHE $XDG_CACHE_HOME/starship
          set -gx STARSHIP_CONFIG $XDG_CONFIG_HOME/starship/starship.toml
        end

        if type -q fzf
          fzf --fish | source
          for file in ~/.config/fish/functions/fzf/*.fish
            source $file
          end
        end

        bind_M_n_history

        set fish_pager_color_prefix cyan
        set fish_color_autosuggestion brblack

        alias cl='clear'
        alias l='eza -lh --icons=auto'
        alias ls='eza -1 --icons=auto'
        alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
        alias ld='eza -lhD --icons=auto'
        alias lt='eza --icons=auto --tree'
        alias fastfetch='fastfetch --logo-type kitty'

        alias ..='cd ..'
        alias ...='cd ../..'
        alias .3='cd ../../..'
        alias .4='cd ../../../..'
        alias .5='cd ../../../../..'

        abbr mkdir 'mkdir -p'

        fastfetch --logo-type kitty
      '';
      shellAliases = {
        l  = "eza -lh --icons=auto";
        ls = "eza -1 --icons=auto";
        ll = "eza -lha --icons=auto --sort=name --group-directories-first";
        ld = "eza -lhD --icons=auto";
        lt = "eza --icons=auto --tree";
      };
      shellAbbrs = {
        ".."  = "cd ..";
        "..." = "cd ../..";
        ".3"  = "cd ../../..";
        ".4"  = "cd ../../../..";
        ".5"  = "cd ../../../../..";
        mkdir = "mkdir -p";
      };
    };

    home.file = {
      ".config/fish/conf.d/terminal.fish".source    = ../../files/.config/fish/conf.d/terminal.fish;
      ".config/fish/functions/bind_M_n_history.fish".source = ../../files/.config/fish/functions/bind_M_n_history.fish;
      ".config/fish/functions/fzf/ffcd.fish".source = ../../files/.config/fish/functions/fzf/ffcd.fish;
      ".config/fish/functions/fzf/ffch.fish".source = ../../files/.config/fish/functions/fzf/ffch.fish;
      ".config/fish/functions/fzf/ffe.fish".source  = ../../files/.config/fish/functions/fzf/ffe.fish;
      ".config/fish/functions/fzf/ffec.fish".source = ../../files/.config/fish/functions/fzf/ffec.fish;
    };
  };
}
