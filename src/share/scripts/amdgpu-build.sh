#!/usr/bin/bash

cat /tmp/zenity/amdgpu-pro-helper/components | grep "'"amdamf-pro-runtime"'"  && export "AMF_MODIFY"=TRUE && export "VLKPRO_MODIFY"=TRUE ||  export "AMF_MODIFY"=FALSE

cat /tmp/zenity/amdgpu-pro-helper/components | grep "'"amdvlk-pro"'" && export "VLKPRO_MODIFY"=TRUE ||  export "VLKPRO_MODIFY"=FALSE

cat /tmp/zenity/amdgpu-pro-helper/components | grep "'"amdvlk-pro-legacy"'"  &&  export "VLKLEGACY_MODIFY"=TRUE ||  export "VLKLEGACY_MODIFY"=FALSE

cat /tmp/zenity/amdgpu-pro-helper/components | grep "'"amdvlk"'"  &&  export "VLKOPEN_MODIFY"=TRUE ||  export "VLKOPEN_MODIFY"=FALSE

cat /tmp/zenity/amdgpu-pro-helper/components | grep "'"amdogl-pro"'"  && export "OGL_MODIFY"=TRUE ||  export "OGL_MODIFY"=FALSE

cat /tmp/zenity/amdgpu-pro-helper/components | grep "'"amdocl-legacy"'" && export "OCL_MODIFY"=TRUE ||  export "OCL_MODIFY"=FALSE



(
# clone spec github repo
echo "# Cloning .spec repository." ; sleep 2
git clone https://github.com/CosmicFusion/fedora-amdgpu-pro /tmp/zenity/amdgpu-pro-helper/fedora-amdgpu-pro
cd /tmp/zenity/amdgpu-pro-helper/fedora-amdgpu-pro
# build libdrm-pro
echo "5"
echo "# Building libdrm-pro." ; sleep 2
/tmp/zenity/amdgpu-pro-helper/fedora-amdgpu-pro/package-builder.sh libdrm-pro 64
/tmp/zenity/amdgpu-pro-helper/fedora-amdgpu-pro/package-builder.sh libdrm-pro 32
# build amdvlk-pro
if [[ "$VLKPRO_MODIFY" == TRUE ]]; then
echo "10"
echo "# Building amdvlk-pro." ; sleep 2
/tmp/zenity/amdgpu-pro-helper/fedora-amdgpu-pro/package-builder.sh amdvlk-pro 64
/tmp/zenity/amdgpu-pro-helper/fedora-amdgpu-pro/package-builder.sh amdvlk-pro 32
fi
# build amdamf-runtime-pro
if [[ "$AMF_MODIFY" == TRUE ]]; then
echo "20"
echo "# Building amdamf-runtime-pro." ; sleep 2
/tmp/zenity/amdgpu-pro-helper/fedora-amdgpu-pro/package-builder.sh amdamf-pro-runtime 64
echo "25"
echo "# Building amd-gpu-pro-firmware." ; sleep 2
/tmp/zenity/amdgpu-pro-helper/fedora-amdgpu-pro/package-builder.sh amd-gpu-pro-firmware 64
fi
# build amdvlk
if [[ "$VLKOPEN_MODIFY" == TRUE ]]; then
echo "30"
echo "# Building amdvlk." ; sleep 2
/tmp/zenity/amdgpu-pro-helper/fedora-amdgpu-pro/package-builder.sh amdvlk 64
/tmp/zenity/amdgpu-pro-helper/fedora-amdgpu-pro/package-builder.sh amdvlk 32
fi
# build amdvlk-pro-legacy
if [[ "$VLKLEGACY_MODIFY" == TRUE ]]; then
echo "50"
echo "# Building amdvlk-pro-legacy." ; sleep 2
/tmp/zenity/amdgpu-pro-helper/fedora-amdgpu-pro/package-builder.sh amdvlk-pro-legacy 64
/tmp/zenity/amdgpu-pro-helper/fedora-amdgpu-pro/package-builder.sh amdvlk-pro-legacy 32
fi
# build amdogl-pro
if [[ "$OGL_MODIFY" == TRUE ]]; then
echo "75"
echo "# Building amdogl-pro." ; sleep 2
/tmp/zenity/amdgpu-pro-helper/fedora-amdgpu-pro/package-builder.sh amdogl-pro 64
/tmp/zenity/amdgpu-pro-helper/fedora-amdgpu-pro/package-builder.sh amdogl-pro 32
fi
# build amdocl-legacy
if [[ "$OCL_MODIFY" == TRUE ]]; then
echo "90"
echo "# Building amdocl-legacy." ; sleep 2
/tmp/zenity/amdgpu-pro-helper/fedora-amdgpu-pro/package-builder.sh amdocl-legacy 64
/tmp/zenity/amdgpu-pro-helper/fedora-amdgpu-pro/package-builder.sh amdocl-legacy 32
fi
# Install
echo "99"
echo "# Installing." ; sleep 2
cd packages
sudo dnf install -y /tmp/zenity/amdgpu-pro-helper/fedora-amdgpu-pro/packages/*.rpm || sudo dnf reinstall -y /tmp/zenity/amdgpu-pro-helper/fedora-amdgpu-pro/packages/*.rpm
# Clean
echo "100"
echo "# Cleaning." ; sleep 2
sudo rm -r /tmp/zenity/amdgpu-pro-helper
) | 
zenity --progress \
--title='Install Progress' \
--text='Installing amdgpu-pro components , this might take while please be patient !'  \
--percentage=0 \
--auto-close \
--auto-kill

(( $? != 0 )) && zenity --error --text="Failed to install amdgpu-pro , please try again!." ||   zenity --info --window-icon='fedora amdgpu installer' --text="Installation Complete!"
       
