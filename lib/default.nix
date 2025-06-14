{ pkgs }:

{
  runAs =
    name: runtimeInputs: text:
    let
      program = pkgs.writeShellApplication {
        inherit name runtimeInputs text;
      };
    in
    {
      type = "app";
      program = "${program}/bin/${name}";
    };
}
