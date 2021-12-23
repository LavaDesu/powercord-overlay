{
  description = "A nix overlay to install Discord Canary with Powercord";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";

    powercord.url = "github:powercord-org/powercord";
    powercord.flake = false;
  };

  outputs = { self, nixpkgs, utils, ... } @ inputs: utils.lib.eachSystem ["x86_64-linux"] (system:
  let
    overlay = import ./overlay.nix inputs;
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [ overlay ];
    };
  in {
    inherit overlay;
    packages = { inherit (pkgs) powercord-unwrapped powercord discord-plugged; };
  });
}
