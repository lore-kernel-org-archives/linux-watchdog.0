Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:45764 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751536Ab2CGK3i (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 05:29:38 -0500
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH 13/15] watchdog/mpcore_wdt: Allow platform_get_irq() to fail
Date: Wed, 7 Mar 2012 15:57:54 +0530
Message-ID: <df548cd74c18aaf00b42cb2976a6b274a4b95c56.1331115752.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331115751.git.viresh.kumar@st.com>
References: <cover.1331115751.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

irq is not necessary for mpcore wdt. Don't return error if it is not passed. But
if it is passed, then request_irq must pass.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/mpcore_wdt.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 6a04e31..ebd964a 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -334,20 +334,20 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	wdt->dev = &pdev->dev;
-	wdt->irq = platform_get_irq(pdev, 0);
-	if (wdt->irq < 0)
-		return -ENXIO;
 
 	wdt->base = devm_ioremap(wdt->dev, res->start, resource_size(res));
 	if (!wdt->base)
 		return -ENOMEM;
 
-	ret = devm_request_irq(wdt->dev, wdt->irq, mpcore_wdt_fire, 0,
-			"mpcore_wdt", wdt);
-	if (ret) {
-		dev_printk(KERN_ERR, wdt->dev,
-			"cannot register IRQ%d for watchdog\n", wdt->irq);
-		return ret;
+	wdt->irq = platform_get_irq(pdev, 0);
+	if (wdt->irq >= 0) {
+		ret = devm_request_irq(wdt->dev, wdt->irq, mpcore_wdt_fire, 0,
+				"mpcore_wdt", wdt);
+		if (ret) {
+			dev_printk(KERN_ERR, wdt->dev,
+					"cannot register IRQ%d for watchdog\n", wdt->irq);
+			return ret;
+		}
 	}
 
 	/*
-- 
1.7.8.110.g4cb5d

