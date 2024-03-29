# Deprecation notice

This overlay is no longer being maintained. Powercord is EOL and Discord has released breaking changes affecting most client mods.

See https://github.com/LunNova/replugged-nix-flake for a flake for [Replugged](https://replugged.dev), the community fork/successor of Powercord.
As of 2022/09/30, it is [yet to support](https://github.com/replugged-org/replugged/issues/205) the breaking changes, but has plans to do so.

# powercord-overlay
An overlay to easily install Discord with [Powercord](https://powercord.dev)

## Installation
### With flakes
```nix
# flake.nix
{
  inputs.powercord-overlay.url = "github:LavaDesu/powercord-overlay";
}
```
```nix
# system config
{
  nixpkgs.overlays = [ inputs.powercord-overlay.overlay ];
}
```

### Without flakes
```nix
let
  powercord-overlay = import (builtins.fetchTarball "https://github.com/LavaDesu/powercord-overlay/archive/master.tar.gz");
in
{
  nixpkgs.overlays = [ powercord-overlay.overlay ];
}
```

## Usage
### Install discord-plugged
```nix
{
  # or home.packages
  environment.systemPackages = [
    ...
    pkgs.discord-plugged
  ];
}
```

### Plugins/Themes
For plugins and/or themes, override `discord-plugged`

Example:
```nix
# where you put your packages
discord-plugged.override {
  plugins = [
    (builtins.fetchTarball "https://github.com/NurMarvin/discord-tweaks/archive/master.tar.gz")
  ];
  themes = [
    (builtins.fetchTarball "https://github.com/Dyzean/Tokyo-Night/archive/master.tar.gz")
  ];
}
```

If you're using flakes, you can instead use inputs to fetch them
```nix
# flake.nix
{
  inputs = {
    discord-tweaks = { url = "github:NurMarvin/discord-tweaks"; flake = false; };
    discord-tokyonight = { url = "github:Dyzean/Tokyo-Night"; flake = false; };
  };
}
```
```nix
# where you put your packages
discord-plugged.override {
  plugins = [
    inputs.discord-tweaks
  ];
  themes = [
    inputs.discord-tokyonight
  ];
}
```

## Additional notes
- The updater should be disabled, it doesn't work for obvious reasons :)
- Settings are stored imperatively in `$XDG_CONFIG_HOME/powercord`
  (and cache in `$XDG_CACHE_HOME/powercord`)
  - This unforunately is not perfect. If you notice some plugin's settings just disappear
    after a restart (as it tried to write to the store), please open an issue here about it

## Some disclaimers
Powercord *is* against Discord's Terms of Service. However, at the time of writing, Discord isn't
currently hunting down modded client users and punishing them or anything.

While you *should* be safe, **you are at your own risk** when using this overlay, and I am not
responsible for any damages that may happen as a result of using Powercord.
