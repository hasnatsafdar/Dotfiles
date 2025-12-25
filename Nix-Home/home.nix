{ config, pkgs, ... }:

{
  home.username = "hxt";
  home.homeDirectory = "/home/hxt";

  home.stateVersion = "25.11";

  imports = [
  ./pkgs.nix
  ./programs
  ];

  xsession.enable = true;
  xsession.windowManager.command = "qtile start";

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
