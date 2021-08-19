{ inputs
, mkYarnPackage
}:
(mkYarnPackage {
  name = "powercord";
  src = inputs.powercord;
  yarnLock = "${inputs.self}/misc/yarn.lock";

  patches = [ ../misc/powercord.patch ];
}).overrideAttrs (_: { doDist = false; })
