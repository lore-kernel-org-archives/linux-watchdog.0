Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50265 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755456AbbBUCU4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Feb 2015 21:20:56 -0500
From: Mathieu Olivari <mathieu@codeaurora.org>
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linux@arm.linux.org.uk, wim@iguana.be, corbet@lwn.net,
	standby24x7@gmail.com, mathieu@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 1/3] watchdog: qcom: use timer devicetree binding
Date: Fri, 20 Feb 2015 18:19:34 -0800
Message-Id: <1424485176-8348-2-git-send-email-mathieu@codeaurora.org>
In-Reply-To: <1424485176-8348-1-git-send-email-mathieu@codeaurora.org>
References: <1424485176-8348-1-git-send-email-mathieu@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

MSM watchdog configuration happens in the same register block as the
timer, so we'll use the same binding as the existing timer.

The qcom-wdt will now be probed when devicetree has an entry compatible
with "qcom,kpss-timer" or "qcom-scss-timer".

Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
---
 drivers/watchdog/qcom-wdt.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index aa85618..aa03ca8 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -20,9 +20,9 @@
 #include <linux/reboot.h>
 #include <linux/watchdog.h>
 
-#define WDT_RST		0x0
-#define WDT_EN		0x8
-#define WDT_BITE_TIME	0x24
+#define WDT_RST		0x38
+#define WDT_EN		0x40
+#define WDT_BITE_TIME	0x5C
 
 struct qcom_wdt {
 	struct watchdog_device	wdd;
@@ -117,6 +117,8 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 {
 	struct qcom_wdt *wdt;
 	struct resource *res;
+	struct device_node *np = pdev->dev.of_node;
+	u32 percpu_offset;
 	int ret;
 
 	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
@@ -124,6 +126,14 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	/* We use CPU0's DGT for the watchdog */
+	if (of_property_read_u32(np, "cpu-offset", &percpu_offset))
+		percpu_offset = 0;
+
+	res->start += percpu_offset;
+	res->end += percpu_offset;
+
 	wdt->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
@@ -203,9 +213,8 @@ static int qcom_wdt_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_wdt_of_table[] = {
-	{ .compatible = "qcom,kpss-wdt-msm8960", },
-	{ .compatible = "qcom,kpss-wdt-apq8064", },
-	{ .compatible = "qcom,kpss-wdt-ipq8064", },
+	{ .compatible = "qcom,kpss-timer" },
+	{ .compatible = "qcom,scss-timer" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, qcom_wdt_of_table);
-- 
1.9.1

