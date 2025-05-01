{ pkgs, source }:
pkgs.hello.overrideAttrs (old: {
  inherit (source) pname src version;
})
