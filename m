Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:38717 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754399AbbGVD1I (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jul 2015 23:27:08 -0400
From: Eddie Huang <eddie.huang@mediatek.com>
To: Wim Van Sebroeck <wim@iguana.be>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
	<linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Greta Zhang <greta.zhang@mediatek.com>,
	Roger Lu <roger.lu@mediatek.com>,
	Eddie Huang <eddie.huang@mediatek.com>
Subject: [PATCH 1/2] watchdog: add wdt suspend/resume support
Date: Wed, 22 Jul 2015 11:26:49 +0800
Message-ID: <1437535610-51314-2-git-send-email-eddie.huang@mediatek.com>
In-Reply-To: <1437535610-51314-1-git-send-email-eddie.huang@mediatek.com>
References: <1437535610-51314-1-git-send-email-eddie.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Greta Zhang <greta.zhang@mediatek.com>

add wdt driver suspend/resume support

Signed-off-by: Greta Zhang <greta.zhang@mediatek.com>
Signed-off-by: Roger Lu <roger.lu@mediatek.com>
Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 drivers/watchdog/mtk_wdt.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 938b987..5ef3910 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -65,6 +65,7 @@ struct mtk_wdt_dev {
 	struct watchdog_device wdt_dev;
 	void __iomem *wdt_base;
 	struct notifier_block restart_handler;
+	bool started;
 };
 
 static int mtk_reset_handler(struct notifier_block *this, unsigned long mode,
@@ -125,6 +126,8 @@ static int mtk_wdt_stop(struct watchdog_device *wdt_dev)
 	reg &= ~WDT_MODE_EN;
 	iowrite32(reg, wdt_base + WDT_MODE);
 
+	mtk_wdt->started = false;
+
 	return 0;
 }
 
@@ -135,6 +138,8 @@ static int mtk_wdt_start(struct watchdog_device *wdt_dev)
 	void __iomem *wdt_base = mtk_wdt->wdt_base;
 	int ret;
 
+	mtk_wdt->started = true;
+
 	ret = mtk_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
 	if (ret < 0)
 		return ret;
@@ -174,6 +179,8 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mtk_wdt);
 
+	mtk_wdt->started = false;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mtk_wdt->wdt_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(mtk_wdt->wdt_base))
@@ -221,6 +228,35 @@ static int mtk_wdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int mtk_wdt_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct mtk_wdt_dev *mtk_wdt = platform_get_drvdata(pdev);
+
+	if (mtk_wdt->started) {
+		mtk_wdt_stop(&mtk_wdt->wdt_dev);
+		mtk_wdt->started = true;
+	}
+
+	return 0;
+}
+
+static int mtk_wdt_resume(struct platform_device *pdev)
+{
+	struct mtk_wdt_dev *mtk_wdt = platform_get_drvdata(pdev);
+
+	if (mtk_wdt->started) {
+		mtk_wdt_start(&mtk_wdt->wdt_dev);
+		mtk_wdt_ping(&mtk_wdt->wdt_dev);
+	}
+
+	return 0;
+}
+#else
+#define	mtk_wdt_suspend	NULL
+#define	mtk_wdt_resume	NULL
+#endif
+
 static const struct of_device_id mtk_wdt_dt_ids[] = {
 	{ .compatible = "mediatek,mt6589-wdt" },
 	{ /* sentinel */ }
@@ -230,6 +266,8 @@ MODULE_DEVICE_TABLE(of, mtk_wdt_dt_ids);
 static struct platform_driver mtk_wdt_driver = {
 	.probe		= mtk_wdt_probe,
 	.remove		= mtk_wdt_remove,
+	.suspend	= mtk_wdt_suspend,
+	.resume		= mtk_wdt_resume,
 	.driver		= {
 		.name		= DRV_NAME,
 		.of_match_table	= mtk_wdt_dt_ids,
-- 
1.8.1.1.dirty

