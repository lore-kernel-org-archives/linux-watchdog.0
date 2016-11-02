Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33776 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753887AbcKBIiA (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 2 Nov 2016 04:38:00 -0400
From: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
To: linus.walleij@linaro.org, gnurou@gmail.com, jdelvare@suse.com,
        linux@roeck-us.net, wsa@the-dreams.de, lee.jones@linaro.org,
        jingoohan1@gmail.com, tomi.valkeinen@ti.com, wim@iguana.be,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org,
        k.kozlowski@samsung.com
Cc: Richard Vidal-Dorsch <richard.dorsch@gmail.com>,
        jo.sunga@advantech.com, weilun.huang@advantech.com
Subject: [PATCH v4 0/6] Advantech iManager EC driver set
Date: Wed,  2 Nov 2016 01:37:45 -0700
Message-Id: <20161102083751.6335-1-richard.dorsch@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

The Advantech iManager is a custom embedded controller based on ITE IT851=
8
or IT8528 EC (depending on PCB). It runs a custom firmware that provides
access to features such as GPIO, I2C/SMbus, hwmon, watchdog, and
backlight/brightness control.  All drivers are being managed by the
iManager (mfd) core driver.  It acts as a 'gateway' and handles
communications between EC and sub-drivers.  The imanager-core follows a
similar concept as Kontron's kempld-core driver.
During core init, the device id list is retrieved from the firmware and a=
n
internal device list is being created. This list is then passed down to
managed drivers.

The out-of-tree iManager driver set is maintained at
https://www.github.com/rvido/iManager

Notebook manufactures such as Dell (XPS series) or Razerzone (Razer Blade=
)
are using similar ITE ECs or even the same ones to implement their own
embedded functions.  Due to the level of firmware customization which tho=
se
ITE ECs provide, the iManager EC driver set is incompatible with those
vendors solutions (and probably others too).

Note that v1..v3 were submitted in Jan. 2016.  It took some time to apply
suggested changes.  However, I kept the original versioning to avoid conf=
lict
with previous patch submissions.

Thanks to Krzysztof Koz=C5=82owski, Guenter Roeck, and Lee Jones for thei=
r
invaluable feedback.  Those drivers clearly needed to be further improved
and cleaned.

Changes from v3:
- Merge imanager-ec-* with corresponding drivers
  This eliminates static init vars and reduces code size
- Remove Documentation/devicetree/bindings/mfd/imanager.txt
  No support for DT
- Add API comments
- List include files in alphabetic order
- Run patches through ./scripts/checkpatch.pl --strict
- Remove headers except imanger.h/imanager-ec.h
  Store them in include/linux/mfd/
imanager-core:
  - Reduce amount of exported functions in core
  - Use usleep_range() instead of udelay()
  - Use dev_info() or dev_warn() where necessary
  - Fix register/probing and __init/__exit
  - Optimize imanager_read_device_config()
  - Shrink down EC device table to known and supported devices
  - Define flags with BIT()
  - Use new imanager device struct
i2c-imanager:
  - Add support for multiple I2C/SMbus adapters
  - Use new imanager device struct
imanager-hwmon-*
gpio-imanager:
imanager_bl:
imanager_wdt:
  - Define flags with BIT()
  - Use new imanager device struct

Changes from v2:
- Remove .owner from platform_driver in:
  drivers/gpio/imanager-bl
  drivers/gpio/imanager-core.c
  drivers/gpio/imanager-i2c.c
  drivers/gpio/imanager-hwmon.c

Changes from v1:
- Remove .owner from platform_driver in drivers/gpio/imanager-gpio.c
- Remove .owner from platform_driver in drivers/gpio/imanager-wdt.c
- Replace 2015 by 2016 in all files

Richard Vidal-Dorsch (6):
  Add Advantech iManager MFD core driver
  Add Advantech iManager GPIO driver
  Add Advantech iManager HWmon driver
  Add Advantech iManager I2C driver
  Add Advantech iManager Backlight driver
  Add Advantech iManager Watchdog driver

 drivers/gpio/Kconfig                  |   10 +
 drivers/gpio/Makefile                 |    1 +
 drivers/gpio/gpio-imanager.c          |  155 +++++
 drivers/hwmon/Kconfig                 |   11 +
 drivers/hwmon/Makefile                |    1 +
 drivers/hwmon/imanager-hwmon.c        | 1226 +++++++++++++++++++++++++++=
++++++
 drivers/i2c/busses/Kconfig            |   10 +
 drivers/i2c/busses/Makefile           |    1 +
 drivers/i2c/busses/i2c-imanager.c     |  461 +++++++++++++
 drivers/mfd/Kconfig                   |   18 +
 drivers/mfd/Makefile                  |    1 +
 drivers/mfd/imanager-core.c           |  941 +++++++++++++++++++++++++
 drivers/video/backlight/Kconfig       |    8 +
 drivers/video/backlight/Makefile      |    1 +
 drivers/video/backlight/imanager_bl.c |  210 ++++++
 drivers/watchdog/Kconfig              |   11 +
 drivers/watchdog/Makefile             |    1 +
 drivers/watchdog/imanager_wdt.c       |  303 ++++++++
 include/linux/mfd/imanager-ec.h       |  228 ++++++
 include/linux/mfd/imanager.h          |  221 ++++++
 20 files changed, 3819 insertions(+)
 create mode 100644 drivers/gpio/gpio-imanager.c
 create mode 100644 drivers/hwmon/imanager-hwmon.c
 create mode 100644 drivers/i2c/busses/i2c-imanager.c
 create mode 100644 drivers/mfd/imanager-core.c
 create mode 100644 drivers/video/backlight/imanager_bl.c
 create mode 100644 drivers/watchdog/imanager_wdt.c
 create mode 100644 include/linux/mfd/imanager-ec.h
 create mode 100644 include/linux/mfd/imanager.h

--=20
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
