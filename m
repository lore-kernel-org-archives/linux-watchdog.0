Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:58460 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752957Ab2L0Oia (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Dec 2012 09:38:30 -0500
From: Gabor Juhos <juhosg@openwrt.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 1/3] watchdog: ath79_wdt: convert to use devm_clk_get
Date: Thu, 27 Dec 2012 15:38:24 +0100
Message-Id: <1356619106-13403-1-git-send-email-juhosg@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use the managed version of clk_get. This allows to
simplify the probe/remove functions a bit.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 drivers/watchdog/ath79_wdt.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index 38a999e..dcd18ec 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -229,13 +229,13 @@ static int ath79_wdt_probe(struct platform_device *pdev)
 	u32 ctrl;
 	int err;
 
-	wdt_clk = clk_get(&pdev->dev, "wdt");
+	wdt_clk = devm_clk_get(&pdev->dev, "wdt");
 	if (IS_ERR(wdt_clk))
 		return PTR_ERR(wdt_clk);
 
 	err = clk_enable(wdt_clk);
 	if (err)
-		goto err_clk_put;
+		return err;
 
 	wdt_freq = clk_get_rate(wdt_clk);
 	if (!wdt_freq) {
@@ -265,8 +265,6 @@ static int ath79_wdt_probe(struct platform_device *pdev)
 
 err_clk_disable:
 	clk_disable(wdt_clk);
-err_clk_put:
-	clk_put(wdt_clk);
 	return err;
 }
 
@@ -274,7 +272,6 @@ static int ath79_wdt_remove(struct platform_device *pdev)
 {
 	misc_deregister(&ath79_wdt_miscdev);
 	clk_disable(wdt_clk);
-	clk_put(wdt_clk);
 	return 0;
 }
 
-- 
1.7.10

