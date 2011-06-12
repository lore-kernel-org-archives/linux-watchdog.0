Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44494 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab1FLQ4V (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 12 Jun 2011 12:56:21 -0400
Received: by wwa36 with SMTP id 36so4179010wwa.1
        for <linux-watchdog@vger.kernel.org>; Sun, 12 Jun 2011 09:56:20 -0700 (PDT)
From: Florian Fainelli <florian@openwrt.org>
To: Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	Jamie Iles <jamie@jamieiles.com>, stable@kernel.org
Subject: [PATCH 2/5 v2] WATCHDOG: mtx1-wdt: request gpio before using it
Date: Sun, 12 Jun 2011 18:56:17 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106121856.17176.florian@openwrt.org>
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

Stable: [2.6.39+]

diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 63df28c..9b63642 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -214,6 +214,12 @@ static int __devinit mtx1_wdt_probe(struct platform_device *pdev)
 	int ret;
 
 	mtx1_wdt_device.gpio = pdev->resource[0].start;
+	ret = gpio_request_one(mtx1_wdt_device.gpio,
+				GPIOF_OUT_INIT_HIGH,"mtx1-wdt");
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

