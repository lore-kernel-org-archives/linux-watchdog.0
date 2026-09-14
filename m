Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A479423A9A;
	Mon, 14 Sep 2026 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377704; cv=none; b=YwrhRiKas5Gn76yRA3YwAvhS1lP9b5L3SNmB+gX8yV8FUmJ30Rbd4WlMt2NOP90I+8zE7KXe3V/8Hlb3dTOQQ0I2qC5YhJzaiBfgB8qiOLCod9gpcO164XaMNxylISI/dmnmOyH9jNdPk2ytL2lfG71IwXSFB6a8R6QRWuHuVJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377704; c=relaxed/simple;
	bh=FzJ820tuBH7IMfvxIDS3r73fdXPEkuD8gEEsKcHgjcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qKfvPa19GZgdIsqajnbwxx6lYcECekkJHzaHhKHhPdDLPpVtiLPf1AAkJc027Kq2SCNtBgDiYL/3TD6e+vTdgd4oIj+jXieiIgl1Kwyn4qn2V50/k7i5fCsirQoVoPQ7viKLFsbq3MiNq9F96P2zNdUbg29bXSDGtIXsYphJp9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0169C1A00C1;
	Mon, 14 Sep 2026 11:21:35 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9CF851A0291;
	Mon, 14 Sep 2026 11:21:34 +0200 (CEST)
Received: from lsv03900.swis.in-blr01.nxp.com (lsv03900.swis.in-blr01.nxp.com [10.12.177.15])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 511FA18000BA;
	Mon, 14 Sep 2026 17:21:33 +0800 (+08)
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
Subject: [PATCH v6 3/5] rtc: pcf85363: add timestamp support with configurable timestamp mode
Date: Mon, 14 Sep 2026 14:51:24 +0530
Message-Id: <20260914092126.3757418-3-lakshay.piplani@nxp.com>
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

Add support for the timestamp capture registers on PCF85263/PCF85363,
which latch the time on selected events (TS pin or battery switch-over).
The capture source is selected via the nxp,timestamp-mode device tree
property and latched values are exported through read-only sysfs
attributes, refreshed on read so poll-only boards still latch events.

The two capture families need different handling: first-event modes hold
the value until the flag is cleared, so it is cached before clearing;
last-event modes overwrite on every event, so the flag is cleared first
and the block re-read until two reads agree.

While at it, register the attributes with rtc_add_group(), preserve
CTRL_INTA_EN with regmap_update_bits() instead of overwriting it, only
clear RTC_FEATURE_ALARM when no interrupt is available, and make the
nvmem_config array probe-local since it is patched per-device.

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>

---
V5 -> V6:
- Return -EPROBE_DEFER from probe when the IRQ request is deferred
  instead of silently disabling alarms; on any other failure warn and
  keep RTC timekeeping alive with interrupt-driven alarms disabled
- Configure the INTA pin and keep RTC_FEATURE_ALARM for
  wakeup-source-only boards (INTA routed to a PMIC) so rtcwake still
  works even without our own IRQ line

V4 -> V5:
- Handle first-event (cache before clearing) and last-event (clear, then
  re-read until stable, -EAGAIN on a torn read) capture modes separately,
  and propagate register-access errors, surfaced on the sysfs read path.
- Refresh the cache on sysfs read so poll-only boards still latch events.
- Treat a failed DT_TS_MODE write as fatal, and drive the TS pin only for
  the TS-pin modes: set TSPM and leave TSIM at its reset default.
- Preserve CTRL_INTA_EN via regmap_update_bits(); enable INT_TSRIE only
  when a timestamp mode is configured, and check the INTA writes.
- Clear RTC_FEATURE_ALARM only when no interrupt is available.
- Make the nvmem_config array probe-local, mask the reserved seconds bit,
  and don't hardcode IRQF_TRIGGER_LOW for a firmware-node interrupt.

V3 -> V4:
- No changes in v4.

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
 drivers/rtc/rtc-pcf85363.c | 396 +++++++++++++++++++++++++++++++------
 1 file changed, 341 insertions(+), 55 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index c8c04312bc58..5cc854d617f3 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -5,6 +5,10 @@
  * Driver for NXP PCF85363 real-time clock.
  *
  * Copyright (C) 2017 Eric Nelson
+ *
+ * Copyright 2025-2026 NXP
+ * Added support for timestamps, battery switch-over,
+ * watchdog, offset calibration.
  */
 #include <linux/module.h>
 #include <linux/i2c.h>
