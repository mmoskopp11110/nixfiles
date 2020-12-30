{ config, pkgs, ... }:

{
	# This value determines the NixOS release with which your system is to be
	# compatible, in order to avoid breaking some software such as database
	# servers. You should change this only after NixOS release notes say you
	# should.
	system.stateVersion = "20.09"; # Did you read the comment?

	# internationalisation
	i18n.defaultLocale = "en_US.UTF-8";
	console = {
          font = "Lat2-Terminus16";
          keyMap = "us";
        };

	# set time
	time.timeZone = "Europe/Berlin";

	# allow unfree
	nixpkgs.config.allowUnfree = true;

	# enable passwd and co
	users.mutableUsers = true;

	# users
	programs.zsh.enable = true;
	programs.zsh.ohMyZsh = {
		enable = true;
		plugins = [ "git" "sudo" "history" "man" ];
		theme = "bira";
	};
				
	users.users.root = {
		shell = pkgs.zsh;
	};

	users.users.markus = {
		uid = 1000;
		description = "Markus Moskopp <markus@moskopp.biz>";
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" ];
		initialPassword = "nixos";
		shell = pkgs.zsh;
	};

	# System-wide packages
    environment.systemPackages = with pkgs;
      let
        # Packages to always install.
        common = [
          bind
          git
          gnupg
          htop
          imagemagick
          killall
          man-pages
          nmap
          python3
          ranger
          rsync
          tmux
          unzip
          (import ./vim_plugins.nix)
          which
          whois
          wget
        ];

	# packages to install if X is disabled.
	noxorg = [

	];

        # Packages to install if X is enabled.
        xorg = [
          google-chrome
          evince
          firefox
        ];
      in common ++ (if config.services.xserver.enable then xorg else noxorg);

	programs.vim.defaultEditor = true;

}
