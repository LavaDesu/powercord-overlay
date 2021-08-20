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
      cp -r ${mappedPlugins} src/Powercord/plugins
      cp -r ${mappedThemes} src/Powercord/themes

      chmod -R u+w src/Powercord/plugins
      chmod -R u+w src/Powercord/themes
    '';

  meta = {
    homepage = "https://powercord.dev";
    license = "unfree";
  };
}).overrideAttrs (_: {
  doDist = false;
})
