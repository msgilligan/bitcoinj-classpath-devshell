{
  description = "bitcoinj devshell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.11";
    bitcoinj = {
        url = "github:msgilligan/bitcoinj-flake";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    bouncy-castle = {
        url = "github:msgilligan/bc-java-flake";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { nixpkgs, bitcoinj, bouncy-castle, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      forEachSystem = f: builtins.listToAttrs (map (system: {
        name = system;
        value = f system;
      }) systems);
    in {
      devShells = forEachSystem(system:
        let
        inherit (pkgs) stdenv;
        pkgs = import nixpkgs {
          inherit system;
        };
        in {
        default = pkgs.mkShell {
          packages = with pkgs ; [
                pkgs.jdk25
                bitcoinj.packages.${system}.bitcoinj-core
                bitcoinj.packages.${system}.bitcoinj-core-deps
                bouncy-castle.packages.${system}.bcprov-jdk18on
            ];
        };
      });
  };
}
