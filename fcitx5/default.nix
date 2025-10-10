{ config, pkgs, ... }:

{
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;

    fcitx5 = {
      addons = 
      # let
      #   config.packageOverrides = pkgs: {
      #     fcitx5-rime = pkgs.fcitx5-rime.override {
      #       rimeDataPkgs = [
      #         ./rime-data-flypy
      #       ];
      #     };
      #   };
      # in
      with pkgs; [
	fcitx5-gtk
        fcitx5-configtool
        fcitx5-chinese-addons
        fcitx5-rime
      ];

      waylandFrontend = false;
    };
  };
}
