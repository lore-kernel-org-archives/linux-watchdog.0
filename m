Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D583AAF78;
	Wed, 12 Aug 2026 07:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520753; cv=none; b=V46efnlEMq8OEDhcOnUIbfdK0brGRqKFn3B6yOOHtUjplwsT/mHxFKnWMsu4Ddj5ud9xB83BnRtvrieY3AWRqxSr6da5EwW2OFsVmg4mRCl2eoJ9yVBcr+o9gK4PotGvGbg2XxVHG1Ga4v/wECmRd2eK/UvfqzgGmfIP94T6AqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520753; c=relaxed/simple;
	bh=0xLHKJRlH3i1y/AQ+NXkZQ/ixgpx+IYi2vXeJpwiXuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KBhl/zs9n76WmuzM0P3yqN9BUbsPfbty6tXo1a82M/0rlB6oVX33+N1pK8OzwsWr3pqypz93sXGcxo/ogi9Xz5Nc/HBlJXfyxq/T/6FHUeN/5M8lJEDNmjasC+C1LyMBaZHuEABckK7/FsRdxDtiuLhTBX+BBzk4LppjDnq8qx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B01D21A02A7;
	Wed, 12 Aug 2026 09:45:46 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7FD121A02BF;
	Wed, 12 Aug 2026 09:45:46 +0200 (CEST)
Received: from lsv03900.swis.in-blr01.nxp.com (lsv03900.swis.in-blr01.nxp.com [10.12.177.15])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id F272718000B0;
	Wed, 12 Aug 2026 15:45:45 +0800 (+08)
From: Lakshay Piplani <lakshay.piplani@nxp.com>
To: alexandre.belloni@bootlin.com,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	wim@linux-watchdog.org,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net
Cc: vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	Lakshay Piplani <lakshay.piplani@nxp.com>
Subject: [RESEND v4 5/5] rtc: pcf85363: add watchdog support with configurable step size
Date: Wed, 12 Aug 2026 13:15:33 +0530
Message-Id: <20260812074533.3545058-5-lakshay.piplani@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260812074533.3545058-1-lakshay.piplani@nxp.com>
References: <20260812074533.3545058-1-lakshay.piplani@nxp.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Add watchdog timer support to PCF85263/PCF85363 using the linux watchdog
subsystem. The driver programs the hardware watchdog timeout based on
the requested period.

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
---
V3 -> V4:
- Use watchdog_init_timeout(&wd->wdd, 0, dev) to allow devicetree or module parameter overrides; 
  fallback to WD_DEFAULT_TIMEOUT if not provided.
- Centralized clock selection logic in pcf85363_wdt_select_clock() and applied dynamically 
  whenever timeout changes.
- Removed unused repeat variable and simplified timeout handling for clarity.
V2 -> V3:
- Split into separate patches as suggested:
  - Battery switch-over detection.
  - Timestamp recording for TS pin and battery switch-over events.
  - Offset calibration.
  - Watchdog timer (to be reviewed by watchdog maintainers).
- Dropped Alarm2 support
- Switched to rtc_add_group() for sysfs attributes
V1 -> V2:
- Watchdog related changes due to removal of vendor specific properties
  from device tree
  * remove vendor DT knobs (enable/timeout/stepsize/repeat)
  * use watchdog_init_timeout (with 10s default)
  * derive clock_sel from final timeout
  * default, repeat=true (repeat mode)
- Fixed uninitalised warning on 'ret' (reported by kernel test robot)
- Use dev_dbg instead of dev_info for debug related print messages
- Minor cleanup and comments.

 drivers/rtc/rtc-pcf85363.c | 156 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index 665bbbb169b0..3eb87306c83c 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -5,6 +5,10 @@
  * Driver for NXP PCF85363 real-time clock.
  *
  * Copyright (C) 2017 Eric Nelson
+ *
+ * Copyright 2025 NXP
+ * Added support for timestamps, battery switch-over,
+ * watchdog, offset calibration.
  */
 #include <linux/module.h>
 #include <linux/i2c.h>
