{
  source,
  original,
}:
original.overrideAttrs (old: {
  inherit (source) pname src version;
  vendorHash = "sha256-jP2Ne/EhmE3tACY1+lHucgBt3VnT4gaQisE3/gVM5Ec=";
})
