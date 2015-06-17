Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from asav22.altibox.net ([109.247.116.9]:42605 "EHLO
	asav22.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455AbbFQOFG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 17 Jun 2015 10:05:06 -0400
From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
To: linux-watchdog@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	=?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH v3] watchdog: bcm2835: Fix poweroff behaviour
Date: Wed, 17 Jun 2015 16:04:04 +0200
Message-Id: <1434549844-11704-1-git-send-email-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Currently poweroff/halt results in a reboot on the Raspberry Pi.
The firmware uses the RSTS register to know which partiton to
boot from. The partiton value is spread into bits
0, 2, 4, 6, 8, 10. Partiton 63 is a special partition used by
the firmware to indicate halt.

The firmware made this change in 19 Aug 2013 and was matched
by the downstream commit:
Changes for new NOOBS multi partition booting from gsh

Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
---

v2: Fix typo in commit message

v3: Only Raspberry Pi is supported so it's ok to just modify
    the poweroff function (Stephen Warrren)

 drivers/watchdog/bcm2835_wdt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index 7116968..43dbf5b 100644
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

@@ -151,8 +158,7 @@ static void bcm2835_power_off(void)
 	 * hard reset.
 	 */
 	val = readl_relaxed(wdt->base + PM_RSTS);
-	val &= PM_RSTC_WRCFG_CLR;
-	val |= PM_PASSWORD | PM_RSTS_HADWRH_SET;
+	val |= PM_PASSWORD | PM_RSTS_RASPBERRYPI_HALT;
 	writel_relaxed(val, wdt->base + PM_RSTS);

 	/* Continue with normal reset mechanism */
--
2.2.2

