{
  pkgs ? import ./pkgs.nix,
}: with pkgs;

let
  name = "dapp2nix";
  version = "1.0.0";
in stdenv.mkDerivation {
  name = "${name}-${version}";
  src = lib.cleanSource ./.;

  buildInputs = [ makeWrapper ];

  phases = [ "unpackPhase" "installPhase" "fixupPhase" ];

  installPhase = ''
    mkdir -p $out/bin

    cp dapp2nix $out/bin
    wrapProgram $out/bin/dapp2nix \
      --set DAPP2NIX_VERSION "${version}" \
      --set PATH ${lib.makeBinPath [ coreutils gnused git ]}

    cp dapp2graph $out/bin
    wrapProgram $out/bin/dapp2graph \
      --set PATH ${lib.makeBinPath [ coreutils nix gnutar gnugrep git jq graphviz ]}
  '';

  meta = with stdenv.lib; {
    description = "Generate a nix expressions for dapptool repos";
    homepage = "https://github.com/icetan/dapp2nix";
    license = licenses.unlicense;
    maintainers = [ { email = "me@icetan.org"; github = "icetan"; name = "Christopher Fredén"; } ];
  };
}
