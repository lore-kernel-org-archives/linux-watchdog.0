Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59411 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab1FORLI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 15 Jun 2011 13:11:08 -0400
Received: by wwa36 with SMTP id 36so681775wwa.1
        for <linux-watchdog@vger.kernel.org>; Wed, 15 Jun 2011 10:11:07 -0700 (PDT)
From: Florian Fainelli <florian@openwrt.org>
To: Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 2/5 v3] WATCHDOG: mtx1-wdt: request gpio before using it
Date: Wed, 15 Jun 2011 19:15:23 +0200
Cc: linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	Jamie Iles <jamie@jamieiles.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106151915.24007.florian@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Otherwise, the gpiolib autorequest feature will produce a WARN_ON():

WARNING: at drivers/gpio/gpiolib.c:101 0x8020ec6c()
autorequest GPIO-215
[...]

CC:stable@kernel.org
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v1:
- use gpio_request_one()
- added missing gpio_free() in mtx1_wdt_remove

Changes since v2:
- added space between GPIOF_OUT_INIT_HIGH and "mtx1-wdt"

diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 63df28c..b93926e 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -214,6 +214,12 @@ static int __devinit mtx1_wdt_probe(struct platform_device *pdev)
 	int ret;
 
 	mtx1_wdt_device.gpio = pdev->resource[0].start;
+	ret = gpio_request_one(mtx1_wdt_device.gpio,
+				GPIOF_OUT_INIT_HIGH, "mtx1-wdt");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to request gpio");
+		return ret;
+	}
 
 	spin_lock_init(&mtx1_wdt_device.lock);
 	init_completion(&mtx1_wdt_device.stop);
@@ -239,6 +245,8 @@ static int __devexit mtx1_wdt_remove(struct platform_device *pdev)
 		mtx1_wdt_device.queue = 0;
 		wait_for_completion(&mtx1_wdt_device.stop);
 	}
+
+	gpio_free(mtx1_wdt_device.gpio);
 	misc_deregister(&mtx1_wdt_misc);
 	return 0;
 }
-- 
1.7.4.1

