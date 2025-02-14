{
  description = "My personal NUR repository";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      treefmt-nix,
    }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
      treefmt =
        system:
        treefmt-nix.lib.evalModule nixpkgs.legacyPackages.${system} (
          { ... }:
          {
            settings.global.excludes = [
              "LICENSE"
              "_sources/*"
            ];
            settings.formatter."pinact" = {
              command = "${self.packages.${system}.pinact}/bin/pinact";
              options = [ "run" ];
              includes = [
                ".github/workflows/*.yaml"
                ".github/workflows/*.yml"
              ];
            };
            programs = {
              nixfmt.enable = true;
              shfmt.enable = true;
              mdformat.enable = true;
              yamlfmt = {
                enable = true;
                settings = {
                  formatter = {
                    type = "basic";
                    retain_line_breaks_single = true;
                  };
                };
              };
              taplo.enable = true;
              pinact.enable = true;
              formatjson5 = {
                enable = true;
                indent = 2;
              };
            };
          }
        );
    in
    {
      legacyPackages = forAllSystems (
        system: import ./default.nix { pkgs = import nixpkgs { inherit system; }; }
      );
      overlays.default = import ./overlay.nix;
      packages = forAllSystems (
        system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system}
      );
      formatter = forAllSystems (system: (treefmt system).config.build.wrapper);
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = [ pkgs.nvfetcher ];
          };
        }
      );
    };
}
