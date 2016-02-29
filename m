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
Subject: [PATCH v5 3/6] watchdog: pnx4008: add support for soft reset
Date: Mon, 29 Feb 2016 12:31:05 -0500
Message-Id: <1456767068-14449-4-git-send-email-slemieux.tyco@gmail.com>
In-Reply-To: <1456767068-14449-1-git-send-email-slemieux.tyco@gmail.com>
References: <1456767068-14449-1-git-send-email-slemieux.tyco@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Sylvain Lemieux <slemieux@tycoint.com>

Add support for explicit soft reset using the reboot mode.

The default reboot mode behavior is unchanged;
you can overwrite the default reboot type in the board specific file
"DT_MACHINE_START" definition using the "reboot_mode" parameter.

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
Changes from v4 to v5:
- no logical change; updated to work with new revision of patch #2.

Changes from v3 to v4:
- none.

Changes from v2 to v3:
- no logical change; updated to work with new revision of patch #2.

Changes from v1 to v2:
- Rename patch title;
  was "arm: lpc32xx: restart: add support for soft reset"
- Add change to "pnx-4008" driver instead of "mach-lpc32xx".
- Use define available in "pnx-4008" when writting to watchdog register.

 drivers/watchdog/pnx4008_wdt.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index f3be522..e05bfecf 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -129,9 +129,16 @@ static int pnx4008_wdt_set_timeout(struct watchdog_device *wdd,
 static int pnx4008_restart_handler(struct watchdog_device *wdd,
 				   unsigned long mode, void *cmd)
 {
-	/* Instant assert of RESETOUT_N with pulse length 1mS */
-	writel(13000, WDTIM_PULSE(wdt_base));
-	writel(M_RES2 | RESFRC1 | RESFRC2, WDTIM_MCTRL(wdt_base));
+	if (mode == (unsigned long)REBOOT_SOFT) {
+		/* Force match output active */
+		writel(EXT_MATCH0, WDTIM_EMR(wdt_base));
+		/* Internal reset on match output (RESOUT_N not asserted) */
+		writel(M_RES1, WDTIM_MCTRL(wdt_base));
+	} else {
+		/* Instant assert of RESETOUT_N with pulse length 1mS */
+		writel(13000, WDTIM_PULSE(wdt_base));
+		writel(M_RES2 | RESFRC1 | RESFRC2, WDTIM_MCTRL(wdt_base));
+	}
 
 	/* Wait for watchdog to reset system */
 	mdelay(1000);
-- 
1.8.3.1
