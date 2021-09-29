################################################################################
#
# HAOS
#
################################################################################

HASSIO_VERSION = 1.0.0
HASSIO_LICENSE = Apache License 2.0
HASSIO_LICENSE_FILES = $(BR2_EXTERNAL_HASSOS_PATH)/../LICENSE
HASSIO_SITE = $(BR2_EXTERNAL_HASSOS_PATH)/package/hassio
HASSIO_SITE_METHOD = local
HASSIO_VERSION_URL = "https://version.home-assistant.io/stable.json"

HASSIO_CONTAINER_IMAGES_ARCH = supervisor dns audio cli multicast observer core

define HASSIO_CONFIGURE_CMDS
	# Set "core" version to "landingpage" and "supervisor" to "latest"
	curl -s ${HASSIO_VERSION_URL} | jq '.core = "landingpage" | .supervisor = "latest"' > $(@D)/stable.json

	$(Q)mkdir -p $(@D)/images
	$(Q)mkdir -p $(HASSIO_DL_DIR)
	$(foreach image,$(HASSIO_CONTAINER_IMAGES_ARCH),\
		$(BR2_EXTERNAL_HASSOS_PATH)/package/hassio/fetch-container-image.sh \
			$(BR2_PACKAGE_HASSIO_ARCH) $(BR2_PACKAGE_HASSIO_MACHINE) $(@D)/stable.json $(image) "$(HASSIO_DL_DIR)" "$(@D)/images"
	)

endef

define HASSIO_BUILD_CMDS
	docker build --tag hassos-hostapps $(@D)/builder
endef

define HASSIO_INSTALL_TARGET_CMDS
	docker run --rm --privileged \
		-e BUILDER_UID="$(shell id -u)" -e BUILDER_GID="$(shell id -g)" \
		-v $(BINARIES_DIR):/export \
		-v $(@D)/images:/images \
		hassos-hostapps
endef

$(eval $(generic-package))
