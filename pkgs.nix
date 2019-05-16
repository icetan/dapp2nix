let
  pkgs = import (fetchTarball {
    url = https://releases.nixos.org/nixos/19.03/nixos-19.03.172627.c21f08bfedd/nixexprs.tar.xz;
    sha256 = "1bs16f4zaq6j5wk7zp0jdcsb144sqycv3bk3jiq2sracc5wswgqh";
  }) {};
in pkgs
