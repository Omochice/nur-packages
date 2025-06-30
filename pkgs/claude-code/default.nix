{
  source,
  nodeEnv,
  lib,
  globalBuildInputs ? [ ],
}:

nodeEnv.buildNodePackage rec {
  inherit (source) pname src version;
  name = source.pname;
  buildInputs = globalBuildInputs;

  packageName = "@anthropic-ai/claude-code";
  meta = with lib; {
    description = "Agentic coding tool that lives in your terminal, understands your codebase, and helps you code faster";
    homepage = "https://github.com/anthropics/claude-code";
    downloadPage = "https://www.npmjs.com/package/@anthropic-ai/claude-code/v/${version}";
    license = licenses.unfree;
    mainProgram = "claude";
  };

  production = true;
  bypassCache = true;
  reconstructLock = true;
}