@@ -18,6 +22,7 @@
 #include <linux/of.h>
 #include <linux/rtc.h>
 #include <linux/regmap.h>
+#include <linux/watchdog.h>
 
 /*
  * Date/Time registers
@@ -128,6 +133,17 @@
 #define OFFSET_MAXIMUM  127
 #define OFFSET_MASK     0xFF
 
+#define WD_TIMEOUT_SHIFT        2
+#define WD_CLKSEL_MASK  GENMASK(1, 0)
+#define WD_CLKSEL_0_25HZ        0x00
+#define WD_CLKSEL_1HZ   0x01
+#define WD_CLKSEL_4HZ   0x02
+#define WD_CLKSEL_16HZ  0x03
+
+#define WD_DEFAULT_TIMEOUT  10
+#define WD_TIMEOUT_MIN	1
+#define WD_TIMEOUT_MAX	0x1F
+
 struct pcf85363 {
 	struct rtc_device	*rtc;
 	struct regmap		*regmap;
@@ -139,6 +155,14 @@ struct pcf85x63_config {
 	unsigned int num_nvram;
 };
 
+struct pcf85363_watchdog {
+	struct watchdog_device wdd;
+	struct regmap *regmap;
+	struct device *dev;
+	u8 timeout_val;
+	u8 clock_sel;
+};
+
 static int pcf85363_load_capacitance(struct pcf85363 *pcf85363, struct device_node *node)
 {
 	u32 load = 7000;
@@ -324,12 +348,13 @@ static irqreturn_t pcf85363_rtc_handle_irq(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	if (flags) {
-		dev_dbg(&pcf85363->rtc->dev, "IRQ flags: 0x%02x%s%s%s%s%s\n",
+		dev_dbg(&pcf85363->rtc->dev, "IRQ flags: 0x%02x%s%s%s%s%s%s\n",
 			flags, (flags & FLAGS_A1F) ? " [A1F]" : "",
 			(flags & FLAGS_TSR1F) ? " [TSR1F]" : "",
 			(flags & FLAGS_TSR2F) ? " [TSR2F]" : "",
 			(flags & FLAGS_TSR3F) ? " [TSR3F]" : "",
-			(flags & FLAGS_BSF) ? " [BSF]" : "");
+			(flags & FLAGS_BSF) ? " [BSF]" : "",
+			(flags & FLAGS_WDF) ? " [WDF]" : "");
 	}
 
 	if (flags & FLAGS_A1F) {
@@ -361,6 +386,11 @@ static irqreturn_t pcf85363_rtc_handle_irq(int irq, void *dev_id)
 		handled = true;
 	}
 
+	if (flags & FLAGS_WDF) {
+		regmap_update_bits(pcf85363->regmap, CTRL_FLAGS, FLAGS_WDF, 0);
+		handled = true;
+	}
+
 	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
@@ -504,6 +534,124 @@ static const struct pcf85x63_config pcf_85363_config = {
 	.num_nvram = 2
 };
 
+static void pcf85363_wdt_select_clock(struct pcf85363_watchdog *wd)
+{
+	unsigned int t = wd->wdd.timeout;
+
+	if (t <= 2)
+		wd->clock_sel = WD_CLKSEL_16HZ;
+	else if (t <= 8)
+		wd->clock_sel = WD_CLKSEL_4HZ;
+	else if (t <= 16)
+		wd->clock_sel = WD_CLKSEL_1HZ;
+	else
+		wd->clock_sel = WD_CLKSEL_0_25HZ;
+}
+
+/*
+ * This function sets the watchdog control register based on the timeout,
+ * clock selection and repeat mode settings. It prepares the value to
+ * write into the watchdog control register (CTRL_WDOG).
+ */
+static int pcf85363_wdt_reload(struct pcf85363_watchdog *wd)
+{
+	u8 val;
+
+	val = ((wd->timeout_val & WD_TIMEOUT_MAX) << WD_TIMEOUT_SHIFT) |
+	       (wd->clock_sel & WD_CLKSEL_MASK);
+
+	return regmap_write(wd->regmap, CTRL_WDOG, val);
+}
+
+static int pcf85363_wdt_start(struct watchdog_device *wdd)
+{
+	struct pcf85363_watchdog *wd = watchdog_get_drvdata(wdd);
+
+	return pcf85363_wdt_reload(wd);
+}
+
+static int pcf85363_wdt_stop(struct watchdog_device *wdd)
+{
+	struct pcf85363_watchdog *wd = watchdog_get_drvdata(wdd);
+
+	return regmap_write(wd->regmap, CTRL_WDOG, 0);
+}
+
+static int pcf85363_wdt_ping(struct watchdog_device *wdd)
+{
+	struct pcf85363_watchdog *wd = watchdog_get_drvdata(wdd);
+
+	regmap_update_bits(wd->regmap, CTRL_FLAGS, FLAGS_WDF, 0);
+
+	return pcf85363_wdt_reload(wd);
+}
+
+static int pcf85363_wdt_set_timeout(struct watchdog_device *wdd,
+				    unsigned int timeout)
+{
+	struct pcf85363_watchdog *wd = watchdog_get_drvdata(wdd);
+
+	wd->timeout_val = clamp(timeout, WD_TIMEOUT_MIN, WD_TIMEOUT_MAX);
+	wdd->timeout = wd->timeout_val;
+
+	pcf85363_wdt_select_clock(wd);
+
+	return pcf85363_wdt_reload(wd);
+}
+
+static const struct watchdog_info pcf85363_wdt_info = {
+	.identity = "PCF85363 Watchdog",
+	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+};
+
+static const struct watchdog_ops pcf85363_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = pcf85363_wdt_start,
+	.stop = pcf85363_wdt_stop,
+	.ping = pcf85363_wdt_ping,
+	.set_timeout = pcf85363_wdt_set_timeout,
+};
+
+static int pcf85363_watchdog_init(struct device *dev, struct regmap *regmap)
+{
+	struct pcf85363_watchdog *wd;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_WATCHDOG))
+		return 0;
+
+	wd = devm_kzalloc(dev, sizeof(*wd), GFP_KERNEL);
+	if (!wd)
+		return -ENOMEM;
+
+	wd->regmap = regmap;
+	wd->dev = dev;
+
+	wd->wdd.info = &pcf85363_wdt_info;
+	wd->wdd.ops = &pcf85363_wdt_ops;
+	wd->wdd.min_timeout = WD_TIMEOUT_MIN;
+	wd->wdd.max_timeout = WD_TIMEOUT_MAX;
+	wd->wdd.parent = dev;
+	wd->wdd.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
+
+	ret = watchdog_init_timeout(&wd->wdd, 0, dev);
+	if (ret)
+		wd->wdd.timeout = WD_DEFAULT_TIMEOUT;
+
+	wd->timeout_val = wd->wdd.timeout;
+	pcf85363_wdt_select_clock(wd);
+
+	ret = regmap_update_bits(regmap, CTRL_FLAGS, FLAGS_WDF, 0);
+	if (ret) {
+		dev_err(dev, "failed to clear WDF:%d\n", ret);
+		return ret;
+	}
+
+	watchdog_set_drvdata(&wd->wdd, wd);
+
+	return devm_watchdog_register_device(dev, &wd->wdd);
+}
+
 /*
  * Reads 6 bytes of timestamp data starting at the given base register,
  * converts them from BCD to binary, and formats the result into a
@@ -685,6 +833,10 @@ static int pcf85363_probe(struct i2c_client *client)
 			   PIN_IO_TSPM | PIN_IO_TSIM,
 			   PIN_IO_TSPM | PIN_IO_TSIM);
 
+	ret = pcf85363_watchdog_init(dev, pcf85363->regmap);
+	if (ret)
+		dev_err_probe(dev, ret, "Watchdog init failed\n");
+
 	if (irq_a > 0 || wakeup_source)
 		device_init_wakeup(dev, true);
 
-- 
2.25.1

