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
  cargoHash = "sha256-OB44JaekEl1dJB6LGTLWXgcwYac2GA3I9Ab8xt/+rkI=";
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
  # keep-sorted end
}
