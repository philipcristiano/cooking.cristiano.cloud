let
  sysPkg = import <nixpkgs> { };
  releasedPkgs = sysPkg.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "22.11";
    sha256 = "sha256-/HEZNyGbnQecrgJnfE8d0WC5c1xuPSD2LUpB6YXlg4c=";
  };
  pkgs = import releasedPkgs {};
  stdenv = pkgs.stdenv;
  extraInputs = sysPkg.lib.optionals stdenv.isDarwin (with sysPkg.darwin.apple_sdk.frameworks; [
    Cocoa
    CoreServices]);


in stdenv.mkDerivation {
  name = "env";
  buildInputs = [ pkgs.gnumake
                  pkgs.erlangR25
                  pkgs.rebar3
                  pkgs.elixir_1_14
                  pkgs.wget
                  pkgs.beam.packages.erlang.elixir
                  pkgs.python3

                  pkgs.rebar


                ] ++ extraInputs;
  shellHook = ''
        source .env

        export MIX_REBAR=$PWD/rebar3

        mix local.hex --force
        # cd ui
        # npm install
        # cd ..

  '';

}
