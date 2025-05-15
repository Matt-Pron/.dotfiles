# Full update
sudo pacman -Syu --noconfirm

# Packages
sudo pacman -S --needed --noconfirm neovim base-devel git hyprpaper hyprlock hyprpicker waybar rofi-wayland foot wezterm yazi lua51 luarocks yarn ripgrep fastfetch ttf-cascadia-code-nerd github-cli zoxide

# Paru for AUR packages
git clone https://aur.archlinux.org/paru.git
cd paru && makepkg -si
cd .. && rm -rf paru

# AUR Packages
paru -S --needed --noconfirm hyprshot wlogout brave-bin simplicity-sddm-theme-git

# Fonts
git clone https://github.com/g5becks/Cartograph ~/CartographCF
sudo mv ~/CartographCF /usr/share/fonts/CartographCF

# Removing Unneeded
sudo pacman -R wofi kitty dolphin
