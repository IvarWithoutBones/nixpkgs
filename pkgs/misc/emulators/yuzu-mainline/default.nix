{ stdenv, mkDerivation, fetchFromGitHub
, cmake, pkgconfig, python2, doxygen
, unicorn-emu, boost173, catch2, fmt, lz4, nlohmann_json, rapidjson, zlib, zstd, SDL2
, libudev, libusb1, libzip, qtbase, qtwebengine
, libpulseaudio, libjack2, alsaLib, sndio, ecasound
, useVulkan ? true, vulkan-loader, vulkan-headers

, fetchpatch
}:

mkDerivation rec {
  pname = "yuzu";
  version = "401";

  src = fetchFromGitHub {
    owner = "yuzu-emu";
    repo = "yuzu-mainline"; # They use a separate repo for mainline “branch”
    fetchSubmodules = true;
    rev = "mainline-0-${version}";
    sha256 = "0j9gi9695m6hljpi5kbid792ggc4n4xldrz81vywgkpi805ldpqh";
  };

  nativeBuildInputs = [ cmake pkgconfig python2 doxygen ];
  buildInputs = [ unicorn-emu qtbase qtwebengine boost173 catch2 fmt lz4 nlohmann_json rapidjson zlib zstd SDL2 libudev libusb1 libpulseaudio alsaLib sndio ecasound libjack2 libzip ]
  ++ stdenv.lib.optionals useVulkan [ vulkan-loader vulkan-headers ];
  cmakeFlags = [ "-DYUZU_USE_BUNDLED_UNICORN=OFF" "-DYUZU_USE_QT_WEB_ENGINE=ON" "-DUSE_DISCORD_PRESENCE=ON" "-Wno-dev" ]
  ++ stdenv.lib.optionals (!useVulkan) [ "-DENABLE_VULKAN=No" ];

  # Trick the configure system. This prevents a check for submodule directories.
  preConfigure = "rm .gitmodules";

  patches = [ # Required till https://github.com/yuzu-emu/yuzu/pull/4731 hits mainline (already merged). This can be removed upon the next update.
    (fetchpatch {
      name = "zstd-fix.patch";
      url = "https://github.com/yuzu-emu/yuzu/pull/4731.patch";
      sha256 = "0xxmly5pql5vff4ff47qbv371himxgppqdyma8hjf5y8xm5byq79";
    })
  ];

  # Fix vulkan detection
  postFixup = stdenv.lib.optionals useVulkan ''
    wrapProgram $out/bin/yuzu --prefix LD_LIBRARY_PATH : ${vulkan-loader}/lib
    wrapProgram $out/bin/yuzu-cmd --prefix LD_LIBRARY_PATH : ${vulkan-loader}/lib
  '';

  meta = with stdenv.lib; {
    homepage = "https://yuzu-emu.org";
    description = "An experimental Nintendo Switch emulator";
    license = with licenses; [
      gpl2Plus
      # Icons
      cc-by-nd-30 cc0
    ];
    maintainers = with maintainers; [ ivar joshuafern ];
    platforms = platforms.linux;
  };
}
