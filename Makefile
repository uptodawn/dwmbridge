# SPDX-License-Identifier: GPL-2.0-only

PREFIX ?= /usr/local

install:
	install -Dm755 dwmbridge.sh $(PREFIX)/bin/dwmbridge
