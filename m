Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:36261 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933546AbcBYSbz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 25 Feb 2016 13:31:55 -0500
Received: by mail-io0-f195.google.com with SMTP id b188so6393434iof.3
        for <linux-watchdog@vger.kernel.org>; Thu, 25 Feb 2016 10:31:55 -0800 (PST)
From: Sylvain Lemieux <slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org, arnd@arndb.de, wim@iguana.be,
	manabian@gmail.com
Cc: linux-watchdog@vger.kernel.org, linux@roeck-us.net,
	stigge@antcom.de, vz@mleia.com
Subject: [PATCH v4 2/6] watchdog: pnx4008: add restart handler
Date: Thu, 25 Feb 2016 13:31:36 -0500
Message-Id: <1456425100-28136-3-git-send-email-slemieux.tyco@gmail.com>
In-Reply-To: <1456425100-28136-1-git-send-email-slemieux.tyco@gmail.com>
References: <1456425100-28136-1-git-send-email-slemieux.tyco@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Sylvain Lemieux <slemieux@tycoint.com>

Add restart handler capability to the driver;
the restart handler implementation was taken from
"mach-lpc32xx" ("lpc23xx_restart" function).

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
Changes from v3 to v4:
- none.

Changes from v2 to v3:
- remove explicit clock enable from restart handler.
- verify "register_restart_handler" return value.
- add call to unregister_restart_handler".
- do the restart handling directly in "pnx4008_restart_handler".

Changes from v1 to v2:
- new patch in v2.

 drivers/watchdog/pnx4008_wdt.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 88264a2..80ee4af 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -31,6 +31,8 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/delay.h>
+#include <linux/reboot.h>
 #include <mach/hardware.h>
 
 /* WatchDog Timer - Chapter 23 Page 207 */
@@ -77,6 +79,7 @@
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static unsigned int heartbeat = DEFAULT_HEARTBEAT;
+static struct notifier_block restart_handler;
 
 static DEFINE_SPINLOCK(io_lock);
 static void __iomem	*wdt_base;
@@ -124,6 +127,19 @@ static int pnx4008_wdt_set_timeout(struct watchdog_device *wdd,
 	return 0;
 }
 
+static int pnx4008_restart_handler(struct notifier_block *this,
+				   unsigned long mode, void *cmd)
+{
+	/* Instant assert of RESETOUT_N with pulse length 1mS */
+	writel(13000, WDTIM_PULSE(wdt_base));
+	writel(M_RES2 | RESFRC1 | RESFRC2, WDTIM_MCTRL(wdt_base));
+
+	/* Wait for watchdog to reset system */
+	mdelay(1000);
+
+	return NOTIFY_DONE;
+}
+
 static const struct watchdog_info pnx4008_wdt_ident = {
 	.options = WDIOF_CARDRESET | WDIOF_MAGICCLOSE |
 	    WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
@@ -157,6 +173,15 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(wdt_base))
 		return PTR_ERR(wdt_base);
 
+	/* Register restart handler. */
+	restart_handler.notifier_call = pnx4008_restart_handler;
+	restart_handler.priority = 128;
+	ret = register_restart_handler(&restart_handler);
+	if (ret) {
+		dev_warn(&pdev->dev, "cannot register restart handler\n");
+		return ret;
+	}
+
 	wdt_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(wdt_clk))
 		return PTR_ERR(wdt_clk);
@@ -189,6 +214,7 @@ disable_clk:
 
 static int pnx4008_wdt_remove(struct platform_device *pdev)
 {
+	unregister_restart_handler(&restart_handler);
 	watchdog_unregister_device(&pnx4008_wdd);
 
 	clk_disable_unprepare(wdt_clk);
-- 
1.8.3.1

