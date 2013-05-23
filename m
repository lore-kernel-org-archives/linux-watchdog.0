Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:54277 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757967Ab3EWKnp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 May 2013 06:43:45 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH 1/5] watchdog: cpwd: use platform_{get,set}_drvdata()
Date: Thu, 23 May 2013 19:43:43 +0900
Message-id: <003401ce57a2$658fbb80$30af3280$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use the wrapper functions for getting and setting the driver data using
platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
so we can directly pass a struct platform_device.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/cpwd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 7038758..213225e 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -621,7 +621,7 @@ static int cpwd_probe(struct platform_device *op)
 			WD_BADMODEL);
 	}
 
-	dev_set_drvdata(&op->dev, p);
+	platform_set_drvdata(op, p);
 	cpwd_device = p;
 	err = 0;
 
@@ -642,7 +642,7 @@ out_free:
 
 static int cpwd_remove(struct platform_device *op)
 {
-	struct cpwd *p = dev_get_drvdata(&op->dev);
+	struct cpwd *p = platform_get_drvdata(op);
 	int i;
 
 	for (i = 0; i < WD_NUMDEVS; i++) {
-- 
1.7.10.4


