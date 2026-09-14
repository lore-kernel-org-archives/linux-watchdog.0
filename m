Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2DD420468;
	Mon, 14 Sep 2026 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377701; cv=none; b=WDzfvgSMlgd8aznLNP1zPZdpbTk8x3c8aRyOZnqSnFyWYiv/rw4FxUDJIssHY/v2v8QsYuoOtZqFJoi+cMbBTKAptm3OF17OM5/8NPp3yy+rJhnefkFHx2BR12Px8uLisbvm15G/g7q/9g2YWcb3Z+LcjR6pjNPrufve+PV3F+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377701; c=relaxed/simple;
	bh=rOx5USgvuTxJyuoRcB/WIiOPs7OWa9OwZx4bOpM8rdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RV5KeZ+bk107VwWRGP+yMvXZpWmmXG3wD5DHIejTTFVMc9mSDhdFqatdiheUuPn7nEMUfBEcXiksQNqI2e0EH8nuXWyYMLP9uiDHz54I6GhF2jH5mGg0zZetSAtwJeMIf9EI7CwSzBdQHbRhFOz4IJmfufye1DfVpzmJ/jgrUD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 416CF20025C;
	Mon, 14 Sep 2026 11:21:37 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D5AE720025A;
	Mon, 14 Sep 2026 11:21:36 +0200 (CEST)
Received: from lsv03900.swis.in-blr01.nxp.com (lsv03900.swis.in-blr01.nxp.com [10.12.177.15])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A2291180006C;
	Mon, 14 Sep 2026 17:21:35 +0800 (+08)
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
Subject: [PATCH v6 5/5] rtc: pcf85363: add watchdog support with configurable step size
Date: Mon, 14 Sep 2026 14:51:26 +0530
Message-Id: <20260914092126.3757418-5-lakshay.piplani@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260914092126.3757418-1-lakshay.piplani@nxp.com>
References: <20260914092126.3757418-1-lakshay.piplani@nxp.com>
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
V5 -> V6:
- Adopt an already-running watchdog (bootloader- or battery-backed):
  read CTRL_WDOG until two reads agree, set WDOG_HW_RUNNING and re-arm
  WDIE when it is running, otherwise leave WDIE masked. Do not decode
  the live countdown as the configured timeout; keep the fixed default
  and let the core's first keep-alive reload it
- Report watchdog probe failures via dev_err_probe()

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
 drivers/rtc/rtc-pcf85363.c | 259 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 258 insertions(+), 2 deletions(-)

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
index 22661abd9ebb..aa45d71e6ab5 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -23,6 +23,7 @@
 #include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/string.h>
+#include <linux/watchdog.h>
 
 #include <dt-bindings/rtc/pcf85363-tsr.h>
 
@@ -147,6 +148,24 @@
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
+/* CTRL_WDOG reads back the live countdown; retry until two reads agree. */
+#define WD_READ_RETRIES		3
+
 /* Cached timestamp; the flag is cleared once the value is copied here. */
 struct pcf85363_ts {
 	bool valid;
@@ -169,6 +188,13 @@ struct pcf85x63_config {
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
@@ -483,12 +509,13 @@ static irqreturn_t pcf85363_rtc_handle_irq(int irq, void *dev_id)
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
@@ -512,6 +539,15 @@ static irqreturn_t pcf85363_rtc_handle_irq(int irq, void *dev_id)
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
@@ -691,6 +727,215 @@ static const struct pcf85x63_config pcf_85363_config = {
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
+/*
+ * CTRL_WDOG reads back the live countdown, which decrements while the
+ * watchdog runs, so a single read can catch a transient value. Read until
+ * two consecutive reads agree before deciding whether the watchdog is armed.
+ */
+static int pcf85363_read_wdog_stable(struct pcf85363 *pcf85363, unsigned int *out)
+{
+	unsigned int prev, cur;
+	int retries, ret;
+
+	ret = regmap_read(pcf85363->regmap, CTRL_WDOG, &prev);
+	if (ret)
+		return ret;
+
+	for (retries = 0; retries < WD_READ_RETRIES; retries++) {
+		ret = regmap_read(pcf85363->regmap, CTRL_WDOG, &cur);
+		if (ret)
+			return ret;
+
+		if (cur == prev) {
+			*out = cur;
+			return 0;
+		}
+
+		prev = cur;
+	}
+
+	*out = cur;
+	return 0;
+}
+
+static int pcf85363_watchdog_init(struct device *dev, struct pcf85363 *pcf85363)
+{
+	struct pcf85363_watchdog *wd;
+	unsigned int regval;
+	bool running;
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
+	/*
+	 * Fixed default timeout; userspace can change it via WDIOC_SETTIMEOUT.
+	 * CTRL_WDOG reads back the live countdown, not the programmed reload
+	 * value, so it must not be decoded into wdd.timeout: adopt the known
+	 * default and let the watchdog core's first keep-alive reload it.
+	 */
+	pcf85363_wdt_select_clock(wd);
+
+	/*
+	 * The counter and WDIE are battery-backed and survive a reboot, so a
+	 * bootloader may leave the watchdog armed. Detect that and hand it to
+	 * the core as already-running rather than silently disabling it; only
+	 * a stopped watchdog gets WDIE masked so a stale enable cannot storm
+	 * the level-triggered INTA line.
+	 */
+	ret = pcf85363_read_wdog_stable(pcf85363, &regval);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to read watchdog register\n");
+
+	running = ((regval >> WD_TIMEOUT_SHIFT) & WD_COUNT_MAX) != 0;
+
+	ret = pcf85363_clear_flags(pcf85363, FLAGS_WDF);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to clear WDF\n");
+
+	/*
+	 * Once WDOG_HW_RUNNING is set the core keeps the watchdog alive via
+	 * .ping(), which does not touch WDIE, so arm WDIE here for an adopted
+	 * watchdog; otherwise keep it masked.
+	 */
+	ret = regmap_update_bits(pcf85363->regmap, CTRL_INTA_EN, INT_WDIE,
+				 running ? INT_WDIE : 0);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to configure WDIE\n");
+
+	if (running)
+		set_bit(WDOG_HW_RUNNING, &wd->wdd.status);
+
+	watchdog_set_drvdata(&wd->wdd, wd);
+
+	return devm_watchdog_register_device(dev, &wd->wdd);
+}
+
 /* Six BCD bytes; bit 7 of the seconds byte is reserved, not time data. */
 static ssize_t pcf85363_format_timestamp(const u8 *regs, char *buf)
 {
@@ -971,6 +1216,16 @@ static int pcf85363_probe(struct i2c_client *client)
 		clear_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
 	}
 
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
 	dev_set_drvdata(&pcf85363->rtc->dev, pcf85363);
 
 	ret = rtc_add_group(pcf85363->rtc, &pcf85363_attr_group);
-- 
2.25.1

