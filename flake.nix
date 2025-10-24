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
      pkgsFor =
        system:
        import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        };
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
      treefmt =
        system:
        let
          pkgs = pkgsFor system;
        in
        treefmt-nix.lib.evalModule pkgs (
          { ... }:
          {
            settings.global.excludes = [
              "LICENSE"
              "_sources/*"
              "node2nix/node-env.nix"
            ];
            settings.formatter = {
              # keep-sorted start block=yes
              disable-checkout-persist-credentials = {
                command = "${pkgs.disable-checkout-persist-credentials}/bin/disable-checkout-persist-credentials";
                includes = [
                  ".github/workflows/*.yaml"
                  ".github/workflows/*.yml"
                ];
              };
              ghatm = {
                command = "${pkgs.ghatm}/bin/ghatm";
                options = [ "set" ];
                includes = [
                  ".github/workflows/*.yaml"
                  ".github/workflows/*.yml"
                ];
              };
              sort-package-json = {
                command = "${pkgs.sort-package-json}/bin/sort-package-json";
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
              shfmt.enable = true;
              taplo.enable = true;
              toml-sort.enable = true;
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
      runAsOn =
        system:
        let
          pkgs = pkgsFor system;
        in
        name: runtimeInputs: text:
        let
          program = pkgs.writeShellApplication {
            inherit name runtimeInputs text;
          };
        in
        {
          type = "app";
          program = "${program}/bin/${name}";
        };
    in
    {
      legacyPackages = forAllSystems (
        system: import ./default.nix { pkgs = import nixpkgs { inherit system; }; }
      );
      overlays.default = import ./overlay.nix;
      packages = forAllSystems (
        system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system}
      );
      checks = forAllSystems (system: {
        formatting = (treefmt system).config.build.check self;
      });
      formatter = forAllSystems (system: (treefmt system).config.build.wrapper);
      apps = forAllSystems (
        system:
        let
          pkgs = pkgsFor system;
          runAs = runAsOn system;
        in
        {
          check-action =
            ''
              actionlint --version
              actionlint
              ghalint --version
              ghalint run
            ''
            |> runAs "check-action" [
              pkgs.actionlint
              pkgs.ghalint
            ];
          check-renovate-config =
            ''
              renovate-config-validator renovate.json5
            ''
            |> runAs "check-renovate-config" [
              pkgs.renovate
            ];
          sync-readme =
            ''
              ${pkgs.callPackage ./scripts/generate-package-table.nix { }}/bin/generate-package-table
              nix fmt
            ''
            |> runAs "sync-readme" [
              pkgs.nix
            ];
          nvfetcher = "nvfetcher \"$@\"" |> runAs "nvfetcher" [ pkgs.nvfetcher ];
        }
      );
      devShells = forAllSystems (
        system:
        let
          pkgs = pkgsFor system;
        in
        {
          default = pkgs.mkShell {
            packages = [
              pkgs.nvfetcher
              (treefmt system).config.build.wrapper
            ];
          };
          renovate = pkgs.mkShell {
            packages = [ pkgs.renovate ];
          };
        }
      );
    };
}
