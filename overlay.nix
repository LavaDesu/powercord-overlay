inputs: final: prev: {
  discord-plugged = prev.callPackage ./drvs/discord.nix {
    inherit inputs;
    powercord = final.powercord;
  };

  powercord = prev.callPackage ./drvs/powercord.nix {
    inherit inputs;
  };
}
