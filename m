Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.34.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008055;
	b=aldoWCNWyFoS6hUSZzdyqRfwvQYfhnAY/uYzf6h09a7lQVrZMCvfxN+iwv/YRp+N9Ilk
	 lsLzm1BnPhvi8tMlt0tlqK5IqlsmAbBoWyjEeMCQPDGAWVJ9yYfJ3vWLcqXCtmevOjF59
	 Y+MSYZmscL84WUrG1Pza9WcWLW6U1YKKa3GduOSf3jflsg6sV5Aas/qkkc/Sb7dKurIRP
	 BgBlIaMDpxUZnYNZL5hWTFhV8KcHU1bQNaiKY9cpSXMp0dCI49yfW5qC2k/bEXCuQQ/Yq
	 jB86ky7oTfdAahD/QsepdmZa8ztmJyWlg+MOYPP8Qu+2a01RKLL7ehOz6vAHV9NmO0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008055;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=XE05MLTJnthAbibdkhDg7wZTzG8ejwKz3IRj01IVuI4=;
	b=VzmyaG6EWgV83J6Myt9VrAKGk0qvpxeQuFrlbmPadcUC5C+YXupcmvEFr3alUnuMAirF
	 6MD8oB8d4zWlkEgJ/e+J5oc0UdJF1tcXXHsDZf+5zHjA4dNxnPLNTDe/+jbF/DwYTX3GM
	 y3CH8OpdoWNPleLGg+SefgdrxT68DpLsva2/R3GHQ9Sl93yX4gDY4byOVtYUks51NKZL0
	 Su2V5GJzx59mo5rDlujHvJic5XgDh8KuBngnSB6JsUtoQIG8TsxVU06o62HadMGEYgtng
	 zpnzeJ756iEPV6sB5S+o1p7AqkMBD/3lCE2HqdvrO0oBQ+PIjKvAv8Jwsl46iNixuUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	arc=none smtp.remote-ip=92.121.34.13
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B7660A260E;
	Mon, 26 Oct 2026 09:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90B7660A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2C7261A0025;
	Mon, 26 Oct 2026 10:47:33 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EA10B1A0011;
	Mon, 26 Oct 2026 10:47:32 +0100 (CET)
Received: from lsv03900.swis.in-blr01.nxp.com (lsv03900.swis.in-blr01.nxp.com [10.12.177.15])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0F142180006C;
	Mon, 26 Oct 2026 17:47:29 +0800 (+08)
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
Subject: [PATCH v8 4/5] rtc: pcf85363: add oscillator offset calibration support
Date: Mon, 26 Oct 2026 15:17:11 +0530
Message-Id: <20261026094712.205214-4-lakshay.piplani@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261026094712.205214-1-lakshay.piplani@nxp.com>
References: <20261026094712.205214-1-lakshay.piplani@nxp.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Expose the oscillator offset register of PCF85263/PCF85363 through the
read_offset and set_offset rtc_class_ops callbacks, so userspace can
apply frequency correction for drift compensation.

The offset is in parts per billion (ppb). CTRL_OFFSET is a signed 8-bit
step count whose size depends on the OFFM bit: 2170 ppb/step normal and
2034.5 ppb/step fast, the latter computed with an x10-scaled constant to
keep the arithmetic integer. Values are range-checked before that scaling
so the multiply cannot overflow, and out-of-range values are rejected
with -ERANGE rather than clamped.

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
---

V7 -> V8:
- No change.

V6 -> V7:
- No change.

V5 -> V6:
- No change

V4 -> V5:
- Report and accept the offset in ppb (per the RTC offset ABI) using the
  step selected by OFFM (2170 ppb, or 2034.5 ppb fast via x10 scaling).
- Range-check before the x10 scaling to avoid overflow, and reject
  out-of-range values with -ERANGE instead of clamping.

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

 drivers/rtc/rtc-pcf85363.c | 67 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index db832cad0b0b..71b82f92a003 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -115,6 +115,7 @@
 #define OSC_CAP_SEL	GENMASK(1, 0)
 #define OSC_CAP_6000	0x01
 #define OSC_CAP_12500	0x02
