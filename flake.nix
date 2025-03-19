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
            settings.formatter = {
              # keep-sorted start block=yes
              disable-checkout-persist-credentials = {
                command = "${
                  self.packages.${system}.disable-checkout-persist-credentials
                }/bin/disable-checkout-persist-credentials";
                includes = [
                  ".github/workflows/*.yaml"
                  ".github/workflows/*.yml"
                ];
              };
              ghatm = {
                command = "${self.packages.${system}.ghatm}/bin/ghatm";
                options = [ "set" ];
                includes = [
                  ".github/workflows/*.yaml"
                  ".github/workflows/*.yml"
                ];
              };
              pinact = {
                command = "${self.packages.${system}.pinact}/bin/pinact";
                options = [ "run" ];
                includes = [
                  ".github/workflows/*.yaml"
                  ".github/workflows/*.yml"
                ];
              };
              sort-package-json = {
                command = "${self.packages.${system}.sort-package-json}/bin/sort-package-json";
                includes = [
                  "**/package.json"
                ];
              };
              # keep-sorted end
            };
            programs = {
              # keep-sorted start block=yes
              formatjson5 = {
                enable = true;
                indent = 2;
              };
              keep-sorted.enable = true;
              mdformat.enable = true;
              nixfmt.enable = true;
              pinact.enable = true;
              shfmt.enable = true;
              taplo.enable = true;
              yamlfmt = {
                enable = true;
                settings = {
                  formatter = {
                    type = "basic";
                    retain_line_breaks_single = true;
                  };
                };
              };
              # keep-sorted end
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
            packages = [
              pkgs.nvfetcher
              self.packages.${system}.tsgo
            ];
          };
          renovate = pkgs.mkShell {
            packages = [
              pkgs.renovate
            ];
          };
        }
      );
    };
}
