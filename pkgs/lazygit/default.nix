{
  source,
  lib,
  buildGoModule,
}:

buildGoModule rec {
  inherit (source) pname src version;

  vendorHash = null;

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
    "-X main.commit=${builtins.readFile "${src}/.git/shallow"}"
    "-X main.date=unknown"
    "-X main.buildSource=nix"
  ];

  subPackages = [ "." ];

  env.CGO_ENABLED = 0;

  doCheck = false;

  meta = with lib; {
    description = "simple terminal UI for git commands";
    homepage = "https://github.com/jesseduffield/lazygit";
    changelog = "https://github.com/jesseduffield/lazygit/releases/tag/${version}";
    license = licenses.mit;
    mainProgram = "lazygit";
  };
}
