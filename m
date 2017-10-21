Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44801 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932179AbdJURr0 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 21 Oct 2017 13:47:26 -0400
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: wim@iguana.be, linux@roeck-us.net,
        maxime.ripard@free-electrons.com, wens@csie.org
Cc: linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH] watchdog: sunxi_wdt: use of_device_get_match_data
Date: Sat, 21 Oct 2017 19:45:13 +0200
Message-Id: <20171021174513.1653-1-clabbe.montjoie@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The usage of of_device_get_match_data reduce the code size a bit.
Furthermore, it prevents an improbable dereference when
of_match_device() return NULL.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/watchdog/sunxi_wdt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index 9728fa32c357..802e31b1416d 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -234,7 +234,6 @@ MODULE_DEVICE_TABLE(of, sunxi_wdt_dt_ids);
 static int sunxi_wdt_probe(struct platform_device *pdev)
 {
 	struct sunxi_wdt_dev *sunxi_wdt;
-	const struct of_device_id *device;
 	struct resource *res;
 	int err;
 
@@ -242,12 +241,10 @@ static int sunxi_wdt_probe(struct platform_device *pdev)
 	if (!sunxi_wdt)
 		return -EINVAL;
 
-	device = of_match_device(sunxi_wdt_dt_ids, &pdev->dev);
-	if (!device)
+	sunxi_wdt->wdt_regs = of_device_get_match_data(&pdev->dev);
+	if (!sunxi_wdt->wdt_regs)
 		return -ENODEV;
 
-	sunxi_wdt->wdt_regs = device->data;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sunxi_wdt->wdt_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(sunxi_wdt->wdt_base))
-- 
2.13.6

