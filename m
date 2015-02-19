Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:53332 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752202AbbBSICI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 19 Feb 2015 03:02:08 -0500
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
To: boris.brezillon@free-electrons.com,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, nicolas.ferre@atmel.com,
	alexandre.belloni@free-electrons.com
Cc: Timo Kokkonen <timo.kokkonen@offcode.fi>
Subject: [PATCHv4 1/2] at91sam9_wdt: Allow watchdog to reset device at early boot
Date: Thu, 19 Feb 2015 10:01:45 +0200
Message-Id: <a9518888bc8d8473fbeea486ec17bc0a55afa309.1424332841.git.timo.kokkonen@offcode.fi>
In-Reply-To: <cover.1424332841.git.timo.kokkonen@offcode.fi>
References: <cover.1424332841.git.timo.kokkonen@offcode.fi>
In-Reply-To: <cover.1424332841.git.timo.kokkonen@offcode.fi>
References: <cover.1424332841.git.timo.kokkonen@offcode.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

By default the driver will start a kernel timer which keeps on kicking
the watchdog HW until user space has opened the watchdog
device. Usually this is desirable as the watchdog HW is running by
default and the user space may not have any watchdog daemon running at
all.

However, on production systems it may be mandatory that also early
crashes and lockups will lead to a watchdog reset, even if they happen
before the user space has opened the watchdog device.

To resolve the issue, add a new device tree property
"early-timeout-sec" which will let the kernel timer to ping the
watchdog HW only as long as the specified timeout permits. The default
is still to use kernel timer, but more strict behavior can be enabled
via the device tree property.

Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
---
 drivers/watchdog/at91sam9_wdt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 6df9405..1b40bfa 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -89,6 +89,8 @@ struct at91wdt {
 	u32 mr_mask;
 	unsigned long heartbeat;	/* WDT heartbeat in jiffies */
 	bool nowayout;
+	/* Timeout in jiffies for stopping the early timer */
+	unsigned long early_timer;
 	unsigned int irq;
 };
 
@@ -122,7 +124,8 @@ static void at91_ping(unsigned long data)
 {
 	struct at91wdt *wdt = (struct at91wdt *)data;
 	if (time_before(jiffies, wdt->next_heartbeat) ||
-	    !watchdog_active(&wdt->wdd)) {
+		(time_before(jiffies, wdt->early_timer) &&
+			!watchdog_active(&wdt->wdd))) {
 		at91_wdt_reset(wdt);
 		mod_timer(&wdt->timer, jiffies + wdt->heartbeat);
 	} else {
@@ -316,6 +319,10 @@ static int of_at91wdt_init(struct device_node *np, struct at91wdt *wdt)
 
 	wdt->mr |= max | ((max - min) << 16);
 
+	if (!of_property_read_u32_index(np, "early-timeout-sec", 0,
+					(u32 *)&wdt->early_timer))
+		wdt->early_timer = wdt->early_timer * HZ + jiffies;
+
 	return 0;
 }
 #else
-- 
2.1.0

