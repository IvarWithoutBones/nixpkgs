{ lib
, stdenv
, fetchFromGitHub
, autoreconfHook
, pkg-config
, lz4
, zlib
}:

stdenv.mkDerivation rec {
  pname = "switch-tools";
  version = "1.10.0";

  src = fetchFromGitHub {
    owner = "switchbrew";
    repo = pname;
    rev = "v${version}";
    sha256 = "1g823mv6r29nzxh35wmi46x5a19xr6qw4gykny91brg6dr73a24a";
  };

  nativeBuildInputs = [ autoreconfHook pkg-config ];
  buildInputs = [ lz4 zlib ];

  meta = with lib; {
    homepage = "https://github.com/The-4n/hacPack";
    description = "Make and repack Nintendo Switch NCAs/NSPs";
    license = licenses.gpl2Only;
    maintainers = [ maintainers.ivar ];
    platforms = platforms.linux;
  };
}
