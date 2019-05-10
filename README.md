# dapp2nix

Generate nix expressions for dapptool repos.

## Install

```sh
nix-env -i -f https://github.com/icetan/dapp2nix/tarball/master
```

## Usage

### Generate lock file

The `dapp2nix` generates a nix expression:

```sh
dapp2nix > dapp.nix
```

You can now import this file into your derivation:

```nix
let
  dapp-version = "dapp/0.16.0";
  dapp-pkgs = import (fetchTarball {
    url = "https://github.com/dapphub/dapptools/tarball/${dapp-version}";
    sha256 = "06k4grj8spdxg5758sqz908f92hp707khsnb2dygsl0229z4rhxl";
  }) {};

  inherit (dapp-pkgs.callPackage ./dapp.nix {}) this;
in this
```
