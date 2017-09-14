Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        linux-watchdog@vger.kernel.org, kernel@pengutronix.de,
        Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] watchdog: dw_wdt: add stop watchdog operation
Date: Thu, 14 Sep 2017 10:14:01 +0200
Message-Id: <20170914081402.7893-1-o.rempel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

From: Steffen Trumtrar <s.trumtrar@pengutronix.de>

The only way of stopping the watchdog is by resetting it.
Add the watchdog op for stopping the device and reset if
a reset line is provided.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/dw_wdt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 36be987ff9ef..50d8a6a5b5ac 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -135,6 +135,21 @@ static int dw_wdt_start(struct watchdog_device *wdd)
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
 static int dw_wdt_restart(struct watchdog_device *wdd,
 			  unsigned long action, void *data)
 {
@@ -173,6 +188,7 @@ static const struct watchdog_info dw_wdt_ident = {
 static const struct watchdog_ops dw_wdt_ops = {
 	.owner		= THIS_MODULE,
 	.start		= dw_wdt_start,
+	.stop		= dw_wdt_stop,
 	.ping		= dw_wdt_ping,
 	.set_timeout	= dw_wdt_set_timeout,
 	.get_timeleft	= dw_wdt_get_timeleft,
-- 
2.11.0
