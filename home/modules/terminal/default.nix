{
  lib,
  config,
  ...
}:
with lib; {
  imports = [
    ./kitty
    ./wezterm
    ./zellij
  ];
  options = {
    terminal.enable = mkOption {
      type = types.bool;
      default = false;
    };
  };
  config = mkIf config.terminal.enable {
    kitty.enable = true;
    zellij.enable = true;
    wezterm.enable = true;
  };
}
