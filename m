Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38862 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752180AbdLXVEa (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 24 Dec 2017 16:04:30 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?=
        <zboszor@pr.hu>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 08/12] watchdog: sp5100_tco: Clean up function and variable names
Date: Sun, 24 Dec 2017 13:04:13 -0800
Message-Id: <1514149457-20273-9-git-send-email-linux@roeck-us.net>
In-Reply-To: <1514149457-20273-1-git-send-email-linux@roeck-us.net>
References: <1514149457-20273-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use more common function and variable names.

Use pdev instead of dev for platform device.
Use sp5100_tco_probe() instead of sp5100_tco_init() for the probe function.
Drop sp5100_tco_cleanup(); just move the code into sp5100_tco_remove().
Use sp5100_tco_init() instead of sp5100_tco_init_module() for the module
initialization function.
Use sp5100_tco_exit() instead of sp5100_tco_cleanup_module() for the module
exit function.
Use consistent defines for accessing the watchdog control register.

Cc: Zoltán Böszörményi <zboszor@pr.hu>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sp5100_tco.c | 25 ++++++++++---------------
 drivers/watchdog/sp5100_tco.h |  5 ++---
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index ff240e5be833..1123fad38fdf 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -421,8 +421,8 @@ static int sp5100_tco_setupdevice(struct device *dev)
 	 * Save WatchDogFired status, because WatchDogFired flag is
 	 * cleared here.
 	 */
-	tco_wdt_fired = val & SP5100_PM_WATCHDOG_FIRED;
-	val &= ~SP5100_PM_WATCHDOG_ACTION_RESET;
+	tco_wdt_fired = val & SP5100_WDT_FIRED;
+	val &= ~SP5100_WDT_ACTION_RESET;
 	writel(val, SP5100_WDT_CONTROL(tcobase));
 
 	/* Set a reasonable heartbeat before we stop the timer */
@@ -445,7 +445,7 @@ static int sp5100_tco_setupdevice(struct device *dev)
 	return ret;
 }
 
-static int sp5100_tco_init(struct platform_device *pdev)
+static int sp5100_tco_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	int ret;
@@ -492,7 +492,7 @@ static int sp5100_tco_init(struct platform_device *pdev)
 	return ret;
 }
 
-static void sp5100_tco_cleanup(void)
+static int sp5100_tco_remove(struct platform_device *pdev)
 {
 	/* Stop the timer before we leave */
 	if (!nowayout)
@@ -502,22 +502,17 @@ static void sp5100_tco_cleanup(void)
 	misc_deregister(&sp5100_tco_miscdev);
 	iounmap(tcobase);
 	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
-}
 
-static int sp5100_tco_remove(struct platform_device *dev)
-{
-	if (tcobase)
-		sp5100_tco_cleanup();
 	return 0;
 }
 
-static void sp5100_tco_shutdown(struct platform_device *dev)
+static void sp5100_tco_shutdown(struct platform_device *pdev)
 {
 	tco_timer_stop();
 }
 
 static struct platform_driver sp5100_tco_driver = {
-	.probe		= sp5100_tco_init,
+	.probe		= sp5100_tco_probe,
 	.remove		= sp5100_tco_remove,
 	.shutdown	= sp5100_tco_shutdown,
 	.driver		= {
@@ -544,7 +539,7 @@ static const struct pci_device_id sp5100_tco_pci_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);
 
-static int __init sp5100_tco_init_module(void)
+static int __init sp5100_tco_init(void)
 {
 	struct pci_dev *dev = NULL;
 	int err;
@@ -580,14 +575,14 @@ static int __init sp5100_tco_init_module(void)
 	return err;
 }
 
-static void __exit sp5100_tco_cleanup_module(void)
+static void __exit sp5100_tco_exit(void)
 {
 	platform_device_unregister(sp5100_tco_platform_device);
 	platform_driver_unregister(&sp5100_tco_driver);
 }
 
-module_init(sp5100_tco_init_module);
-module_exit(sp5100_tco_cleanup_module);
+module_init(sp5100_tco_init);
+module_exit(sp5100_tco_exit);
 
 MODULE_AUTHOR("Priyanka Gupta");
 MODULE_DESCRIPTION("TCO timer driver for SP5100/SB800 chipset");
diff --git a/drivers/watchdog/sp5100_tco.h b/drivers/watchdog/sp5100_tco.h
index 2622cfe23dc1..cc00f1157220 100644
--- a/drivers/watchdog/sp5100_tco.h
+++ b/drivers/watchdog/sp5100_tco.h
@@ -15,6 +15,8 @@
 #define SP5100_WDT_COUNT(base)		((base) + 0x04) /* Watchdog Count */
 
 #define SP5100_WDT_START_STOP_BIT	(1 << 0)
+#define SP5100_WDT_FIRED		(1 << 1)
+#define SP5100_WDT_ACTION_RESET		(1 << 2)
 #define SP5100_WDT_TRIGGER_BIT		(1 << 7)
 
 #define SP5100_PM_IOPORTS_SIZE		0x02
@@ -34,9 +36,6 @@
 #define SP5100_PM_WATCHDOG_CONTROL	0x69
 #define SP5100_PM_WATCHDOG_BASE		0x6C
 
-#define SP5100_PM_WATCHDOG_FIRED	(1 << 1)
-#define SP5100_PM_WATCHDOG_ACTION_RESET	(1 << 2)
-
 #define SP5100_PCI_WATCHDOG_MISC_REG	0x41
 #define SP5100_PCI_WATCHDOG_DECODE_EN	(1 << 3)
 
-- 
2.7.4

