{
  description = "RetroArch with the Beetle PSX HW core";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      retroarch = pkgs.retroarch.withCores (cores: [ cores.beetle-psx-hw ]);
      launcher = pkgs.writeShellApplication {
        name = "retro-psx";
        runtimeInputs = [ retroarch ];
        text = ''exec retroarch "$@"'';
      };
    in {
      packages.${system}.default = retroarch;
      apps.${system}.default = {
        type = "app";
        program = "${launcher}/bin/retro-psx";
      };
    };
}
