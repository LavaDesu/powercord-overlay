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
      map = n: l: lib.concatMapStringsSep "\n" (e: ''
        chmod 755 $out/src/Powercord/${n}
        cp -a ${e} $out/src/Powercord/${n}
        chmod -R u+w $out/src/Powercord/${n}/${lib.last (lib.splitString "/" e)}
      '') l;

      mappedPlugins = map "plugins" plugins;
      mappedThemes = map "themes" themes;
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