@@ -18,6 +22,9 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
+#include <linux/string.h>
+
+#include <dt-bindings/rtc/pcf85363-tsr.h>
 
 /*
  * Date/Time registers
@@ -102,22 +109,50 @@
 #define PIN_IO_INTA_OUT	2
 #define PIN_IO_INTA_HIZ	3
 
+#define PIN_IO_TSPM     GENMASK(3, 2)
+#define PIN_IO_TSIM     BIT(4)
+
 #define OSC_CAP_SEL	GENMASK(1, 0)
 #define OSC_CAP_6000	0x01
 #define OSC_CAP_12500	0x02
 
 #define STOP_EN_STOP	BIT(0)
 
+#define RTCM_BIT        BIT(4)
+
 #define RESET_CPR	0xa4
 
 #define NVRAM_SIZE	0x40
 
+#define TSR1_MASK       0x03
+#define TSR2_MASK       0x07
+#define TSR3_MASK       0x03
+#define TSR1_SHIFT      0
+#define TSR2_SHIFT      2
+#define TSR3_SHIFT      6
+
+#define PCF85363_NUM_TS		3
+/* Bytes latched per timestamp register (sec, min, hour, day, mon, year). */
+#define PCF85363_TS_LEN		6
+/* Bit 7 of the seconds byte is reserved, not time data; mask it off. */
+#define PCF85363_SEC_MASK	0x7F
+#define PCF85363_TS_READ_RETRIES	3
+
+/* Cached timestamp; the flag is cleared once the value is copied here. */
+struct pcf85363_ts {
+	bool valid;
+	u8 regs[PCF85363_TS_LEN];
+};
+
 struct pcf85363 {
 	struct rtc_device	*rtc;
 	struct regmap		*regmap;
 	/* Serialises access to the cached event state below. */
 	struct mutex		lock;
 	bool			bsf;
+	struct pcf85363_ts	ts[PCF85363_NUM_TS];
+	/* Per-TSR: true when the register uses a last-event capture mode. */
+	bool			ts_last_event[PCF85363_NUM_TS];
 };
 
 struct pcf85x63_config {
@@ -306,23 +341,114 @@ static int pcf85363_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	return _pcf85363_rtc_alarm_irq_enable(pcf85363, alrm->enabled);
 }
 
