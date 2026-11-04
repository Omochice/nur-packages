{
  source,
  original,
}:
original.overrideAttrs (old: {
  inherit (source) pname src version;
  vendorHash = "sha256-FvMqeUfX4c2Vm+L2GIDGoxN3w+7UyNI0VRada0zSvcc=";
})
