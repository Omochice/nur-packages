# No name mapping is needed because a source name in nvfetcher.toml is also the
# package attribute name in `default.nix`.
{
  old,
  new,
}:
let
  before = builtins.fromTOML (builtins.readFile old);
  after = builtins.fromTOML (builtins.readFile new);
in
builtins.filter (name: (before.${name} or null) != after.${name}) (builtins.attrNames after)
