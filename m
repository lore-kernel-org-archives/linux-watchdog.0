Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33710 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbcBVQ4N (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Feb 2016 11:56:13 -0500
Received: by mail-ig0-f182.google.com with SMTP id y8so91061669igp.0
        for <linux-watchdog@vger.kernel.org>; Mon, 22 Feb 2016 08:56:13 -0800 (PST)
From: slemieux.tyco@gmail.com
To: linux-arm-kernel@lists.infradead.org, wim@iguana.be,
	manabian@gmail.com
Cc: linux-watchdog@vger.kernel.org, linux@roeck-us.net,
	stigge@antcom.de, vz@mleia.com
Subject: [PATCH v2 3/5] watchdog: pnx4008: add support for soft reset
Date: Mon, 22 Feb 2016 11:55:41 -0500
Message-Id: <1456160143-26761-4-git-send-email-slemieux.tyco@gmail.com>
In-Reply-To: <1456160143-26761-1-git-send-email-slemieux.tyco@gmail.com>
References: <1456160143-26761-1-git-send-email-slemieux.tyco@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Sylvain Lemieux <slemieux@tycoint.com>

Add support for explicit soft reset using the reboot mode.

The default reboot mode behavior is unchanged;
you can overwrite the default reboot type in the board specific file
"DT_MACHINE_START" definition using the "reboot_mode" parameter.

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
Changes from v1 to v2:
- Rename patch title;
  was "arm: lpc32xx: restart: add support for soft reset"
- Add change to "pnx-4008" driver instead of "mach-lpc32xx".
- Use define available in "pnx-4008" when writting to watchdog register.

 drivers/watchdog/pnx4008_wdt.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 4b01b2b..2275fd4 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -133,9 +133,16 @@ static void pnx4008_wdt_sys_reset(enum reboot_mode mode, const char *cmd)
 	/* Make sure WDT clocks are enabled */
 	writel(LPC32XX_CLKPWR_PWMCLK_WDOG_EN, LPC32XX_CLKPWR_TIMER_CLK_CTRL);
 
-	/* Instant assert of RESETOUT_N with pulse length 1mS */
-	writel(13000, WDTIM_PULSE(wdt_base));
-	writel(M_RES2 | RESFRC1 | RESFRC2, WDTIM_MCTRL(wdt_base));
+	if (mode == REBOOT_SOFT) {
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

