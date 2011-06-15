Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59411 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172Ab1FORLh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 15 Jun 2011 13:11:37 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so681775wwa.1
        for <linux-watchdog@vger.kernel.org>; Wed, 15 Jun 2011 10:11:37 -0700 (PDT)
From: Florian Fainelli <florian@openwrt.org>
To: Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 4/5 v3] WATCHDOG: mtx1-wdt: fix section mismatch
Date: Wed, 15 Jun 2011 19:15:52 +0200
Cc: linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	Jamie Iles <jamie@jamieiles.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106151915.52793.florian@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
No changes in v1, v2 and v3

diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 4b0134e..03cab33 100644
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

