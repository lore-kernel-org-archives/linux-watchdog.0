Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:40615 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753960AbbCLMIO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 12 Mar 2015 08:08:14 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v5 04/10] watchdog: at91rm9200: implement restart handler
Date: Thu, 12 Mar 2015 13:07:28 +0100
Message-Id: <1426162054-9987-5-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Restarting the at91rm9200 is done through programming the watchdog and waiting
for it to reset.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/watchdog/at91rm9200_wdt.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
index e6fa87d85de3..41cecb55766c 100644
--- a/drivers/watchdog/at91rm9200_wdt.c
+++ b/drivers/watchdog/at91rm9200_wdt.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/bitops.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/init.h>
@@ -23,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
@@ -53,6 +55,27 @@ static unsigned long at91wdt_busy;
 
 /* ......................................................................... */
 
+static int at91rm9200_restart(struct notifier_block *this,
+					unsigned long mode, void *cmd)
+{
+	/*
+	 * Perform a hardware reset with the use of the Watchdog timer.
+	 */
+	regmap_write(regmap_st, AT91_ST_WDMR,
+		     AT91_ST_RSTEN | AT91_ST_EXTEN | 1);
+	regmap_write(regmap_st, AT91_ST_CR, AT91_ST_WDRST);
+
+	mdelay(2000);
+
+	pr_emerg("Unable to restart system\n");
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block at91rm9200_restart_nb = {
+	.notifier_call = at91rm9200_restart,
+	.priority = 192,
+};
+
 /*
  * Disable the watchdog.
  */
@@ -228,6 +251,10 @@ static int at91wdt_probe(struct platform_device *pdev)
 	if (res)
 		return res;
 
+	res = register_restart_handler(&at91rm9200_restart_nb);
+	if (res)
+		dev_warn(dev, "failed to register restart handler\n");
+
 	pr_info("AT91 Watchdog Timer enabled (%d seconds%s)\n",
 		wdt_time, nowayout ? ", nowayout" : "");
 	return 0;
@@ -235,8 +262,13 @@ static int at91wdt_probe(struct platform_device *pdev)
 
 static int at91wdt_remove(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	int res;
 
+	res = unregister_restart_handler(&at91rm9200_restart_nb);
+	if (res)
+		dev_warn(dev, "failed to unregister restart handler\n");
+
 	res = misc_deregister(&at91wdt_miscdev);
 	if (!res)
 		at91wdt_miscdev.parent = NULL;
-- 
2.1.0

