################################################################################
#
# jitterentropy-library
#
################################################################################

JITTERENTROPY_LIBRARY_VERSION = 2.2.0
JITTERENTROPY_LIBRARY_SITE = $(call github,smuellerDD,$(JITTERENTROPY_LIBRARY_NAME),v$(JITTERENTROPY_LIBRARY_VERSION))
JITTERENTROPY_LIBRARY_LICENSE = GPL-2.0 or BSD-3-Clause
JITTERENTROPY_LIBRARY_LICENSE_FILES = COPYING COPYING.bsd COPYING.gplv2
JITTERENTROPY_LIBRARY_INSTALL_STAGING = YES
JITTERENTROPY_LIBRARY_INSTALL_TARGETS = install-includes
JITTERENTROPY_LIBRARY_SELINUX_MODULES = entropyd

ifeq ($(BR2_STATIC_LIBS)$(BR2_SHARED_STATIC_LIBS),y)
JITTERENTROPY_LIBRARY_BUILD_TARGETS += jitterentropy-static
JITTERENTROPY_LIBRARY_INSTALL_TARGETS += install-static
endif

ifeq ($(BR2_SHARED_LIBS)$(BR2_SHARED_STATIC_LIBS),y)
JITTERENTROPY_LIBRARY_BUILD_TARGETS += jitterentropy
JITTERENTROPY_LIBRARY_INSTALL_TARGETS += install-shared
endif

define JITTERENTROPY_LIBRARY_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		$(JITTERENTROPY_LIBRARY_BUILD_TARGETS)
endef

define JITTERENTROPY_LIBRARY_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(STAGING_DIR) \
		INSTALL_STRIP="install" PREFIX=/usr \
		$(JITTERENTROPY_LIBRARY_INSTALL_TARGETS)
endef

define JITTERENTROPY_LIBRARY_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) \
		INSTALL_STRIP="install" PREFIX=/usr \
		$(JITTERENTROPY_LIBRARY_INSTALL_TARGETS)
endef

$(eval $(generic-package))
