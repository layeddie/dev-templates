{
  description = "A Nix-flake-based Protobuf development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    }:

    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [ buf protobuf ];

        shellHook = with pkgs; ''
          echo "buf `${buf}/bin/buf --version`"
          ${protobuf}/bin/protoc --version
        '';
      };
    });
}
