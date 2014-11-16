#############################################################
#
# sunxi-tools
#
#############################################################
SUNXI_TOOLS_VERSION = "master"
SUNXI_TOOLS_SITE = $(call qstrip,$(BR2_PACKAGE_HOST_SUNXI_TOOLS_GITHUB_LOCATION))
SUNXI_TOOLS_SITE_METHOD = git

HOST_SUNXI_TOOLS_DEPENDENCIES = host-libusb

define HOST_SUNXI_TOOLS_BUILD_CMDS
        cd $(@D) ; \
		make
endef

define HOST_SUNXI_TOOLS_INSTALL_CMDS
        $(INSTALL) -D $(@D)/fex2bin $(HOST_DIR)/usr/bin/
        $(INSTALL) -D $(@D)/bin2fex $(HOST_DIR)/usr/bin/
endef

define HOST_SUNXI_UNINSTALL_CMDS
        rm -f $(HOST_DIR)/usr/bin/fex2bin
        rm -f $(HOST_DIR)/usr/bin/bin2fex
endef

$(eval $(host-generic-package))

