Return-path: <zdoychev@data-modul.com>
From: Zahari Doychev <zahari.doychev@linux.com>
To: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	lee.jones@linaro.org,
	wsa@the-dreams.de,
	linus.walleij@linaro.org,
	wim@iguana.be,
	linux@roeck-us.net
Cc: linux-i2c@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	gnurou@gmail.com,
	linux-watchdog@vger.kernel.org,
	Zahari Doychev <zahari.doychev@linux.com>
Subject: [RFC PATCH 0/5] add support for DMO embedded controller
Date: Thu, 27 Oct 2016 12:47:11 +0200
Message-Id: <cover.42dd8126f6e33b5130d9afa4596d88a106c54188.1477564996.git-series.zahari.doychev@linux.com>
List-ID: <linux-watchdog@vger.kernel.org>

This patch series adds support for the Data Modul Embedded Controller(dmec)
which is implemented within an on board FPGA found on Data Modul embedded
CPU modules.

The dmec is connected to the host through the LPC bus and its registers are
mapped into the host I/O space. The controller supports two addressing modes:
linear and indexed.

The driver adds support for the following functionality:

- i2c
- gpio
- watchdog
- running time meter (rtm)

Zahari Doychev (5):
  dmec: add DMO mfd driver
  i2c-dmec: add i2c bus support for dmec
  gpio-dmec: gpio support for dmec
  wdt-dmec: watchdog support for dmec
  rtm-dmec: running time meter support

 drivers/staging/Kconfig          |   2 +-
 drivers/staging/Makefile         |   1 +-
 drivers/staging/dmec/Kconfig     |  50 +++-
 drivers/staging/dmec/Makefile    |   5 +-
 drivers/staging/dmec/dmec-core.c | 500 ++++++++++++++++++++++++++++-
 drivers/staging/dmec/dmec.h      |  20 +-
 drivers/staging/dmec/gpio-dmec.c | 390 ++++++++++++++++++++++-
 drivers/staging/dmec/i2c-dmec.c  | 524 +++++++++++++++++++++++++++++-
 drivers/staging/dmec/rtm-dmec.c  | 203 +++++++++++-
 drivers/staging/dmec/wdt-dmec.c  | 569 ++++++++++++++++++++++++++++++++-
 10 files changed, 2264 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/dmec/Kconfig
 create mode 100644 drivers/staging/dmec/Makefile
 create mode 100644 drivers/staging/dmec/dmec-core.c
 create mode 100644 drivers/staging/dmec/dmec.h
 create mode 100644 drivers/staging/dmec/gpio-dmec.c
 create mode 100644 drivers/staging/dmec/i2c-dmec.c
 create mode 100644 drivers/staging/dmec/rtm-dmec.c
 create mode 100644 drivers/staging/dmec/wdt-dmec.c

base-commit: 9fe68cad6e74967b88d0c6aeca7d9cd6b6e91942
-- 
git-series 0.8.10
