#!/usr/bin/env bash
export disk="/dev/sda" ;
export boot_partition="${disk}1" ;
export root_partition="${disk}2" ;
export BOOT_SIZE=512
(
# Clear partitions
echo o; echo Y;
# Create EFI partition
echo n; echo; echo; echo "+$BOOT_SIZE""M";echo "EF00"; echo Y;
# Create root partition
echo n; echo; echo; echo ;echo ;
# show layout
echo p;
# apply changes
echo w; echo Y;
) | gdisk $disk ;

mkfs.fat -F32 $boot_partition ;
mkfs.btrfs  -f -L data $root_partition ;

mount $root_partition /mnt -t btrfs -o defaults,noatime,nodiratime,discard,autodefrag,ssd,compress=lzo,space_cache ;

btrfs subvolume create /mnt/@ ;
btrfs subvolume create /mnt/@home ;
btrfs subvolume create /mnt/@snapshots ;

umount /mnt ;
mount -o defaults,noatime,nodiratime,discard,autodefrag,ssd,compress=lzo,space_cache,subvol=@ $root_partition /mnt ;
mkdir -p /mnt/home ;
mount -o defaults,noatime,nodiratime,discard,autodefrag,ssd,compress=lzo,space_cache,subvol=@home $root_partition /mnt/home ;
mkdir -p /mnt/.snapshots ;
mount -o compress=lzo,discard,noatime,nodiratime,subvol=@snapshots $root_partition /mnt/.snapshots ;
mkdir -p /mnt/boot ;
mount $boot_partition /mnt/boot ;

mkdir -p /mnt/var/cache/pacman ;
btrfs subvolume create /mnt/var/cache/pacman/pkg ;
btrfs subvolume create /mnt/var/log ;
btrfs subvolume create /mnt/var/tmp ;

timedatectl set-ntp true ;
reflector -p https --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist ;

pacstrap /mnt base base-devel networkmanager bash openssh btrfs-progs systemd-swap tlp git sudo linux linux-firmware ;

genfstab -Up /mnt > /mnt/etc/fstab ;

echo "vm.swappiness=10" > /mnt/etc/sysctl.d/99-sysctl.conf ;

echo "tmpfs     /tmp         tmpfs  defaults,noatime,mode=1777  0 0" >> /mnt/etc/fstab ;

sed -i  -e '/#/d' -e '/^[[:space:]]*$/d' -e '/MODULES/d' -e '/BINARIES/d' /mnt/etc/mkinitcpio.conf
cat << EOF >> /mnt/etc/mkinitcpio.conf
MODULES=(btrfs loop)
BINARIES=(/usr/bin/btrfs)
EOF
arch-chroot /mnt bash -c "mkinitcpio -p linux"

arch-chroot /mnt pacman -S --noconfirm refind
mkdir -p /mnt/boot/EFI/
cp -r /mnt/usr/share/refind/drivers_x64/ /mnt/boot/EFI/Boot/
cp /mnt/usr/share/refind/refind_x64.efi /mnt/boot/EFI/Boot/bootx64.efi
uuid=$(arch-chroot /mnt blkid -s PARTUUID -o value $root_partition)
cat << EOF > /mnt/boot/EFI/Boot/refind.conf
scanfor manual
# -1 for immediate
timeout 20
fold_linux_kernels false
menuentry "Arch" {
  loader vmlinuz-linux
  initrd initramfs-linux.img
  options "root=PARTUUID=$uuid  rootflags=subvol=@ add_efi_memmap"
}
EOF
sed -i -e '/#/d' -e '/^[[:space:]]*$/d' -e '/zswap_enabled/d' -e '/zram_enabled/d' /mnt/etc/systemd/swap.conf
cat << EOF >> /mnt/etc/systemd/swap.conf
zswap_enabled=0
zram_enabled=1
EOF

