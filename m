Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from m12-15.163.com ([220.181.12.15]:60662 "EHLO m12-15.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753222AbcGSLXe (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Jul 2016 07:23:34 -0400
From: Wei Yongjun <weiyj_lk@163.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH -next] watchdog: core: Fix error handling of watchdog_dev_init()
Date: Tue, 19 Jul 2016 11:22:34 +0000
Message-Id: <1468927354-32155-1-git-send-email-weiyj_lk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix the error handling paths of watchdog_dev_init().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/watchdog/watchdog_dev.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 14f8a92..f6e6751 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -952,17 +952,22 @@ int __init watchdog_dev_init(void)
 	err = class_register(&watchdog_class);
 	if (err < 0) {
 		pr_err("couldn't register class\n");
-		return err;
+		goto err_register;
 	}
 
 	err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
 	if (err < 0) {
 		pr_err("watchdog: unable to allocate char dev region\n");
-		class_unregister(&watchdog_class);
-		return err;
+		goto err_alloc;
 	}
 
 	return 0;
+
+err_alloc:
+	class_unregister(&watchdog_class);
+err_register:
+	destroy_workqueue(watchdog_wq);
+	return err;
 }
 
 /*


