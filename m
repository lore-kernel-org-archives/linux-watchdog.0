Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:36890 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751437Ab2FLRT1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 12 Jun 2012 13:19:27 -0400
From: Linus Walleij <linus.walleij@stericsson.com>
To: Wim Van Sebroeck <wim@iguana.be>, <linux-watchdog@vger.kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] watchdog: coh901327_wdt: use clk_prepare/unprepare
Date: Tue, 12 Jun 2012 19:19:01 +0200
Message-ID: <1339521541-30183-1-git-send-email-linus.walleij@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

Make sure we prepare/unprepare the COH901327 watchdog timer
as is required by the clk API especially if you use common
clock.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/watchdog/coh901327_wdt.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
index 6876430..cb5da5c 100644
--- a/drivers/watchdog/coh901327_wdt.c
+++ b/drivers/watchdog/coh901327_wdt.c
@@ -263,6 +263,7 @@ static int __exit coh901327_remove(struct platform_device *pdev)
 	watchdog_unregister_device(&coh901327_wdt);
 	coh901327_disable();
 	free_irq(irq, pdev);
+	clk_unprepare(clk);
 	clk_put(clk);
 	iounmap(virtbase);
 	release_mem_region(phybase, physize);
@@ -300,9 +301,9 @@ static int __init coh901327_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "could not get clock\n");
 		goto out_no_clk;
 	}
-	ret = clk_enable(clk);
+	ret = clk_prepare_enable(clk);
 	if (ret) {
-		dev_err(&pdev->dev, "could not enable clock\n");
+		dev_err(&pdev->dev, "could not prepare and enable clock\n");
 		goto out_no_clk_enable;
 	}
 
@@ -369,7 +370,7 @@ static int __init coh901327_probe(struct platform_device *pdev)
 out_no_wdog:
 	free_irq(irq, pdev);
 out_no_irq:
-	clk_disable(clk);
+	clk_disable_unprepare(clk);
 out_no_clk_enable:
 	clk_put(clk);
 out_no_clk:
-- 
1.7.9.2

