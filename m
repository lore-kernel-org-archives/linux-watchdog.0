Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49919 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273Ab2KCHKV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 3 Nov 2012 03:10:21 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2892607pbb.19
        for <linux-watchdog@vger.kernel.org>; Sat, 03 Nov 2012 00:10:20 -0700 (PDT)
From: Devendra Naga <devendra.aaru@gmail.com>
To: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>,
	Wim Van sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Cc: Devendra Naga <devendra.aaru@gmail.com>
Subject: [PATCH] watchdog: at32watchdog: use devm_kzalloc
Date: Sat,  3 Nov 2012 03:10:12 -0400
Message-Id: <1351926612-8002-1-git-send-email-devendra.aaru@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

use the devm_kzalloc and no need of error path free's

Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
---
 drivers/watchdog/at32ap700x_wdt.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/at32ap700x_wdt.c b/drivers/watchdog/at32ap700x_wdt.c
index 2896430..dc2e312 100644
--- a/drivers/watchdog/at32ap700x_wdt.c
+++ b/drivers/watchdog/at32ap700x_wdt.c
@@ -321,7 +321,7 @@ static int __init at32_wdt_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	wdt = kzalloc(sizeof(struct wdt_at32ap700x), GFP_KERNEL);
+	wdt = devm_kzalloc(&pdev->dev, sizeof(struct wdt_at32ap700x), GFP_KERNEL);
 	if (!wdt) {
 		dev_dbg(&pdev->dev, "no memory for wdt structure\n");
 		return -ENOMEM;
@@ -329,9 +329,8 @@ static int __init at32_wdt_probe(struct platform_device *pdev)
 
 	wdt->regs = ioremap(regs->start, resource_size(regs));
 	if (!wdt->regs) {
-		ret = -ENOMEM;
 		dev_dbg(&pdev->dev, "could not map I/O memory\n");
-		goto err_free;
+		return -ENOMEM;
 	}
 
 	spin_lock_init(&wdt->io_lock);
@@ -377,9 +376,6 @@ err_register:
 	platform_set_drvdata(pdev, NULL);
 err_iounmap:
 	iounmap(wdt->regs);
-err_free:
-	kfree(wdt);
-	wdt = NULL;
 	return ret;
 }
 
@@ -392,8 +388,6 @@ static int __exit at32_wdt_remove(struct platform_device *pdev)
 
 		misc_deregister(&wdt->miscdev);
 		iounmap(wdt->regs);
-		kfree(wdt);
-		wdt = NULL;
 		platform_set_drvdata(pdev, NULL);
 	}
 	return 0;
-- 
1.7.10.4

