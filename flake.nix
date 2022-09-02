{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils }: {
            defaultPackage.x86_64-linux =
                with import nixpkgs { system = "x86_64-linux"; };
                    stdenv.mkDerivation {
                    pname = "relic";
                    version = "0.5.0";
                    src = self;
                    nativeBuildInputs = [ pkgs.cmake pkgs.gmp ];
                    enableParallelBuilding = true;
                    cmakeFlags = [ "-DARITH=gmp"];
            };
  };
}
