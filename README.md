# Device Tree for Google Pixel 3/a/XL (bluecross/bonito/crosshatch/sargo)

The Google Pixel 3/a/XL (codenamed _"bonito/sargo"_) is a flagship smartphone from Google.
It was released in May 2019.

## Compile

First sync the TWRP minimal manifest.
```
repo init -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-9.0
```

Clone the external NOS repos as well, they are not included by default.
Also clone TWRP's update engine in.

Pick this commit if you wish.
https://gerrit.omnirom.org/#/c/android_bootable_recovery/+/33841/

Finally execute these:

```
. build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
lunch omni_bonito-eng or omni_sargo-eng or omni_blueline-eng or omni_crosshatch-eng  
mka recoveryimage bootimage
```

To test it:
```
fastboot boot out/target/product/sargo/boot.img
```
