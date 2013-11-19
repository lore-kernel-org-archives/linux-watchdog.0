Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34892 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812Ab3KSV0Z (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Nov 2013 16:26:25 -0500
Received: by mail-pb0-f46.google.com with SMTP id md12so2472089pbc.5
        for <linux-watchdog@vger.kernel.org>; Tue, 19 Nov 2013 13:26:25 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] watchdog: Drop unnecessary include of miscdevice.h
Date: Tue, 19 Nov 2013 13:26:17 -0800
Message-Id: <1384896377-32382-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

After commit 487722cf2 (watchdog: Get rid of MODULE_ALIAS_MISCDEV
statements) the affected drivers no longer need to include miscdevice.h.
Only exception is rt2880_wdt.c which never needed it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Compile tested.

 drivers/watchdog/bcm2835_wdt.c      |    1 -
 drivers/watchdog/ep93xx_wdt.c       |    1 -
 drivers/watchdog/ie6xx_wdt.c        |    1 -
 drivers/watchdog/jz4740_wdt.c       |    1 -
 drivers/watchdog/kempld_wdt.c       |    1 -
 drivers/watchdog/max63xx_wdt.c      |    1 -
 drivers/watchdog/orion_wdt.c        |    1 -
 drivers/watchdog/pnx4008_wdt.c      |    1 -
 drivers/watchdog/rt2880_wdt.c       |    1 -
 drivers/watchdog/shwdt.c            |    1 -
 drivers/watchdog/softdog.c          |    1 -
 drivers/watchdog/stmp3xxx_rtc_wdt.c |    1 -
 drivers/watchdog/txx9wdt.c          |    1 -
 drivers/watchdog/ux500_wdt.c        |    1 -
 14 files changed, 14 deletions(-)

diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index a6a2ceb..cafa973 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -19,7 +19,6 @@
 #include <linux/watchdog.h>
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
-#include <linux/miscdevice.h>
 
 #define PM_RSTC				0x1c
 #define PM_WDOG				0x24
diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index 833e813..d1d07f2 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -28,7 +28,6 @@
 
 #include <linux/platform_device.h>
 #include <linux/module.h>
-#include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/timer.h>
 #include <linux/io.h>
diff --git a/drivers/watchdog/ie6xx_wdt.c b/drivers/watchdog/ie6xx_wdt.c
index 70a2402..07f88f5 100644
--- a/drivers/watchdog/ie6xx_wdt.c
+++ b/drivers/watchdog/ie6xx_wdt.c
@@ -28,7 +28,6 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
-#include <linux/miscdevice.h>
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
 #include <linux/uaccess.h>
diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 2de486a..3aa50cf 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -17,7 +17,6 @@
 #include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/drivers/watchdog/kempld_wdt.c b/drivers/watchdog/kempld_wdt.c
index a1a3638..20dc738 100644
--- a/drivers/watchdog/kempld_wdt.c
+++ b/drivers/watchdog/kempld_wdt.c
@@ -26,7 +26,6 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/miscdevice.h>
 #include <linux/uaccess.h>
 #include <linux/watchdog.h>
 #include <linux/platform_device.h>
diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index 6d4f399..bdb3f4a 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -19,7 +19,6 @@
 #include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/init.h>
 #include <linux/bitops.h>
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 44edca6..f7722a4 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -16,7 +16,6 @@
 #include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/miscdevice.h>
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 #include <linux/init.h>
diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 1bdcc31..5bec20f 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -23,7 +23,6 @@
 #include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
index 53d37fe..d92c2d5 100644
--- a/drivers/watchdog/rt2880_wdt.c
+++ b/drivers/watchdog/rt2880_wdt.c
@@ -16,7 +16,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/watchdog.h>
-#include <linux/miscdevice.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
 
diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
index f9b8e06..af3528f 100644
--- a/drivers/watchdog/shwdt.c
+++ b/drivers/watchdog/shwdt.c
@@ -26,7 +26,6 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/spinlock.h>
-#include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/pm_runtime.h>
 #include <linux/fs.h>
diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index ef2638f..c04a1aa 100644
--- a/drivers/watchdog/softdog.c
+++ b/drivers/watchdog/softdog.c
@@ -42,7 +42,6 @@
 #include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/timer.h>
-#include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/notifier.h>
 #include <linux/reboot.h>
diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index d667f6b..bb64ae3 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -12,7 +12,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/platform_device.h>
 #include <linux/stmp3xxx_rtc_wdt.h>
diff --git a/drivers/watchdog/txx9wdt.c b/drivers/watchdog/txx9wdt.c
index 0fd0e8a..6a447e3 100644
--- a/drivers/watchdog/txx9wdt.c
+++ b/drivers/watchdog/txx9wdt.c
@@ -13,7 +13,6 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
-#include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/drivers/watchdog/ux500_wdt.c b/drivers/watchdog/ux500_wdt.c
index e029b57..5aed9d7 100644
--- a/drivers/watchdog/ux500_wdt.c
+++ b/drivers/watchdog/ux500_wdt.c
@@ -12,7 +12,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
-#include <linux/miscdevice.h>
 #include <linux/err.h>
 #include <linux/uaccess.h>
 #include <linux/watchdog.h>
-- 
1.7.9.7

