Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49222 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756332AbdDQT3z (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Apr 2017 15:29:55 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/13] watchdog: lantiq: access boot cause register through regmap
Date: Mon, 17 Apr 2017 21:29:33 +0200
Message-Id: <20170417192942.32219-5-hauke@hauke-m.de>
In-Reply-To: <20170417192942.32219-1-hauke@hauke-m.de>
References: <20170417192942.32219-1-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch avoids accessing the function ltq_reset_cause() and directly
accesses the register given over the syscon interface. The syscon
interface will be implemented for the xway SoCs for the falcon SoCs the
ltq_reset_cause() function never worked, because a wrong offset was used.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/watchdog/lantiq_wdt.c | 47 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index e0823677d8c1..0e349ad03fdf 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -17,9 +17,14 @@
 #include <linux/uaccess.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #include <lantiq_soc.h>
 
+#define LTQ_RST_CAUSE_WDT_XRX		BIT(31)
+#define LTQ_RST_CAUSE_WDT_FALCON	0x02
+
 /*
  * Section 3.4 of the datasheet
  * The password sequence protects the WDT control register from unintended
@@ -186,6 +191,40 @@ static struct miscdevice ltq_wdt_miscdev = {
 	.fops	= &ltq_wdt_fops,
 };
 
+static void ltq_set_wdt_bootstatus(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct regmap *rcu_regmap;
+	u32 status_reg_offset;
+	u32 val;
+	int err;
+
+	rcu_regmap = syscon_regmap_lookup_by_phandle(np,
+						     "lantiq,rcu-syscon");
+	if (IS_ERR_OR_NULL(rcu_regmap))
+		return;
+
+	err = of_property_read_u32_index(np, "lantiq,rcu-syscon", 1,
+					 &status_reg_offset);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to get RCU reg offset\n");
+		return;
+	}
+
+	err = regmap_read(rcu_regmap, status_reg_offset, &val);
+	if (err)
+		return;
+
+	/* find out if the watchdog caused the last reboot */
+	if (of_device_is_compatible(np, "lantiq,wdt-xrx100")) {
+		if (val & LTQ_RST_CAUSE_WDT_XRX)
+			ltq_wdt_bootstatus = WDIOF_CARDRESET;
+	} else if  (of_device_is_compatible(np, "lantiq,wdt-falcon")) {
+		if ((val & 0x7) == LTQ_RST_CAUSE_WDT_FALCON)
+			ltq_wdt_bootstatus = WDIOF_CARDRESET;
+	}
+}
+
 static int
 ltq_wdt_probe(struct platform_device *pdev)
 {
@@ -205,9 +244,7 @@ ltq_wdt_probe(struct platform_device *pdev)
 	ltq_io_region_clk_rate = clk_get_rate(clk);
 	clk_put(clk);
 
-	/* find out if the watchdog caused the last reboot */
-	if (ltq_reset_cause() == LTQ_RST_CAUSE_WDTRST)
-		ltq_wdt_bootstatus = WDIOF_CARDRESET;
+	ltq_set_wdt_bootstatus(pdev);
 
 	dev_info(&pdev->dev, "Init done\n");
 	return misc_register(&ltq_wdt_miscdev);
@@ -222,7 +259,9 @@ ltq_wdt_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ltq_wdt_match[] = {
-	{ .compatible = "lantiq,wdt" },
+	{ .compatible = "lantiq,wdt"},
+	{ .compatible = "lantiq,wdt-xrx100"},
+	{ .compatible = "lantiq,wdt-falcon"},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ltq_wdt_match);
-- 
2.11.0

