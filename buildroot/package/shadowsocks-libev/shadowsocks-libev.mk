################################################################################
#
# shadowsocks-libev
#
################################################################################

SHADOWSOCKS_LIBEV_VERSION = 3.2.0
SHADOWSOCKS_LIBEV_SITE = https://github.com/shadowsocks/shadowsocks-libev/releases/download/v$(SHADOWSOCKS_LIBEV_VERSION)
SHADOWSOCKS_LIBEV_LICENSE = GPL-3.0+, BSD-2-Clause (libbloom), BSD-3-Clause (libcork, libipset)
SHADOWSOCKS_LIBEV_LICENSE_FILES = COPYING libbloom/LICENSE libcork/COPYING
SHADOWSOCKS_LIBEV_DEPENDENCIES = host-pkgconf c-ares libev libsodium mbedtls pcre
SHADOWSOCKS_LIBEV_INSTALL_STAGING = YES
SHADOWSOCKS_LIBEV_CONF_OPTS = \
	--with-pcre=$(STAGING_DIR)/usr \
	--disable-ssp

# gcc on riscv doesn't define _REENTRANT when -pthread is passed while
# it should. Compensate this deficiency here otherwise shadowsocks-libev
# configure script doesn't find that thread support is enabled.
ifeq ($(BR2_riscv),y)
SHADOWSOCKS_LIBEV_CONF_ENV += CFLAGS="$(TARGET_CFLAGS) -D_REENTRANT"
endif

$(eval $(autotools-package))
