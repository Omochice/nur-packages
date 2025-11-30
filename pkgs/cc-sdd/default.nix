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
  meta.description = ''
    Spec-driven development (SDD) for your team's workflow.
    Kiro style commands that enforce structured requirements→design→tasks workflow and steering, transforming how you build with AI.
    Support Claude Code, Codex, Cursor, Github Copilot, Gemini CLI and Windsurf.
  '';
  meta.homepage = "https://github.com/gotalab/cc-sdd";
  meta.changelog = "https://github.com/gotalab/cc-sdd/releases/tag/v${version}";
  meta.license = lib.licenses.mit;
  meta.mainProgram = "cc-sdd";
  name = source.pname;
  packageName = source.pname;
  # keep-sorted end
}
