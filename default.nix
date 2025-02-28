# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{
  pkgs ? import <nixpkgs> { },
}:
let
  sources = pkgs.callPackage ./_sources/generated.nix { };
in

{
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  firge = pkgs.callPackage ./pkgs/data/fonts/firge/default.nix { source = sources.firge; };
  firge-nerd = pkgs.callPackage ./pkgs/data/fonts/firge-nerd/default.nix {
    source = sources.firge-nerd;
  };

  pinact = pkgs.callPackage ./pkgs/pinact/default.nix { source = sources.pinact; };
  disable-checkout-persist-credentials =
    pkgs.callPackage ./pkgs/disable-checkout-persist-credentials/default.nix
      { source = sources.disable-checkout-persist-credentials; };
  ghatm = pkgs.callPackage ./pkgs/ghatm/default.nix { source = sources.ghatm; };
  ghalint = pkgs.callPackage ./pkgs/ghalint/default.nix { source = sources.ghalint; };
  duckgo = pkgs.callPackage ./pkgs/duckgo/default.nix { source = sources.duckgo; };
  gitlab-ci-verify = pkgs.callPackage ./pkgs/gitlab-ci-verify/default.nix {
    source = sources.gitlab-ci-verify;
  };
}
