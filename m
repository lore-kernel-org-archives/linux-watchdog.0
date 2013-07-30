Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:55066 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020Ab3G3H5y (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 30 Jul 2013 03:57:54 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH 03/35] watchdog: use dev_get_platdata()
Date: Tue, 30 Jul 2013 16:57:52 +0900
Message-id: <003501ce8cfa$7e12ff90$7a38feb0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/iTCO_wdt.c         |    2 +-
 drivers/watchdog/mv64x60_wdt.c      |    2 +-
 drivers/watchdog/omap_wdt.c         |    3 ++-
 drivers/watchdog/rdc321x_wdt.c      |    2 +-
 drivers/watchdog/stmp3xxx_rtc_wdt.c |    4 ++--
 drivers/watchdog/ux500_wdt.c        |    2 +-
 drivers/watchdog/wm831x_wdt.c       |    8 +++-----
 7 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 6130321..439b160 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -394,7 +394,7 @@ static int iTCO_wdt_probe(struct platform_device *dev)
 {
 	int ret = -ENODEV;
 	unsigned long val32;
-	struct lpc_ich_info *ich_info = dev->dev.platform_data;
+	struct lpc_ich_info *ich_info = dev_get_platdata(&dev->dev);
 
 	if (!ich_info)
 		goto out;
diff --git a/drivers/watchdog/mv64x60_wdt.c b/drivers/watchdog/mv64x60_wdt.c
index e4cf980..2f2ff19 100644
--- a/drivers/watchdog/mv64x60_wdt.c
+++ b/drivers/watchdog/mv64x60_wdt.c
@@ -255,7 +255,7 @@ static struct miscdevice mv64x60_wdt_miscdev = {
 
 static int mv64x60_wdt_probe(struct platform_device *dev)
 {
-	struct mv64x60_wdt_pdata *pdata = dev->dev.platform_data;
+	struct mv64x60_wdt_pdata *pdata = dev_get_platdata(&dev->dev);
 	struct resource *r;
 	int timeout = 10;
 
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index af88ffd..2cd5218 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -205,7 +205,8 @@ static const struct watchdog_ops omap_wdt_ops = {
 
 static int omap_wdt_probe(struct platform_device *pdev)
 {
-	struct omap_wd_timer_platform_data *pdata = pdev->dev.platform_data;
+	struct omap_wd_timer_platform_data *pdata =
+			dev_get_platdata(&pdev->dev);
 	struct watchdog_device *omap_wdt;
 	struct resource *res, *mem;
 	struct omap_wdt_dev *wdev;
diff --git a/drivers/watchdog/rdc321x_wdt.c b/drivers/watchdog/rdc321x_wdt.c
index b0f116c..8d5facd 100644
--- a/drivers/watchdog/rdc321x_wdt.c
+++ b/drivers/watchdog/rdc321x_wdt.c
@@ -231,7 +231,7 @@ static int rdc321x_wdt_probe(struct platform_device *pdev)
 	struct resource *r;
 	struct rdc321x_wdt_pdata *pdata;
 
-	pdata = pdev->dev.platform_data;
+	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata) {
 		dev_err(&pdev->dev, "no platform data supplied\n");
 		return -ENODEV;
diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index c97e98d..7bf8c50 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -30,7 +30,7 @@ MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat period in seconds from 1 to "
 static int wdt_start(struct watchdog_device *wdd)
 {
 	struct device *dev = watchdog_get_drvdata(wdd);
-	struct stmp3xxx_wdt_pdata *pdata = dev->platform_data;
+	struct stmp3xxx_wdt_pdata *pdata = dev_get_platdata(dev);
 
 	pdata->wdt_set_timeout(dev->parent, wdd->timeout * WDOG_TICK_RATE);
 	return 0;
@@ -39,7 +39,7 @@ static int wdt_start(struct watchdog_device *wdd)
 static int wdt_stop(struct watchdog_device *wdd)
 {
 	struct device *dev = watchdog_get_drvdata(wdd);
-	struct stmp3xxx_wdt_pdata *pdata = dev->platform_data;
+	struct stmp3xxx_wdt_pdata *pdata = dev_get_platdata(dev);
 
 	pdata->wdt_set_timeout(dev->parent, 0);
 	return 0;
diff --git a/drivers/watchdog/ux500_wdt.c b/drivers/watchdog/ux500_wdt.c
index a614d84..d9af934 100644
--- a/drivers/watchdog/ux500_wdt.c
+++ b/drivers/watchdog/ux500_wdt.c
@@ -88,7 +88,7 @@ static struct watchdog_device ux500_wdt = {
 static int ux500_wdt_probe(struct platform_device *pdev)
 {
 	int ret;
-	struct ux500_wdt_data *pdata = pdev->dev.platform_data;
+	struct ux500_wdt_data *pdata = dev_get_platdata(&pdev->dev);
 
 	if (pdata) {
 		if (pdata->timeout > 0)
diff --git a/drivers/watchdog/wm831x_wdt.c b/drivers/watchdog/wm831x_wdt.c
index d4e47ed..e243bd0 100644
--- a/drivers/watchdog/wm831x_wdt.c
+++ b/drivers/watchdog/wm831x_wdt.c
@@ -184,7 +184,7 @@ static const struct watchdog_ops wm831x_wdt_ops = {
 static int wm831x_wdt_probe(struct platform_device *pdev)
 {
 	struct wm831x *wm831x = dev_get_drvdata(pdev->dev.parent);
-	struct wm831x_pdata *chip_pdata;
+	struct wm831x_pdata *chip_pdata = dev_get_platdata(pdev->dev.parent);
 	struct wm831x_watchdog_pdata *pdata;
 	struct wm831x_wdt_drvdata *driver_data;
 	struct watchdog_device *wm831x_wdt;
@@ -231,12 +231,10 @@ static int wm831x_wdt_probe(struct platform_device *pdev)
 		wm831x_wdt->timeout = wm831x_wdt_cfgs[i].time;
 
 	/* Apply any configuration */
-	if (pdev->dev.parent->platform_data) {
-		chip_pdata = pdev->dev.parent->platform_data;
+	if (chip_pdata)
 		pdata = chip_pdata->watchdog;
-	} else {
+	else
 		pdata = NULL;
-	}
 
 	if (pdata) {
 		reg &= ~(WM831X_WDOG_SECACT_MASK | WM831X_WDOG_PRIMACT_MASK |
-- 
1.7.10.4


