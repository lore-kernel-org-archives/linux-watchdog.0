Return-Path: <Li.Xiubo@freescale.com>
From: Xiubo Li <Li.Xiubo@freescale.com>
To: <linux@roeck-us.net>, <wim@iguana.be>, <shawn.guo@linaro.org>,
	<linux-watchdog@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv3 1/2] watchdog: imx2_wdt: Sort the header files alphabetically
Date: Tue, 1 Apr 2014 12:46:37 +0800
Message-ID: <1396327598-28535-2-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1396327598-28535-1-git-send-email-Li.Xiubo@freescale.com>
References: <1396327598-28535-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Li.Xiubo@freescale.com
List-ID: <linux-watchdog@vger.kernel.org>

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
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
