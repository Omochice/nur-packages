{
  source,
  original,
}:
original.overrideAttrs (old: {
  inherit (source) pname src version;
  vendorHash = "sha256-+iYNducL+tX34L5VlisqeNwvJUcuOAkEWDk/2JbfC0Q=";
})
