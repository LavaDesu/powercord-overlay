{ lib
, inputs
, mkYarnPackage
, plugins
, themes
}:
(mkYarnPackage {
  name = "powercord";
  src = inputs.powercord;
  yarnLock = "${inputs.self}/misc/yarn.lock";

  patches = [ ../misc/powercord.patch ];
  postPatch =
    let
      map = l: lib.concatStringsSep " " l;
      mappedPlugins = map plugins;
      mappedThemes = map themes;
    in
    ''
      ln -s ${mappedPlugins} src/Powercord/plugins
      ln -s ${mappedThemes} src/Powercord/themes
    '';
}).overrideAttrs (_: {
  doDist = false;
})
