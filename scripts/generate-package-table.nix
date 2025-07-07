{
  pkgs,
  lib,
}:
let
  sources = pkgs.callPackage ../_sources/generated.nix { };
  nurAttrs = import ../default.nix { inherit pkgs; };
  semver = "^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$";
  # Extract package information
  packageInfo =
    nurAttrs
    |> (lib.filterAttrs (
      n: v:
      !(builtins.elem n [
        "lib"
        "modules"
        "overlays"
      ])
      && lib.isDerivation v
    ))
    |> builtins.mapAttrs (
      name: pkg:
      let
        source = sources.${name} or null;
        meta = pkg.meta or { };
      in
      {
        name = name;
        version =
          (if source != null then source.version else "unknown")
          |> (e: if builtins.match semver e != null then "v${e}" else e);
        description =
          (meta.description or "")
          |> pkgs.lib.strings.replaceString "\n" " "
          |> pkgs.lib.splitString "."
          |> (e: builtins.elemAt e 0)
          |> (e: "${e}.");
        homepage = meta.homepage or "";
      }
    );

  generateRow = name: info: [
    "[${name}](${info.homepage})"
    "${info.version}"
    "${info.description}"
  ];

  packageTable =
    (
      [
        [
          "Package"
          "Version"
          "Description"
        ]
        [
          "-"
          "-"
          "-"
        ]
      ]
      ++ (packageInfo |> lib.mapAttrsToList generateRow)
    )
    |> lib.map (row: [ "" ] ++ row ++ [ "" ])
    |> lib.map (row: lib.concatStringsSep "|" row)
    |> lib.concatStringsSep "\n";

  script = pkgs.writeShellApplication {
    name = "generate-package-table";
    runtimeInputs = with pkgs; [
      coreutils
      gawk
      moreutils
      gnused
    ];
    text = ''
      # Generate the package table
      awk '{print} /## Packages/ {exit}' < README.md | sponge README.md
      cat <<'EOF'>> README.md

      ${packageTable}
      EOF
      sed -i "s/^'//g;s/'$//g" README.md
    '';
  };
in
script
