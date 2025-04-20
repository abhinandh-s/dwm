{
  description = "Patched DWM build";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { nixpkgs, ... }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };

    # Import the DWM package and allow for the configFile to be passed
    dwm = import ./default.nix {
      inherit pkgs;
      configFile = null;  # You can override this in your NixOS configuration or through the flake itself
    };
  in {
    # Explicitly define default package for flake consumers
    packages.x86_64-linux.default = dwm;

    # Or alternatively, if you prefer to define it via defaultPackage
    defaultPackage.x86_64-linux = dwm;
  };
}

