Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36034 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbcKQWnt (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 17 Nov 2016 17:43:49 -0500
Received: by mail-wm0-f65.google.com with SMTP id m203so277395wma.3
        for <linux-watchdog@vger.kernel.org>; Thu, 17 Nov 2016 14:43:48 -0800 (PST)
From: Fernando Ramos <bocadillodeatun@gmail.com>
To: fernando@gluegarage.com
Cc: James Hogan <james.hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        Naidu Tellapati <Naidu.Tellapati@imgtec.com>,
        Jude Abraham <Jude.Abraham@imgtec.com>,
        linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 2/3] watchdog: imgpdc: Fix probe NULL pointer dereference
Date: Thu, 17 Nov 2016 23:43:39 +0100
Message-Id: <20161117224340.7908-2-fernando@gluegarage.com>
In-Reply-To: <20161117224340.7908-1-fernando@gluegarage.com>
References: <20161117224340.7908-1-fernando@gluegarage.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: James Hogan <james.hogan@imgtec.com>

The IMG PDC watchdog probe function calls pdc_wdt_stop() prior to
watchdog_set_drvdata(), causing a NULL pointer dereference when
pdc_wdt_stop() retrieves the struct pdc_wdt_dev pointer using
watchdog_get_drvdata() and reads the register base address through it.

Fix by moving the watchdog_set_drvdata() call earlier, to where various
other pdc_wdt->wdt_dev fields are initialised.

Fixes: 93937669e9b5 ("watchdog: ImgTec PDC Watchdog Timer Driver")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Cc: Jude Abraham <Jude.Abraham@imgtec.com>
Cc: linux-watchdog@vger.kernel.org
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
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
2.10.2

