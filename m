Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434A741D648;
	Mon, 14 Sep 2026 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377697; cv=none; b=nnm+6FJG1ZqluM5YrenQiHUpiU2ODVuxU1GNRI1GFBaRTRU5knaMpNixkxSGA/uyjbP5niEEUHTDZE7uRNr6f3qEPIIXE+vNPQ3FTs/miiUS7hqzH5/tp0si914PhxQ7uYWMooVApqA5GCxrHOf5xL44g5kPtiYdst3VWGO/6j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377697; c=relaxed/simple;
	bh=2hVOiwSNCp7gQds1Anwdc3xtosRjcG+4bcTV3s9HQGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MmN+wks9wBEq5KIoHokhgBbeWhb8YhXgLgFxo9T8uD1EijH3KuD54hsT5Tw177b+oMnm4Fr1CZWmfKMMt98eh/PDfwpRiIuDyro9sENmWmxJNC+C0UNVPCcsGQ6BFdRisd2zT+Gaxv3XttePn+A0H4AeG4gNCDP9zNnTNoFw27g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8BF30200262;
	Mon, 14 Sep 2026 11:21:33 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 55CBE20024A;
	Mon, 14 Sep 2026 11:21:33 +0200 (CEST)
Received: from lsv03900.swis.in-blr01.nxp.com (lsv03900.swis.in-blr01.nxp.com [10.12.177.15])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 214AA180006C;
	Mon, 14 Sep 2026 17:21:32 +0800 (+08)
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
Subject: [PATCH v6 2/5] rtc: pcf85363: support reporting battery switch-over via RTC_VL
Date: Mon, 14 Sep 2026 14:51:23 +0530
Message-Id: <20260914092126.3757418-2-lakshay.piplani@nxp.com>
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

Report battery switch-over on PCF85263/PCF85363 through the standard
RTC_VL_* ioctls: RTC_VL_READ exposes the BSF flag and RTC_VL_CLR clears
it. The flag is cached before it is cleared so it survives re-arming, and
it is collected from both the IRQ handler and RTC_VL_READ so poll-only
setups still see it.

CTRL_FLAGS is write-0-to-clear, so a read-modify-write can drop an
unrelated flag. Add pcf85363_clear_flags(), which writes the complement
of the mask to clear only the requested bits.

Probe no longer blanket-clears CTRL_FLAGS, so pre-existing events are
preserved. As the battery-backed registers can hold stale flags across a
power cycle and storm the level-triggered INTA line, probe masks off only
the interrupt sources and Alarm2 enables this driver never services and
clears their flags, and the IRQ handler clears any unserviced A2F/PIF
flags.

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>

---
V5 -> V6:
- Mask INT_WDIE alongside the other unused INTA sources at probe so a
  battery-backed watchdog-enable left by the bootloader cannot storm the
  level-triggered INTA line before watchdog support is added later in
  the series

V4 -> V5:
- Add pcf85363_clear_flags() for the write-0-to-clear CTRL_FLAGS register
  and use it everywhere, so a read-modify-write no longer drops flags.
- Cache BSF before clearing it and collect it from both the IRQ handler
  and RTC_VL_READ so poll-only setups still observe it.
- Latch pending events in probe instead of blanket-clearing CTRL_FLAGS,
  and mask/clear only the unused INTA sources to avoid an interrupt storm.
- Propagate register-access errors out of pcf85363_collect_events(); the
  IRQ handler logs them but still acknowledges the interrupt.
- Serialise the cached event state with a mutex.

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
 drivers/rtc/rtc-pcf85363.c | 181 ++++++++++++++++++++++++++++++++++---
 1 file changed, 168 insertions(+), 13 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index ccc7834e5759..c8c04312bc58 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -14,6 +14,8 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/bcd.h>
+#include <linux/device.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
 