# locale setup
cat << EOF | arch-chroot /mnt bash --
ln -sf /usr/share/zoneinfo/America/Toronto /etc/localtime
echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen
echo 'LANG=en_US.UTF-8' > /etc/default/locale
echo 'LC_ALL=en_US.UTF-8' >> /etc/default/locale
locale-gen
localectl set-locale LANG=en_US.UTF-8
hostnamectl set-hostname Arch
echo 'LANG=en_US.UTF-8' | tee /etc/locale.conf > /dev/null
EOF
# network setup
cat << EOF > /mnt/etc/systemd/network/20-wired.network
[Match]
Name=eth0
[Network]
DHCP=ipv4
EOF
# allow ssh login
sed -i -e "/.*PasswordAuthentication.*/d" -e "/.*PermitRootLogin.*/d" /mnt/etc/ssh/sshd_config
cat << EOF >> /mnt/etc/ssh/sshd_config
PasswordAuthentication yes
PermitRootLogin no
EOF
cat << EOF | arch-chroot /mnt bash --
systemctl enable systemd-networkd.service
systemctl enable systemd-resolved.service
systemctl enable NetworkManager.service
systemctl enable sshd.service
timedatectl status
EOF
# clock Setup
cat << EOF | arch-chroot /mnt bash --
hwclock --systohc --utc
timedatectl set-ntp true
timedatectl set-timezone Canada/Eastern
EOF
# user belonging to wheel group do not need to enter password to become sudo
sed -i -e '/%wheel\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/d' -e '/%wheel.*NOPASSWD:ALL/d'  /mnt/etc/sudoers
cat << EOF >> /mnt/etc/sudoers
%wheel ALL=(ALL) ALL
%wheel ALL=(ALL) NOPASSWD: ALL
EOF
# user creation
cat << EOF | arch-chroot  /mnt bash --
  useradd -U -md /home/damoon -G wheel,storage,power -s /bin/bash -p damoon damoon
  echo 'damoon:damoon' | chpasswd
EOF

# paru installation
cat << 'EOF' | arch-chroot /mnt sudo -u damoon bash --
  git clone https://aur.archlinux.org/paru.git /tmp/paru
  pushd /tmp/paru
  makepkg -sicr --noconfirm
  popd
  sudo rm -rf /tmp/paru
EOF
# main repos packages
cat << 'EOF' | arch-chroot /mnt sudo -u damoon bash --
  sudo pacman -Sy --noconfirm glibc
  sudo pacman -Sy --noconfirm pacman
  sudo sed -i -e '/ParallelDownloads/d' -e  "/\[options\]/a ParallelDownloads = 16" /etc/pacman.conf
  sudo sed -i -e '/Color/d' -e '/ILoveCandy/d' -e  "/\[options\]/a Color" -e  "/\[options\]/a ILoveCandy" /etc/pacman.conf
  sudo pacman -Sy --noconfirm reflector
  sudo reflector -p https --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
  default_packages=(
    ""
    "bash-completion"
    "sshpass"
    "wget"
    "curl"
    "unzip"
    "fzf"
    "pulseaudio"
    "pavucontrol"
    "alsa-utils"
    ""
  )
  devel=(
    ""
    "perl"
    "java-runtime"
    "python"
    "python2"
    "nodejs"
    "ruby"
    "python2-pip"
    "python-pip"
    "python-poetry"
    "yarn"
    "just"
    ""
  )
  cli=(
    ""
    "aria2"
    "jq"
    "gvim"
    "neovim"
    "python-pynvim"
    "github-cli"
    "ffmpeg"
    "mkvtoolnix-cli"
    "rsync"
    "rclone"
    "parallel"
    "tmux"
    "neofetch"
    "htop"
    "expac"
    "progress"
    "unrar"
    "dialog"
    "psutils"
    "ansible"
    ""
  )

  fonts=(
    ""
    "noto-fonts"
    "ttf-ubuntu-font-family"
    "ttf-dejavu"
    "ttf-freefont"
    "ttf-liberation"
    "ttf-droid"
    "ttf-inconsolata"
    "ttf-roboto"
    "terminus-font"
    "ttf-font-awesome"
    ""
  )
  default_packages+=${devel[@]}
  default_packages+=${cli[@]}
  default_packages+=${fonts[@]}
  sudo pacman -Sy --noconfirm --needed ${default_packages[@]}
  sudo sed -i -e 's/^\(.*pam_systemd_home.so\)$/#\1/g' /etc/pam.d/system-auth
