{
  pkgs,
  source,
  lib,
}:
pkgs.lsd.overrideAttrs (old: {
  inherit (source) pname src version;
  cargoSha256 = "";
})
