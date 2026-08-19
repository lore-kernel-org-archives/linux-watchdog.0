Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EE1490BF0;
	Wed, 19 Aug 2026 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160146; cv=none; b=KZvFUnlMl4k0ccH7DKH9GZAcrMtS5DOZtsOiT2aX+Ma1b5bbfxxrCBQ+N9huZWMbtlhj8qf07swMkj5400jqmmCZEExUL2WgP1gZKwjaVrpAmNixwlJW5TXvXpBkbP95vN4sergH6rJiMoWz35h3WcOnEk0tR5QYbz7OK1SnWQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160146; c=relaxed/simple;
	bh=rYb7DZgQfBqxfPpuD4UDQwovj6NApHGQ1oi2WDhbXwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PZSsudk7f6vy3vSoIqMjmUNbGMqLpwaDfgnMPSCXLeCDNR5UMdQ91R6rz+apo4tadUE+ycVrsr3aGOrmTVPc6Zxl3YfdfUXK+Jvdxk+fi0yTOZWRNHjJGKYRX+3CN3KA0lrbps8F8JFKVQ1BItuM6lyWgT5VyA4aehK50+RxkuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZiM31O/z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZiM31O/z"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF1DQS3869753;
	Wed, 19 Aug 2026 17:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8aYKwHBrHJ7ICON2PeaqhELeeDCIpfPPCZRWsY8FU8Q=; b=ZiM31O/zYODK04yl
	uQGCKKV38kApds9jnsXBOs2jefHewgD8pq4TroQ5Qj1ogbxUG/yJ+A5arze7eQj/
	QHXdOdSTfFRtDetqdzgbGoR/b73zEjEwcMydnTxAGsZ7V4AEhydXDfyTXJMFDCN0
	mYPdoRVF6li4yBR0tzxks8duARlfzPaIfYxci+1/qhFEI8Ud1MSnqvLKiirrqoUM
	Ws+3rF79BaOl2mVWsERJCmhLV/rKEzaY11Uqm7tQbjAS/RvIp01OUwrjWYRBxa9Y
	nW+k1yWdrAD0io1Fve1dfySXrg8bsrAZM+KD9xay0eBxDVXFSKTCJJZOV5UBwe5o
	MF1rPw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5ervgru5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 17:21:10 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JHL6cK027988;
	Wed, 19 Aug 2026 17:21:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 4g2h6kdd9s-1;
	Wed, 19 Aug 2026 17:21:06 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67JHL5e6027937;
	Wed, 19 Aug 2026 17:21:06 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 67JHL5jC027916;
	Wed, 19 Aug 2026 17:21:06 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 22:50:44 +0530
Subject: [PATCH v2 2/4] power: reset: add PSCRR NVMEM recorder
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-pscrr-provider-v2-2-9072383e0f4d@oss.qualcomm.com>
References: <20260819-pscrr-provider-v2-0-9072383e0f4d@oss.qualcomm.com>
In-Reply-To: <20260819-pscrr-provider-v2-0-9072383e0f4d@oss.qualcomm.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, kernel@pengutronix.de,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        =?utf-8?q?S=C3=B8ren_Andersen?= <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: RdCnegqbKrTNggyN9hoUDWuolx9lAmO4
X-Authority-Analysis: v=2.4 cv=VZ3H+lp9 c=1 sm=1 tr=0 ts=6a85e606 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=HK-LrPc_DGzbyERBICQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEzNCBTYWx0ZWRfX3CV+QklcOHL8
 fi4fxik+zMT7sjDGxZDZAxmAiMhW+D8bKBkns8MoF4rPPMyNiW/Xf816+xAUM+vbLtYjYXUsxFQ
 io7AEgkojcPnjy7wAQaXMfkqs3evWjBEHilXGc5U2yhg1ZY8ZhhRJJl5eM8I1LC2Yg27dt6Kr1f
 FIr+rmi2mdoDEGTVmiUTXfCtWc9452pidHvheofpk3sF+nmvL0nW4woJfNyD5WfRrz9p+C8GUW+
 O7isu2+hCplpxrRwfLa7BiF1phOFAGlY8jmNnNvYgmlr/DF6fCiCIbC2FM7kPorJ0iudQJJK1cJ
 POmaoxTDx+upRJhp0JKxXbl8QFNaWxyUcUUaZ0gxxTXuSPyvVFNpV6s+M4HVeo8W9INwsACX+Id
 Xt8QnwXSxV+vMIIPE89Ce892kzCVGVZJ4l68QqYHLcw/1DcnU7hVzZiaOWpG8HIJkJNzhiiuI/I
 sX9yFRdtcFxO0SL31Kw==
