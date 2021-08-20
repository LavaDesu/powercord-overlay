{ discord-canary
, inputs
, powercord
, plugins
, themes
}:
let
  powercordWithAddons = powercord.override {
    inherit plugins themes;
  };
in
discord-canary.overrideAttrs (old: {
  pname = "discord-plugged";
  installPhase = old.installPhase + ''
    cp -r ${inputs.self}/plugs $out/opt/DiscordCanary/resources/app
    substituteInPlace $out/opt/DiscordCanary/resources/app/index.js --replace 'POWERCORD_SRC' '${powercordWithAddons}/libexec/powercord/deps/powercord'
  '';
})
