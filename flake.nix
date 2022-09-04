{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

    outputs = { self, nixpkgs, flake-utils }:
      flake-utils.lib.eachDefaultSystem (system:
        let pkgs = nixpkgs.legacyPackages.${system};
            deps = with pkgs; [ cmake gmp ];
            platform_flags = if(pkgs.lib.strings.hasPrefix "aarch64" system) then [ "-DARCH=ARM -DWSIZE=64" ] else [];
        in
        rec {
          devShells.default = pkgs.mkShell {
            packages = deps;
          };
          defaultPackage = pkgs.stdenv.mkDerivation {
            pname = "relic";
            version = "110-flake";
            src = self;
            nativeBuildInputs = deps;
            enableParallelBuilding = true;
            cmakeFlags = [ "-DARITH=gmp"] ++ platform_flags;
          };
        }
      );
  }
