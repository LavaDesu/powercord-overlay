inputs: final: prev: {
  discord-plugged = prev.callPackage ./drvs/discord.nix {
    inherit inputs;
    powercord = final.powercord;
    plugins = [ ];
    themes = [ ];
  };

  powercord = prev.callPackage ./drvs/powercord.nix {
    inherit inputs;
    plugins = [ ];
    themes = [ ];
  };
}
