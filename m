Return-path: <eddie.huang@mediatek.com>
From: Eddie Huang <eddie.huang@mediatek.com>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
	<linux-watchdog@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Sascha
 Hauer <kernel@pengutronix.de>, Greta Zhang <greta.zhang@mediatek.com>, Roger
 Lu <roger.lu@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>
Subject: [PATCH v2 1/2] watchdog: add wdt suspend/resume support
Date: Thu, 23 Jul 2015 13:49:10 +0800
Message-ID: <1437630551-39650-2-git-send-email-eddie.huang@mediatek.com>
In-Reply-To: <1437630551-39650-1-git-send-email-eddie.huang@mediatek.com>
References: <1437630551-39650-1-git-send-email-eddie.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

From: Greta Zhang <greta.zhang@mediatek.com>

add wdt driver suspend/resume support

Signed-off-by: Greta Zhang <greta.zhang@mediatek.com>
Signed-off-by: Roger Lu <roger.lu@mediatek.com>
Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 drivers/watchdog/mtk_wdt.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 938b987..056412c 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -221,17 +221,47 @@ static int mtk_wdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int mtk_wdt_suspend(struct device *dev)
+{
+	struct mtk_wdt_dev *mtk_wdt = dev_get_drvdata(dev);
+
+	if (watchdog_active(&mtk_wdt->wdt_dev))
+		mtk_wdt_stop(&mtk_wdt->wdt_dev);
+
+	return 0;
+}
+
+static int mtk_wdt_resume(struct device *dev)
+{
+	struct mtk_wdt_dev *mtk_wdt = dev_get_drvdata(dev);
+
+	if (watchdog_active(&mtk_wdt->wdt_dev)) {
+		mtk_wdt_start(&mtk_wdt->wdt_dev);
+		mtk_wdt_ping(&mtk_wdt->wdt_dev);
+	}
+
+	return 0;
+}
+#endif
+
 static const struct of_device_id mtk_wdt_dt_ids[] = {
 	{ .compatible = "mediatek,mt6589-wdt" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mtk_wdt_dt_ids);
 
+static const struct dev_pm_ops mtk_wdt_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(mtk_wdt_suspend,
+				mtk_wdt_resume)
+};
+
 static struct platform_driver mtk_wdt_driver = {
 	.probe		= mtk_wdt_probe,
 	.remove		= mtk_wdt_remove,
 	.driver		= {
 		.name		= DRV_NAME,
+		.pm		= &mtk_wdt_pm_ops,
 		.of_match_table	= mtk_wdt_dt_ids,
 	},
 };
-- 
1.8.1.1.dirty