+static const u8 pcf85363_ts_base[PCF85363_NUM_TS] = {
+	DT_TIMESTAMP1, DT_TIMESTAMP2, DT_TIMESTAMP3,
+};
+
+static const u8 pcf85363_ts_flag[PCF85363_NUM_TS] = {
+	FLAGS_TSR1F, FLAGS_TSR2F, FLAGS_TSR3F,
+};
+
+/* Mark which TSRs use a last-event mode; those need torn-read handling. */
+static void pcf85363_classify_ts_modes(struct pcf85363 *pcf85363, u8 tsmode)
+{
+	u8 m1 = (tsmode >> TSR1_SHIFT) & TSR1_MASK;
+	u8 m2 = (tsmode >> TSR2_SHIFT) & TSR2_MASK;
+	u8 m3 = (tsmode >> TSR3_SHIFT) & TSR3_MASK;
+
+	pcf85363->ts_last_event[0] = (m1 == PCF85363_TSR1_LE);
+	pcf85363->ts_last_event[1] = (m2 == PCF85363_TSR2_LB ||
+				      m2 == PCF85363_TSR2_LV ||
+				      m2 == PCF85363_TSR2_LE);
+	pcf85363->ts_last_event[2] = (m3 == PCF85363_TSR3_LB ||
+				      m3 == PCF85363_TSR3_LV);
+}
+
 /*
- * Latch a pending battery-switch event into the software cache. Runs from
- * the IRQ handler and the RTC_VL_READ path, so it is seen with or without
- * an interrupt line. BSF is cached before it is cleared so it survives
- * re-arming. Caller must hold pcf85363->lock. Returns a negative errno on
- * a register-access failure, otherwise the handled flag mask.
+ * Last-event registers can change under us; re-read the block until two
+ * consecutive reads agree, then publish the stable value. Reject a torn
+ * read with -EAGAIN once the retry budget is exhausted.
+ */
+static int pcf85363_read_ts_stable(struct pcf85363 *pcf85363, int i)
+{
+	u8 prev[PCF85363_TS_LEN], cur[PCF85363_TS_LEN];
+	int retries, ret;
+
+	ret = regmap_bulk_read(pcf85363->regmap, pcf85363_ts_base[i],
+			       prev, PCF85363_TS_LEN);
+	if (ret)
+		return ret;
+
+	for (retries = 0; retries < PCF85363_TS_READ_RETRIES; retries++) {
+		ret = regmap_bulk_read(pcf85363->regmap, pcf85363_ts_base[i],
+				       cur, PCF85363_TS_LEN);
+		if (ret)
+			return ret;
+
+		if (!memcmp(prev, cur, PCF85363_TS_LEN)) {
+			memcpy(pcf85363->ts[i].regs, cur, PCF85363_TS_LEN);
+			return 0;
+		}
+
+		memcpy(prev, cur, PCF85363_TS_LEN);
+	}
+
+	return -EAGAIN;
+}
+
+/*
+ * Latch pending events into the cache. First-event modes hold the value
+ * until the flag is cleared, so cache before clearing; last-event modes
+ * overwrite every event, so clear first then read until stable. Runs from
+ * the IRQ and sysfs paths; caller holds the lock. Returns a negative errno
+ * on a register-access failure (including -EAGAIN for a torn last-event
+ * read), otherwise the handled flag mask.
  */
 static int pcf85363_collect_events(struct pcf85363 *pcf85363)
 {
 	unsigned int flags;
 	int handled = 0;
-	int ret;
+	int i, ret;
 
 	ret = regmap_read(pcf85363->regmap, CTRL_FLAGS, &flags);
 	if (ret)
 		return ret;
 
+	for (i = 0; i < PCF85363_NUM_TS; i++) {
+		if (!(flags & pcf85363_ts_flag[i]))
+			continue;
+
+		if (pcf85363->ts_last_event[i]) {
+			ret = pcf85363_clear_flags(pcf85363,
+						   pcf85363_ts_flag[i]);
+			if (ret)
+				return ret;
+
+			ret = pcf85363_read_ts_stable(pcf85363, i);
+			if (ret)
+				return ret;
+
+			pcf85363->ts[i].valid = true;
+			handled |= pcf85363_ts_flag[i];
+		} else {
+			ret = regmap_bulk_read(pcf85363->regmap,
+					       pcf85363_ts_base[i],
+					       pcf85363->ts[i].regs,
+					       PCF85363_TS_LEN);
+			if (ret)
+				return ret;
+
+			pcf85363->ts[i].valid = true;
+
+			ret = pcf85363_clear_flags(pcf85363,
+						   pcf85363_ts_flag[i]);
+			if (ret)
+				return ret;
+
+			handled |= pcf85363_ts_flag[i];
+		}
+	}
+
 	if (flags & FLAGS_BSF) {
 		pcf85363->bsf = true;
 
@@ -348,8 +474,11 @@ static irqreturn_t pcf85363_rtc_handle_irq(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	if (flags) {
-		dev_dbg(&pcf85363->rtc->dev, "IRQ flags: 0x%02x%s%s\n",
+		dev_dbg(&pcf85363->rtc->dev, "IRQ flags: 0x%02x%s%s%s%s%s\n",
 			flags, (flags & FLAGS_A1F) ? " [A1F]" : "",
+			(flags & FLAGS_TSR1F) ? " [TSR1F]" : "",
+			(flags & FLAGS_TSR2F) ? " [TSR2F]" : "",
+			(flags & FLAGS_TSR3F) ? " [TSR3F]" : "",
 			(flags & FLAGS_BSF) ? " [BSF]" : "");
 	}
 
@@ -359,7 +488,7 @@ static irqreturn_t pcf85363_rtc_handle_irq(int irq, void *dev_id)
 		handled = true;
 	}
 
-	if (flags & FLAGS_BSF) {
+	if (flags & (FLAGS_TSR1F | FLAGS_TSR2F | FLAGS_TSR3F | FLAGS_BSF)) {
 		guard(mutex)(&pcf85363->lock);
 
 		err = pcf85363_collect_events(pcf85363);
@@ -368,8 +497,8 @@ static irqreturn_t pcf85363_rtc_handle_irq(int irq, void *dev_id)
 					    "failed to collect events: %d\n",
 					    err);
 		/*
-		 * This is our interrupt source even if servicing it hit an
-		 * I/O error, so acknowledge the interrupt either way.
+		 * These are our interrupt sources even if servicing them hit
+		 * an I/O error, so acknowledge the interrupt either way.
 		 */
 		handled = true;
 	}
@@ -495,12 +624,88 @@ static const struct pcf85x63_config pcf_85363_config = {
 	.num_nvram = 2
 };
 
+/* Six BCD bytes; bit 7 of the seconds byte is reserved, not time data. */
+static ssize_t pcf85363_format_timestamp(const u8 *regs, char *buf)
+{
+	struct rtc_time tm;
+
+	tm.tm_sec = bcd2bin(regs[0] & PCF85363_SEC_MASK);
+	tm.tm_min = bcd2bin(regs[1]);
+	tm.tm_hour = bcd2bin(regs[2]);
+	tm.tm_mday = bcd2bin(regs[3]);
+	tm.tm_mon = bcd2bin(regs[4]) - 1;
+	tm.tm_year = bcd2bin(regs[5]) + 100;
+
+	return sysfs_emit(buf, "%04d-%02d-%02d %02d:%02d:%02d\n",
+			  tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
+			  tm.tm_hour, tm.tm_min, tm.tm_sec);
+}
+
+/* Refresh from hardware first so poll-only setups still latch events. */
+static ssize_t pcf85363_timestamp_show(struct device *dev, char *buf,
+				       unsigned int index)
+{
+	struct pcf85363 *pcf85363 = dev_get_drvdata(dev);
+	int ret;
+
+	guard(mutex)(&pcf85363->lock);
+
+	ret = pcf85363_collect_events(pcf85363);
+	if (ret < 0)
+		return ret;
+
+	if (!pcf85363->ts[index].valid)
+		return sysfs_emit(buf, "00-00-00 00:00:00\n");
+
+	return pcf85363_format_timestamp(pcf85363->ts[index].regs, buf);
+}
+
+static ssize_t timestamp1_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	return pcf85363_timestamp_show(dev, buf, 0);
+}
+static DEVICE_ATTR_RO(timestamp1);
+
+static ssize_t timestamp2_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	return pcf85363_timestamp_show(dev, buf, 1);
+}
+static DEVICE_ATTR_RO(timestamp2);
+
+static ssize_t timestamp3_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	return pcf85363_timestamp_show(dev, buf, 2);
+}
+static DEVICE_ATTR_RO(timestamp3);
+
+static struct attribute *pcf85363_attrs[] = {
+	&dev_attr_timestamp1.attr,
+	&dev_attr_timestamp2.attr,
+	&dev_attr_timestamp3.attr,
+	NULL,
+};
+
+static const struct attribute_group pcf85363_attr_group = {
+	.attrs = pcf85363_attrs,
+};
+
 static int pcf85363_probe(struct i2c_client *client)
 {
-	struct pcf85363 *pcf85363;
 	const struct pcf85x63_config *config = &pcf_85363_config;
 	const void *data = of_device_get_match_data(&client->dev);
-	static struct nvmem_config nvmem_cfg[] = {
+	struct device *dev = &client->dev;
+	struct pcf85363 *pcf85363;
+	int irq_a = client->irq;
+	bool ts_mode_configured = false;
+	bool wakeup_source;
+	int ret, i, err;
+	u32 tsr_mode[3];
+	u8 val;
+
+	struct nvmem_config nvmem_cfg[] = {
 		{
 			.name = "pcf85x63-",
 			.word_size = 1,
@@ -517,29 +722,72 @@ static int pcf85363_probe(struct i2c_client *client)
 			.reg_write = pcf85363_nvram_write,
 		},
 	};
-	int ret, i, err;
-	bool wakeup_source;
 
 	if (data)
 		config = data;
 
-	pcf85363 = devm_kzalloc(&client->dev, sizeof(struct pcf85363),
-				GFP_KERNEL);
+	pcf85363 = devm_kzalloc(&client->dev, sizeof(*pcf85363), GFP_KERNEL);
 	if (!pcf85363)
 		return -ENOMEM;
 
-	ret = devm_mutex_init(&client->dev, &pcf85363->lock);
+	ret = devm_mutex_init(dev, &pcf85363->lock);
 	if (ret)
 		return ret;
 
 	pcf85363->regmap = devm_regmap_init_i2c(client, &config->regmap);
-	if (IS_ERR(pcf85363->regmap)) {
-		dev_err(&client->dev, "regmap allocation failed\n");
-		return PTR_ERR(pcf85363->regmap);
-	}
+
+	if (IS_ERR(pcf85363->regmap))
+		return dev_err_probe(dev, PTR_ERR(pcf85363->regmap), "regmap init failed\n");
 
 	i2c_set_clientdata(client, pcf85363);
 
+	ret = regmap_update_bits(pcf85363->regmap, CTRL_FUNCTION, RTCM_BIT, 0);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable RTC mode\n");
+
+	if (!device_property_read_u32_array(dev, "nxp,timestamp-mode", tsr_mode, 3)) {
+		bool ts_pin_used;
+
+		tsr_mode[0] &= TSR1_MASK;
+		tsr_mode[1] &= TSR2_MASK;
+		tsr_mode[2] &= TSR3_MASK;
+
+		val = (tsr_mode[2] << TSR3_SHIFT) |
+		      (tsr_mode[1] << TSR2_SHIFT) |
+		      (tsr_mode[0] << TSR1_SHIFT);
+
+		ret = regmap_write(pcf85363->regmap, DT_TS_MODE, val);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to write timestamp mode register\n");
+
+		pcf85363_classify_ts_modes(pcf85363, val);
+
+		ts_mode_configured = tsr_mode[0] || tsr_mode[1] || tsr_mode[2];
+
+		/*
+		 * Only the TS-pin capture modes drive the TS pin. Select the
+		 * timestamp function (TSPM) for those and leave the input mode
+		 * (TSIM) at its reset default rather than forcing the
+		 * mechanical-switch detector.
+		 */
+		ts_pin_used = tsr_mode[0] == PCF85363_TSR1_FE ||
+			      tsr_mode[0] == PCF85363_TSR1_LE ||
+			      tsr_mode[1] == PCF85363_TSR2_FE ||
+			      tsr_mode[1] == PCF85363_TSR2_LE;
+
+		if (ts_pin_used) {
+			ret = regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
+						 PIN_IO_TSPM, PIN_IO_TSPM);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "Failed to configure TS pin\n");
+		}
+
+		dev_dbg(dev, "Timestamp mode set: TSR1=0x%x TSR2=0x%x TSR3=0x%x\n",
+			tsr_mode[0], tsr_mode[1], tsr_mode[2]);
+	}
+
 	pcf85363->rtc = devm_rtc_allocate_device(&client->dev);
 	if (IS_ERR(pcf85363->rtc))
 		return PTR_ERR(pcf85363->rtc);
