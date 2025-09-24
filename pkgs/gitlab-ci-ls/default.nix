{
  source,
  lib,
  rustPlatform,
  openssl,
  pkg-config,
}:

rustPlatform.buildRustPackage rec {
  inherit (source) pname src version;
  # keep-sorted start block=yes
  buildInputs = [ openssl ];
  cargoHash = "sha256-wDu89bhyR4a0U9KDF0iasdYrc1GUGlYH1y6D8+NKPy4=";
  doCheck = true;
  meta = with lib; {
    # keep-sorted start
    changelog = "https://github.com/alesbrelih/gitlab-ci-ls/releases/tag/${version}";
    description = "Language server for Gitlab CI";
    homepage = "https://github.com/alesbrelih/gitlab-ci-ls";
    license = licenses.mit;
    mainProgram = "gitlab-ci-ls";
    # keep-sorted end
  };
  nativeBuildInputs = [ pkg-config ];
  useFetchCargoVendor = true;
  # keep-sorted end
}
