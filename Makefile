INSTALL=$(shell which install)
CONFIG_DIR:=$(DESTDIR)/etc/atom
BIN_DIR:=$(DESTDIR)/usr/bin

all:
	@echo "Nothing to do. Done."
.PHONY: all

install: install-etc install-bin
.PHONY: install

install-bin:
	$(INSTALL) -m 755 bin/atom $(BIN_DIR)
.PHONY: install-bin

install-etc:
	$(INSTALL) -m 755 -d $(CONFIG_DIR)
	$(INSTALL) -m 755 -d $(CONFIG_DIR)/cache
	$(INSTALL) -m 755 -d $(CONFIG_DIR)/db
	$(INSTALL) -m 755 -d $(CONFIG_DIR)/plugins
	$(INSTALL) -m 755 -d $(CONFIG_DIR)/repos
	$(INSTALL) -m 644 default-config/pkg.conf $(CONFIG_DIR)
	$(INSTALL) -m 644 default-config/repos/atom.conf $(CONFIG_DIR)/repos
.PHONY: install-etc

uninstall:
	rm -rf "" $(CONFIG_DIR) $(BIN_DIR)/atom
.PHONY: uninstall
