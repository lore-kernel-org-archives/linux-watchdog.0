Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53824 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933581AbbHLIQQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Aug 2015 04:16:16 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>, kernel@pengutronix.de,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v2 4/7] watchdog: mpc8xxx: use devm_ioremap_resource to map memory
Date: Wed, 12 Aug 2015 10:15:55 +0200
Message-Id: <1439367358-5338-5-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1439367358-5338-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1439367358-5338-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This simplifies the error paths and device unbinding.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/mpc8xxx_wdt.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index fb1fe967cf57..a6790fcfa69b 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -142,8 +142,7 @@ static struct watchdog_device mpc8xxx_wdt_dev = {
 static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 {
 	int ret;
-	const struct of_device_id *match;
-	struct device_node *np = ofdev->dev.of_node;
+	struct resource *res;
 	const struct mpc8xxx_wdt_type *wdt_type;
 	u32 freq = fsl_get_sys_freq();
 	bool enabled;
@@ -156,15 +155,15 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	if (!freq || freq == -1)
 		return -EINVAL;
 
-	wd_base = of_iomap(np, 0);
-	if (!wd_base)
-		return -ENOMEM;
+	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
+	wd_base = devm_ioremap_resource(&ofdev->dev, res);
+	if (IS_ERR(wd_base))
+		return PTR_ERR(wd_base);
 
 	enabled = in_be32(&wd_base->swcrr) & SWCRR_SWEN;
 	if (!enabled && wdt_type->hw_enabled) {
 		pr_info("could not be enabled in software\n");
-		ret = -ENOSYS;
-		goto err_unmap;
+		return -ENOSYS;
 	}
 
 	/* Calculate the timeout in seconds */
@@ -177,7 +176,7 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	ret = watchdog_register_device(&mpc8xxx_wdt_dev);
 	if (ret) {
 		pr_err("cannot register watchdog device (err=%d)\n", ret);
-		goto err_unmap;
+		return ret;
 	}
 
 	pr_info("WDT driver for MPC8xxx initialized. mode:%s timeout=%d (%d seconds)\n",
@@ -191,9 +190,6 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	if (enabled)
 		mod_timer(&wdt_timer, jiffies);
 	return 0;
-err_unmap:
-	iounmap(wd_base);
-	return ret;
 }
 
 static int mpc8xxx_wdt_remove(struct platform_device *ofdev)
@@ -202,7 +198,6 @@ static int mpc8xxx_wdt_remove(struct platform_device *ofdev)
 		reset ? "reset" : "machine check exception");
 	del_timer_sync(&wdt_timer);
 	watchdog_unregister_device(&mpc8xxx_wdt_dev);
-	iounmap(wd_base);
 
 	return 0;
 }
-- 
2.4.6

