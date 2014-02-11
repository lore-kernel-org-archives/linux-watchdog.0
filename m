Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:18359 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbaBKMoO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Feb 2014 07:44:14 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0U00L5L0PPFB60@mailout4.samsung.com> for
 linux-watchdog@vger.kernel.org; Tue, 11 Feb 2014 21:44:13 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Jingoo Han' <jg1.han@samsung.com>,
	'Aaro Koskinen' <aaro.koskinen@iki.fi>
References: <000e01cf2726$a511a030$ef34e090$%han@samsung.com>
In-reply-to: <000e01cf2726$a511a030$ef34e090$%han@samsung.com>
Subject: [PATCH 2/3] watchdog: omap_wdt: Use devm_ioremap_resource()
Date: Tue, 11 Feb 2014 21:44:12 +0900
Message-id: <000f01cf2726$f7500210$e5f00630$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use devm_ioremap_resource() in order to make the code simpler,
and remove 'struct resource *mem' from 'struct omap_wdt_dev'
and omap_wdt_probe(), resplectively. because the 'mem' variables
are not used anymore. Also the redundant return value check of
platform_get_resource() is removed, because the value is checked
by devm_ioremap_resource().

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/omap_wdt.c |   22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 09cf013..40269dd 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -58,7 +58,6 @@ struct omap_wdt_dev {
 	void __iomem    *base;          /* physical */
 	struct device   *dev;
 	bool		omap_wdt_users;
-	struct resource *mem;
 	int		wdt_trgr_pattern;
 	struct mutex	lock;		/* to avoid races with PM */
 };
@@ -207,7 +206,7 @@ static int omap_wdt_probe(struct platform_device *pdev)
 {
 	struct omap_wd_timer_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct watchdog_device *omap_wdt;
-	struct resource *res, *mem;
+	struct resource *res;
 	struct omap_wdt_dev *wdev;
 	u32 rs;
 	int ret;
@@ -216,29 +215,20 @@ static int omap_wdt_probe(struct platform_device *pdev)
 	if (!omap_wdt)
 		return -ENOMEM;
 
-	/* reserve static register mappings */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENOENT;
-
-	mem = devm_request_mem_region(&pdev->dev, res->start,
-				      resource_size(res), pdev->name);
-	if (!mem)
-		return -EBUSY;
-
 	wdev = devm_kzalloc(&pdev->dev, sizeof(*wdev), GFP_KERNEL);
 	if (!wdev)
 		return -ENOMEM;
 
 	wdev->omap_wdt_users	= false;
-	wdev->mem		= mem;
 	wdev->dev		= &pdev->dev;
 	wdev->wdt_trgr_pattern	= 0x1234;
 	mutex_init(&wdev->lock);
 
-	wdev->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!wdev->base)
-		return -ENOMEM;
+	/* reserve static register mappings */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	wdev->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(wdev->base))
+		return PTR_ERR(wdev->base);
 
 	omap_wdt->info	      = &omap_wdt_info;
 	omap_wdt->ops	      = &omap_wdt_ops;
-- 
1.7.10.4


