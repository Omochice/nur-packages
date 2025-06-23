{
  source,
  nodeEnv,
  lib,
  globalBuildInputs ? [ ],
}:

nodeEnv.buildNodePackage rec {
  inherit (source) pname src version;
  name = source.pname;
  packageName = source.pname;
  buildInputs = globalBuildInputs;

  meta = with lib; {
    description = "A CLI tool for analyzing Claude Code usage from local JSONL files.";
    homepage = "https://github.com/ryoppippi/ccusage";
    changelog = "https://github.com/ryoppippi/ccusage/releases/tag/v${version}";
    license = licenses.mit;
    mainProgram = "ccusage";
  };
}
