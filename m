Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581953AA50B;
	Thu, 10 Sep 2026 05:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789016887; cv=none; b=F/t41qsgP6HnIOCzh3FmT1sq5EMFz1A505PZ6vul+3/iQ3sgO00x8NCuE1HI7Gf48kc5zSTcPiqSgD9la8kfzEZpMobIZ1L5ZJr0+PI6aZ2U7bnloDEEvgleKIqtesiAJsxV9lPu3g+sbrq36dq4W35dg/PllnQtR0QBXDn6lhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789016887; c=relaxed/simple;
	bh=8Jal5HGjK356Dc65FpCPalwFLsiPY6g+TRNhA3Ci2tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y2QT5bw6Fe//K02DKPlLn8LFyjEVhciKM0JtoJCnqoRLSZBijHEimjQob3mUB+cAsmIGMrfvs/Q64jlPhGP0nu3YIB3LsXCKSMq2O/2XeBixtekoWiFX3JjYOrLlpZ+4+OqHXcsygEn+wPJ3VDsyrIma3KrQKZFb4XXH/6CY0As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0818F200387;
	Thu, 10 Sep 2026 07:07:58 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CD10E20036F;
	Thu, 10 Sep 2026 07:07:57 +0200 (CEST)
Received: from lsv03900.swis.in-blr01.nxp.com (lsv03900.swis.in-blr01.nxp.com [10.12.177.15])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 916F21800068;
	Thu, 10 Sep 2026 13:07:56 +0800 (+08)
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
Subject: [PATCH v5 5/5] rtc: pcf85363: add watchdog support with configurable step size
Date: Thu, 10 Sep 2026 10:37:47 +0530
Message-Id: <20260910050747.1901440-5-lakshay.piplani@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260910050747.1901440-1-lakshay.piplani@nxp.com>
References: <20260910050747.1901440-1-lakshay.piplani@nxp.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Add watchdog support to PCF85263/PCF85363 using the watchdog subsystem.
The 5-bit count selects the timeout with a clock step: timeouts up to
30 seconds use the 1 Hz step, longer ones the 0.25 Hz step (max 120 s),
reported back through the watchdog device. One count of margin is added
because the first period after a reload lasts between WDR and WDR-1
counts, so the timeout is never shorter than requested. Select
WATCHDOG_CORE if WATCHDOG so the device can register.

The chip has no reset output; expiry is only signalled via the WDF flag
routed to INTA, so this is an alarm-only watchdog (WDIOF_ALARMONLY). WDIE
is toggled on start/stop with rollback-safe register ordering, expiry is
rate-limited from the IRQ handler, and the watchdog is only registered
when an interrupt line is present. WDF is cleared through the
write-0-to-clear helper.

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>

---
V4 -> V5:
- Select WATCHDOG_CORE if WATCHDOG so the device can register.
- Scale the timeout by the clock select with one count of margin (1 Hz
  step up to 30 s, else 0.25 Hz, max 120 s) and report it back.
- Alarm-only watchdog (WDIOF_ALARMONLY): expiry is only signalled via WDF
  routed to INTA; toggle WDIE on start/stop with rollback-safe ordering.
- Don't program WDR from .set_timeout when inactive (it would start the
  watchdog); only reload when watchdog_active(), and drop the clamp.
- Register the watchdog only when an interrupt line is present.
- Use a fixed default timeout (no timeout-sec); userspace can change it.
- Give the watchdog struct a back-pointer to struct pcf85363 and clear
  WDF via the shared write-0-to-clear helper.

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
---
---
 drivers/rtc/Kconfig        |   1 +
 drivers/rtc/rtc-pcf85363.c | 196 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 195 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 05b9233b9418..4871cb3fb24d 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -516,6 +516,7 @@ config RTC_DRV_PCF8523
 config RTC_DRV_PCF85363
 	tristate "NXP PCF85363"
 	select REGMAP_I2C
+	select WATCHDOG_CORE if WATCHDOG
 	help
 	  If you say yes here you get support for the PCF85363 RTC chip.
 
diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index 9da4b1617f82..2046643788fd 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -23,6 +23,7 @@
 #include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/string.h>
