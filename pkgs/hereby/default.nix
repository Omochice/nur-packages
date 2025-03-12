{
  source,
  lib,
  buildNpmPackage,
}:

buildNpmPackage rec {
  inherit (source) pname src version;

  doCheck = false;
  npmDepsHash = "sha256-FdUZKXAu/OBxHRKnGZTcHTwfQwM2v6wfmdcCXit29PY=";

  meta = with lib; {
    description = "A simple Node.js task runner";
    homepage = "https://github.com/jakebailey/hereby";
    changelog = "https://github.com/jakebailey/hereby/releases/tag/v${version}";
    license = licenses.mit;
  };
}
