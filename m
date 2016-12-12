Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail01.prevas.se ([62.95.78.3]:39723 "EHLO mail01.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932313AbcLLJsp (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 12 Dec 2016 04:48:45 -0500
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>
CC: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        <linux-watchdog@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] watchdog: bcm2835_wdt: set WDOG_HW_RUNNING bit when appropriate
Date: Mon, 12 Dec 2016 10:48:43 +0100
Message-ID: <1481536123-9279-1-git-send-email-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

A bootloader may start the watchdog device before handing control to
the kernel - in that case, we should tell the kernel about it so the
watchdog framework can keep it alive until userspace opens
/dev/watchdog0.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/watchdog/bcm2835_wdt.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index 4dddd82..c32c45b 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -55,6 +55,15 @@ struct bcm2835_wdt {
 static unsigned int heartbeat;
 static bool nowayout = WATCHDOG_NOWAYOUT;
 
+static bool bcm2835_wdt_is_running(struct bcm2835_wdt *wdt)
+{
+	uint32_t cur;
+
+	cur = readl(wdt->base + PM_RSTC);
+
+	return !!(cur & PM_RSTC_WRCFG_FULL_RESET);
+}
+
 static int bcm2835_wdt_start(struct watchdog_device *wdog)
 {
 	struct bcm2835_wdt *wdt = watchdog_get_drvdata(wdog);
@@ -181,6 +190,17 @@ static int bcm2835_wdt_probe(struct platform_device *pdev)
 	watchdog_init_timeout(&bcm2835_wdt_wdd, heartbeat, dev);
 	watchdog_set_nowayout(&bcm2835_wdt_wdd, nowayout);
 	bcm2835_wdt_wdd.parent = &pdev->dev;
+	if (bcm2835_wdt_is_running(wdt)) {
+		/*
+		 * The currently active timeout value (set by the
+		 * bootloader) may be different from the module
+		 * heartbeat parameter or the value in device
+		 * tree. But we just need to set WDOG_HW_RUNNING,
+		 * because then the framework will "immediately" ping
+		 * the device, updating the timeout.
+		 */
+		set_bit(WDOG_HW_RUNNING, &bcm2835_wdt_wdd.status);
+	}
 	err = watchdog_register_device(&bcm2835_wdt_wdd);
 	if (err) {
 		dev_err(dev, "Failed to register watchdog device");
-- 
2.7.4

