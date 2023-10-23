sudo apt-get update && sudo apt-get upgrade
# -y install dependencies
sudo apt-get -y install libxcb-randr0-dev libxrandr-dev
sudo apt-get -y install libxcb-xinerama0-dev libxinerama-dev libxcursor-dev
sudo apt-get -y install libxcb-cursor-dev libxkbcommon-dev xutils-dev
sudo apt-get -y install xutils-dev libpthread-stubs0-dev libpciaccess-dev
sudo apt-get -y install libffi-dev x11proto-xext-dev libxcb1-dev libxcb-*dev
sudo apt-get -y install libssl-dev libgnutls28-dev x11proto-dri2-dev
sudo apt-get -y install x11proto-dri3-dev libx11-dev libxcb-glx0-dev
sudo apt-get -y install libx11-xcb-dev libxext-dev libxdamage-dev libxfixes-dev
sudo apt-get -y install libva-dev x11proto-randr-dev x11proto-present-dev
sudo apt-get -y install libclc-dev libelf-dev mesa-utils
sudo apt-get -y install libvulkan-dev libvulkan1 libassimp-dev
sudo apt-get -y install libdrm-dev libxshmfence-dev libxxf86vm-dev libunwind-dev
sudo apt-get -y install libwayland-dev wayland-protocols
sudo apt-get -y install libwayland-egl-backend-dev
sudo apt-get -y install valgrind libzstd-dev vulkan-tools
sudo apt-get -y install git build-essential bison flex ninja-build
sudo apt-get -y install python-mako vulkan-utils
sudo apt-get -y install python3-mako
sudo apt-get -y install pkg-config

sudo apt-get -y install libxcb-glx0-dev libx11-xcb-dev libxcb-dri2-0-dev
sudo apt-get -y install libxcb-dri3-dev libxcb-present-dev

# remove old versions first
# sudo rm -rf /home/pi/mesa_vulkan
# -y install meson
sudo apt purge meson -y
sudo pip3 -y install meson
sudo apt -y install meson

sudo apt -y install llvm

# -y install mako
sudo pip3 -y install mako
# -y install v3dv
cd ~
git clone -b 20.3 https://gitlab.freedesktop.org/mesa/mesa.git ~/mesa_vulkan
# build v3dv (± 30 min)
cd ~/mesa_vulkan

CFLAGS="-mcpu=cortex-a72" CXXFLAGS="-mcpu=cortex-a72" meson --prefix /usr -D platforms=x11 -D vulkan-drivers=broadcom -D dri-drivers= -D gallium-drivers=kmsro,v3d,vc4 -D buildtype=release build

sudo ninja -C build -j4

sudo ninja -C build -y install
