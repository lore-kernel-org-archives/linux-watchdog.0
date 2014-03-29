Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from fallback5.mail.ru ([94.100.176.59]:59937 "EHLO
	fallback5.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbaC2K3U (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 29 Mar 2014 06:29:20 -0400
Received: from smtp2.mail.ru (smtp2.mail.ru [94.100.176.130])
	by fallback5.mail.ru (mPOP.Fallback_MX) with ESMTP id E277711213A38
	for <linux-watchdog@vger.kernel.org>; Sat, 29 Mar 2014 14:29:18 +0400 (MSK)
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] watchdog: shwdt: Remove unused platform_set_drvdata()
Date: Sat, 29 Mar 2014 14:29:00 +0400
Message-Id: <1396088940-9224-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch removes platform_set_drvdata() which is not used in
the driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/watchdog/shwdt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
index d04d02b..061756e 100644
--- a/drivers/watchdog/shwdt.c
+++ b/drivers/watchdog/shwdt.c
@@ -282,8 +282,6 @@ static int sh_wdt_probe(struct platform_device *pdev)
 	wdt->timer.data		= (unsigned long)wdt;
 	wdt->timer.expires	= next_ping_period(clock_division_ratio);
 
-	platform_set_drvdata(pdev, wdt);
-
 	dev_info(&pdev->dev, "initialized.\n");
 
 	pm_runtime_enable(&pdev->dev);
-- 
1.8.3.2

