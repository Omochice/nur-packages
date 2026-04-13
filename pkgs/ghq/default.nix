{
  source,
  original,
}:
original.overrideAttrs (old: {
  inherit (source) pname src version;
  vendorHash = "sha256-8aC1J/mM7ZTEQBdZwstvHxMKDPqgzjzYztC7shuwu/Q=";
})
