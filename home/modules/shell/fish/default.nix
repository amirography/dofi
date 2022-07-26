{
  lib,
  config,
  inputs,
  ...
}:
with lib; {
  options = {
    fish.enable = mkOption {
      type = types.bool;
      default = false;
    };
  };
  config = mkIf config.fish.enable {
    programs.fish = {
      enable = true;
      plugins = [
        {
          name = "fzf-fish";
          src = inputs.fzf-fish;
        }
        {
          name = "done-fish";
          src = inputs.done-fish;
        }
        {
          name = "sponge-fish";
          src = inputs.sponge-fish;
        }
      ];
      interactiveShellInit = ''
        set -Ux FZF_DEFAULT_OPTS "\
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
        --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
      '';
    };

    programs.fzf.enableFishIntegration = mkIf config.fzf.enable true;
    programs.nix-index.enableFishIntegration = true;
    programs.starship.enableFishIntegration = true;
    programs.zoxide.enableFishIntegration = true;
    services.gpg-agent.enableFishIntegration = true;
    home.sessionVariables = {
      fish_greeting = "";
      fish_tmux_config = "$HOME/.config/tmux/tmux.conf";
      fish_tmux_autoconnect = "false";
    };
  };
}
