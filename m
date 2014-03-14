Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58454 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754338AbaCNMQu (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Mar 2014 08:16:50 -0400
Date: Fri, 14 Mar 2014 13:16:47 +0100
From: Jean Delvare <jdelvare@suse.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH] watchdog: geodewdt: Use platform_driver_probe
Message-ID: <20140314131647.60c51274@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Using platform_driver_probe instead of platform_driver_register has
two benefits:
* The driver will fail to load if device probing fails.
* The probe function can be marked __init.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
 drivers/watchdog/geodewdt.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

--- linux-3.14-rc6.orig/drivers/watchdog/geodewdt.c	2014-01-20 03:40:07.000000000 +0100
+++ linux-3.14-rc6/drivers/watchdog/geodewdt.c	2014-03-14 10:41:42.415355724 +0100
@@ -215,7 +215,7 @@ static struct miscdevice geodewdt_miscde
 	.fops = &geodewdt_fops,
 };
 
-static int geodewdt_probe(struct platform_device *dev)
+static int __init geodewdt_probe(struct platform_device *dev)
 {
 	int ret;
 
@@ -255,7 +255,6 @@ static void geodewdt_shutdown(struct pla
 }
 
 static struct platform_driver geodewdt_driver = {
-	.probe		= geodewdt_probe,
 	.remove		= geodewdt_remove,
 	.shutdown	= geodewdt_shutdown,
 	.driver		= {
@@ -268,20 +267,18 @@ static int __init geodewdt_init(void)
 {
 	int ret;
 
-	ret = platform_driver_register(&geodewdt_driver);
-	if (ret)
-		return ret;
-
 	geodewdt_platform_device = platform_device_register_simple(DRV_NAME,
 								-1, NULL, 0);
-	if (IS_ERR(geodewdt_platform_device)) {
-		ret = PTR_ERR(geodewdt_platform_device);
+	if (IS_ERR(geodewdt_platform_device))
+		return PTR_ERR(geodewdt_platform_device);
+
+	ret = platform_driver_probe(&geodewdt_driver, geodewdt_probe);
+	if (ret)
 		goto err;
-	}
 
 	return 0;
 err:
-	platform_driver_unregister(&geodewdt_driver);
+	platform_device_unregister(geodewdt_platform_device);
 	return ret;
 }
 


-- 
Jean Delvare
SUSE L3 Support