X-Proofpoint-ORIG-GUID: RdCnegqbKrTNggyN9hoUDWuolx9lAmO4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEzNCBTYWx0ZWRfXwsWmohM5Ihjw
 Tf8xpFCAyimn9FJcpckqYeWfg9WxCyhWkNxas9pB//y+TSZCwHVWWxzC54SFljHqT2tNsYeH1Cb
 i98xMSciW5kpfRQLSv2p6vnspKlFQXk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190134

Record the power state change reason into a small NVMEM cell (an RTC
scratch register or EEPROM) and read it back on the next boot, so the
cause survives a power cycle. The cell is a plain nvmem consumer
reference and the reason value is stored directly.

Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
 drivers/power/reset/pscrr/Kconfig       |  14 +++
 drivers/power/reset/pscrr/Makefile      |   1 +
 drivers/power/reset/pscrr/pscrr-nvmem.c | 154 ++++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+)

diff --git a/drivers/power/reset/pscrr/Kconfig b/drivers/power/reset/pscrr/Kconfig
index 72de82731b53..bfcf04b0c8f5 100644
--- a/drivers/power/reset/pscrr/Kconfig
+++ b/drivers/power/reset/pscrr/Kconfig
@@ -31,3 +31,17 @@ menuconfig PSCRR
 	  unless hardware provides the reset cause.
 
 	  If unsure, say N.
