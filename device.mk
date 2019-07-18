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
TARGET_CHIPSET := sdm710
else
TARGET_CHIPSET := sdm845
endif

LOCAL_PATH := device/google/boncross

ifeq ($(filter bonito sargo, $(TARGET_PRODUCT)),)
TARGET_SYSTEM_PROP := $(LOCAL_PATH)/sarbon/system.prop
else
TARGET_SYSTEM_PROP := $(LOCAL_PATH)/bluecross/system.prop
endif

PRODUCT_CHARACTERISTICS := nosdcard
PRODUCT_SHIPPING_API_LEVEL := 28

# A/B support
PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier

ifeq ($(filter bonito sargo, $(TARGET_PRODUCT)),)
PRODUCT_PACKAGES += \
    bootctrl.sdm710
else
PRODUCT_PACKAGES += \
    bootctrl.sdm845
endif

AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    system \
    vbmeta \
    dtbo

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Enable update engine sideloading by including the static version of the
# boot_control HAL and its dependencies.
ifeq ($(filter bonito sargo, $(TARGET_PRODUCT)),)
PRODUCT_STATIC_BOOT_CONTROL_HAL := \
    bootctrl.sdm710
else
PRODUCT_STATIC_BOOT_CONTROL_HAL := \
    bootctrl.sdm845
endif
PRODUCT_STATIC_BOOT_CONTROL_HAL := \
    libgptutils \
    libz \
    libcutils

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \