{
  pkgs,
  source,
  nodeEnv,
  lib,
  globalBuildInputs ? [ ] ++ [ pkgs.makeWrapper ],
}:

lib.warn
  "claude-code: this package is deprecated in favor of numtide/llm-agents.nix (https://github.com/numtide/llm-agents.nix); use that flake instead."
  (
    nodeEnv.buildNodePackage rec {
      inherit (source) pname src version;
      name = source.pname;
      buildInputs = globalBuildInputs;

      # `claude-code` tries to auto-update by default, this disables that functionality.
      # https://docs.anthropic.com/en/docs/claude-code/settings#environment-variables
      postInstall = ''
        wrapProgram $out/bin/claude \
          --set DISABLE_AUTOUPDATER 1
      '';

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
  )
