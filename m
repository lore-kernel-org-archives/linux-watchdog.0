Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39755 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab1JQRri (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 17 Oct 2011 13:47:38 -0400
Received: by wyg36 with SMTP id 36so2471376wyg.19
        for <linux-watchdog@vger.kernel.org>; Mon, 17 Oct 2011 10:47:37 -0700 (PDT)
From: Florian Fainelli <florian@openwrt.org>
To: Wim Van Sebroeck <wim@iguana.be>, Greg KH <gregkh@suse.de>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH -stable] watchdog: mtx1-wdt: fix build failure
Date: Mon, 17 Oct 2011 19:47:44 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201110171947.44673.florian@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Commit 6d86a0ee (watchdog: mtx1-wdt: request gpio before using it) was
backported from upstream. The patch is using a gpiolib call which is only
available in kernel 2.6.34+. Fix build by using the "old" gpiolib API
instead.

CC: stable@kernel.org
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
This patch is applicable from 2.6.32+ to 2.6.33+ included.

diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index e797a2c..c9dbe11 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -211,13 +211,14 @@ static int __devinit mtx1_wdt_probe(struct platform_device *pdev)
 	int ret;
 
 	mtx1_wdt_device.gpio = pdev->resource[0].start;
-	ret = gpio_request_one(mtx1_wdt_device.gpio,
-				GPIOF_OUT_INIT_HIGH, "mtx1-wdt");
+	ret = gpio_request(mtx1_wdt_device.gpio, "mtx1-wdt");
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request gpio");
 		return ret;
 	}
 
+	gpio_direction_output(mtx1_wdt_device.gpio, 1);
+
 	spin_lock_init(&mtx1_wdt_device.lock);
 	init_completion(&mtx1_wdt_device.stop);
 	mtx1_wdt_device.queue = 0;
-- 
1.7.5.4


-- 
Florian
