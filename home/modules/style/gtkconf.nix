{
  pkgs,
  lib,
  config,
  ...
}:
with lib; {
  options = {
    gtkconf.enable = mkOption {
      type = types.bool;
      default = false;
    };
  };
  config = mkIf config.gtkconf.enable {
    gtk.enable = true;
    gtk.theme = {
      package = pkgs.rose-pine-gtk-theme;
      name = "Rose Pine";
    };
  };
}