Return-path: <panand@redhat.com>
From: Pratyush Anand <panand@redhat.com>
To: linux@roeck-us.net
Cc: Pratyush Anand <panand@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Lee Jones <lee.jones@linaro.org>, Lubomir Rintel <lkundrak@v3.sk>,
        Maxime Coquelin <maxime.coquelin@st.com>,
        Thierry Reding <treding@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        Andreas Werner <andreas.werner@men.de>, Barry Song <baohua@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        kernel@stlinux.com (open list:ARM/STI ARCHITECTURE),
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/U300 MACHINE SUPPORT),
        linux-kernel@vger.kernel.org (open list:INTEL MANAGEMENT ENGINE (mei)),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2835 ARM ARCHITECTURE),
        linux-samsung-soc@vger.kernel.org (moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES),
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
        linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
        patches@opensource.wolfsonmicro.com (open list:WOLFSON MICROELECTRONICS DRIVERS),
        Patrice Chotard <patrice.chotard@st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH V4] Watchdog: Fix parent of watchdog_devices
Date: Thu, 20 Aug 2015 14:05:01 +0530
Message-Id: <d035c08984bb06bd81e49fa587fab1da44533bcc.1440059435.git.panand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

/sys/class/watchdog/watchdogn/device/modalias can help to identify the
driver/module for a given watchdog node. However, many wdt devices do not
set their parent and so, we do not see an entry for device in sysfs for
such devices.

This patch fixes parent of watchdog_device so that
/sys/class/watchdog/watchdogn/device is populated.

Exceptions: booke, diag288, octeon, softdog and w83627hf -- They do not
have any parent. Not sure, how we can identify driver for these devices.

Signed-off-by: Pratyush Anand <panand@redhat.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
* Changes since v3:
- Fixed max no number of columns in the description to 75 
- Fixed grammatical mistake in patch description reported by Uwe
Kleine-König.
- Fixed for mpc8xxx as well.
* Changes since v2:
- Fixed drivers/watchdog/txx9wdt.c:134:20: error: 'pdev' undeclared
Reported-by: kbuild test robot <fengguang.wu@intel.com>
* Changes since v1:
- Squash all commits of V1 into a single patch.
- V1 was here:
	http://www.spinics.net/lists/linux-watchdog/msg07220.html

 drivers/misc/mei/wd.c               | 1 +
 drivers/watchdog/bcm2835_wdt.c      | 1 +
 drivers/watchdog/bcm47xx_wdt.c      | 1 +
 drivers/watchdog/bcm_kona_wdt.c     | 1 +
 drivers/watchdog/coh901327_wdt.c    | 1 +
 drivers/watchdog/da9052_wdt.c       | 1 +
 drivers/watchdog/da9055_wdt.c       | 1 +
 drivers/watchdog/da9062_wdt.c       | 1 +
 drivers/watchdog/da9063_wdt.c       | 1 +
 drivers/watchdog/davinci_wdt.c      | 1 +
 drivers/watchdog/digicolor_wdt.c    | 1 +
 drivers/watchdog/ep93xx_wdt.c       | 1 +
 drivers/watchdog/gpio_wdt.c         | 1 +
 drivers/watchdog/ie6xx_wdt.c        | 1 +
 drivers/watchdog/intel-mid_wdt.c    | 1 +
 drivers/watchdog/jz4740_wdt.c       | 1 +
 drivers/watchdog/mena21_wdt.c       | 1 +
 drivers/watchdog/menf21bmc_wdt.c    | 1 +
 drivers/watchdog/mpc8xxx_wdt.c      | 1 +
 drivers/watchdog/omap_wdt.c         | 1 +
 drivers/watchdog/orion_wdt.c        | 1 +
 drivers/watchdog/pnx4008_wdt.c      | 1 +
 drivers/watchdog/qcom-wdt.c         | 1 +
 drivers/watchdog/retu_wdt.c         | 1 +
 drivers/watchdog/rt2880_wdt.c       | 1 +
 drivers/watchdog/s3c2410_wdt.c      | 1 +
 drivers/watchdog/shwdt.c            | 1 +
 drivers/watchdog/sirfsoc_wdt.c      | 1 +
 drivers/watchdog/sp805_wdt.c        | 1 +
 drivers/watchdog/st_lpc_wdt.c       | 1 +
 drivers/watchdog/stmp3xxx_rtc_wdt.c | 1 +
 drivers/watchdog/tegra_wdt.c        | 1 +
 drivers/watchdog/twl4030_wdt.c      | 1 +
 drivers/watchdog/txx9wdt.c          | 1 +
 drivers/watchdog/ux500_wdt.c        | 1 +
 drivers/watchdog/via_wdt.c          | 1 +
 drivers/watchdog/wm831x_wdt.c       | 1 +
 drivers/watchdog/wm8350_wdt.c       | 1 +
 38 files changed, 38 insertions(+)

