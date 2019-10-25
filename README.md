# dapp2nix

Generate nix expressions for [dapp.tools](https://dapp.tools/) repos, based on
their installed submodules.

## Install

```sh
nix-env -i -f https://github.com/icetan/dapp2nix/tarball/master
```

## Usage

### Generate lock file

`dapp2nix init` will create a lock file (`.dapp.json`) and a nix expression
(`dapp2.nix`) which you can import into your derivation:

```nix
let
  dapp-pkgs = import (fetchGit {
    url = https://github.com/dapphub/dapptools;
    rev = "a32228048a23ea8f81fdb0e8acb98b914c30144d";
  }) {};

  inherit (dapp-pkgs.callPackage ./dapp2.nix {}) this;
in this
```

### Migrate from dapp submodules

To remove the need to add dappsys dependencies as submodules you can run
`dapp2nix migrate`. This will look att the currently fetched submodules and
generate the `.dapp.json` lock file.
