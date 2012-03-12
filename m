Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:53668 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751346Ab2CLEXU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Mar 2012 00:23:20 -0400
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, <w.sang@pengutronix.de>,
	<sshtylyov@mvista.com>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2 05/22] watchdog/mpcore_wdt: Allow platform_get_irq() to fail
Date: Mon, 12 Mar 2012 09:52:00 +0530
Message-ID: <d086dbc044d530c9db101898d7e7e8d25d91c984.1331524811.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
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
index 63bd161..1d2f1a1 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -344,15 +344,15 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 
 	wdt->dev = &pdev->dev;
 	wdt->irq = platform_get_irq(pdev, 0);
-	if (wdt->irq < 0)
-		return -ENXIO;
-
-	ret = devm_request_irq(wdt->dev, wdt->irq, mpcore_wdt_fire, 0,
-			"mpcore_wdt", wdt);
-	if (ret) {
-		dev_printk(KERN_ERR, wdt->dev,
-			"cannot register IRQ%d for watchdog\n", wdt->irq);
-		return ret;
+	if (wdt->irq >= 0) {
+		ret = devm_request_irq(wdt->dev, wdt->irq, mpcore_wdt_fire, 0,
+				"mpcore_wdt", wdt);
+		if (ret) {
+			dev_printk(KERN_ERR, wdt->dev,
+					"cannot register IRQ%d for watchdog\n",
+					wdt->irq);
+			return ret;
+		}
 	}
 
 	wdt->base = devm_ioremap(wdt->dev, res->start, resource_size(res));
-- 
1.7.8.110.g4cb5d

