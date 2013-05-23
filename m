Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:38786 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758260Ab3EWKok (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 May 2013 06:44:40 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 4/5] watchdog: riowd: use platform_{get,set}_drvdata()
Date: Thu, 23 May 2013 19:44:38 +0900
Message-id: <003701ce57a2$864a0740$92de15c0$@samsung.com>
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
 drivers/watchdog/riowd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/riowd.c b/drivers/watchdog/riowd.c
index 0040451..4f99f12 100644
--- a/drivers/watchdog/riowd.c
+++ b/drivers/watchdog/riowd.c
@@ -206,7 +206,7 @@ static int riowd_probe(struct platform_device *op)
 	pr_info("Hardware watchdog [%i minutes], regs at %p\n",
 		riowd_timeout, p->regs);
 
-	dev_set_drvdata(&op->dev, p);
+	platform_set_drvdata(op, p);
 	return 0;
 
 out_iounmap:
@@ -222,7 +222,7 @@ out:
 
 static int riowd_remove(struct platform_device *op)
 {
-	struct riowd *p = dev_get_drvdata(&op->dev);
+	struct riowd *p = platform_get_drvdata(op);
 
 	misc_deregister(&riowd_miscdev);
 	of_iounmap(&op->resource[0], p->regs, 2);
-- 
1.7.10.4


