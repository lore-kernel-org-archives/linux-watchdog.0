Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Sylvain Lemieux <slemieux@tycoint.com>
Subject: [PATCH] watchdog: Add 'action' and 'data' parameters to restart handler callback
Date: Fri, 26 Feb 2016 17:32:49 -0800
Message-Id: <1456536769-17757-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

The 'action' (or restart mode) and data parameters may be used by restart
handlers, so they should be passed to the restart callback functions.

Cc: Sylvain Lemieux <slemieux@tycoint.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/bcm47xx_wdt.c   | 3 ++-
 drivers/watchdog/da9063_wdt.c    | 3 ++-
 drivers/watchdog/digicolor_wdt.c | 3 ++-
 drivers/watchdog/imgpdc_wdt.c    | 3 ++-
 drivers/watchdog/imx2_wdt.c      | 3 ++-
 drivers/watchdog/lpc18xx_wdt.c   | 3 ++-
 drivers/watchdog/meson_wdt.c     | 3 ++-
 drivers/watchdog/moxart_wdt.c    | 3 ++-
 drivers/watchdog/mtk_wdt.c       | 3 ++-
 drivers/watchdog/qcom-wdt.c      | 3 ++-
 drivers/watchdog/s3c2410_wdt.c   | 3 ++-
 drivers/watchdog/sunxi_wdt.c     | 3 ++-
 drivers/watchdog/watchdog_core.c | 2 +-
 include/linux/watchdog.h         | 2 +-
 14 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index df1c2a4b0165..a1900b9ab6c4 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -87,7 +87,8 @@ static int bcm47xx_wdt_hard_set_timeout(struct watchdog_device *wdd,
 	return 0;
 }
 
-static int bcm47xx_wdt_restart(struct watchdog_device *wdd)
+static int bcm47xx_wdt_restart(struct watchdog_device *wdd,
+			       unsigned long action, void *data)
 {
 	struct bcm47xx_wdt *wdt = bcm47xx_wdt_get(wdd);
 
diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index 11e887572649..a100f648880d 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -119,7 +119,8 @@ static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
 	return ret;
 }
 
-static int da9063_wdt_restart(struct watchdog_device *wdd)
+static int da9063_wdt_restart(struct watchdog_device *wdd, unsigned long action,
+			      void *data)
 {
 	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
 	int ret;
diff --git a/drivers/watchdog/digicolor_wdt.c b/drivers/watchdog/digicolor_wdt.c
index 1ccb0b239348..77df772406b0 100644
--- a/drivers/watchdog/digicolor_wdt.c
+++ b/drivers/watchdog/digicolor_wdt.c
@@ -48,7 +48,8 @@ static void dc_wdt_set(struct dc_wdt *wdt, u32 ticks)
 	spin_unlock_irqrestore(&wdt->lock, flags);
 }
 
