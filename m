Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65201 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933510Ab1FBMyV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 2 Jun 2011 08:54:21 -0400
Received: by wya21 with SMTP id 21so574669wya.19
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Jun 2011 05:54:20 -0700 (PDT)
From: Florian Fainelli <florian@openwrt.org>
To: Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org,
	Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 1/3] WATCHDOG: mtx1-wdt: use dev_{err,info} instead of printk()
Date: Thu, 2 Jun 2011 14:54:17 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106021454.17652.florian@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 1479dc4..63df28c 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -224,11 +224,11 @@ static int __devinit mtx1_wdt_probe(struct platform_device *pdev)
 
 	ret = misc_register(&mtx1_wdt_misc);
 	if (ret < 0) {
-		printk(KERN_ERR " mtx-1_wdt : failed to register\n");
+		dev_err(&pdev->dev, "failed to register\n");
 		return ret;
 	}
 	mtx1_wdt_start();
-	printk(KERN_INFO "MTX-1 Watchdog driver\n");
+	dev_info(&pdev->dev, "MTX-1 Watchdog driver\n");
 	return 0;
 }
 
-- 
1.7.4.1

