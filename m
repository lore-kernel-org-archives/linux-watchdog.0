Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:44583
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932254Ab3HNJLr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 14 Aug 2013 05:11:47 -0400
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: kernel-janitors@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 19/29] watchdog: ts72xx_wdt: simplify use of devm_ioremap_resource
Date: Wed, 14 Aug 2013 11:11:23 +0200
Message-Id: <1376471493-22215-20-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1376471493-22215-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1376471493-22215-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Remove unneeded error handling on the result of a call to
platform_get_resource when the value is passed to devm_ioremap_resource.

A simplified version of the semantic patch that makes this change is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression pdev,res,n,e,e1;
expression ret != 0;
identifier l;
@@

- res = platform_get_resource(pdev, IORESOURCE_MEM, n);
  ... when != res
- if (res == NULL) { ... \(goto l;\|return ret;\) }
  ... when != res
+ res = platform_get_resource(pdev, IORESOURCE_MEM, n);
  e = devm_ioremap_resource(e1, res);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/watchdog/ts72xx_wdt.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
index 4da59b4..42913f1 100644
--- a/drivers/watchdog/ts72xx_wdt.c
+++ b/drivers/watchdog/ts72xx_wdt.c
@@ -403,21 +403,11 @@ static int ts72xx_wdt_probe(struct platform_device *pdev)
 	}
 
 	r1 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r1) {
-		dev_err(&pdev->dev, "failed to get memory resource\n");
-		return -ENODEV;
-	}
-
 	wdt->control_reg = devm_ioremap_resource(&pdev->dev, r1);
 	if (IS_ERR(wdt->control_reg))
 		return PTR_ERR(wdt->control_reg);
 
 	r2 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!r2) {
-		dev_err(&pdev->dev, "failed to get memory resource\n");
-		return -ENODEV;
-	}
-
 	wdt->feed_reg = devm_ioremap_resource(&pdev->dev, r2);
 	if (IS_ERR(wdt->feed_reg))
 		return PTR_ERR(wdt->feed_reg);

