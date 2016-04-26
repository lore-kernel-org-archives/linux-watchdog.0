Return-path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: remove error message when unable to allocate watchdog device
Date: Tue, 26 Apr 2016 18:18:49 +0100
Message-Id: <1461691129-4764-1-git-send-email-colin.king@canonical.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

The dev_err message is superfluous because the failure is already
printed by dev_kzalloc, so remove it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/watchdog/jz4740_wdt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 6a7d5c3..c8d51dd 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -160,10 +160,8 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
 
 	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct jz4740_wdt_drvdata),
 			       GFP_KERNEL);
-	if (!drvdata) {
-		dev_err(&pdev->dev, "Unable to alloacate watchdog device\n");
+	if (!drvdata)
 		return -ENOMEM;
-	}
 
 	if (heartbeat < 1 || heartbeat > MAX_HEARTBEAT)
 		heartbeat = DEFAULT_HEARTBEAT;
-- 
2.7.4
