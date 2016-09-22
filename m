Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56017 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753071AbcIVHEl (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 22 Sep 2016 03:04:41 -0400
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: kernel@pengutronix.de,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] watchdog: dw_wdt: add stop watchdog operation
Date: Thu, 22 Sep 2016 09:02:32 +0200
Message-Id: <1474527753-22194-4-git-send-email-s.trumtrar@pengutronix.de>
In-Reply-To: <1474527753-22194-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1474527753-22194-1-git-send-email-s.trumtrar@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The only way of stopping the watchdog is by resetting it.
Add the watchdog op for stopping the device and reset if
a reset line is provided.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/dw_wdt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index e024722e8b3b..5b067984d5e8 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -137,6 +137,21 @@ static int dw_wdt_start(struct watchdog_device *wdd)
 	return 0;
 }
 
+static int dw_wdt_stop(struct watchdog_device *wdd)
+{
+	struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
+
+	if (IS_ERR(dw_wdt->rst)) {
+		dev_warn(wdd->parent, "No reset line. Will not stop.\n");
+		return PTR_ERR(dw_wdt->rst);
+	}
+
+	reset_control_assert(dw_wdt->rst);
+	reset_control_deassert(dw_wdt->rst);
+
+	return 0;
+}
+
 static int dw_wdt_restart_handle(struct notifier_block *this,
 				 unsigned long mode, void *cmd)
 {
@@ -177,6 +192,7 @@ static const struct watchdog_info dw_wdt_ident = {
 static const struct watchdog_ops dw_wdt_ops = {
 	.owner		= THIS_MODULE,
 	.start		= dw_wdt_start,
+	.stop		= dw_wdt_stop,
 	.ping		= dw_wdt_ping,
 	.set_timeout	= dw_wdt_set_timeout,
 	.get_timeleft	= dw_wdt_get_timeleft,
-- 
2.8.1

