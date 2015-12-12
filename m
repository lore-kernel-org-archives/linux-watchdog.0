Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:43646 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134AbbLLOcv (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 12 Dec 2015 09:32:51 -0500
From: Harald Geyer <harald@ccbib.org>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, Harald Geyer <harald@ccbib.org>
Subject: [PATCHv4] watchdog: stmp3xxx: Stop the watchdog on system halt
Date: Sat, 12 Dec 2015 14:32:15 +0000
Message-Id: <1449930735-8503-1-git-send-email-harald@ccbib.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This allows the system to actually halt even if userspace forgot to
disable the watchdog first. Old behaviour was that the watchdog forced
the system to boot again.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Harald Geyer <harald@ccbib.org>
---
Changes since v3:
* Fix two minor whitespace issues
* Send this patch (was 1/2) alone, because Uwe wants more time looking into
  2/2.

Changes since v2:
* split this out as a separate patch


 drivers/watchdog/stmp3xxx_rtc_wdt.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index 3ee6128..dbe0372 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -14,6 +14,8 @@
 #include <linux/watchdog.h>
 #include <linux/platform_device.h>
 #include <linux/stmp3xxx_rtc_wdt.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
 
 #define WDOG_TICK_RATE 1000 /* 1 kHz clock */
 #define STMP3XXX_DEFAULT_TIMEOUT 19
@@ -69,6 +71,28 @@ static struct watchdog_device stmp3xxx_wdd = {
 	.status = WATCHDOG_NOWAYOUT_INIT_STATUS,
 };
 
+static int wdt_notify_sys(struct notifier_block *nb, unsigned long code,
+			  void *unused)
+{
+	struct device *dev = watchdog_get_drvdata(&stmp3xxx_wdd);
+	struct stmp3xxx_wdt_pdata *pdata = dev_get_platdata(dev);
+
+	switch (code) {
+	case SYS_DOWN:	/* keep enabled, system might crash while going down */
+		break;
+	case SYS_HALT:	/* allow the system to actually halt */
+	case SYS_POWER_OFF:
+		wdt_stop(&stmp3xxx_wdd);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block wdt_notifier = {
+	.notifier_call = wdt_notify_sys,
+};
+
 static int stmp3xxx_wdt_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -84,6 +108,9 @@ static int stmp3xxx_wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (register_reboot_notifier(&wdt_notifier))
+		dev_warn(&pdev->dev, "cannot register reboot notifier\n");
+
 	dev_info(&pdev->dev, "initialized watchdog with heartbeat %ds\n",
 			stmp3xxx_wdd.timeout);
 	return 0;
@@ -91,6 +118,7 @@ static int stmp3xxx_wdt_probe(struct platform_device *pdev)
 
 static int stmp3xxx_wdt_remove(struct platform_device *pdev)
 {
+	unregister_reboot_notifier(&wdt_notifier);
 	watchdog_unregister_device(&stmp3xxx_wdd);
 	return 0;
 }
-- 
2.1.4

