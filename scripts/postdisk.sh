#!/bin/sh

read -p "New username: " newusername
read -p "Password: " newuserpassword

pacstrap -K /mnt base linux linux-firmware vim firefox networkmanager network-manager-applet nm-connection-editor man-db man-pages texinfo sudo openssh git base-devel fakeroot make gcc pkg-config gvfs gvfs-mtp gvfs-smb sshfs which kitty grub efibootmgr os-prober zsh nvidia nvidia-utils vulkan-tools xfce4 xdg-user-dirs wayland pipewire pipewire-audio pipewire-pulse wireplumber bluez bluez-utils blueman polkit lxsession-gtk3 lxappearance neovim

genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt << EOF
ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
hwclock --systohc
localectl set-keymap es

sed -i 's/#es_ES.UTF-8/es_ES.UTF-8/' /etc/locale.gen
locale-gen

echo LANG=es_ES.UTF-8 >> /etc/locale.conf
echo KEYMAP=es >> /etc/vconsole.conf
echo angel-desktop >> /etc/hostname

#passwd

# Bootloader
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
sed -i 's/#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# User(s)
sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
useradd -m -G wheel,users -s /bin/zsh $newusername
passwd $newusername
$newuserpassword
$newuserpassword

pacman -S sddm

sudo systemctl enable NetworkManager
#sudo systemctl enable dhcpcd
sudo systemctl enable sddm
EOF
