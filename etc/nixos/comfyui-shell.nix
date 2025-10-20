{ pkgs ? import <nixpkgs> {
  config = {
    allowUnfree = true;
    cudaSupport = true;
    cudaCapabilities = [ "6.1" ];
  };
  overlays = [
    (final: prev: {
      python311 = prev.python311.override {
        packageOverrides = pythonFinal: pythonPrev: {
          markdown = pythonPrev.markdown.overridePythonAttrs (old: {
            doCheck = false;
          });
        };
      };
    })
  ];
} }:

pkgs.mkShell {
  python = pkgs.python311;

  buildInputs = [
    # Dependensi CUDA
    pkgs.cudaPackages_11_8.cudatoolkit

    # Python dan Pustaka Ilmiah Utama
    pkgs.python311

    # Pustaka PyTorch dan dependensi ComfyUI dengan Dukungan CUDA
    (pkgs.python311.withPackages (ps: [
      # Pustaka PyTorch
      ps.torchWithCuda
      ps.torchvision
      ps.torchaudio
      ps.torchsde
      # Pustaka Ilmiah dan Utama
      ps.numpy
      ps.pip

      # Tambahan Paket Python yang Diminta
      ps.einops
      ps.transformers
      ps.tokenizers
      ps.sentencepiece
      ps.safetensors
      ps.aiohttp
      ps.yarl
      ps.pyyaml
      ps.pillow
      ps.scipy
      ps.tqdm
      ps.psutil
      ps.alembic
      ps.sqlalchemy
      ps.av
      ps.greenlet
      ps.typing-extensions # Sudah ada di banyak env modern, tapi disertakan jika diperlukan
      ps.kornia
      ps.pydantic
      ps.pydantic-settings

      # Catatan: 'numpy' kedua yang terpisah di kode asli dihapus karena sudah termasuk di atas.
    ]))
  ];

  shellHook = ''
    # Setting Environment Variables
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [
      pkgs.cudaPackages_11_8.cudatoolkit
    ]}:$LD_LIBRARY_PATH"
    ${pkgs.python311}/bin/python -m pip install --user --break-system-packages -r requirements.txt
    ${pkgs.python311}/bin/python -m pip install --user --break-system-packages comfyui-frontend-package
    export TORCH_CUDA_ARCH_LIST="6.1"
    export PYTORCH_ALLOC_CONF="backend:cuda"
  '';
}
