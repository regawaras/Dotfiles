# ~/.bash_profile atau ~/.zprofile
# Pastikan Anda menggunakan file yang dijalankan untuk *login shell*


if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ] && [ -n "${NIX_PATH}" ]; then
  # Hanya jalankan jika:
  # 1. Variabel DISPLAY tidak diatur (yaitu, bukan sesi X/Wayland yang sudah berjalan)
  # 2. Anda berada di Virtual Terminal (TTY) 1
  # 3. NIX_PATH diatur (biasanya hanya di NixOS)

  # Anda mungkin perlu memastikan lingkungan Wayland disiapkan
  export XDG_SESSION_TYPE="wayland"
  export XDG_SESSION_DESKTOP="Hyprland"
  export XDG_CURRENT_DESKTOP="Hyprland"

  # Eksekusi Hyprland, menggantikan proses shell saat ini
  # Ini akan membuat sesi Hyprland berjalan di TTY1
  exec Hyprland
fi

. "$HOME/als/Kritaai/server/uv/env"