+#include <linux/watchdog.h>
 
 #include <dt-bindings/rtc/pcf85363-tsr.h>
 
@@ -147,6 +148,22 @@
 #define PCF85363_SEC_MASK	0x7F
 #define PCF85363_TS_READ_RETRIES	3
 
+#define WD_TIMEOUT_SHIFT        2
+#define WD_CLKSEL_MASK  GENMASK(1, 0)
+#define WD_CLKSEL_0_25HZ        0x00
+#define WD_CLKSEL_1HZ   0x01
+#define WD_CLKSEL_4HZ   0x02
+#define WD_CLKSEL_16HZ  0x03
+#define WD_MODE_REPEAT	BIT(7)
+
+#define WD_DEFAULT_TIMEOUT  10
+#define WD_TIMEOUT_MIN	1
+#define WD_COUNT_MAX	0x1F
+/* Longest guaranteed timeout at the 0.25 Hz step (WDR=31, one count margin). */
+#define WD_TIMEOUT_MAX	120
+/* Longest timeout served by the 1 Hz step (WDR=31, one count margin). */
+#define WD_TIMEOUT_1HZ_MAX	30
+
 /* Cached timestamp; the flag is cleared once the value is copied here. */
 struct pcf85363_ts {
 	bool valid;
@@ -169,6 +186,13 @@ struct pcf85x63_config {
 	unsigned int num_nvram;
 };
 
+struct pcf85363_watchdog {
+	struct watchdog_device wdd;
+	struct pcf85363 *pcf85363;
+	u8 timeout_val;
+	u8 clock_sel;
+};
+
 /*
  * CTRL_FLAGS is write-0-to-clear, so write the complement of the mask to
  * clear only the requested bits without disturbing the others.
@@ -483,12 +507,13 @@ static irqreturn_t pcf85363_rtc_handle_irq(int irq, void *dev_id)
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
@@ -512,6 +537,15 @@ static irqreturn_t pcf85363_rtc_handle_irq(int irq, void *dev_id)
 		handled = true;
 	}
 
+	if (flags & FLAGS_WDF) {
+		dev_warn_ratelimited(&pcf85363->rtc->dev,
+				     "watchdog timer expired\n");
+		if (pcf85363_clear_flags(pcf85363, FLAGS_WDF))
+			dev_err(&pcf85363->rtc->dev,
+				"failed to clear watchdog flag\n");
+		handled = true;
+	}
+
 	/*
 	 * Clear flags this handler does not service (e.g. A2F/PIF); otherwise
 	 * they hold the level-triggered INTA line asserted and storm the IRQ.
@@ -691,6 +725,153 @@ static const struct pcf85x63_config pcf_85363_config = {
 	.num_nvram = 2
 };
 
+/*
+ * Program the watchdog counter (WDR) so the reported timeout is never
+ * shorter than requested: the first period after a reload lasts between
+ * WDR and WDR-1 counts, so add one count of margin. Timeouts up to 30 s
+ * use the 1 Hz step (1 s/count); longer ones the 0.25 Hz step (4 s/count).
+ */
+static void pcf85363_wdt_select_clock(struct pcf85363_watchdog *wd)
+{
+	unsigned int timeout = wd->wdd.timeout;
+
+	if (timeout <= WD_TIMEOUT_1HZ_MAX) {
+		wd->clock_sel = WD_CLKSEL_1HZ;
+		wd->timeout_val = timeout + 1;
+		wd->wdd.timeout = timeout;
+	} else {
+		wd->clock_sel = WD_CLKSEL_0_25HZ;
+		wd->timeout_val = DIV_ROUND_UP(timeout, 4) + 1;
+		wd->wdd.timeout = DIV_ROUND_UP(timeout, 4) * 4;
+	}
+}
+
+/* Repeat mode restarts the watchdog automatically after each period. */
+static int pcf85363_wdt_reload(struct pcf85363_watchdog *wd)
+{
+	u8 val;
+
+	val = WD_MODE_REPEAT |
+	      ((wd->timeout_val & WD_COUNT_MAX) << WD_TIMEOUT_SHIFT) |
+	      (wd->clock_sel & WD_CLKSEL_MASK);
+
+	return regmap_write(wd->pcf85363->regmap, CTRL_WDOG, val);
+}
+
+static int pcf85363_wdt_start(struct watchdog_device *wdd)
+{
+	struct pcf85363_watchdog *wd = watchdog_get_drvdata(wdd);
+	int ret;
+
+	/* Route WDF to INTA; alarm-only, the chip has no reset output. */
+	ret = regmap_update_bits(wd->pcf85363->regmap, CTRL_INTA_EN,
+				 INT_WDIE, INT_WDIE);
+	if (ret)
+		return ret;
+
+	ret = pcf85363_wdt_reload(wd);
+	if (ret)
+		regmap_update_bits(wd->pcf85363->regmap, CTRL_INTA_EN,
+				   INT_WDIE, 0);
+
+	return ret;
+}
+
+static int pcf85363_wdt_stop(struct watchdog_device *wdd)
+{
+	struct pcf85363_watchdog *wd = watchdog_get_drvdata(wdd);
+	int ret;
+
+	/* Halt the counter first so a failed disable cannot leave it armed. */
+	ret = regmap_write(wd->pcf85363->regmap, CTRL_WDOG, 0);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(wd->pcf85363->regmap, CTRL_INTA_EN,
+				  INT_WDIE, 0);
+}
+
+static int pcf85363_wdt_ping(struct watchdog_device *wdd)
+{
+	struct pcf85363_watchdog *wd = watchdog_get_drvdata(wdd);
+	int ret;
+
+	ret = pcf85363_clear_flags(wd->pcf85363, FLAGS_WDF);
+	if (ret)
+		return ret;
+
+	return pcf85363_wdt_reload(wd);
+}
+
+static int pcf85363_wdt_set_timeout(struct watchdog_device *wdd,
+				    unsigned int timeout)
+{
+	struct pcf85363_watchdog *wd = watchdog_get_drvdata(wdd);
+
+	wdd->timeout = timeout;
+
+	pcf85363_wdt_select_clock(wd);
+
+	/*
+	 * Programming the counter with a non-zero value starts it, so only
+	 * reprogram when the watchdog is already running; the core keeps the
+	 * new timeout for the next start otherwise.
+	 */
+	if (!watchdog_active(wdd))
+		return 0;
+
+	return pcf85363_wdt_reload(wd);
+}
+
+static const struct watchdog_info pcf85363_wdt_info = {
+	.identity = "PCF85363 Watchdog",
+	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_ALARMONLY,
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
+static int pcf85363_watchdog_init(struct device *dev, struct pcf85363 *pcf85363)
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
+	wd->pcf85363 = pcf85363;
+
+	wd->wdd.info = &pcf85363_wdt_info;
+	wd->wdd.ops = &pcf85363_wdt_ops;
+	wd->wdd.min_timeout = WD_TIMEOUT_MIN;
+	wd->wdd.max_timeout = WD_TIMEOUT_MAX;
+	wd->wdd.timeout = WD_DEFAULT_TIMEOUT;
+	wd->wdd.parent = dev;
+	wd->wdd.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
+
+	/* Fixed default timeout; userspace can change it via WDIOC_SETTIMEOUT. */
+	pcf85363_wdt_select_clock(wd);
+
+	ret = pcf85363_clear_flags(pcf85363, FLAGS_WDF);
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
 /* Six BCD bytes; bit 7 of the seconds byte is reserved, not time data. */
 static ssize_t pcf85363_format_timestamp(const u8 *regs, char *buf)
 {
@@ -943,6 +1124,17 @@ static int pcf85363_probe(struct i2c_client *client)
 		/* Without an interrupt line the alarm cannot be delivered. */
 		clear_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
 	}
+
+	/*
+	 * Watchdog expiry is only signalled via INTA (no reset output), so it
+	 * needs an interrupt line to be usable.
+	 */
+	if (irq_a > 0) {
+		ret = pcf85363_watchdog_init(dev, pcf85363);
+		if (ret)
+			return dev_err_probe(dev, ret, "Watchdog init failed\n");
+	}
+
 	if (irq_a > 0 || wakeup_source)
 		device_init_wakeup(dev, true);
 
-- 
2.25.1

