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
  ];

  env.CGO_ENABLED = 0;

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/rhysd/vim-startuptime";
    description = "A small Go program for better `vim --startuptime` alternative";
    license = licenses.mit;
    mainProgram = "vim-startuptime";
  };
}
