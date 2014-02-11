Return-Path: <jg1.han@samsung.com>
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, 'Guenter Roeck' <linux@roeck-us.net>,
 'Jingoo Han' <jg1.han@samsung.com>, 'Stephen Warren' <swarren@wwwdotorg.org>,
 'Lubomir Rintel' <lkundrak@v3.sk>
References: <000101cf26f5$06c21760$14464620$%han@samsung.com>
In-reply-to: <000101cf26f5$06c21760$14464620$%han@samsung.com>
Subject: [PATCH 2/8] watchdog: bcm2835: Remove unnecessary OOM messages
Date: Tue, 11 Feb 2014 15:50:08 +0900
Message-id: <000301cf26f5$808d4a60$81a7df20$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
List-ID: <linux-watchdog@vger.kernel.org>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/bcm2835_wdt.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index cafa973..8df450c 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -114,10 +114,8 @@ static int bcm2835_wdt_probe(struct platform_device *pdev)
 	int err;
 
 	wdt = devm_kzalloc(dev, sizeof(struct bcm2835_wdt), GFP_KERNEL);
-	if (!wdt) {
-		dev_err(dev, "Failed to allocate memory for watchdog device");
+	if (!wdt)
 		return -ENOMEM;
-	}
 	platform_set_drvdata(pdev, wdt);
 
 	spin_lock_init(&wdt->lock);
-- 
1.7.10.4
