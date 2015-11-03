Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [RFC PATCH 12/13] watchdog: s3c2410_wdt: use core restart handler
Date: Mon,  2 Nov 2015 20:36:25 -0500
Message-Id: <1446514586-31455-13-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1446514586-31455-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1446514586-31455-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

Get rid of the custom restart handler by using the one provided by the
watchdog core.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/watchdog/s3c2410_wdt.c | 60 ++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 35 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index d781000..0093450 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -41,7 +41,6 @@
 #include <linux/of.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
-#include <linux/reboot.h>
 #include <linux/delay.h>
 
 #define S3C2410_WTCON		0x00
@@ -130,7 +129,6 @@ struct s3c2410_wdt {
 	unsigned long		wtdat_save;
 	struct watchdog_device	wdt_device;
 	struct notifier_block	freq_transition;
-	struct notifier_block	restart_handler;
 	struct s3c2410_wdt_variant *drv_data;
 	struct regmap *pmureg;
 };
@@ -351,6 +349,29 @@ static int s3c2410wdt_set_heartbeat(struct watchdog_device *wdd, unsigned timeou
 	return 0;
 }
 
+static int s3c2410wdt_restart(struct watchdog_device *wdd)
+{
+	struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
+	void __iomem *wdt_base = wdt->reg_base;
+
+	/* disable watchdog, to be safe  */
+	writel(0, wdt_base + S3C2410_WTCON);
+
+	/* put initial values into count and data */
+	writel(0x80, wdt_base + S3C2410_WTCNT);
+	writel(0x80, wdt_base + S3C2410_WTDAT);
+
+	/* set the watchdog to go and reset... */
+	writel(S3C2410_WTCON_ENABLE | S3C2410_WTCON_DIV16 |
+		S3C2410_WTCON_RSTEN | S3C2410_WTCON_PRESCALE(0x20),
+		wdt_base + S3C2410_WTCON);
+
+	/* wait for reset to assert... */
+	mdelay(500);
+
+	return 0;
+}
+
 #define OPTIONS (WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE)
 
 static const struct watchdog_info s3c2410_wdt_ident = {
@@ -365,6 +386,7 @@ static struct watchdog_ops s3c2410wdt_ops = {
 	.stop = s3c2410wdt_stop,
 	.ping = s3c2410wdt_keepalive,
 	.set_timeout = s3c2410wdt_set_heartbeat,
+	.restart = s3c2410wdt_restart,
 };
 
 static struct watchdog_device s3c2410_wdd = {
@@ -452,31 +474,6 @@ static inline void s3c2410wdt_cpufreq_deregister(struct s3c2410_wdt *wdt)
 }
 #endif
 
-static int s3c2410wdt_restart(struct notifier_block *this,
-			      unsigned long mode, void *cmd)
-{
-	struct s3c2410_wdt *wdt = container_of(this, struct s3c2410_wdt,
-					       restart_handler);
-	void __iomem *wdt_base = wdt->reg_base;
-
-	/* disable watchdog, to be safe  */
-	writel(0, wdt_base + S3C2410_WTCON);
-
-	/* put initial values into count and data */
-	writel(0x80, wdt_base + S3C2410_WTCNT);
-	writel(0x80, wdt_base + S3C2410_WTDAT);
-
-	/* set the watchdog to go and reset... */
-	writel(S3C2410_WTCON_ENABLE | S3C2410_WTCON_DIV16 |
-		S3C2410_WTCON_RSTEN | S3C2410_WTCON_PRESCALE(0x20),
-		wdt_base + S3C2410_WTCON);
-
-	/* wait for reset to assert... */
-	mdelay(500);
-
-	return NOTIFY_DONE;
-}
-
 static inline unsigned int s3c2410wdt_get_bootstatus(struct s3c2410_wdt *wdt)
 {
 	unsigned int rst_stat;
@@ -605,6 +602,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	}
 
 	watchdog_set_nowayout(&wdt->wdt_device, nowayout);
+	watchdog_set_restart_priority(&wdt->wdt_device, 128);
 
 	wdt->wdt_device.bootstatus = s3c2410wdt_get_bootstatus(wdt);
 	wdt->wdt_device.parent = &pdev->dev;
@@ -632,12 +630,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, wdt);
 
-	wdt->restart_handler.notifier_call = s3c2410wdt_restart;
-	wdt->restart_handler.priority = 128;
-	ret = register_restart_handler(&wdt->restart_handler);
-	if (ret)
-		pr_err("cannot register restart handler, %d\n", ret);
-
 	/* print out a statement of readiness */
 
 	wtcon = readl(wdt->reg_base + S3C2410_WTCON);
@@ -667,8 +659,6 @@ static int s3c2410wdt_remove(struct platform_device *dev)
 	int ret;
 	struct s3c2410_wdt *wdt = platform_get_drvdata(dev);
 
-	unregister_restart_handler(&wdt->restart_handler);
-
 	ret = s3c2410wdt_mask_and_disable_reset(wdt, true);
 	if (ret < 0)
 		return ret;
-- 
2.5.0
