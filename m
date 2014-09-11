Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bl2on0116.outbound.protection.outlook.com ([65.55.169.116]:47171
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753592AbaIKIy5 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 11 Sep 2014 04:54:57 -0400
From: Jingchang Lu <jingchang.lu@freescale.com>
To: <wim@iguana.be>
CC: <shawn.guo@freescale.com>, <arnd@arndb.de>,
	<linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Jingchang Lu <jingchang.lu@freescale.com>
Subject: [PATCH] watchdog: imx2_wdt: add restart handler support
Date: Thu, 11 Sep 2014 15:47:41 +0800
Message-ID: <1410421661-15298-1-git-send-email-jingchang.lu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

  Register the watchdog as the system restart function
to the new introducing kernel restart call chain in the
driver instead of providing the restart in machine desc.
  This restart handler function is from the mxc_restart()
in arch/arm/mach-imx/system.c

Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
---
 drivers/watchdog/imx2_wdt.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 68c3d37..fa723e8 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -22,14 +22,17 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/notifier.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/timer.h>
 #include <linux/watchdog.h>
@@ -59,6 +62,7 @@ struct imx2_wdt_device {
 	struct regmap *regmap;
 	struct timer_list timer;	/* Pings the watchdog when closed */
 	struct watchdog_device wdog;
+	struct notifier_block restart_handler;
 };
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -77,6 +81,31 @@ static const struct watchdog_info imx2_wdt_info = {
 	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 };
 
+static int imx2_restart_handler(struct notifier_block *this, unsigned long mode,
+				void *cmd)
+{
+	unsigned int wcr_enable = IMX2_WDT_WCR_WDE;
+	struct imx2_wdt_device *wdev = container_of(this,
+							struct imx2_wdt_device,
+							restart_handler);
+	/* Assert SRS signal */
+	regmap_write(wdev->regmap, 0, wcr_enable);
+	/*
+	 * Due to imx6q errata ERR004346 (WDOG: WDOG SRS bit requires to be
+	 * written twice), we add another two writes to ensure there must be at
+	 * least two writes happen in the same one 32kHz clock period.  We save
+	 * the target check here, since the writes shouldn't be a huge burden
+	 * for other platforms.
+	 */
+	regmap_write(wdev->regmap, 0, wcr_enable);
+	regmap_write(wdev->regmap, 0, wcr_enable);
+
+	/* wait for reset to assert... */
+	mdelay(500);
+
+	return NOTIFY_DONE;
+}
+
 static inline void imx2_wdt_setup(struct watchdog_device *wdog)
 {
 	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
@@ -257,6 +286,12 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	wdev->restart_handler.notifier_call = imx2_restart_handler;
+	wdev->restart_handler.priority = 128;
+	ret = register_restart_handler(&wdev->restart_handler);
+	if (ret)
+		dev_err(&pdev->dev, "cannot register restart handler\n");
+
 	dev_info(&pdev->dev, "timeout %d sec (nowayout=%d)\n",
 		 wdog->timeout, nowayout);
 
@@ -268,6 +303,8 @@ static int __exit imx2_wdt_remove(struct platform_device *pdev)
 	struct watchdog_device *wdog = platform_get_drvdata(pdev);
 	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
 
+	unregister_restart_handler(&wdev->restart_handler);
+
 	watchdog_unregister_device(wdog);
 
 	if (imx2_wdt_is_running(wdev)) {
-- 
1.8.0