EOF
# aur packages:
cat << 'EOF' | arch-chroot /mnt sudo -u damoon bash --
  aur_packages=(
    "visual-studio-code-bin"
    "brave-bin"
    "superproductivity-bin"
    "glow"
    "xorg-font-utils"
    "git-completion"
    "yarn-completion-git"
    "fzf-extras"
    ""
  )
  paru --needed --removemake --cleanafter --noconfirm -Sy ${aur_packages[@]}
EOF
# common config
arch-chroot /mnt sudo -u damoon sudo usermod -aG avahi,audio `whoami`
cat << 'EOF' | arch-chroot /mnt sudo -u damoon bash --
sed -i -e '/environment/d' -e  '/^PS1.*/a [ -f ~/.environment ] && . ~/.environment' ~/.bashrc
sed -i -e '/local\/bin/d' ~/.environment
(
  echo 'export PATH="$PATH:$HOME/.local/bin"'
) | tee ~/.environment > /dev/null ;
EOF
# init aliases
cat << 'EOF' | arch-chroot /mnt sudo -u damoon bash --
sed -i -e '/alias/d' ~/.bashrc
grep -qF 'bash_aliases' ~/.bashrc || echo '[ -f ~/.bash_aliases ] && . ~/.bash_aliases' | tee -a ~/.bashrc > /dev/null
 > ~/.bash_aliases
(
  echo 'alias egrep="egrep --color=auto"' ;
  echo 'alias fgrep="fgrep --color=auto"' ;
  echo 'alias grep="grep --color=auto"' ;
  echo 'alias l="ls -CF"' ;
  echo 'alias la="ls -A"' ;
  echo 'alias ll="ls -alF"' ;
  echo 'alias ls="ls --color=auto"' ;
  echo 'alias dl="aria2c --optimize-concurrent-downloads -k 1M -j16 -x 16 -c --file-allocation=falloc"' ;
) | tee ~/.bash_aliases > /dev/null ;
EOF
# docker setup
cat << 'EOF' | arch-chroot /mnt sudo -u damoon bash --
docker_packages=(
  "docker"
  "docker-compose"
  ""
)
sudo pacman -Sy --noconfirm --needed ${docker_packages[@]}
sudo systemctl enable docker
sudo usermod -aG docker `whoami`
sed -i -e '/DOCKER/d' -e '/BUILDKIT/d' ~/.environment
sed -i -e '/CONSUL/d' -e '/VAULT/d' ~/.environment
(
  echo 'export DOCKER_BUILDKIT=1' ;
  echo 'export COMPOSE_DOCKER_CLI_BUILD=1' ;
  echo 'export BUILDKIT_PROGRESS="plain"' ;
) | tee -a ~/.environment > /dev/null ;
EOF
# snap init
# [ NOTE ] => cannot install any packages in chroot
cat << 'EOF' | arch-chroot /mnt sudo -u damoon bash --
aur_packages=(
  "snapd"
  ""
)
paru --needed --removemake --cleanafter --noconfirm -Sy ${aur_packages[@]}
sudo systemctl enable snapd.socket
sudo systemctl enable snapd.service
sudo ln -s /var/lib/snapd/snap /snap
EOF

