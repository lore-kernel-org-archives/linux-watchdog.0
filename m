Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45071 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752938AbdEVIwW (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 22 May 2017 04:52:22 -0400
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Dinh Nguyen <dinguyen@opensource.altera.com>,
        linux-arm-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH v4 2/3] watchdog: dw_wdt: get reset lines from dt
Date: Mon, 22 May 2017 10:51:39 +0200
Message-Id: <17fdba7aa0c8f356cfdc28792d228817030b152e.1495443015.git-series.s.trumtrar@pengutronix.de>
In-Reply-To: <cover.50aaf23e8fbe9028f711a67e39b96910c986e8b0.1495443015.git-series.s.trumtrar@pengutronix.de>
References: <cover.50aaf23e8fbe9028f711a67e39b96910c986e8b0.1495443015.git-series.s.trumtrar@pengutronix.de>
In-Reply-To: <cover.50aaf23e8fbe9028f711a67e39b96910c986e8b0.1495443015.git-series.s.trumtrar@pengutronix.de>
References: <cover.50aaf23e8fbe9028f711a67e39b96910c986e8b0.1495443015.git-series.s.trumtrar@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The dw_wdt has an external reset line, that can keep the device in reset
and therefore rendering it useless and also is the only way of stopping
the watchdog once it was started.

Get the reset lines for this core from the devicetree. As these lines are
optional, use devm_reset_control_get_optional_shared. If the reset line
is not specified in the devicetree, the reset framework will just skip
deasserting and continue.
This way all users of the driver will continue to function without
any harm, even if the reset line is not specified in the devicetree.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/watchdog/dw_wdt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 914da3a4d334..36be987ff9ef 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -29,6 +29,7 @@
 #include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/watchdog.h>
 
 #define WDOG_CONTROL_REG_OFFSET		    0x00
@@ -54,6 +55,7 @@ struct dw_wdt {
 	struct clk		*clk;
 	unsigned long		rate;
 	struct watchdog_device	wdd;
+	struct reset_control	*rst;
 };
 
 #define to_dw_wdt(wdd)	container_of(wdd, struct dw_wdt, wdd)
@@ -234,6 +236,14 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 		goto out_disable_clk;
 	}
 
+	dw_wdt->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
+	if (IS_ERR(dw_wdt->rst)) {
+		ret = PTR_ERR(dw_wdt->rst);
+		goto out_disable_clk;
+	}
+
+	reset_control_deassert(dw_wdt->rst);
+
 	wdd = &dw_wdt->wdd;
 	wdd->info = &dw_wdt_ident;
 	wdd->ops = &dw_wdt_ops;
@@ -279,6 +289,7 @@ static int dw_wdt_drv_remove(struct platform_device *pdev)
 	struct dw_wdt *dw_wdt = platform_get_drvdata(pdev);
 
 	watchdog_unregister_device(&dw_wdt->wdd);
+	reset_control_assert(dw_wdt->rst);
 	clk_disable_unprepare(dw_wdt->clk);
 
 	return 0;
-- 
git-series 0.9.1
