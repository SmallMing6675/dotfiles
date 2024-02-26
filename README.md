## My Dotfiles:

This is my personal dotfiles configuration.

## Dependencies:

Make sure you have the following packages installed on your system before proceeding:

- git
- stow
- fish
- neovim
- alacritty / kitty
- hyprland
- starship
- rofi
- waybar

Assuming you are using an Arch based system and you have `yay` installed on your system,
simply run:
```
pacman -S Hyprland rofi fish kitty neovim vim starship waybar git stow 
#essential tools
pacman -S brightnessctl eza fd librewolf-bin hyprpicker lazygit neofetch pavucontrol ripgrep pipewire wl-clipboard zoxide 
```

To apply:

```bash
$ git clone https://github.com/SmallMing6675/Dotfiles
$ cd dotfiles
$ stow . # besure to backup your existing configuration before applying!
```
