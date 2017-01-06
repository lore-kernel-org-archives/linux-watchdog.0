Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] watchdog: dw_wdt: Use watchdog core to install restart handler
Date: Thu,  5 Jan 2017 19:51:59 -0800
Message-Id: <1483674720-4870-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1483674720-4870-1-git-send-email-linux@roeck-us.net>
References: <1483674720-4870-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use the infrastructure provided by the watchdog core to install
the restart handler.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Need to call watchdog_set_restart_priority()

 drivers/watchdog/dw_wdt.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 3c6a3de13a1b..914da3a4d334 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -26,11 +26,9 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 #include <linux/watchdog.h>
 
 #define WDOG_CONTROL_REG_OFFSET		    0x00
@@ -55,7 +53,6 @@ struct dw_wdt {
 	void __iomem		*regs;
 	struct clk		*clk;
 	unsigned long		rate;
-	struct notifier_block	restart_handler;
 	struct watchdog_device	wdd;
 };
 
@@ -136,14 +133,12 @@ static int dw_wdt_start(struct watchdog_device *wdd)
 	return 0;
 }
 
-static int dw_wdt_restart_handle(struct notifier_block *this,
-				 unsigned long mode, void *cmd)
+static int dw_wdt_restart(struct watchdog_device *wdd,
+			  unsigned long action, void *data)
 {
-	struct dw_wdt *dw_wdt;
+	struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
 	u32 val;
 
-	dw_wdt = container_of(this, struct dw_wdt, restart_handler);
-
 	writel(0, dw_wdt->regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
 	val = readl(dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
 	if (val & WDOG_CONTROL_REG_WDT_EN_MASK)
@@ -156,7 +151,7 @@ static int dw_wdt_restart_handle(struct notifier_block *this,
 	/* wait for reset to assert... */
 	mdelay(500);
 
-	return NOTIFY_DONE;
+	return 0;
 }
 
 static unsigned int dw_wdt_get_timeleft(struct watchdog_device *wdd)
@@ -179,6 +174,7 @@ static const struct watchdog_ops dw_wdt_ops = {
 	.ping		= dw_wdt_ping,
 	.set_timeout	= dw_wdt_set_timeout,
 	.get_timeleft	= dw_wdt_get_timeleft,
+	.restart	= dw_wdt_restart,
 };
 
 #ifdef CONFIG_PM_SLEEP
@@ -265,16 +261,12 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dw_wdt);
 
+	watchdog_set_restart_priority(wdd, 128);
+
 	ret = watchdog_register_device(wdd);
 	if (ret)
 		goto out_disable_clk;
 
-	dw_wdt->restart_handler.notifier_call = dw_wdt_restart_handle;
-	dw_wdt->restart_handler.priority = 128;
-	ret = register_restart_handler(&dw_wdt->restart_handler);
-	if (ret)
-		pr_warn("cannot register restart handler\n");
-
 	return 0;
 
 out_disable_clk:
@@ -286,7 +278,6 @@ static int dw_wdt_drv_remove(struct platform_device *pdev)
 {
 	struct dw_wdt *dw_wdt = platform_get_drvdata(pdev);
 
-	unregister_restart_handler(&dw_wdt->restart_handler);
 	watchdog_unregister_device(&dw_wdt->wdd);
 	clk_disable_unprepare(dw_wdt->clk);
 
-- 
2.7.4
