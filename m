Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35353 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbbKRCp0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 17 Nov 2015 21:45:26 -0500
Received: by pacej9 with SMTP id ej9so28480504pac.2
        for <linux-watchdog@vger.kernel.org>; Tue, 17 Nov 2015 18:45:26 -0800 (PST)
From: Nicolas Boichat <drinkcat@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: mtk_wdt: Use MODE_KEY when stopping the watchdog
Date: Wed, 18 Nov 2015 10:45:01 +0800
Message-Id: <1447814701-23504-1-git-send-email-drinkcat@chromium.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

WDT_MODE value need to be or-ed with MODE_KEY when setting
watchdog mode. Add it to mtk_wdt_stop function, so that the
watchdog can be stopped (e.g. during suspend).

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/watchdog/mtk_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 6ad9df9..b751f43 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -123,6 +123,7 @@ static int mtk_wdt_stop(struct watchdog_device *wdt_dev)
 
 	reg = readl(wdt_base + WDT_MODE);
 	reg &= ~WDT_MODE_EN;
+	reg |= WDT_MODE_KEY;
 	iowrite32(reg, wdt_base + WDT_MODE);
 
 	return 0;
-- 
2.6.0.rc2.230.g3dd15c0

