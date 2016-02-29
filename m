Return-path: <slemieux.tyco@gmail.com>
From: Sylvain Lemieux <slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	arnd@arndb.de,
	linux@roeck-us.net,
	manabian@gmail.com
Cc: linux-watchdog@vger.kernel.org,
	wim@iguana.be,
	stigge@antcom.de,
	vz@mleia.com
Subject: [PATCH v5 2/6] watchdog: pnx4008: add restart handler
Date: Mon, 29 Feb 2016 12:31:04 -0500
Message-Id: <1456767068-14449-3-git-send-email-slemieux.tyco@gmail.com>
In-Reply-To: <1456767068-14449-1-git-send-email-slemieux.tyco@gmail.com>
References: <1456767068-14449-1-git-send-email-slemieux.tyco@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Sylvain Lemieux <slemieux@tycoint.com>

Add restart handler capability to the driver;
the restart handler implementation was taken from
"mach-lpc32xx" ("lpc23xx_restart" function).

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
Changes from v4 to v5:
- Rebased on the following patch:
  http://permalink.gmane.org/gmane.linux.watchdog/3364/

Changes from v3 to v4:
- none.

Changes from v2 to v3:
- remove explicit clock enable from restart handler.
- verify "register_restart_handler" return value.
- add call to unregister_restart_handler".
- do the restart handling directly in "pnx4008_restart_handler".

Changes from v1 to v2:
- new patch in v2.

 drivers/watchdog/pnx4008_wdt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 88264a2..f3be522 100644
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
@@ -124,6 +126,19 @@ static int pnx4008_wdt_set_timeout(struct watchdog_device *wdd,
 	return 0;
 }
 
+static int pnx4008_restart_handler(struct watchdog_device *wdd,
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
@@ -135,6 +150,7 @@ static const struct watchdog_ops pnx4008_wdt_ops = {
 	.start = pnx4008_wdt_start,
 	.stop = pnx4008_wdt_stop,
 	.set_timeout = pnx4008_wdt_set_timeout,
+	.restart = pnx4008_restart_handler,
 };
 
 static struct watchdog_device pnx4008_wdd = {
@@ -169,6 +185,7 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
 			WDIOF_CARDRESET : 0;
 	pnx4008_wdd.parent = &pdev->dev;
 	watchdog_set_nowayout(&pnx4008_wdd, nowayout);
+	watchdog_set_restart_priority(&pnx4008_wdd, 128);
 
 	pnx4008_wdt_stop(&pnx4008_wdd);	/* disable for now */
 
-- 
1.8.3.1
