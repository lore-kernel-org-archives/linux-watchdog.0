Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:61111 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755000AbbBTXp5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Feb 2015 18:45:57 -0500
Received: by mail-wi0-f175.google.com with SMTP id r20so6238888wiv.2
        for <linux-watchdog@vger.kernel.org>; Fri, 20 Feb 2015 15:45:56 -0800 (PST)
From: James Hogan <james.hogan@imgtec.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Cc: James Hogan <james@albanarts.com>,
	James Hogan <james.hogan@imgtec.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Naidu Tellapati <Naidu.Tellapati@imgtec.com>,
	Jude Abraham <Jude.Abraham@imgtec.com>
Subject: [PATCH 1/2] watchdog: imgpdc: Fix probe NULL pointer dereference
Date: Fri, 20 Feb 2015 23:45:44 +0000
Message-Id: <1424475945-30009-2-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1424475945-30009-1-git-send-email-james.hogan@imgtec.com>
References: <1424475945-30009-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The IMG PDC watchdog probe function calls pdc_wdt_stop() prior to
watchdog_set_drvdata(), causing a NULL pointer dereference when
pdc_wdt_stop() retrieves the struct pdc_wdt_dev pointer using
watchdog_get_drvdata() and reads the register base address through it.

Fix by moving the watchdog_set_drvdata() call earlier, to where various
other pdc_wdt->wdt_dev fields are initialised.

Fixes: 93937669e9b5 ("watchdog: ImgTec PDC Watchdog Timer Driver")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Cc: Jude Abraham <Jude.Abraham@imgtec.com>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/imgpdc_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index c8def68..32c35eb 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -191,6 +191,7 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 	pdc_wdt->wdt_dev.ops = &pdc_wdt_ops;
 	pdc_wdt->wdt_dev.max_timeout = 1 << PDC_WDT_CONFIG_DELAY_MASK;
 	pdc_wdt->wdt_dev.parent = &pdev->dev;
+	watchdog_set_drvdata(&pdc_wdt->wdt_dev, pdc_wdt);
 
 	ret = watchdog_init_timeout(&pdc_wdt->wdt_dev, heartbeat, &pdev->dev);
 	if (ret < 0) {
@@ -232,7 +233,6 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(&pdc_wdt->wdt_dev, nowayout);
 
 	platform_set_drvdata(pdev, pdc_wdt);
-	watchdog_set_drvdata(&pdc_wdt->wdt_dev, pdc_wdt);
 
 	ret = watchdog_register_device(&pdc_wdt->wdt_dev);
 	if (ret)
-- 
2.0.5

