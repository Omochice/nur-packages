# A source is refreshed under its own name, because that name is also the
# package attribute in `default.nix`.
# Sources that match no attribute, such as one prebuilt binary per platform,
# are skipped because nvfetcher already records the only hash they have.
{
  old,
  new,
  packages,
}:
let
  before = builtins.fromTOML (builtins.readFile old);
  after = builtins.fromTOML (builtins.readFile new);
  isPackage = name: builtins.elem name (builtins.fromJSON packages);
in
builtins.filter (name: isPackage name && (before.${name} or null) != after.${name}) (
  builtins.attrNames after
)