+#define OSC_OFFM	BIT(6)
 
 #define STOP_EN_STOP	BIT(0)
 
@@ -135,6 +136,14 @@
 			 (TSR2_MASK << TSR2_SHIFT) | \
 			 (TSR3_MASK << TSR3_SHIFT))
 
+#define OFFSET_SIGN_BIT 7
+#define OFFSET_MASK     0xFF
+/* Offset step in ppb; fast mode (OFFM=1) is scaled x10 for integer maths. */
+#define OFFSET_STEP_PPB		2170
+#define OFFSET_STEP_PPB_FAST_X10	20345
+#define OFFSET_PPB_MAX		(127 * OFFSET_STEP_PPB)
+#define OFFSET_PPB_MIN		(-128 * OFFSET_STEP_PPB)
+
 #define PCF85363_NUM_TS		3
 /* Bytes latched per timestamp register (sec, min, hour, day, mon, year). */
 #define PCF85363_TS_LEN		6
@@ -558,6 +567,62 @@ static irqreturn_t pcf85363_rtc_handle_irq(int irq, void *dev_id)
 	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
+/*
+ * CTRL_OFFSET is a signed step count; the step is 2170 ppb (normal) or
+ * 2034.5 ppb (fast/OFFM, scaled x10 to keep the arithmetic integer).
+ */
+static int pcf85363_read_offset(struct device *dev, long *offset)
+{
+	struct pcf85363 *pcf85363 = dev_get_drvdata(dev);
+	unsigned int val, osc;
+	long steps;
+	int ret;
+
+	ret = regmap_read(pcf85363->regmap, CTRL_OFFSET, &val);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(pcf85363->regmap, CTRL_OSCILLATOR, &osc);
+	if (ret)
+		return ret;
+
+	steps = sign_extend32(val, OFFSET_SIGN_BIT);
+
+	if (osc & OSC_OFFM)
+		*offset = steps * OFFSET_STEP_PPB_FAST_X10 / 10;
+	else
+		*offset = steps * OFFSET_STEP_PPB;
+
+	return 0;
+}
+
+static int pcf85363_set_offset(struct device *dev, long offset)
+{
+	struct pcf85363 *pcf85363 = dev_get_drvdata(dev);
+	unsigned int osc;
+	long steps;
+	int ret;
+
+	ret = regmap_read(pcf85363->regmap, CTRL_OSCILLATOR, &osc);
+	if (ret)
+		return ret;
+
+	/* Range-check before the x10 scaling so the multiply cannot overflow. */
+	if (offset > OFFSET_PPB_MAX || offset < OFFSET_PPB_MIN)
+		return -ERANGE;
+
+	if (osc & OSC_OFFM)
+		steps = DIV_ROUND_CLOSEST(offset * 10, OFFSET_STEP_PPB_FAST_X10);
+	else
+		steps = DIV_ROUND_CLOSEST(offset, OFFSET_STEP_PPB);
+
+	if (steps < -128 || steps > 127)
+		return -ERANGE;
+
+	return regmap_write(pcf85363->regmap, CTRL_OFFSET,
+			    steps & OFFSET_MASK);
+}
+
 static int pcf85363_rtc_ioctl(struct device *dev,
 			      unsigned int cmd, unsigned long arg)
 {
@@ -605,6 +670,8 @@ static const struct rtc_class_ops rtc_ops = {
 	.read_alarm	= pcf85363_rtc_read_alarm,
 	.set_alarm	= pcf85363_rtc_set_alarm,
 	.alarm_irq_enable = pcf85363_rtc_alarm_irq_enable,
+	.read_offset = pcf85363_read_offset,
+	.set_offset = pcf85363_set_offset,
 };
 
 static int pcf85363_nvram_read(void *priv, unsigned int offset, void *val,
-- 
2.25.1

