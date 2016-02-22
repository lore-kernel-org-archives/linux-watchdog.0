Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35138 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbcBVQ4P (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Feb 2016 11:56:15 -0500
Received: by mail-ig0-f174.google.com with SMTP id hb3so80918451igb.0
        for <linux-watchdog@vger.kernel.org>; Mon, 22 Feb 2016 08:56:14 -0800 (PST)
From: slemieux.tyco@gmail.com
To: linux-arm-kernel@lists.infradead.org, wim@iguana.be,
	manabian@gmail.com
Cc: linux-watchdog@vger.kernel.org, linux@roeck-us.net,
	stigge@antcom.de, vz@mleia.com
Subject: [PATCH v2 4/5] watchdog: pnx4008: restart: support "cmd" from userspace
Date: Mon, 22 Feb 2016 11:55:42 -0500
Message-Id: <1456160143-26761-5-git-send-email-slemieux.tyco@gmail.com>
In-Reply-To: <1456160143-26761-1-git-send-email-slemieux.tyco@gmail.com>
References: <1456160143-26761-1-git-send-email-slemieux.tyco@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Sylvain Lemieux <slemieux@tycoint.com>

Added support to verify if a "cmd" is passed from the userspace program rebooting the system;
- if a valid "cmd" is available, handle it;
- If the received "cmd" is not supported, use the default reboot mode.

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
Changes from v1 to v2:
- Rename patch title;
  was "arm: lpc32xx: restart: support "cmd" from userspace"
- Add change to "pnx-4008" driver instead of "mach-lpc32xx".

 drivers/watchdog/pnx4008_wdt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 2275fd4..5f34299 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -133,6 +133,19 @@ static void pnx4008_wdt_sys_reset(enum reboot_mode mode, const char *cmd)
 	/* Make sure WDT clocks are enabled */
 	writel(LPC32XX_CLKPWR_PWMCLK_WDOG_EN, LPC32XX_CLKPWR_TIMER_CLK_CTRL);
 
+	/*
+	 * Verify if a "cmd" passed from the userspace program rebooting
+	 * the system; if available, and handle it.
+	 * - For details, see the 'reboot' syscall in kernel/reboot.c
+	 * - If the received "cmd" is not supported, use the default mode.
+	 */
+	if (cmd) {
+		if (cmd[0] == 'h')
+			mode = REBOOT_HARD;
+		else if (cmd[0] == 's')
+			mode = REBOOT_SOFT;
+	}
+
 	if (mode == REBOOT_SOFT) {
 		/* Force match output active */
 		writel(EXT_MATCH0, WDTIM_EMR(wdt_base));
-- 
1.8.3.1

