{
  description = "A flake for Bench development.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShell = pkgs.mkShell rec {
        buildInputs = with pkgs; [
          stdenv.cc
          stdenv.cc.cc.lib
          cmake
          git
          alsa-lib
          libGL
          libGLU
          wayland-protocols
          libx11
          libxcursor
          libxi
          libxinerama
          libxkbcommon
          libxrandr
        ];
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
      };
    });
}
