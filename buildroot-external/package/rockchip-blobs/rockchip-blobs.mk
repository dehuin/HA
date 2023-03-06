################################################################################
#
# Rockchip loader binaries
#
################################################################################

ROCKCHIP_BLOBS_SOURCE = $(BR2_PACKAGE_ROCKCHIP_BLOBS_VERSION).tar.gz
ROCKCHIP_BLOBS_SITE = https://github.com/JeffyCN/rockchip_mirrors/archive
ROCKCHIP_BLOBS_LICENSE = PROPRIETARY
ROCKCHIP_BLOBS_INSTALL_IMAGES = YES

define ROCKCHIP_BLOBS_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 $(@D)/$(BR2_PACKAGE_ROCKCHIP_BLOBS_ATF) $(BINARIES_DIR)/bl31.elf
	$(INSTALL) -D -m 0644 $(@D)/$(BR2_PACKAGE_ROCKCHIP_BLOBS_TPL) $(BINARIES_DIR)/ram_init.bin
endef

$(eval $(generic-package))
