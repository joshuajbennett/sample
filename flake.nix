{
  description = "A sample C++ repository.";

  # External sources needed to evaluate the flake:
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-22.11";
    nixpkgs.flake = false;
  };

  # Results of the flake:
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
  # List of systems supported by this project:
  let
    supported-systems = [ "x86_64-linux" "i686-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
  in
    flake-utils.lib.eachSystem supported-systems (
      system: let
        # nixpkgs is used for legacy-defined dependencies:
        pkgs = import nixpkgs {inherit system;};
      in {
        devShell = pkgs.mkShell rec {
          name = "sample";
          packages = with pkgs; [
            # Development Tools
            clang
            cmake
            cmakeCurses
            git
          ];

          shellHook = let
            icon = "2744";
          in ''
            export CXX=clang++
          '';
        };
      }
   );
}
