Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35982 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544AbbGWUY5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 Jul 2015 16:24:57 -0400
Received: by qkdv3 with SMTP id v3so2383649qkd.3
        for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2015 13:24:57 -0700 (PDT)
From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To: <linux-watchdog@vger.kernel.org>
Cc: Andrew Bresticker <abrestic@chromium.org>,
	Naidu.Tellapati@imgtec.com,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH] watchdog: imgpdc: Unregister restart handler on remove
Date: Thu, 23 Jul 2015 17:21:16 -0300
Message-Id: <1437682876-1561-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Commit c631f20068 ("watchdog: imgpdc: Add reboot support") introduced
a restart handler but forgot to unregister it on driver removal. Fix it.

Fixes: c631f20068 ("watchdog: imgpdc: Add reboot support")
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
Build test only.

 drivers/watchdog/imgpdc_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index 0f73621..15ab072 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -316,6 +316,7 @@ static int pdc_wdt_remove(struct platform_device *pdev)
 {
 	struct pdc_wdt_dev *pdc_wdt = platform_get_drvdata(pdev);
 
+	unregister_restart_handler(&pdc_wdt->restart_handler);
 	pdc_wdt_stop(&pdc_wdt->wdt_dev);
 	watchdog_unregister_device(&pdc_wdt->wdt_dev);
 	clk_disable_unprepare(pdc_wdt->wdt_clk);
-- 
2.4.6

