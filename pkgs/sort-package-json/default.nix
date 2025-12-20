{
  source,
  lib,
  buildNpmPackage,
}:

buildNpmPackage rec {
  inherit (source) pname src version;
  # keep-sorted start block=yes
  # NOTE: Errors occur on fixupPhase
  # > ERROR: noBrokenSymlinks: the symlink /nix/store/b9mqysqk5hsl76dxd2h1851dwvbll6wm-sort-package-json-v3.0.0/lib/node_modules/sort-package-json/node_modules/.bin/sshpk-conv points to a missing target: /nix/store/b9mqysqk5hsl76dxd2h1851dwvbll6wm-sort-package-json-v3.0.0/lib/node_modules/sort-package-json/node_modules/sshpk/bin/sshpk-conv
  # > ERROR: noBrokenSymlinks: the symlink /nix/store/b9mqysqk5hsl76dxd2h1851dwvbll6wm-sort-package-json-v3.0.0/lib/node_modules/sort-package-json/node_modules/.bin/sshpk-verify points to a missing target: /nix/store/b9mqysqk5hsl76dxd2h1851dwvbll6wm-sort-package-json-v3.0.0/lib/node_modules/sort-package-json/node_modules/sshpk/bin/sshpk-verify
  # > ERROR: noBrokenSymlinks: the symlink /nix/store/b9mqysqk5hsl76dxd2h1851dwvbll6wm-sort-package-json-v3.0.0/lib/node_modules/sort-package-json/node_modules/.bin/sshpk-sign points to a missing target: /nix/store/b9mqysqk5hsl76dxd2h1851dwvbll6wm-sort-package-json-v3.0.0/lib/node_modules/sort-package-json/node_modules/sshpk/bin/sshpk-sign
  # > ERROR: noBrokenSymlinks: found 3 dangling symlinks and 0 reflexive symlinks
  dontFixup = true;
  meta = with lib; {
    description = "Sort an Object or package.json based on the well-known package.json keys";
    homepage = "https://github.com/keithamus/sort-package-json";
    changelog = "https://github.com/keithamus/sort-package-json/releases/tag/v${version}";
    license = licenses.mit;
    mainProgram = "sort-package-json";
  };
  npmDepsHash = "sha256-dECVKQE7AwAZERSmFhv9qXG+zCSXxSxKBqX/mtFFXFs=";
  # keep-sorted end
}
