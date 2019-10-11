{
  pkgs ? import ./pkgs.nix,
}: with pkgs;

let
  name = "dapp2nix";
  version = "1.1.1";
in stdenv.mkDerivation {
  name = "${name}-${version}";
  src = lib.cleanSource ./.;

  buildInputs = [ makeWrapper ];

  phases = [ "unpackPhase" "installPhase" "fixupPhase" ];

  installPhase = ''
    mkdir -p $out/{bin,lib}

    cp dapp2.nix $out/lib/dapp2.nix

    cp dapp2nix $out/bin
    wrapProgram $out/bin/dapp2nix \
      --set DAPP2NIX_VERSION "${version}" \
      --set DAPP2NIX_FORMAT_VERSION 1 \
      --set DAPP2NIX_EXPR "$out/lib/dapp2.nix" \
      --set PATH ${lib.makeBinPath [ coreutils gnused git jq mktemp ]}

    cp dapp2graph $out/bin
    wrapProgram $out/bin/dapp2graph \
      --set PATH ${lib.makeBinPath [ coreutils gnugrep jq graphviz ]}
  '';

  meta = with stdenv.lib; {
    description = "Generate a nix expressions for dapptool repos";
    homepage = "https://github.com/icetan/dapp2nix";
    license = licenses.unlicense;
    maintainers = [ { email = "me@icetan.org"; github = "icetan"; name = "Christopher Fredén"; } ];
  };
}