@@ -553,80 +801,118 @@ static int pcf85363_probe(struct i2c_client *client)
 	pcf85363->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	pcf85363->rtc->range_max = RTC_TIMESTAMP_END_2099;
 
-	wakeup_source = device_property_read_bool(&client->dev,
-						  "wakeup-source");
+	wakeup_source = device_property_read_bool(dev, "wakeup-source");
 
 	/*
-	 * Latch and clear any battery-switch event that occurred before
-	 * probe (for example while the main supply was off) instead of
-	 * blanket clearing CTRL_FLAGS, so the cached state is preserved.
+	 * Latch pre-probe events instead of blanket-clearing CTRL_FLAGS, so
+	 * pre-existing timestamps and the battery-switch flag are not lost.
 	 */
 	scoped_guard(mutex, &pcf85363->lock) {
 		ret = pcf85363_collect_events(pcf85363);
 		if (ret < 0)
-			return dev_err_probe(&client->dev, ret,
+			return dev_err_probe(dev, ret,
 					     "Failed to latch boot-time events\n");
 	}
 
 	/*
 	 * Battery-backed registers can retain stale state across a power cycle.
 	 * A stale asserted flag would storm the level-triggered INTA line, so
-	 * disable only the interrupt sources and Alarm2 enables this driver
-	 * never services and clear their flags; leave the managed sources
-	 * (A1IE, BSIE) and Alarm1 for their own paths to arm. WDIE is masked
-	 * too so a bootloader-armed watchdog cannot storm INTA before the
-	 * driver is ready to service it.
+	 * disable the interrupt sources and Alarm2 enables this driver does not
+	 * arm here and clear their flags; leave the managed sources (A1IE, BSIE,
+	 * TSRIE) and Alarm1 for their own paths to arm. WDIE is masked too so a
+	 * bootloader-armed watchdog cannot storm INTA before the driver is ready
+	 * to service it.
 	 */
 	ret = regmap_update_bits(pcf85363->regmap, CTRL_INTA_EN,
 				 INT_WDIE | INT_A2IE | INT_OIE | INT_PIE | INT_ILP,
 				 0);
 	if (ret)
-		return dev_err_probe(&client->dev, ret,
-				     "Failed to mask unused INTA sources\n");
+		return dev_err_probe(dev, ret, "Failed to mask unused INTA sources\n");
 
 	ret = regmap_update_bits(pcf85363->regmap, DT_ALARM_EN,
 				 ALRM_MIN_A2E | ALRM_HR_A2E | ALRM_DAY_A2E, 0);
 	if (ret)
-		return dev_err_probe(&client->dev, ret,
-				     "Failed to mask Alarm2 enables\n");
+		return dev_err_probe(dev, ret, "Failed to mask Alarm2 enables\n");
 
 	ret = pcf85363_clear_flags(pcf85363, FLAGS_A2F | FLAGS_PIF);
 	if (ret)
-		return dev_err_probe(&client->dev, ret,
-				     "Failed to clear stale flags\n");
-
-	if (client->irq > 0 || wakeup_source) {
-		ret = regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
-					 PIN_IO_INTAPM, PIN_IO_INTA_OUT);
-		if (ret)
-			return dev_err_probe(&client->dev, ret,
-					     "Failed to configure INTA pin\n");
-	}
+		return dev_err_probe(dev, ret, "Failed to clear stale flags\n");
 
