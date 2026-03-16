{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];

      perSystem = {pkgs, ...}: let
        serve = pkgs.writeShellScriptBin "serve" ''
          exec npm run dev "$@"
        '';
      in {
        devShells.default = pkgs.mkShell {
          packages = [pkgs.nodejs_22 serve];

          shellHook = ''
            echo "Available Commands:"
            echo "    serve:    start vite dev server"
            npm install
          '';
        };
      };
    };
}
