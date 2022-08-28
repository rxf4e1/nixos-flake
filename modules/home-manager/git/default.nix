{ pkgs, ... }:

let
  # Fix any corruptions in the local copy.
  myGitFix = pkgs.writeShellScriptBin "git-fix" ''
    if [ -d .git/objects/ ]; then
      find .git/objects/ -type f -empty | xargs rm -f
      git fetch -p
      git fsck --full
    fi
    exit 1
  '';

  cfg = config.modules.git;
  
in {
  options = {
    modules.git = {
      enable = mkOption {
				type = types.bool;
				default = true;
      };
    };
  };

  config = mkIf cfg.enable {
  	home.packages = [ myGitFix ];
  
  	programs.git = {
    	enable = true;
    	userName = "rxf4el";
   	 userEmail = "rxf4el@pm.me";
   	 # signing = {
   	 #   key = "FD141B6640DAD9D8";
   	 #   signByDefault = true;
   	 # };
  	};

  	programs.lazygit = {
   	 enable = true;
   	 # settings = {};
  	}; 
	};
}
