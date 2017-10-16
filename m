Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:52110 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755144AbdJPU4w (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 16 Oct 2017 16:56:52 -0400
Received: by mail-lf0-f41.google.com with SMTP id r129so18496637lff.8
        for <linux-watchdog@vger.kernel.org>; Mon, 16 Oct 2017 13:56:51 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/5 v2] watchdog: ftwdt010: Make interrupt optional
Date: Mon, 16 Oct 2017 22:54:25 +0200
Message-Id: <20171016205427.4297-3-linus.walleij@linaro.org>
In-Reply-To: <20171016205427.4297-1-linus.walleij@linaro.org>
References: <20171016205427.4297-1-linus.walleij@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The Moxart does not appear to be using the interrupt from the
watchdog timer, maybe it's not even routed, so as to support
more architectures with this driver, make the interrupt
optional.

While we are at it: actually enable the use of the interrupt
if present by setting the right bit in the control register
and define the missing control register bits.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Fix surplus flag assignment of enable |= WDCR_CLOCK_5MHZ
---
 drivers/watchdog/ftwdt010_wdt.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/ftwdt010_wdt.c b/drivers/watchdog/ftwdt010_wdt.c
index 637ffd812f0b..a9c2912ee280 100644
--- a/drivers/watchdog/ftwdt010_wdt.c
+++ b/drivers/watchdog/ftwdt010_wdt.c
@@ -30,6 +30,8 @@
 #define WDRESTART_MAGIC		0x5AB9
 
 #define WDCR_CLOCK_5MHZ		BIT(4)
+#define WDCR_WDEXT		BIT(3)
+#define WDCR_WDINTR		BIT(2)
 #define WDCR_SYS_RST		BIT(1)
 #define WDCR_ENABLE		BIT(0)
 
@@ -39,6 +41,7 @@ struct ftwdt010_wdt {
 	struct watchdog_device	wdd;
 	struct device		*dev;
 	void __iomem		*base;
+	bool			has_irq;
 };
 
 static inline
@@ -50,14 +53,17 @@ struct ftwdt010_wdt *to_ftwdt010_wdt(struct watchdog_device *wdd)
 static int ftwdt010_wdt_start(struct watchdog_device *wdd)
 {
 	struct ftwdt010_wdt *gwdt = to_ftwdt010_wdt(wdd);
+	u32 enable;
 
 	writel(wdd->timeout * WDT_CLOCK, gwdt->base + FTWDT010_WDLOAD);
 	writel(WDRESTART_MAGIC, gwdt->base + FTWDT010_WDRESTART);
 	/* set clock before enabling */
-	writel(WDCR_CLOCK_5MHZ | WDCR_SYS_RST,
-			gwdt->base + FTWDT010_WDCR);
-	writel(WDCR_CLOCK_5MHZ | WDCR_SYS_RST | WDCR_ENABLE,
-			gwdt->base + FTWDT010_WDCR);
+	enable = WDCR_CLOCK_5MHZ | WDCR_SYS_RST;
+	writel(enable, gwdt->base + FTWDT010_WDCR);
+	if (gwdt->has_irq)
+		enable |= WDCR_WDINTR;
+	enable |= WDCR_ENABLE;
+	writel(enable, gwdt->base + FTWDT010_WDCR);
 
 	return 0;
 }
@@ -133,10 +139,6 @@ static int ftwdt010_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(gwdt->base))
 		return PTR_ERR(gwdt->base);
 
-	irq = platform_get_irq(pdev, 0);
-	if (!irq)
-		return -EINVAL;
-
 	gwdt->dev = dev;
 	gwdt->wdd.info = &ftwdt010_wdt_info;
 	gwdt->wdd.ops = &ftwdt010_wdt_ops;
@@ -158,10 +160,14 @@ static int ftwdt010_wdt_probe(struct platform_device *pdev)
 		writel(reg, gwdt->base + FTWDT010_WDCR);
 	}
 
-	ret = devm_request_irq(dev, irq, ftwdt010_wdt_interrupt, 0,
-			       "watchdog bark", gwdt);
-	if (ret)
-		return ret;
+	irq = platform_get_irq(pdev, 0);
+	if (irq) {
+		ret = devm_request_irq(dev, irq, ftwdt010_wdt_interrupt, 0,
+				       "watchdog bark", gwdt);
+		if (ret)
+			return ret;
+		gwdt->has_irq = true;
+	}
 
 	ret = devm_watchdog_register_device(dev, &gwdt->wdd);
 	if (ret) {
-- 
2.13.6