-static int dc_wdt_restart(struct watchdog_device *wdog)
+static int dc_wdt_restart(struct watchdog_device *wdog, unsigned long action,
+			  void *data)
 {
 	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
 
diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index 3679f2e1922f..516fbef00856 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -150,7 +150,8 @@ static int pdc_wdt_start(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
-static int pdc_wdt_restart(struct watchdog_device *wdt_dev)
+static int pdc_wdt_restart(struct watchdog_device *wdt_dev,
+			   unsigned long action, void *data)
 {
 	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
 
diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 1a48cb28718f..7ae92aef4cc8 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -77,7 +77,8 @@ static const struct watchdog_info imx2_wdt_info = {
 	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 };
 
-static int imx2_wdt_restart(struct watchdog_device *wdog)
+static int imx2_wdt_restart(struct watchdog_device *wdog, unsigned long action,
+			    void *data)
 {
 	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
 	unsigned int wcr_enable = IMX2_WDT_WCR_WDE;
diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
index 6914c83aa6d9..fd171e6caa16 100644
--- a/drivers/watchdog/lpc18xx_wdt.c
+++ b/drivers/watchdog/lpc18xx_wdt.c
@@ -153,7 +153,8 @@ static int lpc18xx_wdt_start(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
-static int lpc18xx_wdt_restart(struct watchdog_device *wdt_dev)
+static int lpc18xx_wdt_restart(struct watchdog_device *wdt_dev,
+			       unsigned long action, void *data)
 {
 	struct lpc18xx_wdt_dev *lpc18xx_wdt = watchdog_get_drvdata(wdt_dev);
 	unsigned long flags;
diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
index aea5d2f44ad7..56ea1caf71c3 100644
--- a/drivers/watchdog/meson_wdt.c
+++ b/drivers/watchdog/meson_wdt.c
@@ -62,7 +62,8 @@ struct meson_wdt_dev {
 	const struct meson_wdt_data *data;
 };
 
-static int meson_wdt_restart(struct watchdog_device *wdt_dev)
+static int meson_wdt_restart(struct watchdog_device *wdt_dev,
+			     unsigned long action, void *data)
 {
 	struct meson_wdt_dev *meson_wdt = watchdog_get_drvdata(wdt_dev);
 	u32 tc_reboot = MESON_WDT_DC_RESET;
diff --git a/drivers/watchdog/moxart_wdt.c b/drivers/watchdog/moxart_wdt.c
index 885c81bc4210..2c4a73d1e214 100644
--- a/drivers/watchdog/moxart_wdt.c
+++ b/drivers/watchdog/moxart_wdt.c
@@ -31,7 +31,8 @@ struct moxart_wdt_dev {
 
 static int heartbeat;
 
-static int moxart_wdt_restart(struct watchdog_device *wdt_dev)
+static int moxart_wdt_restart(struct watchdog_device *wdt_dev,
+			      unsigned long action, void *data)
 {
 	struct moxart_wdt_dev *moxart_wdt = watchdog_get_drvdata(wdt_dev);
 
diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index b78776c05554..7ed417a765c7 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -64,7 +64,8 @@ struct mtk_wdt_dev {
 	void __iomem *wdt_base;
 };
 
-static int mtk_wdt_restart(struct watchdog_device *wdt_dev)
+static int mtk_wdt_restart(struct watchdog_device *wdt_dev,
+			   unsigned long action, void *data)
 {
 	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdt_dev);
 	void __iomem *wdt_base;
diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 424f9a952fee..20563ccb7be0 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -70,7 +70,8 @@ static int qcom_wdt_set_timeout(struct watchdog_device *wdd,
 	return qcom_wdt_start(wdd);
 }
 
-static int qcom_wdt_restart(struct watchdog_device *wdd)
+static int qcom_wdt_restart(struct watchdog_device *wdd, unsigned long action,
+			    void *data)
 {
 	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
 	u32 timeout;
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 0093450441fe..d57f19b5077f 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -349,7 +349,8 @@ static int s3c2410wdt_set_heartbeat(struct watchdog_device *wdd, unsigned timeou
 	return 0;
 }
 
-static int s3c2410wdt_restart(struct watchdog_device *wdd)
+static int s3c2410wdt_restart(struct watchdog_device *wdd, unsigned long action,
+			      void *data)
 {
 	struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
 	void __iomem *wdt_base = wdt->reg_base;
diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index e027deb54740..953bb7b7446f 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -83,7 +83,8 @@ static const int wdt_timeout_map[] = {
 };
 
 
-static int sunxi_wdt_restart(struct watchdog_device *wdt_dev)
+static int sunxi_wdt_restart(struct watchdog_device *wdt_dev,
+			     unsigned long action, void *data)
 {
 	struct sunxi_wdt_dev *sunxi_wdt = watchdog_get_drvdata(wdt_dev);
 	void __iomem *wdt_base = sunxi_wdt->wdt_base;
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 07c9931e2123..d3cfcccddf39 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -164,7 +164,7 @@ static int watchdog_restart_notifier(struct notifier_block *nb,
 
 	int ret;
 
-	ret = wdd->ops->restart(wdd);
+	ret = wdd->ops->restart(wdd, action, data);
 	if (ret)
 		return NOTIFY_BAD;
 
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 537e84e2592a..f1fccc7aea68 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -47,7 +47,7 @@ struct watchdog_ops {
 	unsigned int (*status)(struct watchdog_device *);
 	int (*set_timeout)(struct watchdog_device *, unsigned int);
 	unsigned int (*get_timeleft)(struct watchdog_device *);
-	int (*restart)(struct watchdog_device *);
+	int (*restart)(struct watchdog_device *, unsigned long, void *);
 	long (*ioctl)(struct watchdog_device *, unsigned int, unsigned long);
 };
 
-- 
2.5.0
