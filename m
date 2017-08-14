Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50028 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752029AbdHNQez (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 12:34:55 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH v2 2/3] mfd: tps65010: move header file out of I2C realm
Date: Mon, 14 Aug 2017 18:34:23 +0200
Message-Id: <20170814163424.2197-3-wsa@the-dreams.de>
In-Reply-To: <20170814163424.2197-1-wsa@the-dreams.de>
References: <20170814163424.2197-1-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

include/linux/i2c is not for client devices. Move the header file to a
more appropriate location.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
Change since V1:

* rebased to v4.13-rc5, no changes needed
* acks added. I think none are missing.

 arch/arm/mach-omap1/board-h2-mmc.c      | 2 +-
 arch/arm/mach-omap1/board-h2.c          | 2 +-
 arch/arm/mach-omap1/board-h3-mmc.c      | 2 +-
 arch/arm/mach-omap1/board-h3.c          | 2 +-
 arch/arm/mach-omap1/board-osk.c         | 2 +-
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 2 +-
 arch/arm/mach-s3c24xx/mach-osiris.c     | 2 +-
 drivers/mfd/tps65010.c                  | 2 +-
 drivers/usb/host/ohci-omap.c            | 2 +-
 drivers/usb/phy/phy-isp1301-omap.c      | 2 +-
 drivers/video/fbdev/omap/lcd_h3.c       | 2 +-
 include/linux/{i2c => mfd}/tps65010.h   | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)
 rename include/linux/{i2c => mfd}/tps65010.h (99%)

diff --git a/arch/arm/mach-omap1/board-h2-mmc.c b/arch/arm/mach-omap1/board-h2-mmc.c
index 357be2debc9da8..91bda9c802ff38 100644
--- a/arch/arm/mach-omap1/board-h2-mmc.c
+++ b/arch/arm/mach-omap1/board-h2-mmc.c
@@ -14,7 +14,7 @@
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/gpio-omap.h>
-#include <linux/i2c/tps65010.h>
+#include <linux/mfd/tps65010.h>
 
 #include "board-h2.h"
 #include "mmc.h"
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 675254ee4b1e93..dece47d76282ac 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -28,7 +28,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/input.h>
-#include <linux/i2c/tps65010.h>
+#include <linux/mfd/tps65010.h>
 #include <linux/smc91x.h>
 #include <linux/omapfb.h>
 #include <linux/platform_data/gpio-omap.h>
diff --git a/arch/arm/mach-omap1/board-h3-mmc.c b/arch/arm/mach-omap1/board-h3-mmc.c
index 4f58bfa5e7549e..692c267a9a9052 100644
--- a/arch/arm/mach-omap1/board-h3-mmc.c
+++ b/arch/arm/mach-omap1/board-h3-mmc.c
@@ -14,7 +14,7 @@
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 
-#include <linux/i2c/tps65010.h>
+#include <linux/mfd/tps65010.h>
 
 #include "common.h"
 #include "board-h3.h"
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index e62f9d454f1005..6d32beeb2d8857 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -28,7 +28,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/input.h>
 #include <linux/spi/spi.h>
-#include <linux/i2c/tps65010.h>
+#include <linux/mfd/tps65010.h>
 #include <linux/smc91x.h>
 #include <linux/omapfb.h>
 #include <linux/platform_data/gpio-omap.h>
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 95ac1929aede4d..d579f4e0413743 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -38,7 +38,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
-#include <linux/i2c/tps65010.h>
+#include <linux/mfd/tps65010.h>
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/omap1_bl.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
index 262ab07447483a..6cac7da15e2b0d 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
@@ -17,7 +17,7 @@
 #include <linux/cpufreq.h>
 #include <linux/gpio.h>
 
-#include <linux/i2c/tps65010.h>
+#include <linux/mfd/tps65010.h>
 
 #include <plat/cpu-freq.h>
 #include <mach/gpio-samsung.h>
diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
index 70b0eb7d31347f..64b1a0b7b803a1 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -24,7 +24,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 
-#include <linux/i2c/tps65010.h>
+#include <linux/mfd/tps65010.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/drivers/mfd/tps65010.c b/drivers/mfd/tps65010.c
index d829a6131f09e5..2ab67386b4ef1e 100644
--- a/drivers/mfd/tps65010.c
+++ b/drivers/mfd/tps65010.c
@@ -32,7 +32,7 @@
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 
-#include <linux/i2c/tps65010.h>
+#include <linux/mfd/tps65010.h>
 
 #include <linux/gpio/driver.h>
 
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index a4d814b7f38066..91393ec7d8503c 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -53,7 +53,7 @@
 #define DRIVER_DESC "OHCI OMAP driver"
 
 #ifdef CONFIG_TPS65010
-#include <linux/i2c/tps65010.h>
+#include <linux/mfd/tps65010.h>
 #else
 
 #define LOW	0
diff --git a/drivers/usb/phy/phy-isp1301-omap.c b/drivers/usb/phy/phy-isp1301-omap.c
index 042c5a8fd423d8..c6052c814bcc24 100644
--- a/drivers/usb/phy/phy-isp1301-omap.c
+++ b/drivers/usb/phy/phy-isp1301-omap.c
@@ -96,7 +96,7 @@ struct isp1301 {
 
 #if IS_REACHABLE(CONFIG_TPS65010)
 
-#include <linux/i2c/tps65010.h>
+#include <linux/mfd/tps65010.h>
 
 #else
 
diff --git a/drivers/video/fbdev/omap/lcd_h3.c b/drivers/video/fbdev/omap/lcd_h3.c
index 9d2da146813ef0..796f4634c4c6f1 100644
--- a/drivers/video/fbdev/omap/lcd_h3.c
+++ b/drivers/video/fbdev/omap/lcd_h3.c
@@ -21,7 +21,7 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/i2c/tps65010.h>
+#include <linux/mfd/tps65010.h>
 #include <linux/gpio.h>
 
 #include "omapfb.h"
diff --git a/include/linux/i2c/tps65010.h b/include/linux/mfd/tps65010.h
similarity index 99%
rename from include/linux/i2c/tps65010.h
rename to include/linux/mfd/tps65010.h
index 08aa92278d71cd..a1fb9bc5311de4 100644
--- a/include/linux/i2c/tps65010.h
+++ b/include/linux/mfd/tps65010.h
@@ -1,4 +1,4 @@
-/* linux/i2c/tps65010.h
+/* linux/mfd/tps65010.h
  *
  * Functions to access TPS65010 power management device.
  *
-- 
2.11.0

