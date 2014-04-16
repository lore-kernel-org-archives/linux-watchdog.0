Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:56996 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbaDPJo7 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 16 Apr 2014 05:44:59 -0400
From: Gabor Juhos <juhosg@openwrt.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] watchdog: ath79_wdt: switch to clk_prepare/clk_disable
Date: Wed, 16 Apr 2014 11:35:50 +0200
Message-Id: <1397640950-21859-1-git-send-email-juhosg@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Replace clk_enable() and clk_disable() calls with
clk_prepare_enable() and clk_disable_unprepare()
to get ready for the migration to the common clock
framework.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 drivers/watchdog/ath79_wdt.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index 0e67d96..41ac466 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -265,7 +265,7 @@ static int ath79_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(wdt_clk))
 		return PTR_ERR(wdt_clk);
 
-	err = clk_enable(wdt_clk);
+	err = clk_prepare_enable(wdt_clk);
 	if (err)
 		return err;
 
@@ -296,14 +296,14 @@ static int ath79_wdt_probe(struct platform_device *pdev)
 	return 0;
 
 err_clk_disable:
-	clk_disable(wdt_clk);
+	clk_disable_unprepare(wdt_clk);
 	return err;
 }
 
 static int ath79_wdt_remove(struct platform_device *pdev)
 {
 	misc_deregister(&ath79_wdt_miscdev);
-	clk_disable(wdt_clk);
+	clk_disable_unprepare(wdt_clk);
 	return 0;
 }
 
-- 
1.7.10
