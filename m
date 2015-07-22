Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:50480 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932480AbbGVD1K (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jul 2015 23:27:10 -0400
From: Eddie Huang <eddie.huang@mediatek.com>
To: Wim Van Sebroeck <wim@iguana.be>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
	<linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Greta Zhang <greta.zhang@mediatek.com>,
	Eddie Huang <eddie.huang@mediatek.com>
Subject: [PATCH 2/2] watchdog: add wdt shutdown callback to disable wdt if enabled
Date: Wed, 22 Jul 2015 11:26:50 +0800
Message-ID: <1437535610-51314-3-git-send-email-eddie.huang@mediatek.com>
In-Reply-To: <1437535610-51314-1-git-send-email-eddie.huang@mediatek.com>
References: <1437535610-51314-1-git-send-email-eddie.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Greta Zhang <greta.zhang@mediatek.com>

Without .shutdown(), watchdog might reset the system during power off.
For example, if watchdog's timeout is set to 30s, then it is reset to
zero by mtk_wdt_ping(). During power off, no app will ping watchdog,
but watchdog is still running and may trigger reset.

Signed-off-by: Greta Zhang <greta.zhang@mediatek.com>
Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 drivers/watchdog/mtk_wdt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 5ef3910..c6741a5 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -217,6 +217,14 @@ static int mtk_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static void mtk_wdt_shutdown(struct platform_device *pdev)
+{
+	struct mtk_wdt_dev *mtk_wdt = platform_get_drvdata(pdev);
+
+	if (mtk_wdt->started)
+		mtk_wdt_stop(&mtk_wdt->wdt_dev);
+}
+
 static int mtk_wdt_remove(struct platform_device *pdev)
 {
 	struct mtk_wdt_dev *mtk_wdt = platform_get_drvdata(pdev);
@@ -266,6 +274,7 @@ MODULE_DEVICE_TABLE(of, mtk_wdt_dt_ids);
 static struct platform_driver mtk_wdt_driver = {
 	.probe		= mtk_wdt_probe,
 	.remove		= mtk_wdt_remove,
+	.shutdown	= mtk_wdt_shutdown,
 	.suspend	= mtk_wdt_suspend,
 	.resume		= mtk_wdt_resume,
 	.driver		= {
-- 
1.8.1.1.dirty

