Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from asav22.altibox.net ([109.247.116.9]:43947 "EHLO
	asav22.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546AbbFIKeA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 9 Jun 2015 06:34:00 -0400
From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	=?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH 2/3] watchdog: bcm2835: Add poweroff code for the Raspberry Pi
Date: Tue,  9 Jun 2015 12:21:44 +0200
Message-Id: <1433845305-17329-2-git-send-email-noralf@tronnes.org>
In-Reply-To: <1433845305-17329-1-git-send-email-noralf@tronnes.org>
References: <1433845305-17329-1-git-send-email-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This adds a new poweroff function to the watchdog driver for the
Raspberry Pi. Currently poweroff/halt results in a reboot.

The Raspberry Pi firmware uses the RSTS register to know which
partiton to boot from. The partiton value is spread into bits
0, 2, 4, 6, 8, 10. Partiton 63 is a special partition used by
the firmware to indicate halt.

The firmware made this change in 19 Aug 2013 and was matched
by the downstream commit:
Changes for new NOOBS multi partition booting from gsh

Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
---
 drivers/watchdog/bcm2835_wdt.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index 7116968..fdf0d7d 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -36,6 +36,13 @@
 #define PM_RSTC_WRCFG_FULL_RESET	0x00000020
 #define PM_RSTC_RESET			0x00000102
 
+/*
+ * The Raspberry Pi firmware uses the RSTS register to know which partiton
+ * to boot from. The partiton value is spread into bits 0, 2, 4, 6, 8, 10.
+ * Partiton 63 is a special partition used by the firmware to indicate halt.
+ */
+#define PM_RSTS_RASPBERRYPI_HALT	0x555
+
 #define SECS_TO_WDOG_TICKS(x) ((x) << 16)
 #define WDOG_TICKS_TO_SECS(x) ((x) >> 16)
 
@@ -159,6 +166,24 @@ static void bcm2835_power_off(void)
 	bcm2835_restart(&wdt->restart_handler, REBOOT_HARD, NULL);
 }
 
+static void rpi_power_off(void)
+{
+	struct device_node *np =
+		of_find_compatible_node(NULL, NULL, "brcm,raspberrypi-pm-wdt");
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct bcm2835_wdt *wdt = platform_get_drvdata(pdev);
+	u32 val;
+
+	val = readl_relaxed(wdt->base + PM_RSTS);
+	val |= PM_PASSWORD | PM_RSTS_RASPBERRYPI_HALT;
+	writel_relaxed(val, wdt->base + PM_RSTS);
+
+	/* Continue with normal reset mechanism */
+	bcm2835_restart(&wdt->restart_handler, REBOOT_HARD, NULL);
+}
+
+static const struct of_device_id bcm2835_wdt_of_match[];
+
 static int bcm2835_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -192,8 +217,12 @@ static int bcm2835_wdt_probe(struct platform_device *pdev)
 	wdt->restart_handler.notifier_call = bcm2835_restart;
 	wdt->restart_handler.priority = 128;
 	register_restart_handler(&wdt->restart_handler);
-	if (pm_power_off == NULL)
-		pm_power_off = bcm2835_power_off;
+	if (!pm_power_off) {
+		const struct of_device_id *match;
+
+		match = of_match_node(bcm2835_wdt_of_match, pdev->dev.of_node);
+		pm_power_off = match->data;
+	}
 
 	dev_info(dev, "Broadcom BCM2835 watchdog timer");
 	return 0;
@@ -204,7 +233,7 @@ static int bcm2835_wdt_remove(struct platform_device *pdev)
 	struct bcm2835_wdt *wdt = platform_get_drvdata(pdev);
 
 	unregister_restart_handler(&wdt->restart_handler);
-	if (pm_power_off == bcm2835_power_off)
+	if (pm_power_off == bcm2835_power_off || pm_power_off == rpi_power_off)
 		pm_power_off = NULL;
 	watchdog_unregister_device(&bcm2835_wdt_wdd);
 	iounmap(wdt->base);
@@ -218,7 +247,8 @@ static void bcm2835_wdt_shutdown(struct platform_device *pdev)
 }
 
 static const struct of_device_id bcm2835_wdt_of_match[] = {
-	{ .compatible = "brcm,bcm2835-pm-wdt", },
+	{ .compatible = "brcm,bcm2835-pm-wdt", .data = bcm2835_power_off },
+	{ .compatible = "brcm,raspberrypi-pm-wdt", .data = rpi_power_off },
 	{},
 };
 MODULE_DEVICE_TABLE(of, bcm2835_wdt_of_match);
-- 
2.2.2

