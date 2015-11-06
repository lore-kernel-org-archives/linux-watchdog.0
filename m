Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37665 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030347AbbKFVzS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Nov 2015 16:55:18 -0500
Received: by wiva10 with SMTP id a10so3543154wiv.0
        for <linux-watchdog@vger.kernel.org>; Fri, 06 Nov 2015 13:55:16 -0800 (PST)
From: Carlo Caione <carlo@caione.org>
To: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	drake@endlessm.com, jerry.cao@amlogic.com, victor.wan@amlogic.com,
	romain.perier@gmail.com
Cc: Carlo Caione <carlo@endlessm.com>
Subject: [PATCH 1/4] watchdog: meson: Enable meson SoC specific data
Date: Fri,  6 Nov 2015 22:55:03 +0100
Message-Id: <1446846906-31520-2-git-send-email-carlo@caione.org>
In-Reply-To: <1446846906-31520-1-git-send-email-carlo@caione.org>
References: <1446846906-31520-1-git-send-email-carlo@caione.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Carlo Caione <carlo@endlessm.com>

With this patch we refactor the driver code to enable watchdog support
for all platforms based on Amlogic meson SoCs.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/watchdog/meson_wdt.c | 55 ++++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
index 1f4155e..89944ed 100644
--- a/drivers/watchdog/meson_wdt.c
+++ b/drivers/watchdog/meson_wdt.c
@@ -19,6 +19,7 @@
 #include <linux/moduleparam.h>
 #include <linux/notifier.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/types.h>
@@ -27,34 +28,45 @@
 #define DRV_NAME		"meson_wdt"
 
 #define MESON_WDT_TC		0x00
-#define MESON_WDT_TC_EN		BIT(22)
-#define MESON_WDT_TC_TM_MASK	0x3fffff
 #define MESON_WDT_DC_RESET	(3 << 24)
 
 #define MESON_WDT_RESET		0x04
 
-#define MESON_WDT_TIMEOUT	30
+#define MESON_WDT_TIMEOUT	5
 #define MESON_WDT_MIN_TIMEOUT	1
-#define MESON_WDT_MAX_TIMEOUT	(MESON_WDT_TC_TM_MASK / 100000)
 
-#define MESON_SEC_TO_TC(s)	((s) * 100000)
+#define MESON_SEC_TO_TC(s, c)	((s) * (c))
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static unsigned int timeout = MESON_WDT_TIMEOUT;
 
+struct meson_wdt_data {
+	unsigned int shift_enable;
+	unsigned int terminal_count_mask;
+	unsigned int count_unit;
+};
+
+static struct meson_wdt_data meson6_wdt_data = {
+	.shift_enable		= 22,
+	.terminal_count_mask	= 0x3fffff,
+	.count_unit		= 100000, /* 10 us */
+};
+
 struct meson_wdt_dev {
 	struct watchdog_device wdt_dev;
 	void __iomem *wdt_base;
 	struct notifier_block restart_handler;
+	struct meson_wdt_data *data;
 };
 
 static int meson_restart_handle(struct notifier_block *this, unsigned long mode,
 				void *cmd)
 {
-	u32 tc_reboot = MESON_WDT_DC_RESET | MESON_WDT_TC_EN;
+	u32 tc_reboot = MESON_WDT_DC_RESET;
 	struct meson_wdt_dev *meson_wdt = container_of(this,
 						       struct meson_wdt_dev,
 						       restart_handler);
+	tc_reboot |= BIT(meson_wdt->data->shift_enable);
 
 	while (1) {
 		writel(tc_reboot, meson_wdt->wdt_base + MESON_WDT_TC);
@@ -80,8 +92,8 @@ static void meson_wdt_change_timeout(struct watchdog_device *wdt_dev,
 	u32 reg;
 
 	reg = readl(meson_wdt->wdt_base + MESON_WDT_TC);
-	reg &= ~MESON_WDT_TC_TM_MASK;
-	reg |= MESON_SEC_TO_TC(timeout);
+	reg &= ~(meson_wdt->data->terminal_count_mask);
+	reg |= MESON_SEC_TO_TC(timeout, meson_wdt->data->count_unit);
 	writel(reg, meson_wdt->wdt_base + MESON_WDT_TC);
 }
 
@@ -102,7 +114,7 @@ static int meson_wdt_stop(struct watchdog_device *wdt_dev)
 	u32 reg;
 
 	reg = readl(meson_wdt->wdt_base + MESON_WDT_TC);
-	reg &= ~MESON_WDT_TC_EN;
+	reg &= ~BIT(meson_wdt->data->shift_enable);
 	writel(reg, meson_wdt->wdt_base + MESON_WDT_TC);
 
 	return 0;
@@ -117,7 +129,7 @@ static int meson_wdt_start(struct watchdog_device *wdt_dev)
 	meson_wdt_ping(wdt_dev);
 
 	reg = readl(meson_wdt->wdt_base + MESON_WDT_TC);
-	reg |= MESON_WDT_TC_EN;
+	reg |= BIT(meson_wdt->data->shift_enable);
 	writel(reg, meson_wdt->wdt_base + MESON_WDT_TC);
 
 	return 0;
@@ -138,10 +150,17 @@ static const struct watchdog_ops meson_wdt_ops = {
 	.set_timeout	= meson_wdt_set_timeout,
 };
 
+static const struct of_device_id meson_wdt_dt_ids[] = {
+	{ .compatible = "amlogic,meson6-wdt", .data = &meson6_wdt_data },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, meson_wdt_dt_ids);
+
 static int meson_wdt_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct meson_wdt_dev *meson_wdt;
+	const struct of_device_id *of_id;
 	int err;
 
 	meson_wdt = devm_kzalloc(&pdev->dev, sizeof(*meson_wdt), GFP_KERNEL);
@@ -153,11 +172,19 @@ static int meson_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(meson_wdt->wdt_base))
 		return PTR_ERR(meson_wdt->wdt_base);
 
+	of_id = of_match_device(meson_wdt_dt_ids, &pdev->dev);
+	if (!of_id) {
+		dev_err(&pdev->dev, "Unable to setup WDT data\n");
+		return -ENODEV;
+	}
+	meson_wdt->data = (struct meson_wdt_data *) of_id->data;
+
 	meson_wdt->wdt_dev.parent = &pdev->dev;
 	meson_wdt->wdt_dev.info = &meson_wdt_info;
 	meson_wdt->wdt_dev.ops = &meson_wdt_ops;
 	meson_wdt->wdt_dev.timeout = MESON_WDT_TIMEOUT;
-	meson_wdt->wdt_dev.max_timeout = MESON_WDT_MAX_TIMEOUT;
+	meson_wdt->wdt_dev.max_timeout =
+		meson_wdt->data->terminal_count_mask / meson_wdt->data->count_unit;
 	meson_wdt->wdt_dev.min_timeout = MESON_WDT_MIN_TIMEOUT;
 
 	watchdog_set_drvdata(&meson_wdt->wdt_dev, meson_wdt);
@@ -204,12 +231,6 @@ static void meson_wdt_shutdown(struct platform_device *pdev)
 	meson_wdt_stop(&meson_wdt->wdt_dev);
 }
 
-static const struct of_device_id meson_wdt_dt_ids[] = {
-	{ .compatible = "amlogic,meson6-wdt" },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, meson_wdt_dt_ids);
-
 static struct platform_driver meson_wdt_driver = {
 	.probe		= meson_wdt_probe,
 	.remove		= meson_wdt_remove,
-- 
1.9.1

