Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47597 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933573AbbHLIQL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Aug 2015 04:16:11 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>, kernel@pengutronix.de,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v2 2/7] watchdog: mpc8xxx: simplify registration
Date: Wed, 12 Aug 2015 10:15:53 +0200
Message-Id: <1439367358-5338-3-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1439367358-5338-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1439367358-5338-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Since commit ef90174f8210 ("watchdog: watchdog_core: Add watchdog
registration deferral mechanism") there is no need to delay the call to
watchdog_register_device any more. So simplify the registration code
accordingly.

Resetting wd_base to NULL can the also be dropped because nothing
depends on it being NULL to signal probe failure any more. (The matching
wd_base = NULL in .remove was missing, too.)

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/mpc8xxx_wdt.c | 38 +++++++-------------------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 8ad42b83f995..e0acda3282d9 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -51,7 +51,6 @@ struct mpc8xxx_wdt_type {
 };
 
 static struct mpc8xxx_wdt __iomem *wd_base;
-static int mpc8xxx_wdt_init_late(void);
 
 static u16 timeout = 0xffff;
 module_param(timeout, ushort, 0);
@@ -174,11 +173,14 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	timeout_sec = (timeout * wdt_type->prescaler) / freq;
 
 	mpc8xxx_wdt_dev.timeout = timeout_sec;
-#ifdef MODULE
-	ret = mpc8xxx_wdt_init_late();
-	if (ret)
+
+	watchdog_set_nowayout(&mpc8xxx_wdt_dev, nowayout);
+
+	ret = watchdog_register_device(&mpc8xxx_wdt_dev);
+	if (ret) {
+		pr_err("cannot register watchdog device (err=%d)\n", ret);
 		goto err_unmap;
-#endif
+	}
 
 	pr_info("WDT driver for MPC8xxx initialized. mode:%s timeout=%d (%d seconds)\n",
 		reset ? "reset" : "interrupt", timeout, timeout_sec);
@@ -193,7 +195,6 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	return 0;
 err_unmap:
 	iounmap(wd_base);
-	wd_base = NULL;
 	return ret;
 }
 
@@ -242,31 +243,6 @@ static struct platform_driver mpc8xxx_wdt_driver = {
 	},
 };
 
-/*
- * We do wdt initialization in two steps: arch_initcall probes the wdt
- * very early to start pinging the watchdog (misc devices are not yet
- * available), and later module_init() just registers the misc device.
- */
-static int mpc8xxx_wdt_init_late(void)
-{
-	int ret;
-
-	if (!wd_base)
-		return -ENODEV;
-
-	watchdog_set_nowayout(&mpc8xxx_wdt_dev, nowayout);
-
-	ret = watchdog_register_device(&mpc8xxx_wdt_dev);
-	if (ret) {
-		pr_err("cannot register watchdog device (err=%d)\n", ret);
-		return ret;
-	}
-	return 0;
-}
-#ifndef MODULE
-module_init(mpc8xxx_wdt_init_late);
-#endif
-
 static int __init mpc8xxx_wdt_init(void)
 {
 	return platform_driver_register(&mpc8xxx_wdt_driver);
-- 
2.4.6

