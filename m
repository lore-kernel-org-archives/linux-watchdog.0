Return-path: <ukl@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Felipe Balbi <balbi@ti.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: kernel@pengutronix.de,
	Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 3/4] watchdog: omap: put struct watchdog_device into driver data
Date: Mon, 27 Apr 2015 11:23:00 +0200
Message-Id: <1430126581-24946-4-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1430126581-24946-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1430126581-24946-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

This way only a single allocation is needed (per device). Also this
simplifies the data structure used by the driver because there is no
need anymore to link from one struct to the other (by means of
watchdog_{set,get}_drvdata).

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Notes:
    Changes since (implicit) v1, sent with
    Message-Id: 1429868913-24049-3-git-send-email-u.kleine-koenig@pengutronix.de:
    
     - reword commit log
     - add Guenter's Reviewed-by tag

 drivers/watchdog/omap_wdt.c | 55 ++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 0eb9ca04e672..479e7c8e44f5 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -53,7 +53,10 @@ static unsigned timer_margin;
 module_param(timer_margin, uint, 0);
 MODULE_PARM_DESC(timer_margin, "initial watchdog timeout (in seconds)");
 
+#define to_omap_wdt_dev(_wdog)	container_of(_wdog, struct omap_wdt_dev, wdog)
+
 struct omap_wdt_dev {
+	struct watchdog_device wdog;
 	void __iomem    *base;          /* physical */
 	struct device   *dev;
 	bool		omap_wdt_users;
@@ -123,7 +126,7 @@ static void omap_wdt_set_timer(struct omap_wdt_dev *wdev,
 
 static int omap_wdt_start(struct watchdog_device *wdog)
 {
-	struct omap_wdt_dev *wdev = watchdog_get_drvdata(wdog);
+	struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
 	void __iomem *base = wdev->base;
 
 	mutex_lock(&wdev->lock);
@@ -151,7 +154,7 @@ static int omap_wdt_start(struct watchdog_device *wdog)
 
 static int omap_wdt_stop(struct watchdog_device *wdog)
 {
-	struct omap_wdt_dev *wdev = watchdog_get_drvdata(wdog);
+	struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
 
 	mutex_lock(&wdev->lock);
 	omap_wdt_disable(wdev);
@@ -163,7 +166,7 @@ static int omap_wdt_stop(struct watchdog_device *wdog)
 
 static int omap_wdt_ping(struct watchdog_device *wdog)
 {
-	struct omap_wdt_dev *wdev = watchdog_get_drvdata(wdog);
+	struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
 
 	mutex_lock(&wdev->lock);
 	omap_wdt_reload(wdev);
@@ -175,7 +178,7 @@ static int omap_wdt_ping(struct watchdog_device *wdog)
 static int omap_wdt_set_timeout(struct watchdog_device *wdog,
 				unsigned int timeout)
 {
-	struct omap_wdt_dev *wdev = watchdog_get_drvdata(wdog);
+	struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
 
 	mutex_lock(&wdev->lock);
 	omap_wdt_disable(wdev);
@@ -204,16 +207,11 @@ static const struct watchdog_ops omap_wdt_ops = {
 static int omap_wdt_probe(struct platform_device *pdev)
 {
 	struct omap_wd_timer_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct watchdog_device *omap_wdt;
 	struct resource *res;
 	struct omap_wdt_dev *wdev;
 	u32 rs;
 	int ret;
 
-	omap_wdt = devm_kzalloc(&pdev->dev, sizeof(*omap_wdt), GFP_KERNEL);
-	if (!omap_wdt)
-		return -ENOMEM;
-
 	wdev = devm_kzalloc(&pdev->dev, sizeof(*wdev), GFP_KERNEL);
 	if (!wdev)
 		return -ENOMEM;
@@ -229,18 +227,17 @@ static int omap_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(wdev->base))
 		return PTR_ERR(wdev->base);
 
-	omap_wdt->info	      = &omap_wdt_info;
-	omap_wdt->ops	      = &omap_wdt_ops;
-	omap_wdt->min_timeout = TIMER_MARGIN_MIN;
-	omap_wdt->max_timeout = TIMER_MARGIN_MAX;
+	wdev->wdog.info = &omap_wdt_info;
+	wdev->wdog.ops = &omap_wdt_ops;
+	wdev->wdog.min_timeout = TIMER_MARGIN_MIN;
+	wdev->wdog.max_timeout = TIMER_MARGIN_MAX;
 
-	if (watchdog_init_timeout(omap_wdt, timer_margin, &pdev->dev) < 0)
-		omap_wdt->timeout = TIMER_MARGIN_DEFAULT;
+	if (watchdog_init_timeout(&wdev->wdog, timer_margin, &pdev->dev) < 0)
+		wdev->wdog.timeout = TIMER_MARGIN_DEFAULT;
 
-	watchdog_set_drvdata(omap_wdt, wdev);
-	watchdog_set_nowayout(omap_wdt, nowayout);
+	watchdog_set_nowayout(&wdev->wdog, nowayout);
 
-	platform_set_drvdata(pdev, omap_wdt);
+	platform_set_drvdata(pdev, wdev);
 
 	pm_runtime_enable(wdev->dev);
 	pm_runtime_get_sync(wdev->dev);
@@ -249,12 +246,12 @@ static int omap_wdt_probe(struct platform_device *pdev)
 		rs = pdata->read_reset_sources();
 	else
 		rs = 0;
-	omap_wdt->bootstatus = (rs & (1 << OMAP_MPU_WD_RST_SRC_ID_SHIFT)) ?
-				WDIOF_CARDRESET : 0;
+	wdev->wdog.bootstatus = (rs & (1 << OMAP_MPU_WD_RST_SRC_ID_SHIFT)) ?
+		WDIOF_CARDRESET : 0;
 
 	omap_wdt_disable(wdev);
 
-	ret = watchdog_register_device(omap_wdt);
+	ret = watchdog_register_device(&wdev->wdog);
 	if (ret) {
 		pm_runtime_disable(wdev->dev);
 		return ret;
@@ -262,7 +259,7 @@ static int omap_wdt_probe(struct platform_device *pdev)
 
 	pr_info("OMAP Watchdog Timer Rev 0x%02x: initial timeout %d sec\n",
 		readl_relaxed(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
-		omap_wdt->timeout);
+		wdev->wdog.timeout);
 
 	pm_runtime_put_sync(wdev->dev);
 
@@ -271,8 +268,7 @@ static int omap_wdt_probe(struct platform_device *pdev)
 
 static void omap_wdt_shutdown(struct platform_device *pdev)
 {
-	struct watchdog_device *wdog = platform_get_drvdata(pdev);
-	struct omap_wdt_dev *wdev = watchdog_get_drvdata(wdog);
+	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
 	mutex_lock(&wdev->lock);
 	if (wdev->omap_wdt_users) {
@@ -284,11 +280,10 @@ static void omap_wdt_shutdown(struct platform_device *pdev)
 
 static int omap_wdt_remove(struct platform_device *pdev)
 {
-	struct watchdog_device *wdog = platform_get_drvdata(pdev);
-	struct omap_wdt_dev *wdev = watchdog_get_drvdata(wdog);
+	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(wdev->dev);
-	watchdog_unregister_device(wdog);
+	watchdog_unregister_device(&wdev->wdog);
 
 	return 0;
 }
@@ -303,8 +298,7 @@ static int omap_wdt_remove(struct platform_device *pdev)
 
 static int omap_wdt_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	struct watchdog_device *wdog = platform_get_drvdata(pdev);
-	struct omap_wdt_dev *wdev = watchdog_get_drvdata(wdog);
+	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
 	mutex_lock(&wdev->lock);
 	if (wdev->omap_wdt_users) {
@@ -318,8 +312,7 @@ static int omap_wdt_suspend(struct platform_device *pdev, pm_message_t state)
 
 static int omap_wdt_resume(struct platform_device *pdev)
 {
-	struct watchdog_device *wdog = platform_get_drvdata(pdev);
-	struct omap_wdt_dev *wdev = watchdog_get_drvdata(wdog);
+	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
 	mutex_lock(&wdev->lock);
 	if (wdev->omap_wdt_users) {
-- 
2.1.4
