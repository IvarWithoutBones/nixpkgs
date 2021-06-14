{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "libnx";
  version = "4.1.0";

  src = fetchFromGitHub {
    owner = "switchbrew";
    repo = pname;
    rev = "v${version}";
    sha256 = "19f2qwzimhniyx6hwygafmd0yrvvv8zdm077vjpvgw6z6byaz6sf";
  };

  meta = with lib; {
    homepage = "https://github.com/The-4n/hacPack";
    description = "Make and repack Nintendo Switch NCAs/NSPs";
    license = licenses.gpl2Only;
    maintainers = [ maintainers.ivar ];
    platforms = platforms.linux;
  };
}
