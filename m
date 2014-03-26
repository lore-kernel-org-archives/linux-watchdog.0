Return-Path: <Li.Xiubo@freescale.com>
From: Xiubo Li <Li.Xiubo@freescale.com>
To: <wim@iguana.be>, <w.sang@pengutronix.de>,
	<linux-watchdog@vger.kernel.org>, <linux@roeck-us.net>
CC: <linux-kernel@vger.kernel.org>, Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 1/2] watchdog: imx2_wdt: Sort the header files alphabetically
Date: Wed, 26 Mar 2014 10:21:39 +0800
Message-ID: <1395800500-22655-2-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1395800500-22655-1-git-send-email-Li.Xiubo@freescale.com>
References: <1395800500-22655-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Li.Xiubo@freescale.com
List-ID: <linux-watchdog@vger.kernel.org>

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/imx2_wdt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index dd51d95..1795922 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -21,19 +21,19 @@
  * Halt on suspend:	Manual		Can be automatic
  */
 
+#include <linux/clk.h>
+#include <linux/fs.h>
 #include <linux/init.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
-#include <linux/watchdog.h>
-#include <linux/clk.h>
-#include <linux/fs.h>
-#include <linux/io.h>
-#include <linux/uaccess.h>
 #include <linux/timer.h>
-#include <linux/jiffies.h>
+#include <linux/uaccess.h>
+#include <linux/watchdog.h>
 
 #define DRIVER_NAME "imx2-wdt"
 
-- 
1.8.4
