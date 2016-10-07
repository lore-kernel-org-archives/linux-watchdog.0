Return-path: <pantelis.antoniou@konsulko.com>
From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Peter Rosin <peda@axentia.se>,
	Debjit Ghosh <dghosh@juniper.net>,
	Georgi Vlaev <gvlaev@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Maryam Seraj <mseraj@juniper.net>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 00/10] Introduce Juniper SAM FPGA driver
Date: Fri,  7 Oct 2016 18:18:28 +0300
Message-Id: <1475853518-22264-1-git-send-email-pantelis.antoniou@konsulko.com>
List-ID: <linux-watchdog@vger.kernel.org>

Add Juniper's SAM FPGA driver. Those FPGAs
are present in Juniper's PTX series of routers.

The MFD driver provices i2c/gpio/mtd/mdio devices.

There are full device tree binding documents for the
master mfd driver and for all slave drivers.

This patchset is against mainline as of today: v4.8-9431-g3477d16
and is dependent on the "Juniper prerequisites" and
"Juniper infrastructure" patchsets sent earlier.

Georgi Vlaev (6):
  mfd: sam: Add documentation for the SAM FPGA
  i2c: i2c-sam: Add device tree bindings
  gpio: sam: Document bindings of SAM FPGA GPIO block
  mtd: flash-sam: Bindings for Juniper's SAM FPGA flash
  net: phy: Add MDIO driver for Juniper's SAM FPGA
  net: mdio-sam: Add device tree documentation for SAM MDIO

Guenter Roeck (2):
  gpio: Introduce SAM gpio driver
  mtd: Add SAM Flash driver

Maryam Seraj (2):
  mfd: Add Juniper SAM FPGA MFD driver
  i2c: Juniper SAM I2C driver

 .../devicetree/bindings/gpio/jnx,gpio-sam.txt      | 110 +++
 .../devicetree/bindings/i2c/i2c-sam-mux.txt        |  20 +
 Documentation/devicetree/bindings/i2c/i2c-sam.txt  |  44 +
 Documentation/devicetree/bindings/mfd/jnx-sam.txt  |  94 ++
 .../devicetree/bindings/mtd/flash-sam.txt          |  31 +
 Documentation/devicetree/bindings/net/mdio-sam.txt |  48 +
 drivers/gpio/Kconfig                               |  11 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-sam.c                            | 707 +++++++++++++++
 drivers/i2c/busses/Kconfig                         |  11 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-sam.c                       | 942 +++++++++++++++++++
 drivers/mfd/Kconfig                                |  16 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/sam-core.c                             | 997 +++++++++++++++++++++
 drivers/mtd/devices/Kconfig                        |  11 +
 drivers/mtd/devices/Makefile                       |   1 +
 drivers/mtd/devices/sam-flash.c                    | 642 +++++++++++++
 drivers/net/phy/Kconfig                            |   8 +
 drivers/net/phy/Makefile                           |   1 +
 drivers/net/phy/mdio-sam.c                         | 564 ++++++++++++
 include/linux/mfd/sam.h                            |  30 +
 22 files changed, 4291 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/jnx,gpio-sam.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sam-mux.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sam.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/jnx-sam.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/flash-sam.txt
 create mode 100644 Documentation/devicetree/bindings/net/mdio-sam.txt
 create mode 100644 drivers/gpio/gpio-sam.c
 create mode 100644 drivers/i2c/busses/i2c-sam.c
 create mode 100644 drivers/mfd/sam-core.c
 create mode 100644 drivers/mtd/devices/sam-flash.c
 create mode 100644 drivers/net/phy/mdio-sam.c
 create mode 100644 include/linux/mfd/sam.h

-- 
1.9.1
