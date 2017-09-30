{ stdenv ? (import <nixpkgs> {}).stdenv, fetchurl ? (import <nixpkgs> {}).fetchurl }:

stdenv.mkDerivation rec {
  name = "${pname}-${version}";
  pname = "sgrep";
  version = "1.94a";
  
  src = fetchurl {
    url = "https://mirrors.mediatemple.net/debian-archive/debian/pool/main/s/sgrep/sgrep_1.94a.orig.tar.gz";
    sha256 = "1ygsjmil9b5jpprqs8lmkh9q171cbn4jsg984ig76i5bwdw69cfm";
  };
}
