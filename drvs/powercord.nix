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
      map = n: l: lib.concatMapStringsSep "\n" (e: ''
        cp -r ${e} src/Powercord/${n}
        chmod -R u+w src/Powercord/${n}/${lib.last (lib.splitString "/" e)}
      '') l;

      mappedPlugins = map "plugins" plugins;
      mappedThemes = map "themes" themes;
    in
      mappedPlugins + mappedThemes;

  meta = {
    homepage = "https://powercord.dev";
    license = "unfree";
  };
}).overrideAttrs (_: {
  doDist = false;
})
