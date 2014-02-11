Return-Path: <jg1.han@samsung.com>
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, 'Guenter Roeck' <linux@roeck-us.net>,
 'Jingoo Han' <jg1.han@samsung.com>, patches@opensource.wolfsonmicro.com
References: <000101cf26f5$06c21760$14464620$%han@samsung.com>
In-reply-to: <000101cf26f5$06c21760$14464620$%han@samsung.com>
Subject: [PATCH 8/8] watchdog: wm831x: Remove unnecessary OOM messages
Date: Tue, 11 Feb 2014 15:56:13 +0900
Message-id: <000901cf26f6$5a28d730$0e7a8590$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
List-ID: <linux-watchdog@vger.kernel.org>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/wm831x_wdt.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/wm831x_wdt.c b/drivers/watchdog/wm831x_wdt.c
index e243bd0..2fa17e7 100644
--- a/drivers/watchdog/wm831x_wdt.c
+++ b/drivers/watchdog/wm831x_wdt.c
@@ -204,7 +204,6 @@ static int wm831x_wdt_probe(struct platform_device *pdev)
 	driver_data = devm_kzalloc(&pdev->dev, sizeof(*driver_data),
 				   GFP_KERNEL);
 	if (!driver_data) {
-		dev_err(wm831x->dev, "Unable to alloacate watchdog device\n");
 		ret = -ENOMEM;
 		goto err;
 	}
-- 
1.7.10.4
