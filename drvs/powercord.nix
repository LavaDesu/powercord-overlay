{ lib
, powercord-unwrapped
, stdenvNoCC
, plugins
, themes
}:
stdenvNoCC.mkDerivation {
  name = "powercord";
  src = powercord-unwrapped.out;

  installPhase =
    let
      readName = file: lib.strings.sanitizeDerivationName (builtins.fromJSON (builtins.readFile file)).name;

      intoAddons = list: manifestName: builtins.map (element:
      let
        # We're relying on nix to coerce this into something we can use
        path = "${element}";
      in {
        inherit path;
        name = readName "${path}/${manifestName}";
      }) list;

      map = type: addons: lib.concatMapStringsSep "\n" (addon: ''
        chmod 755 $out/src/Powercord/${type}
        cp -a ${addon.path} $out/src/Powercord/${type}/${addon.name}
        chmod -R u+w $out/src/Powercord/${type}/${addon.name}
      '') addons;

      mappedPlugins = map "plugins" (intoAddons plugins "manifest.json");
      mappedThemes = map "themes" (intoAddons themes "powercord_manifest.json");
    in ''
      cp -a $src $out
      chmod 755 $out
      ln -s ${powercord-unwrapped.deps}/node_modules $out/node_modules

      ${mappedPlugins}
      ${mappedThemes}
    '';

  passthru.unwrapped = powercord-unwrapped;
  meta = powercord-unwrapped.meta // {
    priority = (powercord-unwrapped.meta.priority or 0) - 1;
  };
}
