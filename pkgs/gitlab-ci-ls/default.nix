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
  cargoHash = "sha256-SZLSTstzokjazhvVXyHjGhsfQ3vKxmSijHiq9dP5ADc=";

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
