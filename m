Return-path: <pantelis.antoniou@konsulko.com>
From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Peter Rosin <peda@axentia.se>,
	Debjit Ghosh <dghosh@juniper.net>,
	Georgi Vlaev <gvlaev@juniper.net>,
	Guenter Roeck <groeck@juniper.net>,
	JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>,
	Rajat Jain <rajatjain@juniper.net>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 00/10] Introduce Juniper PTXPMB CPLD driver
Date: Fri,  7 Oct 2016 18:17:21 +0300
Message-Id: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com>
List-ID: <linux-watchdog@vger.kernel.org>

Add Juniper's PTXPMB FPGA CPLD driver. Those FPGAs
are present in Juniper's PTX series of routers.

The MFD driver provices watchdog/i2c/gpio/mtd devices.

There are full device tree binding documents for the
master mfd driver and for all slave drivers.

This patchset is against mainline as of today: v4.8-9431-g3477d16
and is dependent on the "Juniper prerequisites" and
"Juniper infrastructure" patchsets sent earlier.

Georgi Vlaev (5):
  mfd: ptxpmb-cpld: Add documentation for PTXPMB CPLD
  watchdog: ptxpmb-wdt: Add ptxpmb-wdt device tree bindings
  i2c: i2c-mux-ptxpmb-cpld: Add device tree bindings
  gpio: ptxpmb-cpld: Document bindings of PTXPMB's CPLD GPIO
  mtd: ngpmb_nvram: Add bindings for Juniper's ngpmb NVRAM

Guenter Roeck (4):
  mfd: Juniper PTXPMB CPLD Multi-function core driver
  watchdog: Add support for PTXPMB CPLD watchdog
  i2c/muxes: Juniper's PTXPMB CPLD I2C multiplexer
  gpio: ptxpmb-cpld: Add support for PTXPMB CPLD's GPIO

JawaharBalaji Thirumalaisamy (1):
  mtd: devices: Add driver for memory mapped NVRAM on FPC

 .../bindings/gpio/jnx,gpio-ptxpmb-cpld.txt         |  30 ++
 .../bindings/i2c/jnx,i2c-mux-ptxpmb-cpld.txt       |  50 +++
 .../devicetree/bindings/mfd/jnx-ptxpmb-cpld.txt    |  76 ++++
 .../devicetree/bindings/mtd/ngpmb-nvram.txt        |  22 ++
 .../bindings/watchdog/jnx-ptxpmb-wdt.txt           |  17 +
 drivers/gpio/Kconfig                               |  11 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-ptxpmb-cpld.c                    | 177 +++++++++
 drivers/i2c/muxes/Kconfig                          |  11 +
 drivers/i2c/muxes/Makefile                         |   1 +
 drivers/i2c/muxes/i2c-mux-ptxpmb.c                 | 299 +++++++++++++++
 drivers/mfd/Kconfig                                |  15 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/ptxpmb-cpld-core.c                     | 406 +++++++++++++++++++++
 drivers/mtd/devices/Kconfig                        |  11 +
 drivers/mtd/devices/Makefile                       |   1 +
 drivers/mtd/devices/jnx_pmb_nvram.c                | 191 ++++++++++
 drivers/watchdog/Kconfig                           |  12 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/ptxpmb_wdt.c                      | 283 ++++++++++++++
 include/linux/mfd/ptxpmb_cpld.h                    | 140 +++++++
 21 files changed, 1756 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/jnx,gpio-ptxpmb-cpld.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/jnx,i2c-mux-ptxpmb-cpld.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/jnx-ptxpmb-cpld.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/ngpmb-nvram.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/jnx-ptxpmb-wdt.txt
 create mode 100644 drivers/gpio/gpio-ptxpmb-cpld.c
 create mode 100644 drivers/i2c/muxes/i2c-mux-ptxpmb.c
 create mode 100644 drivers/mfd/ptxpmb-cpld-core.c
 create mode 100644 drivers/mtd/devices/jnx_pmb_nvram.c
 create mode 100644 drivers/watchdog/ptxpmb_wdt.c
 create mode 100644 include/linux/mfd/ptxpmb_cpld.h

-- 
1.9.1
