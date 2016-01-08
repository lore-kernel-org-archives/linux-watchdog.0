Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34647 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756341AbcAHW3c (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 Jan 2016 17:29:32 -0500
From: richard.dorsch@gmail.com
To: linux-kernel@vger.kernel.org
Cc: lm-sensors@lm-sensors.org, linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
	lee.jones@linaro.org, jdelvare@suse.com, linux@roeck-us.net,
	wim@iguana.be, jo.sunga@advantech.com,
	Richard Vidal-Dorsch <richard.dorsch@gmail.com>
Subject: [PATCH 0/6] Add Advantech iManager EC driver set
Date: Fri,  8 Jan 2016 14:29:20 -0800
Message-Id: <1452292166-20118-1-git-send-email-richard.dorsch@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Richard Vidal-Dorsch <richard.dorsch@gmail.com>

The Advantech iManager is an embedded controller (depending on board type,
ITE it8518/it8528) on which a custom firmware runs. All drivers (GPIO, I2C,
HWmon, Watchdog, and backlight) are being managed by the imanager mfd driver.
The imanager mfd driver acts as a 'gateway' and handles all communications
between the EC and sub-drivers (GPIO, I2C, ...). The feature specific
communication portions are split up into core files such as
imanager-ec-[gpio, i2c, ...].

Richard Vidal-Dorsch (6):
  Add Advantech iManager MFD core driver
  Add Advantech iManager GPIO driver
  Add Advantech iManager HWmon driver
  Add Advantech iManager I2C driver
  Add Advantech iManager Backlight driver
  Add Advantech iManager Watchdog driver

 Documentation/devicetree/bindings/mfd/imanager.txt |   33 +
 Documentation/hwmon/imanager                       |   59 +
 Documentation/i2c/busses/i2c-imanager              |   48 +
 MAINTAINERS                                        |   13 +
 drivers/gpio/Kconfig                               |    8 +
 drivers/gpio/Makefile                              |    2 +
 drivers/gpio/imanager-ec-gpio.c                    |   98 ++
 drivers/gpio/imanager-gpio.c                       |  182 +++
 drivers/hwmon/Kconfig                              |   12 +
 drivers/hwmon/Makefile                             |    2 +
 drivers/hwmon/imanager-ec-hwmon.c                  |  606 +++++++++
 drivers/hwmon/imanager-hwmon.c                     | 1058 +++++++++++++++
 drivers/i2c/busses/Kconfig                         |   11 +
 drivers/i2c/busses/Makefile                        |    2 +
 drivers/i2c/busses/imanager-ec-i2c.c               |  466 +++++++
 drivers/i2c/busses/imanager-i2c.c                  |  240 ++++
 drivers/mfd/Kconfig                                |   20 +
 drivers/mfd/Makefile                               |    2 +
 drivers/mfd/imanager-core.c                        |  288 +++++
 drivers/mfd/imanager-ec.c                          | 1345 ++++++++++++++++++++
 drivers/video/backlight/Kconfig                    |   12 +
 drivers/video/backlight/Makefile                   |    2 +
 drivers/video/backlight/imanager-bl.c              |  199 +++
 drivers/video/backlight/imanager-ec-bl.c           |  118 ++
 drivers/watchdog/Kconfig                           |   12 +
 drivers/watchdog/Makefile                          |    2 +
 drivers/watchdog/imanager-ec-wdt.c                 |  170 +++
 drivers/watchdog/imanager-wdt.c                    |  334 +++++
 include/linux/mfd/imanager/backlight.h             |   37 +
 include/linux/mfd/imanager/core.h                  |   31 +
 include/linux/mfd/imanager/ec.h                    |  210 +++
 include/linux/mfd/imanager/gpio.h                  |   27 +
 include/linux/mfd/imanager/hwmon.h                 |  120 ++
 include/linux/mfd/imanager/i2c.h                   |   55 +
 include/linux/mfd/imanager/wdt.h                   |   37 +
 35 files changed, 5861 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/imanager.txt
 create mode 100644 Documentation/hwmon/imanager
 create mode 100644 Documentation/i2c/busses/i2c-imanager
 create mode 100644 drivers/gpio/imanager-ec-gpio.c
 create mode 100644 drivers/gpio/imanager-gpio.c
 create mode 100644 drivers/hwmon/imanager-ec-hwmon.c
 create mode 100644 drivers/hwmon/imanager-hwmon.c
 create mode 100644 drivers/i2c/busses/imanager-ec-i2c.c
 create mode 100644 drivers/i2c/busses/imanager-i2c.c
 create mode 100644 drivers/mfd/imanager-core.c
 create mode 100644 drivers/mfd/imanager-ec.c
 create mode 100644 drivers/video/backlight/imanager-bl.c
 create mode 100644 drivers/video/backlight/imanager-ec-bl.c
 create mode 100644 drivers/watchdog/imanager-ec-wdt.c
 create mode 100644 drivers/watchdog/imanager-wdt.c
 create mode 100644 include/linux/mfd/imanager/backlight.h
 create mode 100644 include/linux/mfd/imanager/core.h
 create mode 100644 include/linux/mfd/imanager/ec.h
 create mode 100644 include/linux/mfd/imanager/gpio.h
 create mode 100644 include/linux/mfd/imanager/hwmon.h
 create mode 100644 include/linux/mfd/imanager/i2c.h
 create mode 100644 include/linux/mfd/imanager/wdt.h

-- 
2.6.4

