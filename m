Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42492 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755405Ab1FBNoa (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 2 Jun 2011 09:44:30 -0400
Received: by wya21 with SMTP id 21so607306wya.19
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Jun 2011 06:44:29 -0700 (PDT)
From: Florian Fainelli <florian@openwrt.org>
To: Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org,
	Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 1/2] WATCHDOG: mtx1-wdt: fix section mismatch
Date: Thu, 2 Jun 2011 15:44:26 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106021544.26256.florian@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 9756da9..f313d3b 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -245,7 +245,7 @@ static int __devexit mtx1_wdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver mtx1_wdt = {
+static struct platform_driver mtx1_wdt_driver = {
 	.probe = mtx1_wdt_probe,
 	.remove = __devexit_p(mtx1_wdt_remove),
 	.driver.name = "mtx1-wdt",
@@ -254,12 +254,12 @@ static struct platform_driver mtx1_wdt = {
 
 static int __init mtx1_wdt_init(void)
 {
-	return platform_driver_register(&mtx1_wdt);
+	return platform_driver_register(&mtx1_wdt_driver);
 }
 
 static void __exit mtx1_wdt_exit(void)
 {
-	platform_driver_unregister(&mtx1_wdt);
+	platform_driver_unregister(&mtx1_wdt_driver);
 }
 
 module_init(mtx1_wdt_init);
-- 
1.7.4.1

