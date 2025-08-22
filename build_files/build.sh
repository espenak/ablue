#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1


# dnf5 group list --hidden \*devel\*
dnf5 group install -y development-tools development-libs

dnf5 install -y \
  gcc-c++ \
  dotnet-sdk-8.0 \
  bat \
  readline-devel \
  cmake \
  ripgrep atuin fd-find \
  libtiff-devel libjpeg-devel openjpeg2-devel zlib-devel \
  freetype-devel lcms2-devel libwebp-devel tcl-devel tk-devel \
  harfbuzz-devel fribidi-devel libraqm-devel libimagequant-devel libxcb-devel \
  gdal-devel gdal-libs \
  pango libffi-devel \
  libpq-devel postgresql \
  ghostscript \
  azure-cli \
  dnsmasq \
  sassc \
  sqlite sqlite-devel \
  git-delta \
  kitty \
  ctags \
  corectrl \
  solaar

# Install sway
dnf5 install -y \
  sway \
  swaylock \
  waybar \
  swayidle \
  swaybg \
  swappy \
  xdg-desktop-portal-wlr \
  xdg-desktop-portal-gtk \
  polkit \
  wf-recorder \
  slurp \
  grim \
  SwayNotificationCenter \
  inotify-tools \
  blueman \
  wob \
  fontawesome-fonts-all \
  papirus-icon-theme \
  pavucontrol \
  nm-connection-editor \
  network-manager-applet \
  rofi-wayland \
  kanshi \
  libsecret \
  mate-polkit \
  seahorse


# Missing:
# - satty
# - cliphist
# - showmethekey
# - gcr-4 (think this is already installed via the gcr package)

cat > /etc/ssh/sshd_config.d/99-custom.conf << EOF
# Disable password authentication
PasswordAuthentication no

# Disable root login
PermitRootLogin no

# Disable X11 forwarding (unless you need it)
X11Forwarding no

# Disable TCP forwarding (unless you need it)
AllowTcpForwarding no

# Enable pubke authentication
PubkeyAuthentication yes
EOF

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

# systemctl enable podman.socket