-	if (client->irq > 0) {
+	if (irq_a > 0) {
 		unsigned long irqflags = IRQF_TRIGGER_LOW;
 
 		if (dev_fwnode(&client->dev))
 			irqflags = 0;
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
-						NULL, pcf85363_rtc_handle_irq,
+
+		ret = devm_request_threaded_irq(dev, irq_a, NULL,
+						pcf85363_rtc_handle_irq,
 						irqflags | IRQF_ONESHOT,
-						"pcf85363", client);
+						"pcf85363-inta", client);
+		/*
+		 * Let the driver core retry when the interrupt provider is not
+		 * ready yet; only a genuine failure disables interrupt-driven
+		 * alarms while leaving RTC timekeeping (and any wakeup-source
+		 * path) intact.
+		 */
+		if (ret == -EPROBE_DEFER)
+			return ret;
 		if (ret) {
-			dev_warn(&client->dev,
-				 "unable to request IRQ, alarms disabled\n");
-			client->irq = 0;
+			dev_warn(dev, "unable to request IRQ, alarms disabled: %d\n",
+				 ret);
+			irq_a = 0;
 		}
 	}
 
-	if (client->irq > 0 || wakeup_source) {
-		device_init_wakeup(&client->dev, true);
+	if (irq_a > 0 || wakeup_source) {
+		/*
+		 * The alarm can be delivered either through our own IRQ line or
+		 * via an external wakeup path (INTA routed to a PMIC), so route
+		 * INTA to its interrupt output and keep the alarm feature in
+		 * both cases; rtcwake relies on it for wakeup-source-only boards.
+		 */
+		ret = regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
+					 PIN_IO_INTAPM, PIN_IO_INTA_OUT);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to configure INTA pin\n");
+
+		if (irq_a > 0) {
+			u8 inta_en = INT_BSIE;
+
+			/*
+			 * Enable the timestamp interrupt only when a capture
+			 * mode is configured; always enable battery-switch.
+			 * Only relevant when we service the IRQ ourselves.
+			 */
+			if (ts_mode_configured)
+				inta_en |= INT_TSRIE;
+
+			ret = regmap_update_bits(pcf85363->regmap, CTRL_INTA_EN,
+						 INT_BSIE | INT_TSRIE, inta_en);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "Failed to enable INTA sources\n");
+		}
+
+		device_init_wakeup(dev, true);
 		set_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
 	} else {
+		/*
+		 * Neither an interrupt line nor a wakeup source: the alarm
+		 * cannot be delivered, so drop the alarm feature.
+		 */
 		clear_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
 	}
 
+	dev_set_drvdata(&pcf85363->rtc->dev, pcf85363);
+
+	ret = rtc_add_group(pcf85363->rtc, &pcf85363_attr_group);
+	if (ret)
+		return ret;
+
 	ret = devm_rtc_register_device(pcf85363->rtc);
+	if (ret)
+		return dev_err_probe(dev, ret, "RTC registration failed\n");
 
 	for (i = 0; i < config->num_nvram; i++) {
 		nvmem_cfg[i].priv = pcf85363;
-- 
2.25.1

