Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57815 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933510Ab1FBMyW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 2 Jun 2011 08:54:22 -0400
Received: by wya21 with SMTP id 21so574689wya.19
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Jun 2011 05:54:21 -0700 (PDT)
From: Florian Fainelli <florian@openwrt.org>
To: Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org,
	Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 2/3] WATCHDOG: mtx1-wdt: request gpio before using it
Date: Thu, 2 Jun 2011 14:54:20 +0200
Cc: stable@kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106021454.20111.florian@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Otherwise, the gpiolib autorequest feature will produce a WARN_ON():

WARNING: at drivers/gpio/gpiolib.c:101 0x8020ec6c()
autorequest GPIO-215
[...]

CC: stable@kernel.org
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 63df28c..16086f8 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -214,6 +214,11 @@ static int __devinit mtx1_wdt_probe(struct platform_device *pdev)
 	int ret;
 
 	mtx1_wdt_device.gpio = pdev->resource[0].start;
+	ret = gpio_request(mtx1_wdt_device.gpio, "mtx1-wdt");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to request gpio");
+		return ret;
+	}
 
 	spin_lock_init(&mtx1_wdt_device.lock);
 	init_completion(&mtx1_wdt_device.stop);
-- 
1.7.4.1

