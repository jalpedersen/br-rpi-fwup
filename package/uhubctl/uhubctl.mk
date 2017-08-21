################################################################################
#
# hubctrl
#
################################################################################

UHUBCTL_VERSION = 047bb1e392efd3e0ea5d5caf351e20761e12cd44
UHUBCTL_SITE = https://github.com/mvp/uhubctl.git
UHUBCTL_SITE_METHOD = git
UHUBCTL_LICENSE = GPL-2
UHUBCTL_LICENSE_FILES = COPYING
UHUBCTL_INSTALL_STAGING = YES
UHUBCTL_DEPENDENCIES = libusb

define UHUBCTL_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) \
        LDFLAGS="$(TARGET_LDFLAGS) -lusb-1.0" \
        CFLAGS="$(TARGET_CFLAGS)" -C$(@D) uhubctl
endef

define UHUBCTL_INSTALL_STAGING_CMDS
    $(INSTALL) -D -m 0755 $(@D)/uhubctl $(STAGING_DIR)/usr/bin/uhubctl
endef

define UHUBCTL_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/uhubctl $(TARGET_DIR)/usr/bin
endef

define UHUBCTL_PERMISSIONS
    /usr/bin/uhubctl  f  0755  root  root   -  -  -  -  -
endef

$(eval $(generic-package))
