{
  source,
  lib,
  buildGo124Module,
}:

buildGo124Module rec {
  inherit (source) pname src version;

  vendorHash = "sha256-Hxgoxmu2rqfDKKiJOXfXoPxNMt/iAQnqx4cRFQj1KWU=";

  # nativeBuildInputs = [node];

  ldflags = [
    "-X main.date=unknown"
    "-X main.commit=unknown"
    "-X main.version=${version}"
  ];

  tags = [
    "noembed"
  ];

  env.CGO_ENABLED = 0;

  # NOTE: based on https://github.com/NixOS/nixpkgs/blob/48f6c520757ccd72d2f0c448d45599c621cef9c4/pkgs/build-support/go/module.nix#L310
  installPhase = ''
    runHook preInstall

    mkdir -p $out
    dir="$GOPATH/bin"
    [ -e "$dir" ] && cp internal/bundled/libs/* $dir
    [ -e "$dir" ] && cp -r $dir $out

    runHook postInstall
  '';

  subPackages = [ "./cmd/tsgo" ];
  doCheck = false;

  meta = with lib; {
    description = "Staging repo for development of native port of TypeScript";
    homepage = "https://github.com/microsoft/typescript-go/tree/main#";
    changelog = "https://github.com/microsoft/typescript-go/commit/${source.src.rev}";
    license = licenses.asl20;
  };
}
