{
  source,
  lib,
  buildGoLatestModule,
  glab,
  makeWrapper,
}:

buildGoLatestModule rec {
  inherit (source) pname src version;
  # keep-sorted start block=yes
  env.CGO_ENABLED = 0;
  ldflags = [
    "-s"
    "-w"
    # Upstream prepends "refs/tags/v" to this value, so passing the tag as is would yield "refs/tags/vv0.5.0".
    "-X github.com/Omochice/nyctereutes/nyctereutes.version=${lib.removePrefix "v" version}"
  ];
  meta.changelog = "https://github.com/Omochice/nyctereutes/releases/tag/${version}";
  meta.description = "A CLI toolchain for operating GitLab projects, driven through the glab CLI.";
  meta.homepage = "https://github.com/Omochice/nyctereutes";
  meta.license = lib.licenses.zlib;
  meta.mainProgram = "nyctereutes";
  nativeBuildInputs = [ makeWrapper ];
  # A suffix rather than a prefix, so a glab the user already has on PATH keeps taking precedence.
  postInstall = "wrapProgram $out/bin/nyctereutes --suffix PATH : ${lib.makeBinPath [ glab ]}";
  vendorHash = "sha256-qQ/VZ2G5IE8t72CGSyrAJ9glhfirNvkUX+KY7oEKs+w=";
  # keep-sorted end
}
