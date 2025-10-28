# shell.nix

{ pkgs ? import <nixpkgs> {
    config = {
      # Mengizinkan paket berpemilik (unfree).
      allowUnfree = true;
    };
  }
}:
pkgs.mkShell {
  # Dependensi yang diperlukan
  buildInputs = [
    pkgs.python312      
    pkgs.stdenv.cc.cc.lib 
    pkgs.linuxPackages.nvidia_x11
    pkgs.cudaPackages.cudatoolkit 
    pkgs.cudaPackages.cudnn
    pkgs.git
  ];
  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ 
      pkgs.stdenv.cc.cc.lib
      pkgs.cudaPackages.cudatoolkit
      pkgs.cudaPackages.cudnn
      pkgs.linuxPackages.nvidia_x11 
    ]}:$LD_LIBRARY_PATH"
  '';
}
