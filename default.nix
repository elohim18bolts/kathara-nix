let
  pkgs = import <nixpkgs> { };
in
pkgs.callPackage ./kathara.nix { inherit pkgs; inherit (pkgs) lib; python3Packages = pkgs.python311Packages; inherit (pkgs) fetchFromGitHub; }

