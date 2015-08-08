Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46033 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078AbbHHFDI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 8 Aug 2015 01:03:08 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 6/8] watchdog: retu: Convert to use infrastructure triggered keepalives
Date: Fri,  7 Aug 2015 22:02:45 -0700
Message-Id: <1439010167-13818-7-git-send-email-linux@roeck-us.net>
In-Reply-To: <1439010167-13818-1-git-send-email-linux@roeck-us.net>
References: <1439010167-13818-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog infrastructure now supports handling watchdog keepalive
if the watchdog is running while the watchdog device is closed.
Convert the driver to use this infrastructure.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: No changes
---
 drivers/watchdog/retu_wdt.c | 78 ++++-----------------------------------------
 1 file changed, 7 insertions(+), 71 deletions(-)

diff --git a/drivers/watchdog/retu_wdt.c b/drivers/watchdog/retu_wdt.c
index b7c68e275aeb..ce2982a7670c 100644
--- a/drivers/watchdog/retu_wdt.c
+++ b/drivers/watchdog/retu_wdt.c
@@ -28,69 +28,22 @@
 /* Watchdog timer values in seconds */
 #define RETU_WDT_MAX_TIMER	63
 
-struct retu_wdt_dev {
-	struct retu_dev		*rdev;
-	struct device		*dev;
-	struct delayed_work	ping_work;
-};
-
-/*
- * Since Retu watchdog cannot be disabled in hardware, we must kick it
- * with a timer until userspace watchdog software takes over. If
- * CONFIG_WATCHDOG_NOWAYOUT is set, we never start the feeding.
- */
-static void retu_wdt_ping_enable(struct retu_wdt_dev *wdev)
-{
-	retu_write(wdev->rdev, RETU_REG_WATCHDOG, RETU_WDT_MAX_TIMER);
-	schedule_delayed_work(&wdev->ping_work,
-			round_jiffies_relative(RETU_WDT_MAX_TIMER * HZ / 2));
-}
-
-static void retu_wdt_ping_disable(struct retu_wdt_dev *wdev)
-{
-	retu_write(wdev->rdev, RETU_REG_WATCHDOG, RETU_WDT_MAX_TIMER);
-	cancel_delayed_work_sync(&wdev->ping_work);
-}
-
-static void retu_wdt_ping_work(struct work_struct *work)
-{
-	struct retu_wdt_dev *wdev = container_of(to_delayed_work(work),
-						struct retu_wdt_dev, ping_work);
-	retu_wdt_ping_enable(wdev);
-}
-
 static int retu_wdt_start(struct watchdog_device *wdog)
 {
-	struct retu_wdt_dev *wdev = watchdog_get_drvdata(wdog);
+	struct retu_dev *rdev = watchdog_get_drvdata(wdog);
 
-	retu_wdt_ping_disable(wdev);
+	set_bit(WDOG_RUNNING, &wdog->status);
 
-	return retu_write(wdev->rdev, RETU_REG_WATCHDOG, wdog->timeout);
-}
-
-static int retu_wdt_stop(struct watchdog_device *wdog)
-{
-	struct retu_wdt_dev *wdev = watchdog_get_drvdata(wdog);
-
-	retu_wdt_ping_enable(wdev);
-
-	return 0;
-}
-
-static int retu_wdt_ping(struct watchdog_device *wdog)
-{
-	struct retu_wdt_dev *wdev = watchdog_get_drvdata(wdog);
-
-	return retu_write(wdev->rdev, RETU_REG_WATCHDOG, wdog->timeout);
+	return retu_write(rdev, RETU_REG_WATCHDOG, wdog->timeout);
 }
 
 static int retu_wdt_set_timeout(struct watchdog_device *wdog,
 				unsigned int timeout)
 {
-	struct retu_wdt_dev *wdev = watchdog_get_drvdata(wdog);
+	struct retu_dev *rdev = watchdog_get_drvdata(wdog);
 
 	wdog->timeout = timeout;
-	return retu_write(wdev->rdev, RETU_REG_WATCHDOG, wdog->timeout);
+	return retu_write(rdev, RETU_REG_WATCHDOG, wdog->timeout);
 }
 
 static const struct watchdog_info retu_wdt_info = {
@@ -101,8 +54,6 @@ static const struct watchdog_info retu_wdt_info = {
 static const struct watchdog_ops retu_wdt_ops = {
 	.owner		= THIS_MODULE,
 	.start		= retu_wdt_start,
-	.stop		= retu_wdt_stop,
-	.ping		= retu_wdt_ping,
 	.set_timeout	= retu_wdt_set_timeout,
 };
 
@@ -111,39 +62,26 @@ static int retu_wdt_probe(struct platform_device *pdev)
 	struct retu_dev *rdev = dev_get_drvdata(pdev->dev.parent);
 	bool nowayout = WATCHDOG_NOWAYOUT;
 	struct watchdog_device *retu_wdt;
-	struct retu_wdt_dev *wdev;
 	int ret;
 
 	retu_wdt = devm_kzalloc(&pdev->dev, sizeof(*retu_wdt), GFP_KERNEL);
 	if (!retu_wdt)
 		return -ENOMEM;
 
-	wdev = devm_kzalloc(&pdev->dev, sizeof(*wdev), GFP_KERNEL);
-	if (!wdev)
-		return -ENOMEM;
-
 	retu_wdt->info		= &retu_wdt_info;
 	retu_wdt->ops		= &retu_wdt_ops;
 	retu_wdt->timeout	= RETU_WDT_MAX_TIMER;
 	retu_wdt->min_timeout	= 0;
 	retu_wdt->max_timeout	= RETU_WDT_MAX_TIMER;
 
-	watchdog_set_drvdata(retu_wdt, wdev);
+	watchdog_set_drvdata(retu_wdt, rdev);
 	watchdog_set_nowayout(retu_wdt, nowayout);
 
-	wdev->rdev		= rdev;
-	wdev->dev		= &pdev->dev;
-
-	INIT_DELAYED_WORK(&wdev->ping_work, retu_wdt_ping_work);
-
 	ret = watchdog_register_device(retu_wdt);
 	if (ret < 0)
 		return ret;
 
-	if (nowayout)
-		retu_wdt_ping(retu_wdt);
-	else
-		retu_wdt_ping_enable(wdev);
+	retu_wdt_start(retu_wdt);
 
 	platform_set_drvdata(pdev, retu_wdt);
 
@@ -153,10 +91,8 @@ static int retu_wdt_probe(struct platform_device *pdev)
 static int retu_wdt_remove(struct platform_device *pdev)
 {
 	struct watchdog_device *wdog = platform_get_drvdata(pdev);
-	struct retu_wdt_dev *wdev = watchdog_get_drvdata(wdog);
 
 	watchdog_unregister_device(wdog);
-	cancel_delayed_work_sync(&wdev->ping_work);
 
 	return 0;
 }
-- 
2.1.4

