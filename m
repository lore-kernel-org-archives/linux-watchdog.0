Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34473 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbcBVQ4L (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Feb 2016 11:56:11 -0500
Received: by mail-ig0-f182.google.com with SMTP id g6so91108927igt.1
        for <linux-watchdog@vger.kernel.org>; Mon, 22 Feb 2016 08:56:11 -0800 (PST)
From: slemieux.tyco@gmail.com
To: linux-arm-kernel@lists.infradead.org, wim@iguana.be,
	manabian@gmail.com
Cc: linux-watchdog@vger.kernel.org, linux@roeck-us.net,
	stigge@antcom.de, vz@mleia.com
Subject: [PATCH v2 2/5] watchdog: pnx4008: add restart handler
Date: Mon, 22 Feb 2016 11:55:40 -0500
Message-Id: <1456160143-26761-3-git-send-email-slemieux.tyco@gmail.com>
In-Reply-To: <1456160143-26761-1-git-send-email-slemieux.tyco@gmail.com>
References: <1456160143-26761-1-git-send-email-slemieux.tyco@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Sylvain Lemieux <slemieux@tycoint.com>

Add restart handler capability to the driver;
the restart handler implementation was taken from
"mach-lpc32xx" ("lpc23xx_restart" function).

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
Changes from v1 to v2:
- new patch in v2.

 drivers/watchdog/pnx4008_wdt.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 88264a2..4b01b2b 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -31,7 +31,10 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/delay.h>
+#include <linux/reboot.h>
 #include <mach/hardware.h>
+#include <mach/platform.h>
 
 /* WatchDog Timer - Chapter 23 Page 207 */
 
@@ -77,6 +80,7 @@
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static unsigned int heartbeat = DEFAULT_HEARTBEAT;
+static struct notifier_block restart_handler;
 
 static DEFINE_SPINLOCK(io_lock);
 static void __iomem	*wdt_base;
@@ -124,6 +128,27 @@ static int pnx4008_wdt_set_timeout(struct watchdog_device *wdd,
 	return 0;
 }
 
+static void pnx4008_wdt_sys_reset(enum reboot_mode mode, const char *cmd)
+{
+	/* Make sure WDT clocks are enabled */
+	writel(LPC32XX_CLKPWR_PWMCLK_WDOG_EN, LPC32XX_CLKPWR_TIMER_CLK_CTRL);
+
+	/* Instant assert of RESETOUT_N with pulse length 1mS */
+	writel(13000, WDTIM_PULSE(wdt_base));
+	writel(M_RES2 | RESFRC1 | RESFRC2, WDTIM_MCTRL(wdt_base));
+
+	/* Wait for watchdog to reset system */
+	mdelay(1000);
+}
+
+static int pnx4008_restart_handler(struct notifier_block *this,
+				   unsigned long mode, void *cmd)
+{
+	pnx4008_wdt_sys_reset((enum reboot_mode)mode, cmd);
+
+	return NOTIFY_DONE;
+}
+
 static const struct watchdog_info pnx4008_wdt_ident = {
 	.options = WDIOF_CARDRESET | WDIOF_MAGICCLOSE |
 	    WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
@@ -157,6 +182,11 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(wdt_base))
 		return PTR_ERR(wdt_base);
 
+	/* Register restart handler. */
+	restart_handler.notifier_call = pnx4008_restart_handler;
+	restart_handler.priority = 128;
+	ret = register_restart_handler(&restart_handler);
+
 	wdt_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(wdt_clk))
 		return PTR_ERR(wdt_clk);
-- 
1.8.3.1

