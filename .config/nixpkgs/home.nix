{config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.03";

  # Add utilities
  nixpkgs.config.allowUnfree = true;
  home.packages = [
      pkgs.htop
      pkgs.bat
      pkgs.wget
      pkgs.gnupg
      pkgs.vscode
      pkgs.watchexec
      pkgs.jq
      pkgs.hugo
      pkgs.asciinema
      pkgs.avrdude
      pkgs.binutils
      pkgs.coreutils
      pkgs.doctl
      pkgs.ctags
      pkgs.elmPackages.elm
      pkgs.elmPackages.elm-format
      pkgs.elmPackages.elm-live
      pkgs.fd
      pkgs.findutils
      pkgs.gawk
      pkgs.gnugrep
      pkgs.exa
      pkgs.prettyping
      pkgs.gotop
      pkgs.gitAndTools.hub
      pkgs._1password
      pkgs.highlight
      pkgs.black
  ];

  programs.command-not-found.enable = true;
}