# goenv setup
cat << 'EOF' | arch-chroot /mnt sudo -u damoon bash --
  sudo paru -Rcns --noconfirm go || true
  [ ! -d ~/.goenv ] && git clone https://github.com/syndbg/goenv.git ~/.goenv > /dev/null 2>&1
  export PATH="$PATH:$HOME/.goenv/bin"
  goenv install 1.16.3 || true
  goenv global 1.16.3 || true
  goenv rehash
  sed -i -e '/goenv/d' -e  '/.*PS1.*/a  git -C ~/.goenv pull > /dev/null 2>&1' ~/.bashrc
  sed -i -e '/GOENV_ROOT/d' ~/.environment
  echo 'export GOENV_ROOT="$HOME/.goenv"' >> ~/.environment 
  sed -i -e '/\$GOENV_ROOT\/bin/d' -e  '/.*GOENV_ROOT.*/a export PATH="$PATH:$GOENV_ROOT/bin"' ~/.environment
  sed -i -e '/goenv init/d' -e  '/.*GOENV_ROOT\/bin.*/a eval "$(goenv init -)"' ~/.environment
  sed -i -e '/go env GOROOT/d' -e  '/.*goenv init.*/a export PATH="$PATH:$(go env GOROOT)/bin"' ~/.environment
  sed -i -e '/go env GOPATH/d' -e  '/.*GOROOT.*/a export PATH="$PATH:$(go env GOPATH)/bin"' ~/.environment
  sed -i -e '/GO111MODULE/d' -e  '/.*GOPATH.*/a export GO111MODULE=on' ~/.environment
EOF
# rust toolchain setup
cat << 'EOF' | arch-chroot /mnt sudo -u damoon bash --
  sudo paru -Rcns --noconfirm rust || true ;
  NIGHTLY_VERSION="nightly-2021-01-01" ;
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain nightly --profile default ;
  sed -i -e '/cargo/d' -e  '/.*environment.*/i  [ -d ~/.cargo/env ] && . ~/.cargo/env' ~/.bashrc
  source $HOME/.cargo/env
  rustup --version
  cargo --version
  rustc --version
  rustup update "${NIGHTLY_VERSION}"
  rustup default "${NIGHTLY_VERSION}"
  rustup completions bash | sudo tee /etc/bash_completion.d/rustup.bash-completion > /dev/null
  rustup component add rust-src
  rustup component add rustfmt
  rustup component add rls
  rustup component add clippy
  cargo install -j $(nproc) cargo-watch cargo-cache cargo-tree
  cargo install -j $(nproc) systemfd tojson jen
EOF

# hashi setup
cat << 'EOF' | arch-chroot /mnt sudo -u damoon bash --
  aur_packages=(
    "tfenv"
    ""
  )

  packages=(
    "consul"
    "consul-template"
    "vault"
    ""
  )
  sudo pacman -Sy --noconfirm --needed ${packages[@]}
  paru --needed --removemake --cleanafter --noconfirm -Sy ${aur_packages[@]}
  sudo usermod -aG consul,vault,tfenv `whoami`

  sed -i -e '/CONSUL/d' -e '/VAULT/d' ~/.environment
  (
    echo 'export VAULT_SKIP_VERIFY="true"' ;
    echo 'export CONSUL_SCHEME="https"' ;
    echo 'export CONSUL_HTTP_SSL="true"' ;
    echo 'export CONSUL_HTTP_SSL_VERIFY="false"' ;
  ) | tee -a ~/.environment > /dev/null ;
  sudo tfenv install 1.0.0 > /dev/null 2>&1 || true
  sudo tfenv use 1.0.0 > /dev/null 2>&1 || true
  sed -i -e '/terraform/d' ~/.bash_aliases
  (
  echo 'alias tf="terraform"' ;
  echo 'alias tfi="terraform init"' ;
  echo 'alias tfa="terraform apply -auto-approve"' ;
  echo 'alias tfd="terraform destroy -auto-approve"' ;
  echo 'alias tfp="terraform plan"' ;
  echo 'alias tfw="terraform workspace"' ;
  echo 'alias tfwl="terraform workspace list"' ;
  echo 'alias tfws="terraform workspace select"' ;
  echo 'alias tfo="terraform output"' ;
  ) | tee -a ~/.bash_aliases > /dev/null ;
EOF
# rust tools 
cat << 'EOF' | arch-chroot /mnt sudo -u damoon bash --
  aur_packages=(
    "nushell-bin"
    ""
  )
  rustutils=(
  "alacritty"
  "starship"
  "exa"
  "ripgrep"
  "bat"
  "tokei"
  "sd"
  "fd"
  "hyperfine"
  "procs"
  ""
)
  sudo pacman -Sy --noconfirm --needed ${rustutils[@]}
  paru --needed --removemake --cleanafter --noconfirm -Sy ${aur_packages[@]}
  sed -i -e '/starship/d' ~/.environment
  echo 'eval "$(starship init bash)"' >> ~/.environment
  sed -i -e '/bat/d' ~/.bash_aliases
  (
    echo 'alias cat="bat -pp"' ;
  ) | tee -a ~/.bash_aliases > /dev/null ;
