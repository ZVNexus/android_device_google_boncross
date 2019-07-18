#
# Copyright (C) 2016 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

ifeq ($(filter bonito sargo, $(TARGET_PRODUCT)),)
TARGET_BOARD_PLATFORM := sdm710
else
TARGET_BOARD_PLATFORM := sdm845
endif

USES_DEVICE_GOOGLE_B1C1 := true
USES_DEVICE_GOOGLE_B4S4 := true
TARGET_NO_BOOTLOADER := true

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a75

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a75

BOARD_KERNEL_CMDLINE += console=ttyMSM0,115200n8 androidboot.console=ttyMSM0 printk.devkmsg=on
BOARD_KERNEL_CMDLINE += msm_rtb.filter=0x237
BOARD_KERNEL_CMDLINE += ehci-hcd.park=3
BOARD_KERNEL_CMDLINE += service_locator.enable=1
BOARD_KERNEL_CMDLINE += firmware_class.path=/vendor/firmware
BOARD_KERNEL_CMDLINE += cgroup.memory=nokmem
BOARD_KERNEL_CMDLINE += lpm_levels.sleep_disabled=1
BOARD_KERNEL_CMDLINE += androidboot.fastboot=1
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

ifeq ($(filter bonito sargo, $(TARGET_PRODUCT)),)
BOARD_KERNEL_CMDLINE += loop.max_part=7
else
BOARD_KERNEL_CMDLINE += usbcore.autosuspend=7
endif

TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android-
BOARD_KERNEL_IMAGE_NAME := Image.lz4-dtb

ifeq ($(filter bonito sargo, $(TARGET_PRODUCT)),)
TARGET_KERNEL_SOURCE := kernel/google/bonito
TARGET_KERNEL_CONFIG := bonito_defconfig
else
TARGET_KERNEL_SOURCE := kernel/google/bluecross
TARGET_KERNEL_CONFIG := b1c1_defconfig
endif

BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_PAGESIZE    := 4096
ifeq ($(filter-out bonito_kasan sargo_kasan, $(TARGET_PRODUCT)),)
BOARD_KERNEL_OFFSET      := 0x80000
BOARD_KERNEL_TAGS_OFFSET := 0x02500000
BOARD_RAMDISK_OFFSET     := 0x02700000
BOARD_MKBOOTIMG_ARGS     := --kernel_offset $(BOARD_KERNEL_OFFSET) --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
else
BOARD_KERNEL_TAGS_OFFSET := 0x01E00000
BOARD_RAMDISK_OFFSET     := 0x02000000
endif

BOARD_BOOT_HEADER_VERSION := 1
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

TARGET_NO_BOOTLOADER ?= true
TARGET_NO_KERNEL := false
TARGET_NO_RECOVERY := true
BOARD_USES_RECOVERY_AS_BOOT := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
BOARD_USES_METADATA_PARTITION := true

# Partitions (listed in the file) to be wiped under recovery.
ifeq ($(filter bonito sargo, $(TARGET_PRODUCT)),)
TARGET_RECOVERY_WIPE := device/google/boncross/sarbon/recovery.wipe
TARGET_RECOVERY_FSTAB := device/google/boncross/sarbon/fstab.hardware
TARGET_RECOVERY_UI_LIB := \
  librecovery_ui_bonito \

TARGET_RECOVERY_TWRP_LIB := \
  librecovery_twrp_bonito
else
TARGET_RECOVERY_WIPE := device/google/boncross/bluecross/recovery.wipe
TARGET_RECOVERY_FSTAB := device/google/boncross/bluecross/fstab.hardware
TARGET_RECOVERY_UI_LIB := \
  librecovery_ui_crosshatch \

TARGET_RECOVERY_TWRP_LIB := \
  librecovery_twrp_crosshatch
endif

TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_RECOVERY_UI_LIB := \
  libnos_citadel_for_recovery \
  libnos_for_recovery

TARGET_RECOVERY_TWRP_LIB := \
  libnos_citadel_for_recovery \
  libnos_for_recovery liblog

# Partitions
ifeq ($(filter bonito sargo, $(TARGET_PRODUCT)),)
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3267362816
else
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2952790016
BOARD_USERDATAIMAGE_PARTITION_SIZE := 10737418240
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
endif

BOARD_SYSTEMIMAGE_JOURNAL_SIZE := 0
BOARD_SYSTEMIMAGE_EXTFS_INODE_COUNT := 4096
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x04000000
BOARD_FLASH_BLOCK_SIZE := 131072

TARGET_COPY_OUT_VENDOR := vendor

BOARD_ROOT_EXTRA_SYMLINKS := /mnt/vendor/persist:/persist
BOARD_ROOT_EXTRA_SYMLINKS += /vendor/firmware_mnt:/firmware
BOARD_ROOT_EXTRA_SYMLINKS += /vendor/dsp:/dsp

# Use MKE2FS to create EXT4 images
TARGET_USES_MKE2FS := true

# TWRP
TW_THEME := portrait_hdpi
BOARD_SUPPRESS_SECURE_ERASE := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_DEFAULT_BRIGHTNESS := "80"
TW_INCLUDE_CRYPTO := true
AB_OTA_UPDATER := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true
TW_NO_HAPTICS := true
PLATFORM_SECURITY_PATCH := 2025-12-31
TW_USE_TOOLBOX := true
LZMA_RAMDISK_TARGETS := recovery