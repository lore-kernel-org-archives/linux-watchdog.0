Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:20003 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbbBKKZe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 11 Feb 2015 05:25:34 -0500
Date: Wed, 11 Feb 2015 13:26:21 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	linux-watchdog@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] watchdog: mtk_wdt: signedness bug in mtk_wdt_start()
Message-ID: <20150211102621.GC18515@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

"ret" should be signed for the error handling to work correctly.  This
doesn't matter much in real life since mtk_wdt_set_timeout() always
succeeds.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index a87f6df..938b987 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -133,7 +133,7 @@ static int mtk_wdt_start(struct watchdog_device *wdt_dev)
 	u32 reg;
 	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdt_dev);
 	void __iomem *wdt_base = mtk_wdt->wdt_base;
-	u32 ret;
+	int ret;
 
 	ret = mtk_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
 	if (ret < 0)
