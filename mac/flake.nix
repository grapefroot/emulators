{
  description = "OpenEmu-Silicon for Apple Silicon macOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nur, ... }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };
      openemu = nur.legacyPackages.${system}.repos.forkprince.openemu-silicon;
      launcher = pkgs.writeShellApplication {
        name = "openemu-silicon";
        text = ''
          app=$(/usr/bin/find "${openemu}" -maxdepth 4 -type d -name '*.app' -print -quit)
          if [ -z "$app" ]; then
            echo "Could not find the OpenEmu-Silicon app bundle in the Nix package." >&2
            exit 1
          fi
          exec /usr/bin/open -a "$app" --args "$@"
        '';
      };
    in {
      packages.${system}.default = openemu;
      apps.${system}.default = {
        type = "app";
        program = "${launcher}/bin/openemu-silicon";
      };
    };
}
