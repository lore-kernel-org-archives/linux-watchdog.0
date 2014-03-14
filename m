Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58205 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754203AbaCNMEk (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Mar 2014 08:04:40 -0400
Date: Fri, 14 Mar 2014 13:04:37 +0100
From: Jean Delvare <jdelvare@suse.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH] watchdog: acquirewdt: Use platform_driver_probe
Message-ID: <20140314130437.0774fb75@endymion.delvare>
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
 drivers/watchdog/acquirewdt.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

--- linux-3.14-rc6.orig/drivers/watchdog/acquirewdt.c	2014-01-20 03:40:07.000000000 +0100
+++ linux-3.14-rc6/drivers/watchdog/acquirewdt.c	2014-03-14 10:32:39.208535731 +0100
@@ -239,7 +239,7 @@ static struct miscdevice acq_miscdev = {
  *	Init & exit routines
  */
 
-static int acq_probe(struct platform_device *dev)
+static int __init acq_probe(struct platform_device *dev)
 {
 	int ret;
 
@@ -291,7 +291,6 @@ static void acq_shutdown(struct platform
 }
 
 static struct platform_driver acquirewdt_driver = {
-	.probe		= acq_probe,
 	.remove		= acq_remove,
 	.shutdown	= acq_shutdown,
 	.driver		= {
@@ -306,20 +305,18 @@ static int __init acq_init(void)
 
 	pr_info("WDT driver for Acquire single board computer initialising\n");
 
-	err = platform_driver_register(&acquirewdt_driver);
-	if (err)
-		return err;
-
 	acq_platform_device = platform_device_register_simple(DRV_NAME,
 								-1, NULL, 0);
-	if (IS_ERR(acq_platform_device)) {
-		err = PTR_ERR(acq_platform_device);
-		goto unreg_platform_driver;
-	}
+	if (IS_ERR(acq_platform_device))
+		return PTR_ERR(acq_platform_device);
+
+	err = platform_driver_probe(&acquirewdt_driver, acq_probe);
+	if (err)
+		goto unreg_platform_device;
 	return 0;
 
-unreg_platform_driver:
-	platform_driver_unregister(&acquirewdt_driver);
+unreg_platform_device:
+	platform_device_unregister(acq_platform_device);
 	return err;
 }
 


-- 
Jean Delvare
SUSE L3 Support
