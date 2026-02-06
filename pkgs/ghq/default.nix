{
  source,
  original,
}:
original.overrideAttrs (old: {
  inherit (source) pname src version;
  vendorHash = "sha256-RRxRwYTkveOZvvxAwpG9ie4+ZdUDDkZZfX5cNn0DAhA=";
})
