Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:47094 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753348AbeAJMN1 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 10 Jan 2018 07:13:27 -0500
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To: linux-kernel@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH 2/2] watchdog: mt7621: switch to using managed devm_watchdog_register_device()
Date: Wed, 10 Jan 2018 12:13:23 +0000
Message-Id: <20180110121323.17657-2-git@andred.net>
In-Reply-To: <20180110121323.17657-1-git@andred.net>
References: <20180110121323.17657-1-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This does the necessary cleanup on driver unload automatically.

Signed-off-by: André Draszik <git@andred.net>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Cc: John Crispin <john@phrozen.org>
---
 drivers/watchdog/mt7621_wdt.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
index 0eabea2d88a2..a04f49309188 100644
--- a/drivers/watchdog/mt7621_wdt.c
+++ b/drivers/watchdog/mt7621_wdt.c
@@ -133,7 +133,6 @@ static struct watchdog_device mt7621_wdt_dev = {
 static int mt7621_wdt_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mt7621_wdt_base = devm_ioremap_resource(&pdev->dev, res);
@@ -161,16 +160,7 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
 		set_bit(WDOG_HW_RUNNING, &mt7621_wdt_dev.status);
 	}
 
-	ret = watchdog_register_device(&mt7621_wdt_dev);
-
-	return 0;
-}
-
-static int mt7621_wdt_remove(struct platform_device *pdev)
-{
-	watchdog_unregister_device(&mt7621_wdt_dev);
-
-	return 0;
+	return devm_watchdog_register_device(&pdev->dev, &mt7621_wdt_dev);
 }
 
 static void mt7621_wdt_shutdown(struct platform_device *pdev)
@@ -186,7 +176,6 @@ MODULE_DEVICE_TABLE(of, mt7621_wdt_match);
 
 static struct platform_driver mt7621_wdt_driver = {
 	.probe		= mt7621_wdt_probe,
-	.remove		= mt7621_wdt_remove,
 	.shutdown	= mt7621_wdt_shutdown,
 	.driver		= {
 		.name		= KBUILD_MODNAME,
-- 
2.15.1

