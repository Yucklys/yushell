{
  description = "Yushell - A minimal system bar for Niri";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    qml-niri = {
      url = "github:imiric/qml-niri/main";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      quickshell,
      qml-niri,
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system} = {
        default = qml-niri.packages.${system}.quickshell;
      };

      devShells.${system} = {
        default = pkgs.mkShell {
          packages = [
            qml-niri.packages.${system}.quickshell
            pkgs.just
          ];

          shellHook = ''
            echo "Yushell development shell"
            echo "Run: quickshell -p ."
          '';
        };
      };
    };
}
