Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:41399
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753085AbaCYKUF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 25 Mar 2014 06:20:05 -0400
From: Xiubo Li <Li.Xiubo@freescale.com>
To: <wim@iguana.be>, <w.sang@pengutronix.de>,
	<linux-watchdog@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 1/2] watchdog: imx2_wdt: Sort the header files alphabetically
Date: Tue, 25 Mar 2014 17:35:31 +0800
Message-ID: <1395740132-21396-2-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1395740132-21396-1-git-send-email-Li.Xiubo@freescale.com>
References: <1395740132-21396-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

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


