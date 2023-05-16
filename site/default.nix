{ pkgs, stdenv, ... }:
pkgs.stdenv.mkDerivation rec {
  pname = "thedev-one";
  version = "0.0.1";
  src = ./.;
  buildInputs = [ pkgs.zola ];
  buildPhase = ''
    zola build
  '';
  installPhase = ''
    cp -r public $out
  '';
}