EOF
# regolith installation
cat << 'EOF' | arch-chroot /mnt sudo -u damoon bash --
git clone https://github.com/gardotd426/regolith-de.git /tmp/regolith-de
pushd /tmp/regolith-de
makepkg -sicr --noconfirm
popd
rm -rf /tmp/regolith-de
paru --needed --removemake --cleanafter --noconfirm -Sy \
  remontoire-git \
  nerd-fonts-source-code-pro
sudo pacman -Sy --noconfirm --needed dmenu gnome-terminal gnome-disk-utility acpi sysstat
sudo python3 -m pip install td-cli
regolith-look stage
regolith-look set solarized-dark
EOF

cat << 'EOF' | arch-chroot /mnt sudo -u damoon bash --
paru --needed --removemake --cleanafter --noconfirm -Sy  \
  xrdp \
  xorgxrdp-devel-git \
  pulseaudio-module-xrdp-git
EOF
cat << 'EOF' | arch-chroot /mnt bash --
sudo pacman -Sy --noconfirm --needed \
  hyperv \
  xf86-video-fbdev \ 
rm -rf /tmp/linux-vm-tools/arch
git clone https://github.com/Microsoft/linux-vm-tools /tmp/linux-vm-tools
bash /tmp/linux-vm-tools/arch/install-config.sh
rm -rf /tmp/linux-vm-tools/arch
sudo systemctl enable hv_fcopy_daemon.service
sudo systemctl enable hv_kvp_daemon.service
sudo systemctl enable hv_vss_daemon.service
EOF
arch-chroot /mnt sudo -u damoon sudo usermod -aG kvm `whoami`
# xint setup session for regolith
# sudo pacman -Sy --noconfirm --needed xorg-xinit
cat << 'EOF' | arch-chroot /mnt sudo -u damoon bash --
cp /etc/X11/xinit/xinitrc ~/.xinitrc
sed -i -e '/exec/d' -e '/^[[:space:]]*$/d' ~/.xinitrc
(
  echo 'export SSH_AUTH_SOCK' ;
  echo 'export $(dbus-launch)' ;
  echo 'exec regolith-session' ;
  systemctl --user start pulseaudio.service > /dev/null 2>&1 || true;
) | tee -a ~/.xinitrc > /dev/null ;
gsettings set org.gnome.desktop.session idle-delay 0
EOF
# lightdm install and setup
cat << 'EOF' | arch-chroot /mnt sudo -u damoon bash --
sudo pacman -Sy --noconfirm lightdm lightdm-gtk-greeter
sudo grep 'autologin-user=\|autologin-session=\|greeter-session=' /etc/lightdm/lightdm.conf && \
sudo sed -i "s/#autologin-user=/autologin-user=$(whoami)/g" /etc/lightdm/lightdm.conf && \
sudo sed -i 's/#autologin-session=/autologin-session=regolith/g' /etc/lightdm/lightdm.conf && \
sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/g' /etc/lightdm/lightdm.conf && \
sudo grep 'autologin-user=\|autologin-session=\|greeter-session=' /etc/lightdm/lightdm.conf
sudo sed -i -e '/nopasswdlogin/d' -e '/^#%PAM-1.0.*/a auth        sufficient  pam_succeed_if.so user ingroup nopasswdlogin' /etc/pam.d/lightdm
getent group nopasswdlogin > /dev/null || sudo groupadd -r nopasswdlogin > /dev/null 2>&1
getent group autologin > /dev/null || sudo groupadd -r autologin > /dev/null 2>&1
sudo gpasswd -a "$(whoami)" nopasswdlogin
sudo gpasswd -a "$(whoami)" autologin
sudo systemctl enable lightdm
sudo usermod -aG lightdm,users "$(whoami)"
EOF
umount -R /mnt
shutdown now
