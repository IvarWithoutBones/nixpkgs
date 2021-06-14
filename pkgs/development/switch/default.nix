{ lib, stdenv, pkgs }:

lib.makeScope pkgs.newScope (self: with self; rec {
  libnx = callPackage ./libnx { };

  devkita64-rules = callPackage ./devkita64-rules { };

  switch-tools = callPackage ./switch-tools { };

  devkitpro-tools = callPackage ./devkitpro-tools { };
})
