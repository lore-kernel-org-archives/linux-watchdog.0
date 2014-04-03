Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:2089 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932373AbaDCCDA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Apr 2014 22:03:00 -0400
From: Xiubo Li <Li.Xiubo@freescale.com>
To: <wim@iguana.be>, <linux@roeck-us.net>, <shawn.guo@linaro.org>,
	<linux-watchdog@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv4 1/2] watchdog: imx2_wdt: Sort the header files alphabetically
Date: Thu, 3 Apr 2014 09:04:18 +0800
Message-ID: <1396487059-15298-2-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1396487059-15298-1-git-send-email-Li.Xiubo@freescale.com>
References: <1396487059-15298-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Cc: Shawn Guo <shawn.guo@linaro.org>
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


