{
  source,
  original,
}:
original.overrideAttrs (old: {
  inherit (source) pname src version;
  vendorHash = "sha256-YToIkJozCyI1k5xqs4w6brVERJ2edR2PRob2tXWb9Ms=";
})
