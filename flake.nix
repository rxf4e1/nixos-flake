{
  description = "rx/Flake Configuration";
# ------------------------------------------------------------------------------
  inputs = {

    stable.url = "github:NixOS/nixpkgs/nixos-22.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "unstable";
    flake-utils.url = "github:numtide/flake-utils";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # hyprland.url = "github:hyprwm/Hyprland";
    # hyprland.inputs.nixpkgs.follows = "unstable";
  
  };
# ------------------------------------------------------------------------------
  outputs = inputs @ {self, stable, unstable, home-manager, emacs-overlay, flake-utils, ... }:
    
    let
      devShells = flake-utils.lib.eachDefaultSystem (
        system: {
          devShell = let
            pkgs = unstable.legacyPackages.${system};
          in pkgs.mkShell {
            buildInputs = with pkgs; [
              rnix-lsp
              nixpkgs-fmt
            ];
          };
        }
      );
      system = "x86_64-linux";
      username = "rxf4el";
      
    in {
      nixosConfigurations = {
        
        aspire-a315 = stable.lib.nixosSystem {
          system = "${system}";
          specialArgs = { inherit inputs; };
          modules = [
            # System
            ./modules/system/aspire-a315
            ./modules/desktop

            # Home-Manager
            inputs.home-manager.nixosModules.home-manager {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.rxf4el = {
                  imports = [ ./modules/home-manager ];
                  home.stateVersion = "22.05";
                };
              };

            } # <<-- End Home-manager Section

            # HyprLand WindowManager
            # inputs.hyprland.nixosModules.default { 
            #   imports = [ ./modules/desktop ]; 
	          # } 
            # { programs.hyprland.enable = true; }
          ];
        };
      };
      
# ------------------------------------------------------------------------------
      # homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      #   configuration = import ./modules/home-manager;
        
      #   inherit system username;
      #   homeDirectory = "/home/${username}";
      #   # stateVersion = "22.05";
      # };
      # $ home-manager switch --flake '<flake-uri>#{username}'
# ------------------------------------------------------------------------------
      
    } // devShells;
}
