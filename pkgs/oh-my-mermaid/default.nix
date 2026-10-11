{
  source,
  lib,
  buildNpmPackage,
}:

buildNpmPackage rec {
  inherit (source) pname src version;
  # keep-sorted start block=yes
  meta = with lib; {
    description = "Turn complex codebases into clear, navigable architecture diagrams with Claude Code.";
    homepage = "https://github.com/oh-my-mermaid/oh-my-mermaid";
    changelog = "https://github.com/oh-my-mermaid/oh-my-mermaid/releases/tag/${version}";
    license = licenses.mit;
    mainProgram = "omm";
  };
  npmDepsHash = "sha256-B6+dxmh4cdItS3QvTIkxt6/YAEnjVs1dIY86e/9uGEA=";
  # keep-sorted end
}
