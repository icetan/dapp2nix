let
  pkgs-version = "19.03";
  pkgs = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/tarball/${pkgs-version}";
    sha256 = "06k4grj8spdxg5758sqz908f92hp707khsnb2dygsl0229z4rhxl";
  }) {};
in pkgs
