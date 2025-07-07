{
  pkgs,
  lib,
}:
let
  sources = pkgs.callPackage ../_sources/generated.nix { };
  nurAttrs = import ../default.nix { inherit pkgs; };

  # Extract package information
  packageInfo =
    builtins.mapAttrs
      (
        name: pkg:
        let
          source = sources.${name} or null;
          meta = pkg.meta or { };
        in
        {
          name = name;
          version = if source != null then source.version else "unknown";
          description = meta.description or "";
          homepage = meta.homepage or "";
        }
      )
      (
        lib.filterAttrs (
          n: v:
          !(builtins.elem n [
            "lib"
            "modules"
            "overlays"
          ])
          && lib.isDerivation v
        ) nurAttrs
      );

  # Generate markdown table
  generateRow = name: info: "| [${name}](${info.homepage}) | ${info.version} | ${info.description} |";

  tableHeader = ''
    ## Available Packages

    | Package | Version | Description |
    |---------|---------|-------------|'';

  tableRows = lib.mapAttrsToList generateRow packageInfo;

  packageTable = tableHeader + "\n" + (lib.concatStringsSep "\n" tableRows);

  script = pkgs.writeShellApplication {
    name = "generate-package-table";
    runtimeInputs = with pkgs; [ gnused ];
    text = ''
      # Generate the package table
      cat > /tmp/package-table.md << 'EOF'
      ${packageTable}
      EOF

      # Update README.md
      if grep -q "## Available Packages" README.md; then
        # Replace existing section
        sed -i '/## Available Packages/,/^## /{ /^## Available Packages/!{ /^## /!d; }; }' README.md
        sed -i '/## Available Packages/r /tmp/package-table.md' README.md
        sed -i '/## Available Packages/d' README.md
      else
        # Append to end of file
        echo "" >> README.md
        cat /tmp/package-table.md >> README.md
      fi

      rm -f /tmp/package-table.md
      echo "Package table updated in README.md"
    '';
  };
in
script
