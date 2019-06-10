# dapp2nix

Generate nix expressions for [dapp.tools](https://dapp.tools/) repos, based on their installed submodules

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
  dapp-pkgs = import (fetchGit {
    url = https://github.com/dapphub/dapptools;
    rev = "a32228048a23ea8f81fdb0e8acb98b914c30144d";
  }) {};

  inherit (dapp-pkgs.callPackage ./dapp.nix {}) this;
in this
```