@@ -113,6 +115,9 @@
 struct pcf85363 {
 	struct rtc_device	*rtc;
 	struct regmap		*regmap;
+	/* Serialises access to the cached event state below. */
+	struct mutex		lock;
+	bool			bsf;
 };
 
 struct pcf85x63_config {
@@ -120,6 +125,15 @@ struct pcf85x63_config {
 	unsigned int num_nvram;
 };
 
+/*
+ * CTRL_FLAGS is write-0-to-clear, so write the complement of the mask to
+ * clear only the requested bits without disturbing the others.
+ */
+static int pcf85363_clear_flags(struct pcf85363 *pcf85363, u8 mask)
+{
+	return regmap_write(pcf85363->regmap, CTRL_FLAGS, (u8)~mask);
+}
+
 static int pcf85363_load_capacitance(struct pcf85363 *pcf85363, struct device_node *node)
 {
 	u32 load = 7000;
@@ -253,7 +267,7 @@ static int _pcf85363_rtc_alarm_irq_enable(struct pcf85363 *pcf85363, unsigned
 		return ret;
 
 	/* clear current flags */
-	return regmap_update_bits(pcf85363->regmap, CTRL_FLAGS, FLAGS_A1F, 0);
+	return pcf85363_clear_flags(pcf85363, FLAGS_A1F);
 }
 
 static int pcf85363_rtc_alarm_irq_enable(struct device *dev,
@@ -292,9 +306,40 @@ static int pcf85363_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	return _pcf85363_rtc_alarm_irq_enable(pcf85363, alrm->enabled);
 }
 
+/*
+ * Latch a pending battery-switch event into the software cache. Runs from
+ * the IRQ handler and the RTC_VL_READ path, so it is seen with or without
+ * an interrupt line. BSF is cached before it is cleared so it survives
+ * re-arming. Caller must hold pcf85363->lock. Returns a negative errno on
+ * a register-access failure, otherwise the handled flag mask.
+ */
+static int pcf85363_collect_events(struct pcf85363 *pcf85363)
+{
+	unsigned int flags;
+	int handled = 0;
+	int ret;
+
+	ret = regmap_read(pcf85363->regmap, CTRL_FLAGS, &flags);
+	if (ret)
+		return ret;
+
+	if (flags & FLAGS_BSF) {
+		pcf85363->bsf = true;
+
+		ret = pcf85363_clear_flags(pcf85363, FLAGS_BSF);
+		if (ret)
+			return ret;
+
+		handled |= FLAGS_BSF;
+	}
+
+	return handled;
+}
+
 static irqreturn_t pcf85363_rtc_handle_irq(int irq, void *dev_id)
 {
 	struct pcf85363 *pcf85363 = i2c_get_clientdata(dev_id);
+	bool handled = false;
 	unsigned int flags;
 	int err;
 
@@ -302,16 +347,87 @@ static irqreturn_t pcf85363_rtc_handle_irq(int irq, void *dev_id)
 	if (err)
 		return IRQ_NONE;
 
+	if (flags) {
+		dev_dbg(&pcf85363->rtc->dev, "IRQ flags: 0x%02x%s%s\n",
+			flags, (flags & FLAGS_A1F) ? " [A1F]" : "",
+			(flags & FLAGS_BSF) ? " [BSF]" : "");
+	}
+
 	if (flags & FLAGS_A1F) {
 		rtc_update_irq(pcf85363->rtc, 1, RTC_IRQF | RTC_AF);
-		regmap_update_bits(pcf85363->regmap, CTRL_FLAGS, FLAGS_A1F, 0);
-		return IRQ_HANDLED;
+		pcf85363_clear_flags(pcf85363, FLAGS_A1F);
+		handled = true;
+	}
+
+	if (flags & FLAGS_BSF) {
+		guard(mutex)(&pcf85363->lock);
+
+		err = pcf85363_collect_events(pcf85363);
+		if (err < 0)
+			dev_err_ratelimited(&pcf85363->rtc->dev,
+					    "failed to collect events: %d\n",
+					    err);
+		/*
+		 * This is our interrupt source even if servicing it hit an
+		 * I/O error, so acknowledge the interrupt either way.
+		 */
+		handled = true;
+	}
+
+	/*
+	 * Clear flags this handler does not service (e.g. A2F/PIF); otherwise
+	 * they hold the level-triggered INTA line asserted and storm the IRQ.
+	 */
+	if (flags & (FLAGS_A2F | FLAGS_PIF)) {
+		pcf85363_clear_flags(pcf85363, FLAGS_A2F | FLAGS_PIF);
+		handled = true;
 	}
 
-	return IRQ_NONE;
+	return handled ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static int pcf85363_rtc_ioctl(struct device *dev,
+			      unsigned int cmd, unsigned long arg)
+{
+	struct pcf85363 *pcf85363 = dev_get_drvdata(dev);
+	int ret;
+
+	switch (cmd) {
+	case RTC_VL_READ: {
+		u32 status = 0;
+
+		guard(mutex)(&pcf85363->lock);
+
+		/* Refresh so a poll-only setup still latches the BSF flag. */
+		ret = pcf85363_collect_events(pcf85363);
+		if (ret < 0)
+			return ret;
+
+		if (pcf85363->bsf)
+			status |= RTC_VL_BACKUP_SWITCH;
+
+		return put_user(status, (u32 __user *)arg);
+	}
+
+	case RTC_VL_CLR: {
+		guard(mutex)(&pcf85363->lock);
+
+		ret = pcf85363_clear_flags(pcf85363, FLAGS_BSF);
+		if (ret)
+			return ret;
+
+		pcf85363->bsf = false;
+
+		return 0;
+	}
+
+	default:
+		return -ENOIOCTLCMD;
+	}
 }
 
 static const struct rtc_class_ops rtc_ops = {
+	.ioctl  = pcf85363_rtc_ioctl,
 	.read_time	= pcf85363_rtc_read_time,
 	.set_time	= pcf85363_rtc_set_time,
 	.read_alarm	= pcf85363_rtc_read_alarm,
@@ -412,6 +528,10 @@ static int pcf85363_probe(struct i2c_client *client)
 	if (!pcf85363)
 		return -ENOMEM;
 
+	ret = devm_mutex_init(&client->dev, &pcf85363->lock);
+	if (ret)
+		return ret;
+
 	pcf85363->regmap = devm_regmap_init_i2c(client, &config->regmap);
 	if (IS_ERR(pcf85363->regmap)) {
 		dev_err(&client->dev, "regmap allocation failed\n");
@@ -435,17 +555,52 @@ static int pcf85363_probe(struct i2c_client *client)
 
 	wakeup_source = device_property_read_bool(&client->dev,
 						  "wakeup-source");
-	if (client->irq > 0 || wakeup_source) {
-		err = regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
-		if (err)
-			return dev_err_probe(&client->dev, err,
-					     "failed to clear flags\n");
 
-		err = regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
+	/*
+	 * Latch and clear any battery-switch event that occurred before
+	 * probe (for example while the main supply was off) instead of
+	 * blanket clearing CTRL_FLAGS, so the cached state is preserved.
+	 */
+	scoped_guard(mutex, &pcf85363->lock) {
+		ret = pcf85363_collect_events(pcf85363);
+		if (ret < 0)
+			return dev_err_probe(&client->dev, ret,
+					     "Failed to latch boot-time events\n");
+	}
+
+	/*
+	 * Battery-backed registers can retain stale state across a power cycle.
+	 * A stale asserted flag would storm the level-triggered INTA line, so
+	 * disable only the interrupt sources and Alarm2 enables this driver
+	 * never services and clear their flags; leave the managed sources
+	 * (A1IE, BSIE) and Alarm1 for their own paths to arm. WDIE is masked
+	 * too so a bootloader-armed watchdog cannot storm INTA before the
+	 * driver is ready to service it.
+	 */
+	ret = regmap_update_bits(pcf85363->regmap, CTRL_INTA_EN,
+				 INT_WDIE | INT_A2IE | INT_OIE | INT_PIE | INT_ILP,
+				 0);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to mask unused INTA sources\n");
+
+	ret = regmap_update_bits(pcf85363->regmap, DT_ALARM_EN,
+				 ALRM_MIN_A2E | ALRM_HR_A2E | ALRM_DAY_A2E, 0);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to mask Alarm2 enables\n");
+
+	ret = pcf85363_clear_flags(pcf85363, FLAGS_A2F | FLAGS_PIF);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to clear stale flags\n");
+
+	if (client->irq > 0 || wakeup_source) {
+		ret = regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
 					 PIN_IO_INTAPM, PIN_IO_INTA_OUT);
-		if (err)
-			return dev_err_probe(&client->dev, err,
-					     "failed to set interrupt pin mode\n");
+		if (ret)
+			return dev_err_probe(&client->dev, ret,
+					     "Failed to configure INTA pin\n");
 	}
 
 	if (client->irq > 0) {
-- 
2.25.1

