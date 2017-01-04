Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/4] watchdog: coh901327_wdt: Simplify error handling in probe function
Date: Tue,  3 Jan 2017 19:25:40 -0800
Message-Id: <1483500343-27113-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Checking if there is no error followed by a goto if there is one is
confusing. Reverse the logic.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/coh901327_wdt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
index a099b77fc0b9..dc97b2fd6c49 100644
--- a/drivers/watchdog/coh901327_wdt.c
+++ b/drivers/watchdog/coh901327_wdt.c
@@ -360,12 +360,10 @@ static int __init coh901327_probe(struct platform_device *pdev)
 
 	coh901327_wdt.parent = &pdev->dev;
 	ret = watchdog_register_device(&coh901327_wdt);
-	if (ret == 0)
-		dev_info(&pdev->dev,
-			 "initialized. timer margin=%d sec\n", margin);
-	else
+	if (ret)
 		goto out_no_wdog;
 
+	dev_info(&pdev->dev, "initialized. timer margin=%d sec\n", margin);
 	return 0;
 
 out_no_wdog:
-- 
2.7.4
