inputs: final: prev: rec {
  powercord-unwrapped = prev.callPackage ./drvs/powercord-unwrapped.nix { inherit inputs; };

  powercord = prev.callPackage ./drvs/powercord.nix {
    inherit powercord-unwrapped;
    plugins = [ ];
    themes = [ ];
  };

  discord-plugged = prev.callPackage ./drvs/discord.nix {
    inherit inputs powercord;
    plugins = [ ];
    themes = [ ];
  };

  bdcompat = prev.callPackage ./drvs/bdcompat.nix {
    plugins = [ ];
  };
}
