{
  source,
  nodeEnv,
  lib,
  globalBuildInputs ? [ ],
}:

nodeEnv.buildNodePackage rec {
  inherit (source) pname src version;
  # keep-sorted start block=yes
  buildInputs = globalBuildInputs;
  meta = with lib; {
    description = "A fast, tiny package manager for the npm registry, written in TypeScript.";
    homepage = "https://github.com/unjs/upm";
    changelog = "https://github.com/unjs/upm/releases/tag/v${version}";
    license = licenses.mit;
    mainProgram = "upm";
  };
  name = source.pname;
  packageName = source.pname;
  # keep-sorted end
}
