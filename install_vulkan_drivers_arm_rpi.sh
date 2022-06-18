sudo apt-get update
sudo apt-get upgrade
# install dependencies
sudo apt-get install libxcb-randr0-dev libxrandr-dev
sudo apt-get install libxcb-xinerama0-dev libxinerama-dev libxcursor-dev
sudo apt-get install libxcb-cursor-dev libxkbcommon-dev xutils-dev
sudo apt-get install xutils-dev libpthread-stubs0-dev libpciaccess-dev
sudo apt-get install libffi-dev x11proto-xext-dev libxcb1-dev libxcb-*dev
sudo apt-get install libssl-dev libgnutls28-dev x11proto-dri2-dev
sudo apt-get install x11proto-dri3-dev libx11-dev libxcb-glx0-dev
sudo apt-get install libx11-xcb-dev libxext-dev libxdamage-dev libxfixes-dev
sudo apt-get install libva-dev x11proto-randr-dev x11proto-present-dev
sudo apt-get install libclc-dev libelf-dev mesa-utils
sudo apt-get install libvulkan-dev libvulkan1 libassimp-dev
sudo apt-get install libdrm-dev libxshmfence-dev libxxf86vm-dev libunwind-dev
sudo apt-get install libwayland-dev wayland-protocols
sudo apt-get install libwayland-egl-backend-dev
sudo apt-get install valgrind libzstd-dev vulkan-tools
sudo apt-get install git build-essential bison flex ninja-build
#Buster
sudo apt-get install python-mako vulkan-utils
#or Bullseye
sudo apt-get install python3-mako

sudo apt-get install libxcb-glx0-dev libx11-xcb-dev libxcb-dri2-0-dev
sudo apt-get install libxcb-dri3-dev libxcb-present-dev

# remove old versions first
# sudo rm -rf /home/pi/mesa_vulkan
# install meson
sudo apt purge meson -y
sudo pip3 install meson
# install mako
sudo pip3 install mako
# install v3dv
cd ~
git clone -b 20.3 https://gitlab.freedesktop.org/mesa/mesa.git mesa_vulkan
# build v3dv (± 30 min)
cd mesa_vulkan
CFLAGS="-mcpu=cortex-a72" \
CXXFLAGS="-mcpu=cortex-a72" \
meson --prefix /usr \
-D platforms=x11 \
-D vulkan-drivers=broadcom \
-D dri-drivers= \
-D gallium-drivers=kmsro,v3d,vc4 \
-D buildtype=release build
ninja -C build -j4

sudo ninja -C build install
