INSTALL=$(shell which install)

ifdef DESTDIR
	CONFIG_DIR:=$(DESTDIR)/etc/atom
	BIN_DIR:=$(DESTDIR)/bin
else
	CONFIG_DIR:=/etc/atom
	BIN_DIR:=/usr/bin
endif
PROG=$(BIN_DIR)/atom

ifndef OS
	OS:=$(shell uname -s)
endif
ifeq ($(OS),Darwin)
	export SED_INLINE_CMD:=sed -i ''
else
	export SED_INLINE_CMD:=sed -i
endif
# escape destination dir for sed later
DESTDIR_SED=$(shell echo $(DESTDIR) | sed s/\\//\\\\\\//g)

all:
	@echo "nothing to do. done."
.PHONY: all

install: install-etc install-bin
	@echo "atom installation done."
.PHONY: install

install-bin:
	@echo "installing atom script in $(BIN_DIR)"
	$(INSTALL) -m 755 bin/atom $(PROG)
	$(SED_INLINE_CMD) 's/^INSTALL_PREFIX=$$/INSTALL_PREFIX="$(DESTDIR_SED)"/' $(PROG)
.PHONY: install-bin

install-etc:
	@echo "installing atom configuration files in $(CONFIG_DIR)"
	$(INSTALL) -m 755 -d $(CONFIG_DIR)
	$(INSTALL) -m 755 -d $(CONFIG_DIR)/cache
	$(INSTALL) -m 755 -d $(CONFIG_DIR)/db
	$(INSTALL) -m 755 -d $(CONFIG_DIR)/plugins
	$(INSTALL) -m 755 -d $(CONFIG_DIR)/vendor
	$(INSTALL) -m 755 -d $(CONFIG_DIR)/repos
	$(INSTALL) -m 644 default-config/pkg.conf $(CONFIG_DIR)
	$(INSTALL) -m 644 default-config/repos/atom.conf $(CONFIG_DIR)/repos
.PHONY: install-etc

uninstall:
	rm -rf "" $(CONFIG_DIR) $(PROG)
.PHONY: uninstall

test:
	bats test/main.bats
.PHONY: test