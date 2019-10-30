rec {
  nixpkgs = fetchGit {
    url = "https://github.com/NixOS/nixpkgs-channels";
    ref = "nixos-19.09";
    rev = "c75de8bc12cc7e713206199e5ca30b224e295041";
  };
  pkgs = import nixpkgs {};
}
