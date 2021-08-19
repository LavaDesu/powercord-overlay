{ discord-canary
, inputs
, powercord
}:
discord-canary.overrideAttrs (old: {
  installPhase = old.installPhase + ''
    cp -r ${inputs.self}/plugs $out/opt/DiscordCanary/resources/app
    substituteInPlace $out/opt/DiscordCanary/resources/app/index.js --replace 'POWERCORD_SRC' '${powercord}/libexec/powercord/deps/powercord'
  '';
})
