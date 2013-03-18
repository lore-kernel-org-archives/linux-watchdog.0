Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:55327 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab3CRHdk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Mar 2013 03:33:40 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJU0092PIBX0HU0@mailout3.samsung.com> for
 linux-watchdog@vger.kernel.org; Mon, 18 Mar 2013 16:33:33 +0900 (KST)
Received: from DOJG1HAN02 ([12.23.120.99])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MJU00EIXIBWDN00@mmp1.samsung.com> for
 linux-watchdog@vger.kernel.org; Mon, 18 Mar 2013 16:33:33 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH 1/7] watchdog: at32ap700x_wdt: use devm_*() functions
Date: Mon, 18 Mar 2013 16:33:32 +0900
Message-id: <01ad01ce23aa$e49c8b00$add5a100$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use devm_*() functions to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/at32ap700x_wdt.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/at32ap700x_wdt.c b/drivers/watchdog/at32ap700x_wdt.c
index 7a715e3..c4cb552 100644
--- a/drivers/watchdog/at32ap700x_wdt.c
+++ b/drivers/watchdog/at32ap700x_wdt.c
@@ -321,13 +321,14 @@ static int __init at32_wdt_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	wdt = kzalloc(sizeof(struct wdt_at32ap700x), GFP_KERNEL);
+	wdt = devm_kzalloc(&pdev->dev, sizeof(struct wdt_at32ap700x),
+			GFP_KERNEL);
 	if (!wdt) {
 		dev_dbg(&pdev->dev, "no memory for wdt structure\n");
 		return -ENOMEM;
 	}
 
-	wdt->regs = ioremap(regs->start, resource_size(regs));
+	wdt->regs = devm_ioremap(&pdev->dev, regs->start, resource_size(regs));
 	if (!wdt->regs) {
 		ret = -ENOMEM;
 		dev_dbg(&pdev->dev, "could not map I/O memory\n");
@@ -342,7 +343,7 @@ static int __init at32_wdt_probe(struct platform_device *pdev)
 		dev_info(&pdev->dev, "CPU must be reset with external "
 				"reset or POR due to silicon errata.\n");
 		ret = -EIO;
-		goto err_iounmap;
+		goto err_free;
 	} else {
 		wdt->users = 0;
 	}
@@ -375,10 +376,7 @@ static int __init at32_wdt_probe(struct platform_device *pdev)
 
 err_register:
 	platform_set_drvdata(pdev, NULL);
-err_iounmap:
-	iounmap(wdt->regs);
 err_free:
-	kfree(wdt);
 	wdt = NULL;
 	return ret;
 }
@@ -391,8 +389,6 @@ static int __exit at32_wdt_remove(struct platform_device *pdev)
 			at32_wdt_stop();
 
 		misc_deregister(&wdt->miscdev);
-		iounmap(wdt->regs);
-		kfree(wdt);
 		wdt = NULL;
 		platform_set_drvdata(pdev, NULL);
 	}
-- 
1.7.2.5


