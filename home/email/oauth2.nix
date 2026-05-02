{
  pkgs ? import <nixpkgs> { },
  lib ? pkgs.lib,
  ...
}:
pkgs.writeShellApplication {
  name = "mutt_oauth2";
  runtimeInputs = with pkgs; [
    libsecret
    gobject-introspection
    (python3.withPackages (ps: [
      ps.pygobject3
      ps.dbus-python
    ]))
  ];
  text = ''
    export GI_TYPELIB_PATH=${lib.makeSearchPath "lib/girepository-1.0" [ pkgs.libsecret ]}
    python3 ${./mutt_oauth2.py} "$@"
  '';
}
