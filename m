Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:54504 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755820Ab2EBSCA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 May 2012 14:02:00 -0400
Date: Wed, 2 May 2012 19:40:39 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Banajit Goswami <banajit.g@samsung.com>,
	Ben Dooks <ben-linux@fluff.org>, Ben Dooks <ben@simtec.co.uk>,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] watchdog: s3c2410-wdt: Use of_match_ptr().
Message-ID: <20120502174039.GH3074@spo001.leaseweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use of_match_ptr definition for the of_match_table.

Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

---

Can someone compile test this?

Thanks,
Wim.

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 04e5a6d..686c8fc 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -503,8 +503,6 @@ static const struct of_device_id s3c2410_wdt_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, s3c2410_wdt_match);
-#else
-#define s3c2410_wdt_match NULL
 #endif
 
 static struct platform_driver s3c2410wdt_driver = {
@@ -516,7 +514,7 @@ static struct platform_driver s3c2410wdt_driver = {
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "s3c2410-wdt",
-		.of_match_table	= s3c2410_wdt_match,
+		.of_match_table	= of_match_ptr(s3c2410_wdt_match),
 	},
 };
 
