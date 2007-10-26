PACKAGE_LC:=matrixtunnel
PACKAGE_UC:=MATRIXTUNNEL
MATRIXTUNNEL_VERSION:=0.2
MATRIXTUNNEL_SOURCE:=matrixtunnel-$(MATRIXTUNNEL_VERSION).tar.gz
MATRIXTUNNEL_SITE:=http://znerol.ch/files
MATRIXTUNNEL_MAKE_DIR:=$(MAKE_DIR)/matrixtunnel
MATRIXTUNNEL_DIR:=$(SOURCE_DIR)/matrixtunnel
MATRIXTUNNEL_BINARY:=$(MATRIXTUNNEL_DIR)/src/matrixtunnel
MATRIXTUNNEL_PKG_VERSION:=0.1
MATRIXTUNNEL_PKG_SOURCE:=matrixtunnel-$(MATRIXTUNNEL_VERSION)-dsmod-$(MATRIXTUNNEL_PKG_VERSION).tar.bz2
MATRIXTUNNEL_TARGET_DIR:=$(PACKAGES_DIR)/matrixtunnel-$(MATRIXTUNNEL_VERSION)
MATRIXTUNNEL_TARGET_BINARY:=$(MATRIXTUNNEL_TARGET_DIR)/root/usr/sbin/matrixtunnel
MATRIXTUNNEL_STARTLEVEL=40

$(PACKAGE_UC)_CONFIGURE_OPTIONS += --without-libiconv-prefix
$(PACKAGE_UC)_CONFIGURE_OPTIONS += --without-libintl-prefix
$(PACKAGE_UC)_CONFIGURE_OPTIONS += --with-matrixssl-src="$(shell pwd)/$(MATRIXSSL_DIR)"
$(PACKAGE_UC)_CONFIGURE_OPTIONS += LDFLAGS="-lpthread"


$(PACKAGE_SOURCE_DOWNLOAD)
$(PACKAGE_BIN_UNPACKED)
$(PACKAGE_CONFIGURED_CONFIGURE)

$(MATRIXTUNNEL_BINARY): $(MATRIXTUNNEL_DIR)/.configured
	PATH="$(TARGET_PATH)" \
		$(MAKE) -C $(MATRIXTUNNEL_DIR)/src all
		
$(MATRIXTUNNEL_TARGET_BINARY): $(MATRIXTUNNEL_BINARY) 
	mkdir -p $(dir $(MATRIXTUNNEL_TARGET_BINARY))
	$(INSTALL_BINARY_STRIP)

matrixtunnel:

matrixtunnel-precompiled: uclibc matrixssl-precompiled matrixtunnel $(MATRIXTUNNEL_TARGET_BINARY) 

matrixtunnel-source: $(MATRIXTUNNEL_DIR)/.unpacked

matrixtunnel-clean:
	-$(MAKE) -C $(MATRIXTUNNEL_DIR)/src clean
	rm -f $(PACKAGES_BUILD_DIR)/$(MATRIXTUNNEL_PKG_SOURCE)

matrixtunnel-dirclean:
	rm -rf $(MATRIXTUNNEL_DIR)
	rm -rf $(PACKAGES_DIR)/matrixtunnel-$(MATRIXTUNNEL_VERSION)

matrixtunnel-uninstall: 
	rm -f $(MATRIXTUNNEL_TARGET_BINARY)
  
$(PACKAGE_LIST)
