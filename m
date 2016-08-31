Return-path: <Vladimir_Zapolskiy@mentor.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Wolfram Sang <wsa@the-dreams.de>
CC: <linux-watchdog@vger.kernel.org>
Subject: [PATCH v5 10/10] watchdog: imx2_wdt: add pretimeout function support
Date: Wed, 31 Aug 2016 14:52:50 +0300
Message-ID: <1472644370-16982-11-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1472644370-16982-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1472644370-16982-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

The change adds watchdog pretimeout notification handling to imx2_wdt
driver, if device data contains information about a valid interrupt.

It is unlikely but still possible (e.g. through a software limitation)
that only a subset of watchdogs on SoC has interrupt lines, hence
functionally the devices from these two groups have different
capabilities, and this is reflected in different watchdog_info
structs assigned to the devices.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
New change in the series.

 drivers/watchdog/imx2_wdt.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index d17643eb7683..4874b0f18650 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -24,6 +24,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -50,6 +51,11 @@
 #define IMX2_WDT_WRSR		0x04		/* Reset Status Register */
 #define IMX2_WDT_WRSR_TOUT	BIT(1)		/* -> Reset due to Timeout */
 
+#define IMX2_WDT_WICR		0x06		/* Interrupt Control Register */
+#define IMX2_WDT_WICR_WIE	BIT(15)		/* -> Interrupt Enable */
+#define IMX2_WDT_WICR_WTIS	BIT(14)		/* -> Interrupt Status */
+#define IMX2_WDT_WICR_WICT	0xFF		/* -> Interrupt Count Timeout */
+
 #define IMX2_WDT_WMCR		0x08		/* Misc Register */
 
 #define IMX2_WDT_MAX_TIME	128
@@ -80,6 +86,12 @@ static const struct watchdog_info imx2_wdt_info = {
 	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 };
 
+static const struct watchdog_info imx2_wdt_pretimeout_info = {
+	.identity = "imx2+ watchdog",
+	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE |
+		   WDIOF_PRETIMEOUT,
+};
+
 static int imx2_wdt_restart(struct watchdog_device *wdog, unsigned long action,
 			    void *data)
 {
@@ -169,6 +181,35 @@ static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
 	return 0;
 }
 
+static int imx2_wdt_set_pretimeout(struct watchdog_device *wdog,
+				   unsigned int new_pretimeout)
+{
+	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
+
+	if (new_pretimeout >= IMX2_WDT_MAX_TIME)
+		return -EINVAL;
+
+	wdog->pretimeout = new_pretimeout;
+
+	regmap_update_bits(wdev->regmap, IMX2_WDT_WICR,
+			   IMX2_WDT_WICR_WIE | IMX2_WDT_WICR_WICT,
+			   IMX2_WDT_WICR_WIE | (new_pretimeout << 1));
+	return 0;
+}
+
+static irqreturn_t imx2_wdt_isr(int irq, void *wdog_arg)
+{
+	struct watchdog_device *wdog = wdog_arg;
+	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
+
+	regmap_write_bits(wdev->regmap, IMX2_WDT_WICR,
+			  IMX2_WDT_WICR_WTIS, IMX2_WDT_WICR_WTIS);
+
+	watchdog_notify_pretimeout(wdog);
+
+	return IRQ_HANDLED;
+}
+
 static int imx2_wdt_start(struct watchdog_device *wdog)
 {
 	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
@@ -188,6 +229,7 @@ static const struct watchdog_ops imx2_wdt_ops = {
 	.start = imx2_wdt_start,
 	.ping = imx2_wdt_ping,
 	.set_timeout = imx2_wdt_set_timeout,
+	.set_pretimeout = imx2_wdt_set_pretimeout,
 	.restart = imx2_wdt_restart,
 };
 
@@ -236,6 +278,12 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	wdog->max_hw_heartbeat_ms = IMX2_WDT_MAX_TIME * 1000;
 	wdog->parent		= &pdev->dev;
 
+	ret = platform_get_irq(pdev, 0);
+	if (ret > 0)
+		if (!devm_request_irq(&pdev->dev, ret, imx2_wdt_isr, 0,
+				      dev_name(&pdev->dev), wdog))
+			wdog->info = &imx2_wdt_pretimeout_info;
+
 	ret = clk_prepare_enable(wdev->clk);
 	if (ret)
 		return ret;
-- 
2.8.1
