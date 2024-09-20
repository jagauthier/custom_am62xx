#!/bin/bash
# set up environment for custom yocto build

layers=("meta-arm/meta-arm-toolchain"
        "meta-arm/meta-arm"
		"meta-arm/meta-arm-bsp"
		"meta-myir/meta-myir-bsp")
		

# Get poky distribution
git clone https://git.yoctoproject.org/poky -b scarthgap
. poky/oe-init-build-env build

for directory in "${layers[@]}"
do
    bitbake-layers add-layer ../layers/${directory}
done

cp ../conf/local.conf conf/local.conf

cd ..

utils/print_image_names.sh layers
utils/print_image_names.sh poky

cd build

echo "Setup environmen with:"
echo ". poky/oe-init-build-env build"