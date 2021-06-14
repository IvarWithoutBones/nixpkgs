{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "devkita64-rules";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "devkitPro";
    repo = pname;
    rev = "v${version}";
    sha256 = "092rxymxnmdb15bzfzrrh0gdrbad9svnfxi5yg59j6my1qfda60b";
  };

  # Hardcoded install paths
  installPhase = ''
    mkdir -p $out/include 
    cp base_{rules,tools} $out/include

    substituteInPlace $out/include/base_rules \
      --replace "\$(DEVKITPRO)/devkitA64" "$out/include"
  '';

  meta = with lib; {
    homepage = "https://github.com/The-4n/hacPack";
    description = "Make and repack Nintendo Switch NCAs/NSPs";
    license = licenses.gpl2Only;
    maintainers = [ maintainers.ivar ];
    platforms = platforms.linux;
  };
}
