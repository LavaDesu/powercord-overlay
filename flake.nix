{
  description = "A nix overlay to install Discord Canary with Powercord";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus/staging";

    powercord.url = "github:powercord-org/powercord";
    powercord.flake = false;
  };

  outputs = { self, nixpkgs, utils, ... } @ inputs: utils.lib.mkFlake {
    inherit self inputs;

    # this is the only arch supported in the discord derivation
    supportedSystems = [ "x86_64-linux" ];

    channels.nixpkgs.config.allowUnfree = true;
    channels.nixpkgs.overlaysBuilder = _: [ (import ./overlay.nix inputs) ];
    overlays = utils.lib.exportOverlays { inherit (self) pkgs inputs; };
    outputsBuilder = channels: {
      packages = utils.lib.exportPackages self.overlays channels;
    };
  };
}