+
+if PSCRR
+
+config PSCRR_NVMEM
+	tristate "PSCRR NVMEM recorder provider"
+	depends on NVMEM
+	help
+	  PSCRR recorder that stores the power state change reason in a
+	  small NVMEM cell (such as an RTC scratch register) and reads it
+	  back on the next boot, so the cause survives a power cycle.
+
+	  If unsure, say N.
+
+endif # PSCRR
diff --git a/drivers/power/reset/pscrr/Makefile b/drivers/power/reset/pscrr/Makefile
index e5530a858971..95c80c80c7da 100644
--- a/drivers/power/reset/pscrr/Makefile
+++ b/drivers/power/reset/pscrr/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PSCRR) += pscrr.o
+obj-$(CONFIG_PSCRR_NVMEM) += pscrr-nvmem.o
diff --git a/drivers/power/reset/pscrr/pscrr-nvmem.c b/drivers/power/reset/pscrr/pscrr-nvmem.c
new file mode 100644
index 000000000000..1c3145c0d058
--- /dev/null
+++ b/drivers/power/reset/pscrr/pscrr-nvmem.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pscrr-nvmem.c - NVMEM recorder provider for PSCRR
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * Copyright (C) 2025 Pengutronix, Oleksij Rempel <o.rempel@pengutronix.de>
+ */
+
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/platform_device.h>
+#include <linux/pscrr.h>
+#include <linux/reboot.h>
+#include <linux/slab.h>
+
+struct pscrr_nvmem {
+	struct nvmem_cell *cell;
+	enum psc_reason reason;
+};
+
+static int pscrr_nvmem_cell_read(struct pscrr_nvmem *priv, u8 *out)
+{
+	size_t len;
+	void *buf;
+
+	buf = nvmem_cell_read(priv->cell, &len);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	*out = len ? *(u8 *)buf : 0;
+	kfree(buf);
+
+	return 0;
+}
+
+static int pscrr_nvmem_cell_write(struct pscrr_nvmem *priv, u8 val)
+{
+	int ret;
+
+	/* nvmem_cell_write() returns the byte count on success, not 0. */
+	ret = nvmem_cell_write(priv->cell, &val, sizeof(val));
+
+	return ret < 0 ? ret : 0;
+}
+
+static int pscrr_nvmem_read_reasons(struct pscrr_provider *p,
+				    unsigned long *reasons)
+{
+	struct pscrr_nvmem *priv = p->priv;
+
+	/*
+	 * Report the reason latched at probe (or overwritten by a later
+	 * record); the cell itself was cleared at probe, so it is not read
+	 * live here.
+	 */
+	set_bit(READ_ONCE(priv->reason), reasons);
+
+	return 0;
+}
+
+static int pscrr_nvmem_write_reason(struct pscrr_provider *p,
+				    enum psc_reason reason)
+{
+	struct pscrr_nvmem *priv = p->priv;
+	int ret;
+
+	if (reason >= PSCR_REASON_COUNT)
+		return -EINVAL;
+
+	ret = pscrr_nvmem_cell_write(priv, reason);
+	if (ret)
+		return ret;
+
+	WRITE_ONCE(priv->reason, reason);
+
+	return 0;
+}
+
+static const struct pscrr_provider_ops pscrr_nvmem_ops = {
+	.read_reasons = pscrr_nvmem_read_reasons,
+	.write_reason = pscrr_nvmem_write_reason,
+};
+
+static int pscrr_nvmem_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pscrr_nvmem *priv;
+	size_t bytes, bits;
+	u8 val;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->cell = devm_nvmem_cell_get(dev, "pscr");
+	if (IS_ERR(priv->cell))
+		return dev_err_probe(dev, PTR_ERR(priv->cell),
+				     "failed to get the pscr nvmem cell\n");
+
+	ret = nvmem_cell_get_size(priv->cell, &bytes, &bits);
+	if (ret)
+		return ret;
+
+	/* The reason is a single byte; a bit cell still occupies one. */
+	if ((bytes ?: DIV_ROUND_UP(bits, 8)) != sizeof(val))
+		return dev_err_probe(dev, -EINVAL,
+				     "unsupported pscr nvmem cell size\n");
+
+	/*
+	 * The cell survives resets, so at boot it still holds whatever the
+	 * previous session recorded before it went down. Latch that as this
+	 * boot's reason, then clear the cell back to PSCR_UNKNOWN: if this
+	 * session is later cut short by an abrupt reset that never runs the
+	 * recorder (watchdog power-cycle, sudden power loss), the next boot
+	 * reads "unknown" instead of a stale reason left over from an earlier
+	 * cycle.
+	 */
+	ret = pscrr_nvmem_cell_read(priv, &val);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to read the pscr nvmem cell\n");
+
+	priv->reason = val < PSCR_REASON_COUNT ? val : PSCR_UNKNOWN;
+
+	ret = pscrr_nvmem_cell_write(priv, PSCR_UNKNOWN);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to clear the pscr nvmem cell\n");
+
+	return PTR_ERR_OR_ZERO(devm_pscrr_provider_register(dev, "nvmem",
+							    &pscrr_nvmem_ops, NULL,
+							    priv));
+}
+
+static const struct of_device_id pscrr_nvmem_of_match[] = {
+	{ .compatible = "pscrr-nvmem" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pscrr_nvmem_of_match);
+
+static struct platform_driver pscrr_nvmem_driver = {
+	.probe	= pscrr_nvmem_probe,
+	.driver	= {
+		.name		= "pscrr-nvmem",
+		.of_match_table	= pscrr_nvmem_of_match,
+	},
+};
+module_platform_driver(pscrr_nvmem_driver);
+
+MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
+MODULE_AUTHOR("Faruque Ansari <faruque.ansari@oss.qualcomm.com>");
+MODULE_DESCRIPTION("NVMEM recorder provider for PSCRR");
+MODULE_LICENSE("GPL");

-- 
2.34.1

