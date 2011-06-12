Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42929 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab1FLQ4f (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 12 Jun 2011 12:56:35 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so2756954wya.19
        for <linux-watchdog@vger.kernel.org>; Sun, 12 Jun 2011 09:56:34 -0700 (PDT)
From: Florian Fainelli <florian@openwrt.org>
To: Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH 4/5 v2] WATCHDOG: mtx1-wdt: fix section mismatch
Date: Sun, 12 Jun 2011 18:56:32 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106121856.32317.florian@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
No changes since v1

diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 0e51dca..c5f6e72 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -248,7 +248,7 @@ static int __devexit mtx1_wdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver mtx1_wdt = {
+static struct platform_driver mtx1_wdt_driver = {
 	.probe = mtx1_wdt_probe,
 	.remove = __devexit_p(mtx1_wdt_remove),
 	.driver.name = "mtx1-wdt",
@@ -257,12 +257,12 @@ static struct platform_driver mtx1_wdt = {
 
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

