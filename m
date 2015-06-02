Return-path: <jthumshirn@suse.de>
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] watchdog: mena21_wdt: Fix possible NULL pointer dereference
Date: Tue,  2 Jun 2015 12:25:26 +0200
Message-Id: <1433240726-7031-1-git-send-email-jthumshirn@suse.de>
List-ID: <linux-watchdog@vger.kernel.org>

In a21_wdt_remove() we do a watchdog_unregister_device() on struct
a21_wdt_drv->wdt but never assign it.

Also move the dev_set_drvdata() call in front of the watchdog_register_device()
call, so it doesn't look like an error.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/watchdog/mena21_wdt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/mena21_wdt.c b/drivers/watchdog/mena21_wdt.c
index 96dbba9..d193a5e 100644
--- a/drivers/watchdog/mena21_wdt.c
+++ b/drivers/watchdog/mena21_wdt.c
@@ -208,14 +208,15 @@ static int a21_wdt_probe(struct platform_device *pdev)
 	else if (reset == 7)
 		a21_wdt.bootstatus |= WDIOF_EXTERN2;
 
+	drv->wdt = a21_wdt;
+	dev_set_drvdata(&pdev->dev, drv);
+
 	ret = watchdog_register_device(&a21_wdt);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot register watchdog device\n");
 		goto err_register_wd;
 	}
 
-	dev_set_drvdata(&pdev->dev, drv);
-
 	dev_info(&pdev->dev, "MEN A21 watchdog timer driver enabled\n");
 
 	return 0;
-- 
2.4.1
