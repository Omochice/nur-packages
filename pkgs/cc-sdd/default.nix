{
  source,
  nodeEnv,
  lib,
  globalBuildInputs ? [ ],
}:

lib.warn
  "cc-sdd: this package is deprecated in favor of numtide/llm-agents.nix (https://github.com/numtide/llm-agents.nix); use that flake instead."
  (
    nodeEnv.buildNodePackage rec {
      inherit (source) pname src version;
      # keep-sorted start block=yes
      buildInputs = globalBuildInputs;
      meta.description = ''
        Spec-driven development (SDD) for your team's workflow.
        Kiro style commands that enforce structured requirements→design→tasks workflow and steering, transforming how you build with AI.
        Support Claude Code, Codex, Cursor, GitHub Copilot, Gemini CLI and Windsurf.
      '';
      meta.homepage = "https://github.com/gotalab/cc-sdd";
      meta.changelog = "https://github.com/gotalab/cc-sdd/releases/tag/v${version}";
      meta.license = lib.licenses.mit;
      meta.mainProgram = "cc-sdd";
      name = source.pname;
      packageName = source.pname;
      # keep-sorted end
    }
  )
