Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:57116 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752003Ab2CLEYR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Mar 2012 00:24:17 -0400
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, <w.sang@pengutronix.de>,
	<sshtylyov@mvista.com>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2 20/22] watchdog/sp805: Use devm routines
Date: Mon, 12 Mar 2012 09:52:15 +0530
Message-ID: <5b951b210d14db05858e7fccb4d184df9a56a719.1331524811.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

sp805 driver currently uses normal kzalloc, ioremap, etc routines. This patch
replaces these routines with devm_kzalloc and devm_request_mem_region etc, so
that we don't need to handle freeing of resources for error cases and module
removal routine.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/sp805_wdt.c |   35 +++++++++++++----------------------
 1 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 1291960..859d8b0 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -285,32 +285,33 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	int ret = 0;
 
-	if (!request_mem_region(adev->res.start, resource_size(&adev->res),
-				"sp805_wdt")) {
+	if (!devm_request_mem_region(&adev->dev, adev->res.start,
+				resource_size(&adev->res), "sp805_wdt")) {
 		dev_warn(&adev->dev, "Failed to get memory region resource\n");
 		ret = -ENOENT;
 		goto err;
 	}
 
-	wdt = kzalloc(sizeof(*wdt), GFP_KERNEL);
+	wdt = devm_kzalloc(&adev->dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt) {
 		dev_warn(&adev->dev, "Kzalloc failed\n");
 		ret = -ENOMEM;
-		goto err_kzalloc;
+		goto err;
+	}
+
+	wdt->base = devm_ioremap(&adev->dev, adev->res.start,
+			resource_size(&adev->res));
+	if (!wdt->base) {
+		ret = -ENOMEM;
+		dev_warn(&adev->dev, "ioremap fail\n");
+		goto err;
 	}
 
 	wdt->clk = clk_get(&adev->dev, NULL);
 	if (IS_ERR(wdt->clk)) {
 		dev_warn(&adev->dev, "Clock not found\n");
 		ret = PTR_ERR(wdt->clk);
-		goto err_clk_get;
-	}
-
-	wdt->base = ioremap(adev->res.start, resource_size(&adev->res));
-	if (!wdt->base) {
-		ret = -ENOMEM;
-		dev_warn(&adev->dev, "ioremap fail\n");
-		goto err_ioremap;
+		goto err;
 	}
 
 	wdt->adev = adev;
@@ -327,14 +328,7 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 	return 0;
 
 err_misc_register:
-	iounmap(wdt->base);
-err_ioremap:
 	clk_put(wdt->clk);
-err_clk_get:
-	kfree(wdt);
-	wdt = NULL;
-err_kzalloc:
-	release_mem_region(adev->res.start, resource_size(&adev->res));
 err:
 	dev_err(&adev->dev, "Probe Failed!!!\n");
 	return ret;
@@ -343,10 +337,7 @@ err:
 static int __devexit sp805_wdt_remove(struct amba_device *adev)
 {
 	misc_deregister(&sp805_wdt_miscdev);
-	iounmap(wdt->base);
 	clk_put(wdt->clk);
-	kfree(wdt);
-	release_mem_region(adev->res.start, resource_size(&adev->res));
 
 	return 0;
 }
-- 
1.7.8.110.g4cb5d

