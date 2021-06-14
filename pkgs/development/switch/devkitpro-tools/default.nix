{ lib
, stdenv
, fetchFromGitHub
, autoreconfHook
}:

stdenv.mkDerivation rec {
  pname = "devkitpro-tools";
  version = "1.0.3";

  src = fetchFromGitHub {
    owner = "devkitPro";
    repo = "general-tools";
    rev = "v${version}";
    sha256 = "1030269qwcndaygwkakv54g0gnw4w4qngwg4zy5a2j1a2dl4l6sp";
  };

  nativeBuildInputs = [ autoreconfHook ];

  meta = with lib; {
    homepage = "https://github.com/The-4n/hacPack";
    description = "Make and repack Nintendo Switch NCAs/NSPs";
    license = licenses.gpl2Only;
    maintainers = [ maintainers.ivar ];
    platforms = platforms.linux;
  };
}
