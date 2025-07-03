{
  source,
  lib,
  rustPlatform,
  openssl,
  pkg-config,
}:

rustPlatform.buildRustPackage rec {
  inherit (source) pname src version;

  useFetchCargoVendor = true;
  cargoHash = "sha256-V2ZQLHLIaYJpNeQIZyRq2G5u6/cTJvMXV2301VG21xQ=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  meta = with lib; {
    description = "Language server for Gitlab CI";
    homepage = "https://github.com/alesbrelih/gitlab-ci-ls";
    changelog = "https://github.com/alesbrelih/gitlab-ci-ls/releases/tag/${version}";
    license = licenses.mit;
    mainProgram = "gitlab-ci-ls";
  };
}
