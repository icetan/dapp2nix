{
  pkgs ? (import ./pkgs.nix).pkgs,
}: with pkgs;

let
  version = "2.1.7";

  meta = with stdenv.lib; {
    description = "Generate a nix expressions for dapptool repos";
    homepage = "https://github.com/icetan/dapp2nix";
    license = licenses.unlicense;
    maintainers = [ { email = "me@icetan.org"; github = "icetan"; name = "Christopher Fredén"; } ];
  };

  dapp2nix = stdenv.mkDerivation {
    name = "dapp2nix-${version}";
    src = ./src;

    nativeBuildInputs = [ makeWrapper shellcheck ];

    phases = [ "unpackPhase" "installPhase" "fixupPhase" "checkPhase" ];

    installPhase = ''
      mkdir -p $out/{bin,lib}

      cp dapp2.nix $out/lib/dapp2.nix

      cp dapp2nix $out/bin
      wrapProgram $out/bin/dapp2nix \
        --set-default NIX_SSL_CERT_FILE "${cacert}/etc/ssl/certs/ca-bundle.crt" \
        --set DAPP2NIX_VERSION "${version}" \
        --set DAPP2NIX_FORMAT_VERSION 1 \
        --set DAPP2NIX_EXPR "$out/lib/dapp2.nix" \
        --set PATH ${lib.makeBinPath [ coreutils utillinux gnused git jq ]}
    '';

    doCheck = false;
    checkPhase = ''
      shellcheck -x dapp2nix
    '';

    passthru = { inherit dapp2graph dapp2nix; };

    inherit meta;
  };

  dapp2graph = stdenv.mkDerivation {
    name = "dapp2graph-${version}";
    src = ./src;

    nativeBuildInputs = [ makeWrapper shellcheck ];

    phases = [ "unpackPhase" "installPhase" "fixupPhase" "checkPhase" ];

    installPhase = ''
      mkdir -p $out/bin
      cp dapp2graph $out/bin
      wrapProgram $out/bin/dapp2graph \
        --set PATH ${lib.makeBinPath [ coreutils gnugrep jq graphviz ]}
    '';

    doCheck = false;
    checkPhase = ''
      shellcheck -x dapp2graph
    '';
    inherit meta;
  };
in dapp2nix
