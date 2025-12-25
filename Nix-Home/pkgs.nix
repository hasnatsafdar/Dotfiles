{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
  nitch
  eza
  btop
  helix
  fzf
  mpv
  kitty
  tealdeer
  uv
  yazi
  nerd-fonts.jetbrains-mono
  poppins

  ];
}

