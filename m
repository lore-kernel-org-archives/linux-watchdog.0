Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58508 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065AbaCNMSt (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Mar 2014 08:18:49 -0400
Date: Fri, 14 Mar 2014 13:18:47 +0100
From: Jean Delvare <jdelvare@suse.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH] watchdog: ib700wdt: Use platform_driver_probe
Message-ID: <20140314131847.5e27fe11@endymion.delvare>
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
 drivers/watchdog/ib700wdt.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

--- linux-3.14-rc6.orig/drivers/watchdog/ib700wdt.c	2014-01-20 03:40:07.000000000 +0100
+++ linux-3.14-rc6/drivers/watchdog/ib700wdt.c	2014-03-13 15:31:38.097211632 +0100
@@ -277,7 +277,7 @@ static struct miscdevice ibwdt_miscdev =
  *	Init & exit routines
  */
 
-static int ibwdt_probe(struct platform_device *dev)
+static int __init ibwdt_probe(struct platform_device *dev)
 {
 	int res;
 
@@ -336,7 +336,6 @@ static void ibwdt_shutdown(struct platfo
 }
 
 static struct platform_driver ibwdt_driver = {
-	.probe		= ibwdt_probe,
 	.remove		= ibwdt_remove,
 	.shutdown	= ibwdt_shutdown,
 	.driver		= {
@@ -351,21 +350,19 @@ static int __init ibwdt_init(void)
 
 	pr_info("WDT driver for IB700 single board computer initialising\n");
 
-	err = platform_driver_register(&ibwdt_driver);
-	if (err)
-		return err;
-
 	ibwdt_platform_device = platform_device_register_simple(DRV_NAME,
 								-1, NULL, 0);
-	if (IS_ERR(ibwdt_platform_device)) {
-		err = PTR_ERR(ibwdt_platform_device);
-		goto unreg_platform_driver;
-	}
+	if (IS_ERR(ibwdt_platform_device))
+		return PTR_ERR(ibwdt_platform_device);
+
+	err = platform_driver_probe(&ibwdt_driver, ibwdt_probe);
+	if (err)
+		goto unreg_platform_device;
 
 	return 0;
 
-unreg_platform_driver:
-	platform_driver_unregister(&ibwdt_driver);
+unreg_platform_device:
+	platform_device_unregister(ibwdt_platform_device);
 	return err;
 }
 


-- 
Jean Delvare
SUSE L3 Support
