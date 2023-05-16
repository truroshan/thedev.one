{
  # https://lukebentleyfox.net/posts/building-this-blog/
  # building zola is based on ^ blog post
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
            inherit system;
            overlays = [ overlay ];
        };
        overlay = (final: prev: {
          roshan-site = prev.callPackage ./site {};
        });
      in 
      rec {
        inherit (overlay);

        packages.default = pkgs.roshan-site;

        devShells.default = pkgs.mkShell {
          buildInputs = [ pkgs.zola ];
        };

        # defaultApp =  pkgs.writeShellScriptBin "roshan-site" ''
        #   #!${pkgs.stdenv.shell}
        #   cd site
        #   ${pkgs.zola}/bin/zola serve --port 8000
        # '';

      }
    );
}
