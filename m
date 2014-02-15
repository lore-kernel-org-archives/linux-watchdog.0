Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from fallback2.mail.ru ([94.100.176.87]:52515 "EHLO
	fallback2.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbaBOJX2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Feb 2014 04:23:28 -0500
Received: from smtp48.i.mail.ru (smtp48.i.mail.ru [94.100.177.108])
	by fallback2.mail.ru (mPOP.Fallback_MX) with ESMTP id BCA0AFE9FD20
	for <linux-watchdog@vger.kernel.org>; Sat, 15 Feb 2014 13:23:25 +0400 (MSK)
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] watchdog: shwdt: Remove unused variable
Date: Sat, 15 Feb 2014 13:23:07 +0400
Message-Id: <1392456187-30082-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Variable "wdt" is not used anywhere in the function sh_wdt_remove().
This patch removes this variable.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/watchdog/shwdt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
index af3528f..d04d02b 100644
--- a/drivers/watchdog/shwdt.c
+++ b/drivers/watchdog/shwdt.c
@@ -293,8 +293,6 @@ static int sh_wdt_probe(struct platform_device *pdev)
 
 static int sh_wdt_remove(struct platform_device *pdev)
 {
-	struct sh_wdt *wdt = platform_get_drvdata(pdev);
-
 	watchdog_unregister_device(&sh_wdt_dev);
 
 	pm_runtime_disable(&pdev->dev);
-- 
1.8.3.2

