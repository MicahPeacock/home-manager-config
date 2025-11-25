{ config, lib, pkgs, ... }:
let
  cfg = config.local.programs.zsh;
in
{
  options.local.programs.zsh = {
    enable = lib.mkEnableOption "Enable zsh interactive shell";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" ];
      };
      dotDir = "${config.xdg.configHome}/zsh";

      shellAliases = {
        cl    = "clear";
        ".."  = "cd ..";
        "..." = "cd ../..";
        ".3"  = "cd ../../..";
        ".4"  = "cd ../../../..";
        ".5"  = "cd ../../../../..";
        mkdir = "mkdir -p";
        fastfetch = "fastfetch --logo-type kitty";
      };

      initContent = ''
        #!/usr/bin/env zsh

        bindkey '\e[H' beginning-of-line
        bindkey '\e[F' end-of-line

        if [[ -d ~/.config/zsh/functions ]]; then
          for file in ~/.config/zsh/functions/*.zsh; do
            [[ -f "$file" ]] && source "$file"
          done
        fi

        if [[ -d ~/.config/zsh/completions ]]; then
          for file in ~/.config/zsh/completions/*.zsh; do
            [[ -f "$file" ]] && source "$file"
          done
        fi

        if command -v starship &>/dev/null; then
            eval "$(starship init zsh)"
            export STARSHIP_CACHE=$XDG_CACHE_HOME/starship
            export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
        fi

        fastfetch --logo-type kitty
      '';
    };

    home.file = {
      ".zshenv".source = ../../files/.zshenv;
      ".config/zsh/completions/fzf.zsh".source = ../../files/.config/zsh/completions/fzf.zsh;
      ".config/zsh/functions/bat.zsh".source = ../../files/.config/zsh/functions/bat.zsh;
      ".config/zsh/functions/duf.zsh".source = ../../files/.config/zsh/functions/duf.zsh;
      ".config/zsh/functions/eza.zsh".source = ../../files/.config/zsh/functions/eza.zsh;
      ".config/zsh/functions/fzf.zsh".source = ../../files/.config/zsh/functions/fzf.zsh;
    };
  };
}
