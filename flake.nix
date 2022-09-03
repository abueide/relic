{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

    outputs = { self, nixpkgs, flake-utils }:
      flake-utils.lib.eachDefaultSystem (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in
        rec {
          defaultPackage = pkgs.stdenv.mkDerivation {
            pname = "relic";
            version = "0.5.0";
            src = self;
            nativeBuildInputs = with pkgs; [ cmake gmp ];
            enableParallelBuilding = true;
            cmakeFlags = [ "-DARITH=gmp"];
          };
        }
      );
  }
