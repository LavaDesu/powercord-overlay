inputs: final: prev: rec {
  powercord-unwrapped = prev.callPackage ./drvs/powercord-unwrapped.nix { inherit inputs; };

  powercord = final.lib.warn "[powercord-overlay] Powercord is EOL and no longer works. See README.md for more information." (prev.callPackage ./drvs/powercord.nix {
    inherit powercord-unwrapped;
    plugins = [ ];
    themes = [ ];
  });

  discord-plugged = prev.callPackage ./drvs/discord.nix {
    inherit inputs powercord;
    plugins = [ ];
    themes = [ ];
  };
}
