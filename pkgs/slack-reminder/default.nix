{
  source,
  lib,
  buildGoModule,
}:

buildGoModule rec {
  inherit (source) pname src version;

  vendorHash = "sha256-WTP2iEwffesoS0mSfqPOVZycoyJAs/nTPR0AlIkDyYo=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/skanehira/slack-reminder/cmd.Version=${version}"
    "-X github.com/skanehira/slack-reminder/cmd.Revision=unknown"
  ];

  env.CGO_ENABLED = 0;

  versionCheckProgramArg = "--help";
  doInstallCheck = true;

  meta = with lib; {
    description = "Slack remind generator";
    homepage = "https://github.com/skanehira/slack-reminder";
    changelog = "https://github.com/skanehira/slack-reminder/tag/v${version}";
    license = licenses.mit;
  };
}