diff --git a/drivers/misc/mei/wd.c b/drivers/misc/mei/wd.c
index 2bc0f5089f82..b346638833b0 100644
--- a/drivers/misc/mei/wd.c
+++ b/drivers/misc/mei/wd.c
@@ -364,6 +364,7 @@ int mei_watchdog_register(struct mei_device *dev)
 
 	int ret;
 
+	amt_wd_dev.parent = dev->dev;
 	/* unlock to perserve correct locking order */
 	mutex_unlock(&dev->device_lock);
 	ret = watchdog_register_device(&amt_wd_dev);
diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index 7116968dee12..66c3e656a616 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -182,6 +182,7 @@ static int bcm2835_wdt_probe(struct platform_device *pdev)
 	watchdog_set_drvdata(&bcm2835_wdt_wdd, wdt);
 	watchdog_init_timeout(&bcm2835_wdt_wdd, heartbeat, dev);
 	watchdog_set_nowayout(&bcm2835_wdt_wdd, nowayout);
+	bcm2835_wdt_wdd.parent = &pdev->dev;
 	err = watchdog_register_device(&bcm2835_wdt_wdd);
 	if (err) {
 		dev_err(dev, "Failed to register watchdog device");
diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index b28a072abf78..4064a43f1360 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -209,6 +209,7 @@ static int bcm47xx_wdt_probe(struct platform_device *pdev)
 
 	wdt->wdd.info = &bcm47xx_wdt_info;
 	wdt->wdd.timeout = WDT_DEFAULT_TIME;
+	wdt->wdd.parent = &pdev->dev;
 	ret = wdt->wdd.ops->set_timeout(&wdt->wdd, timeout);
 	if (ret)
 		goto err_timer;
diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
index 22d8ae65772a..e0c98423f2c9 100644
--- a/drivers/watchdog/bcm_kona_wdt.c
+++ b/drivers/watchdog/bcm_kona_wdt.c
@@ -319,6 +319,7 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
 	spin_lock_init(&wdt->lock);
 	platform_set_drvdata(pdev, wdt);
 	watchdog_set_drvdata(&bcm_kona_wdt_wdd, wdt);
+	bcm_kona_wdt_wdd.parent = &pdev->dev;
 
 	ret = bcm_kona_wdt_set_timeout_reg(&bcm_kona_wdt_wdd, 0);
 	if (ret) {
diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
index ce12f437f195..a099b77fc0b9 100644
--- a/drivers/watchdog/coh901327_wdt.c
+++ b/drivers/watchdog/coh901327_wdt.c
@@ -358,6 +358,7 @@ static int __init coh901327_probe(struct platform_device *pdev)
 	if (ret < 0)
 		coh901327_wdt.timeout = 60;
 
+	coh901327_wdt.parent = &pdev->dev;
 	ret = watchdog_register_device(&coh901327_wdt);
 	if (ret == 0)
 		dev_info(&pdev->dev,
diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
index 2e9589652e1e..67e67977bd29 100644
--- a/drivers/watchdog/da9052_wdt.c
+++ b/drivers/watchdog/da9052_wdt.c
@@ -195,6 +195,7 @@ static int da9052_wdt_probe(struct platform_device *pdev)
 	da9052_wdt->timeout = DA9052_DEF_TIMEOUT;
 	da9052_wdt->info = &da9052_wdt_info;
 	da9052_wdt->ops = &da9052_wdt_ops;
+	da9052_wdt->parent = &pdev->dev;
 	watchdog_set_drvdata(da9052_wdt, driver_data);
 
 	kref_init(&driver_data->kref);
diff --git a/drivers/watchdog/da9055_wdt.c b/drivers/watchdog/da9055_wdt.c
index 495089d8dbfe..04d1430d93d2 100644
--- a/drivers/watchdog/da9055_wdt.c
+++ b/drivers/watchdog/da9055_wdt.c
@@ -161,6 +161,7 @@ static int da9055_wdt_probe(struct platform_device *pdev)
 	da9055_wdt->timeout = DA9055_DEF_TIMEOUT;
 	da9055_wdt->info = &da9055_wdt_info;
 	da9055_wdt->ops = &da9055_wdt_ops;
+	da9055_wdt->parent = &pdev->dev;
 	watchdog_set_nowayout(da9055_wdt, nowayout);
 	watchdog_set_drvdata(da9055_wdt, driver_data);
 
diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index b3a870ce85be..7386111220d5 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -210,6 +210,7 @@ static int da9062_wdt_probe(struct platform_device *pdev)
 	wdt->wdtdev.max_timeout = DA9062_WDT_MAX_TIMEOUT;
 	wdt->wdtdev.timeout = DA9062_WDG_DEFAULT_TIMEOUT;
 	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
+	wdt->wdtdev.parent = &pdev->dev;
 
 	watchdog_set_drvdata(&wdt->wdtdev, wdt);
 	dev_set_drvdata(&pdev->dev, wdt);
diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index e2fe2ebdebd4..6bf130bd863d 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -175,6 +175,7 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 	wdt->wdtdev.min_timeout = DA9063_WDT_MIN_TIMEOUT;
 	wdt->wdtdev.max_timeout = DA9063_WDT_MAX_TIMEOUT;
 	wdt->wdtdev.timeout = DA9063_WDG_TIMEOUT;
+	wdt->wdtdev.parent = &pdev->dev;
 
 	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
 
diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index cfdf8a408aea..17454ca653f4 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -179,6 +179,7 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 	wdd->min_timeout	= 1;
 	wdd->max_timeout	= MAX_HEARTBEAT;
 	wdd->timeout		= DEFAULT_HEARTBEAT;
+	wdd->parent		= &pdev->dev;
 
 	watchdog_init_timeout(wdd, heartbeat, dev);
 
diff --git a/drivers/watchdog/digicolor_wdt.c b/drivers/watchdog/digicolor_wdt.c
index 31d8e4936611..50abe1bf62a5 100644
--- a/drivers/watchdog/digicolor_wdt.c
+++ b/drivers/watchdog/digicolor_wdt.c
@@ -143,6 +143,7 @@ static int dc_wdt_probe(struct platform_device *pdev)
 	}
 	dc_wdt_wdd.max_timeout = U32_MAX / clk_get_rate(wdt->clk);
 	dc_wdt_wdd.timeout = dc_wdt_wdd.max_timeout;
+	dc_wdt_wdd.parent = &pdev->dev;
 
 	spin_lock_init(&wdt->lock);
 
diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index 7a2cc7191c58..0a4d7cc05d54 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -132,6 +132,7 @@ static int ep93xx_wdt_probe(struct platform_device *pdev)
 	val = readl(mmio_base + EP93XX_WATCHDOG);
 	ep93xx_wdt_wdd.bootstatus = (val & 0x01) ? WDIOF_CARDRESET : 0;
 	ep93xx_wdt_wdd.timeout = timeout;
+	ep93xx_wdt_wdd.parent = &pdev->dev;
 
 	watchdog_set_nowayout(&ep93xx_wdt_wdd, nowayout);
 
diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index 1687cc2d7122..336bddd84809 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -217,6 +217,7 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	priv->wdd.ops		= &gpio_wdt_ops;
 	priv->wdd.min_timeout	= SOFT_TIMEOUT_MIN;
 	priv->wdd.max_timeout	= SOFT_TIMEOUT_MAX;
+	priv->wdd.parent	= &pdev->dev;
 
 	if (watchdog_init_timeout(&priv->wdd, 0, &pdev->dev) < 0)
 		priv->wdd.timeout = SOFT_TIMEOUT_DEF;
diff --git a/drivers/watchdog/ie6xx_wdt.c b/drivers/watchdog/ie6xx_wdt.c
index 9bc39ae51624..78c2541f5d52 100644
--- a/drivers/watchdog/ie6xx_wdt.c
+++ b/drivers/watchdog/ie6xx_wdt.c
@@ -267,6 +267,7 @@ static int ie6xx_wdt_probe(struct platform_device *pdev)
 
 	ie6xx_wdt_dev.timeout = timeout;
 	watchdog_set_nowayout(&ie6xx_wdt_dev, nowayout);
+	ie6xx_wdt_dev.parent = &pdev->dev;
 
 	spin_lock_init(&ie6xx_wdt_data.unlock_sequence);
 
diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
index 84f6701c391f..0a436b5d1e84 100644
--- a/drivers/watchdog/intel-mid_wdt.c
+++ b/drivers/watchdog/intel-mid_wdt.c
@@ -137,6 +137,7 @@ static int mid_wdt_probe(struct platform_device *pdev)
 	wdt_dev->min_timeout = MID_WDT_TIMEOUT_MIN;
 	wdt_dev->max_timeout = MID_WDT_TIMEOUT_MAX;
 	wdt_dev->timeout = MID_WDT_DEFAULT_TIMEOUT;
+	wdt_dev->parent = &pdev->dev;
 
 	watchdog_set_drvdata(wdt_dev, &pdev->dev);
 	platform_set_drvdata(pdev, wdt_dev);
diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 4c2cc09c0c57..6a7d5c365438 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -174,6 +174,7 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
 	jz4740_wdt->timeout = heartbeat;
 	jz4740_wdt->min_timeout = 1;
 	jz4740_wdt->max_timeout = MAX_HEARTBEAT;
+	jz4740_wdt->parent = &pdev->dev;
 	watchdog_set_nowayout(jz4740_wdt, nowayout);
 	watchdog_set_drvdata(jz4740_wdt, drvdata);
 
diff --git a/drivers/watchdog/mena21_wdt.c b/drivers/watchdog/mena21_wdt.c
index d193a5e79c38..69013007dc47 100644
--- a/drivers/watchdog/mena21_wdt.c
+++ b/drivers/watchdog/mena21_wdt.c
@@ -197,6 +197,7 @@ static int a21_wdt_probe(struct platform_device *pdev)
 	watchdog_init_timeout(&a21_wdt, 30, &pdev->dev);
 	watchdog_set_nowayout(&a21_wdt, nowayout);
 	watchdog_set_drvdata(&a21_wdt, drv);
+	a21_wdt.parent = &pdev->dev;
 
 	reset = a21_wdt_get_bootstatus(drv);
 	if (reset == 2)
diff --git a/drivers/watchdog/menf21bmc_wdt.c b/drivers/watchdog/menf21bmc_wdt.c
index 59f0913c7341..3aefddebb386 100644
--- a/drivers/watchdog/menf21bmc_wdt.c
+++ b/drivers/watchdog/menf21bmc_wdt.c
@@ -130,6 +130,7 @@ static int menf21bmc_wdt_probe(struct platform_device *pdev)
 	drv_data->wdt.info = &menf21bmc_wdt_info;
 	drv_data->wdt.min_timeout = BMC_WD_TIMEOUT_MIN;
 	drv_data->wdt.max_timeout = BMC_WD_TIMEOUT_MAX;
+	drv_data->wdt.parent = &pdev->dev;
 	drv_data->i2c_client = i2c_client;
 
 	/*
diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 689381a24887..21eda27686c5 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -185,6 +185,7 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 		timeout_sec = timeout / freq;
 
 	mpc8xxx_wdt_dev.timeout = timeout_sec;
+	mpc8xxx_wdt_dev.parent = &ofdev->dev;
 #ifdef MODULE
 	ret = mpc8xxx_wdt_init_late();
 	if (ret)
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index de911c7e477c..d96bee017fd3 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -253,6 +253,7 @@ static int omap_wdt_probe(struct platform_device *pdev)
 	wdev->wdog.ops = &omap_wdt_ops;
 	wdev->wdog.min_timeout = TIMER_MARGIN_MIN;
 	wdev->wdog.max_timeout = TIMER_MARGIN_MAX;
+	wdev->wdog.parent = &pdev->dev;
 
 	if (watchdog_init_timeout(&wdev->wdog, timer_margin, &pdev->dev) < 0)
 		wdev->wdog.timeout = TIMER_MARGIN_DEFAULT;
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index ef0c628d5037..c6b8f4a43bde 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -567,6 +567,7 @@ static int orion_wdt_probe(struct platform_device *pdev)
 
 	dev->wdt.timeout = wdt_max_duration;
 	dev->wdt.max_timeout = wdt_max_duration;
+	dev->wdt.parent = &pdev->dev;
 	watchdog_init_timeout(&dev->wdt, heartbeat, &pdev->dev);
 
 	platform_set_drvdata(pdev, &dev->wdt);
diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index b9c6049c3e78..4224b3ec83a5 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -167,6 +167,7 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
 
 	pnx4008_wdd.bootstatus = (readl(WDTIM_RES(wdt_base)) & WDOG_RESET) ?
 			WDIOF_CARDRESET : 0;
+	pnx4008_wdd.parent = &pdev->dev;
 	watchdog_set_nowayout(&pnx4008_wdd, nowayout);
 
 	pnx4008_wdt_stop(&pnx4008_wdd);	/* disable for now */
diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index aa03ca8f2d9b..773dcfaee7b2 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -171,6 +171,7 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	wdt->wdd.ops = &qcom_wdt_ops;
 	wdt->wdd.min_timeout = 1;
 	wdt->wdd.max_timeout = 0x10000000U / wdt->rate;
+	wdt->wdd.parent = &pdev->dev;
 
 	/*
 	 * If 'timeout-sec' unspecified in devicetree, assume a 30 second
diff --git a/drivers/watchdog/retu_wdt.c b/drivers/watchdog/retu_wdt.c
index b7c68e275aeb..39cd51df2ffc 100644
--- a/drivers/watchdog/retu_wdt.c
+++ b/drivers/watchdog/retu_wdt.c
@@ -127,6 +127,7 @@ static int retu_wdt_probe(struct platform_device *pdev)
 	retu_wdt->timeout	= RETU_WDT_MAX_TIMER;
 	retu_wdt->min_timeout	= 0;
 	retu_wdt->max_timeout	= RETU_WDT_MAX_TIMER;
+	retu_wdt->parent	= &pdev->dev;
 
 	watchdog_set_drvdata(retu_wdt, wdev);
 	watchdog_set_nowayout(retu_wdt, nowayout);
diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
index a6f7e2e29beb..1967919ae743 100644
--- a/drivers/watchdog/rt2880_wdt.c
+++ b/drivers/watchdog/rt2880_wdt.c
@@ -161,6 +161,7 @@ static int rt288x_wdt_probe(struct platform_device *pdev)
 	rt288x_wdt_dev.dev = &pdev->dev;
 	rt288x_wdt_dev.bootstatus = rt288x_wdt_bootcause();
 	rt288x_wdt_dev.max_timeout = (0xfffful / rt288x_wdt_freq);
+	rt288x_wdt_dev.parent = &pdev->dev;
 
 	watchdog_init_timeout(&rt288x_wdt_dev, rt288x_wdt_dev.max_timeout,
 			      &pdev->dev);
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index e89ae027c91d..d781000c7825 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -607,6 +607,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(&wdt->wdt_device, nowayout);
 
 	wdt->wdt_device.bootstatus = s3c2410wdt_get_bootstatus(wdt);
+	wdt->wdt_device.parent = &pdev->dev;
 
 	ret = watchdog_register_device(&wdt->wdt_device);
 	if (ret) {
diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
index 567458b137a6..f90812170657 100644
--- a/drivers/watchdog/shwdt.c
+++ b/drivers/watchdog/shwdt.c
@@ -252,6 +252,7 @@ static int sh_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_nowayout(&sh_wdt_dev, nowayout);
 	watchdog_set_drvdata(&sh_wdt_dev, wdt);
+	sh_wdt_dev.parent = &pdev->dev;
 
 	spin_lock_init(&wdt->lock);
 
diff --git a/drivers/watchdog/sirfsoc_wdt.c b/drivers/watchdog/sirfsoc_wdt.c
index 42fa5c0c518a..d0578ab2e636 100644
--- a/drivers/watchdog/sirfsoc_wdt.c
+++ b/drivers/watchdog/sirfsoc_wdt.c
@@ -154,6 +154,7 @@ static int sirfsoc_wdt_probe(struct platform_device *pdev)
 
 	watchdog_init_timeout(&sirfsoc_wdd, timeout, &pdev->dev);
 	watchdog_set_nowayout(&sirfsoc_wdd, nowayout);
+	sirfsoc_wdd.parent = &pdev->dev;
 
 	ret = watchdog_register_device(&sirfsoc_wdd);
 	if (ret)
diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 4e7fec36f5c3..01d816251302 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -226,6 +226,7 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 	wdt->adev = adev;
 	wdt->wdd.info = &wdt_info;
 	wdt->wdd.ops = &wdt_ops;
+	wdt->wdd.parent = &adev->dev;
 
 	spin_lock_init(&wdt->lock);
 	watchdog_set_nowayout(&wdt->wdd, nowayout);
diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
index 6785afdc0fca..14e9badf2bfa 100644
--- a/drivers/watchdog/st_lpc_wdt.c
+++ b/drivers/watchdog/st_lpc_wdt.c
@@ -241,6 +241,7 @@ static int st_wdog_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	st_wdog_dev.max_timeout = 0xFFFFFFFF / st_wdog->clkrate;
+	st_wdog_dev.parent = &pdev->dev;
 
 	ret = clk_prepare_enable(clk);
 	if (ret) {
diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index e7f0d5b60d3d..3ee6128a540e 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -76,6 +76,7 @@ static int stmp3xxx_wdt_probe(struct platform_device *pdev)
 	watchdog_set_drvdata(&stmp3xxx_wdd, &pdev->dev);
 
 	stmp3xxx_wdd.timeout = clamp_t(unsigned, heartbeat, 1, STMP3XXX_MAX_TIMEOUT);
+	stmp3xxx_wdd.parent = &pdev->dev;
 
 	ret = watchdog_register_device(&stmp3xxx_wdd);
 	if (ret < 0) {
diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
index 30451ea46902..7f97cdd53f29 100644
--- a/drivers/watchdog/tegra_wdt.c
+++ b/drivers/watchdog/tegra_wdt.c
@@ -218,6 +218,7 @@ static int tegra_wdt_probe(struct platform_device *pdev)
 	wdd->ops = &tegra_wdt_ops;
 	wdd->min_timeout = MIN_WDT_TIMEOUT;
 	wdd->max_timeout = MAX_WDT_TIMEOUT;
+	wdd->parent = &pdev->dev;
 
 	watchdog_set_drvdata(wdd, wdt);
 
diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index 2c1db6fa9a27..9bf3cc0f3961 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -83,6 +83,7 @@ static int twl4030_wdt_probe(struct platform_device *pdev)
 	wdt->timeout		= 30;
 	wdt->min_timeout	= 1;
 	wdt->max_timeout	= 30;
+	wdt->parent = &pdev->dev;
 
 	watchdog_set_nowayout(wdt, nowayout);
 	platform_set_drvdata(pdev, wdt);
diff --git a/drivers/watchdog/txx9wdt.c b/drivers/watchdog/txx9wdt.c
index 7f615933d31a..c2da880292bc 100644
--- a/drivers/watchdog/txx9wdt.c
+++ b/drivers/watchdog/txx9wdt.c
@@ -131,6 +131,7 @@ static int __init txx9wdt_probe(struct platform_device *dev)
 	txx9wdt.timeout = timeout;
 	txx9wdt.min_timeout = 1;
 	txx9wdt.max_timeout = WD_MAX_TIMEOUT;
+	txx9wdt.parent = &dev->dev;
 	watchdog_set_nowayout(&txx9wdt, nowayout);
 
 	ret = watchdog_register_device(&txx9wdt);
diff --git a/drivers/watchdog/ux500_wdt.c b/drivers/watchdog/ux500_wdt.c
index 9de09ab00838..37c084353cce 100644
--- a/drivers/watchdog/ux500_wdt.c
+++ b/drivers/watchdog/ux500_wdt.c
@@ -96,6 +96,7 @@ static int ux500_wdt_probe(struct platform_device *pdev)
 			ux500_wdt.max_timeout = WATCHDOG_MAX28;
 	}
 
+	ux500_wdt.parent = &pdev->dev;
 	watchdog_set_nowayout(&ux500_wdt, nowayout);
 
 	/* disable auto off on sleep */
diff --git a/drivers/watchdog/via_wdt.c b/drivers/watchdog/via_wdt.c
index 56369c4f1961..5f9cbc37520d 100644
--- a/drivers/watchdog/via_wdt.c
+++ b/drivers/watchdog/via_wdt.c
@@ -206,6 +206,7 @@ static int wdt_probe(struct pci_dev *pdev,
 		timeout = WDT_TIMEOUT;
 
 	wdt_dev.timeout = timeout;
+	wdt_dev.parent = &pdev->dev;
 	watchdog_set_nowayout(&wdt_dev, nowayout);
 	if (readl(wdt_mem) & VIA_WDT_FIRED)
 		wdt_dev.bootstatus |= WDIOF_CARDRESET;
diff --git a/drivers/watchdog/wm831x_wdt.c b/drivers/watchdog/wm831x_wdt.c
index 2fa17e746ff6..8d1184aee932 100644
--- a/drivers/watchdog/wm831x_wdt.c
+++ b/drivers/watchdog/wm831x_wdt.c
@@ -215,6 +215,7 @@ static int wm831x_wdt_probe(struct platform_device *pdev)
 
 	wm831x_wdt->info = &wm831x_wdt_info;
 	wm831x_wdt->ops = &wm831x_wdt_ops;
+	wm831x_wdt->parent = &pdev->dev;
 	watchdog_set_nowayout(wm831x_wdt, nowayout);
 	watchdog_set_drvdata(wm831x_wdt, driver_data);
 
diff --git a/drivers/watchdog/wm8350_wdt.c b/drivers/watchdog/wm8350_wdt.c
index 34d272ada23d..4ab4b8347d45 100644
--- a/drivers/watchdog/wm8350_wdt.c
+++ b/drivers/watchdog/wm8350_wdt.c
@@ -151,6 +151,7 @@ static int wm8350_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_nowayout(&wm8350_wdt, nowayout);
 	watchdog_set_drvdata(&wm8350_wdt, wm8350);
+	wm8350_wdt.parent = &pdev->dev;
 
 	/* Default to 4s timeout */
 	wm8350_wdt_set_timeout(&wm8350_wdt, 4);
-- 
2.4.3
