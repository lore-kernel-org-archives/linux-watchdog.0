Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B5D37187F;
	Mon, 14 Sep 2026 04:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789360763; cv=none; b=HWF4zMrXXLaN+cfSNqKlrH4u2a7IWvkBM1AKn94B9QyGHGqRDEKFRSX6DbJsZCC2mR1UKCCIq6NEJlG6ZuAP7TJXTm6ZPgaKfUOjWIe/zLYF1jYkz6IAsav3dn81lJR5XX/0A/uVsdEDPLZR6TZsnatsaSw/BNmkzswCMTxmYzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789360763; c=relaxed/simple;
	bh=15LMnO2wrHN3YSxzTuWxS1uP+Ve8hcmU5iWTTs9VkJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CA9/VQibtTJhdjjwAQK6mLsWivYSzp1mJj45hvvVA9QRP9ZBoaPzySq+ur+NIcH2ku9YwJA27FbQ6DyD5d1ujWNVgFnpwsXdUs/c85GjmoiMnSgmYSBJXuCyNpjyx3M17+sjNsiwiuDSrapVqNrEM8xIgPR9WUGhUPyzrhjMueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iO/gV6lT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iO/gV6lT"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E2eSCi3671285;
	Mon, 14 Sep 2026 04:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kdTc+KLQyEBRM2aXQDsAocP22KpoZQf7glsEGlA2jiY=; b=iO/gV6lTIW1Mkb3v
	1/zpKYNO9r9Z01s6nmlkDSw3cfLCX/1mKC2A4tU40JrwBzHun2/pfcxQpll6kYcD
	aLY7tOoTTF4DGAMKdpqWPKCLbEFBzJNfs4keBv3k69hSB31Tj2biNL0IkeXhyUjr
	TLwcXlPlEpbtU+pmhDX/R1TYqDuLyarBguqvzYHXROGwjNxvmIZ+olGwRMnx0tr+
	pJjoxxUswqa/BWrA/8k5l/ozgoza7BXQDla6M/VNHMzfsYTu0nwXWVM6Loiz10TV
	EYzNLR2X7ZXjrMtFwXnFCll+i4lqUkmqJ5p2iA9082jPKQlKaDedoWLx63/7sM6H
	G1xgLg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3hsrug2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 04:38:52 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68E4cn2h811256;
	Mon, 14 Sep 2026 04:38:49 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 68E4cm1l811221;
	Mon, 14 Sep 2026 04:38:49 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 10:08:46 +0530
Subject: [PATCH v3 2/3] power: reset: Add PSCRR NVMEM recorder
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-pscrr-provider-v3-2-c45cb16542e8@oss.qualcomm.com>
References: <20260914-pscrr-provider-v3-0-c45cb16542e8@oss.qualcomm.com>
In-Reply-To: <20260914-pscrr-provider-v3-0-c45cb16542e8@oss.qualcomm.com>
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
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA2MSBTYWx0ZWRfX+3lr2EVZT1Fg
 zxOASOXV9Tyn0l8PzpnzkiVzyyi8g8qMORwqfW/fACFuxk0+B0zEML9/eVBUheU3ZJwOeD3fN38
 bHXGFsU7f/XmVIJUSObAgaFDZqLY19TQ5or9MfT0WBD5D0eWptaQ9AsSbtxl3NB1EZJ9LiuBrV1
 Dn25UvKiwSNrZUhT40VeQPEF0uheR2m/o5Jo5H+XqhgD0sNV5KhrQuVFxm/OYXWzwx5xx+O6Pqw
 /ehEOPv2xPqZOeWyUWiw80BS0tLCWWFCZwFTkmu4SYZk96VlicOa/LOygOmHDNEUQCK/ziIzMaY
 hte1gbiG78gMFJXdMszXh1x3Qh7FNDX+O6UK2wjkZdusBtj9L6rVSMPM6c0LMYS1sMs677clETU
 jeg70CAn+zZrZUiVrRP3Ag7ItAXCC2qpYKLEe4i3fdOvhpPj0Ia/zzNWi9kTw28pswHEiAraqqy
 89F/rd/fBWrRZvdTZEw==
X-Authority-Analysis: v=2.4 cv=IZwSymqa c=1 sm=1 tr=0 ts=6aa77a5c cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=4NpiubGSDSypE1FgfBwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: A8ZkH-16WYdNgX8asI71vGKHz_mLZR5i
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA2MSBTYWx0ZWRfXxj2twiQCAnbf
 eDfxRwJ/Yfra4czHxssRbqjxwOo8rs8LIqiqe4kxAYCIaMpJKYD0qfLTiI8o5Cb1FtnK7sUuDm5
 jHoEyqHJV2kZv6RnDBj12oMLCXQAXbI=
X-Proofpoint-ORIG-GUID: A8ZkH-16WYdNgX8asI71vGKHz_mLZR5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140061

Record the power state change reason into a NVMEM cell (a PMIC
SDAM byte, RTC scratch register, or EEPROM) and read it back on the
next boot, so the cause survives a power cycle.

The recorder is implemented as an NVMEM layout driver: it owns the
single cell described by its layout binding and adds it to the
parent NVMEM device, rather than acting as a standalone consumer of
someone else's cell.

Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
 drivers/power/reset/pscrr/Kconfig       |  14 ++
 drivers/power/reset/pscrr/Makefile      |   1 +
 drivers/power/reset/pscrr/pscrr-nvmem.c | 269 ++++++++++++++++++++++++++++++++
 3 files changed, 284 insertions(+)

diff --git a/drivers/power/reset/pscrr/Kconfig b/drivers/power/reset/pscrr/Kconfig
index 72de82731b53..459b05ba32d3 100644
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
+	depends on NVMEM_LAYOUTS
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
index 000000000000..64f67f0521e0
--- /dev/null
+++ b/drivers/power/reset/pscrr/pscrr-nvmem.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pscrr-nvmem.c - NVMEM layout driver for PSCRR
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * Copyright (C) 2025 Pengutronix, Oleksij Rempel <o.rempel@pengutronix.de>
+ */
+
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/pscrr.h>
+#include <linux/slab.h>
+
+struct pscrr_nvmem {
+	struct nvmem_device *nvmem;
+	u32 offset;		/* byte offset of the cell, from reg[0] */
+	u32 bit_offset;		/* 0 when the cell has no "bits" property */
+	u32 nbits;		/* BITS_PER_BYTE when the cell has no "bits" property */
+	enum psc_reason reason;
+};
+
+static inline u8 pscrr_nvmem_mask(struct pscrr_nvmem *priv)
+{
+	return (u8)GENMASK(priv->bit_offset + priv->nbits - 1, priv->bit_offset);
+}
+
+static int pscrr_nvmem_raw_read(struct pscrr_nvmem *priv, u8 *raw)
+{
+	int ret;
+
+	ret = nvmem_device_read(priv->nvmem, priv->offset, sizeof(*raw), raw);
+
+	return ret < 0 ? ret : 0;
+}
+
+static int pscrr_nvmem_raw_write(struct pscrr_nvmem *priv, u8 raw)
+{
+	int ret;
+
+	ret = nvmem_device_write(priv->nvmem, priv->offset, sizeof(raw), &raw);
+
+	return ret < 0 ? ret : 0;
+}
+
+static int pscrr_nvmem_cell_read(struct pscrr_nvmem *priv, u8 *out)
+{
+	u8 raw, mask = pscrr_nvmem_mask(priv);
+	int ret;
+
+	ret = pscrr_nvmem_raw_read(priv, &raw);
+	if (ret)
+		return ret;
+
+	*out = (raw & mask) >> priv->bit_offset;
+
+	return 0;
+}
+
+static int pscrr_nvmem_cell_write(struct pscrr_nvmem *priv, u8 val)
+{
+	u8 raw, mask = pscrr_nvmem_mask(priv);
+	int ret;
+
+	/* Sub-byte cell: preserve the neighbouring bits, read-modify-write. */
+	if (priv->nbits < BITS_PER_BYTE) {
+		ret = pscrr_nvmem_raw_read(priv, &raw);
+		if (ret)
+			return ret;
+	} else {
+		raw = 0;
+	}
+
+	raw = (raw & ~mask) | ((val << priv->bit_offset) & mask);
+
+	return pscrr_nvmem_raw_write(priv, raw);
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
+static struct device_node *pscrr_nvmem_get_cell(struct device *dev,
+						struct nvmem_device *nvmem,
+						u32 reg[2])
+{
+	struct device_node *layout_np, *cell_np = NULL;
+
+	layout_np = of_nvmem_layout_get_container(nvmem);
+	if (!layout_np)
+		return ERR_PTR(-ENOENT);
+
+	for_each_child_of_node_scoped(layout_np, child) {
+		if (of_property_read_u32_array(child, "reg", reg, 2))
+			continue;
+
+		cell_np = of_node_get(child);
+		break;
+	}
+	of_node_put(layout_np);
+
+	return cell_np ?: ERR_PTR(dev_err_probe(dev, -ENOENT,
+						"missing pscr nvmem cell\n"));
+}
+
+static int pscrr_nvmem_add_cells(struct nvmem_layout *layout)
+{
+	struct device *dev = &layout->dev;
+	struct pscrr_nvmem *priv;
+	struct device_node *cell_np;
+	struct nvmem_cell_info info = { };
+	u32 reg[2], bits[2];
+	u8 val;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->nvmem = layout->nvmem;
+
+	cell_np = pscrr_nvmem_get_cell(dev, priv->nvmem, reg);
+	if (IS_ERR(cell_np))
+		return PTR_ERR(cell_np);
+
+	/* The reason is a single byte; a bit cell still occupies one. */
+	if (reg[1] != sizeof(val)) {
+		of_node_put(cell_np);
+		return dev_err_probe(dev, -EINVAL,
+				     "unsupported pscr nvmem cell size\n");
+	}
+	priv->offset = reg[0];
+
+	if (!of_property_read_u32_array(cell_np, "bits", bits, ARRAY_SIZE(bits))) {
+		priv->bit_offset = bits[0];
+		priv->nbits = bits[1];
+	} else {
+		priv->bit_offset = 0;
+		priv->nbits = BITS_PER_BYTE;
+	}
+
+	if (priv->bit_offset + priv->nbits > BITS_PER_BYTE * reg[1]) {
+		of_node_put(cell_np);
+		return dev_err_probe(dev, -EINVAL, "bits exceed cell size\n");
+	}
+
+	/* PSCR_REASON_COUNT must fit in the allotted bits. */
+	if (PSCR_REASON_COUNT > (1U << priv->nbits)) {
+		of_node_put(cell_np);
+		return dev_err_probe(dev, -EINVAL,
+				     "too few bits for the reason range\n");
+	}
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
+	if (ret) {
+		of_node_put(cell_np);
+		return dev_err_probe(dev, ret,
+				     "failed to read the pscr nvmem cell\n");
+	}
+
+	priv->reason = val < PSCR_REASON_COUNT ? val : PSCR_UNKNOWN;
+
+	ret = pscrr_nvmem_cell_write(priv, PSCR_UNKNOWN);
+	if (ret) {
+		of_node_put(cell_np);
+		return dev_err_probe(dev, ret,
+				     "failed to clear the pscr nvmem cell\n");
+	}
+
+	info.name = kasprintf(GFP_KERNEL, "%pOFn", cell_np);
+	if (!info.name) {
+		of_node_put(cell_np);
+		return -ENOMEM;
+	}
+	info.offset = reg[0];
+	info.bytes = reg[1];
+	info.bit_offset = priv->bit_offset;
+	info.nbits = priv->nbits;
+	info.np = cell_np;
+
+	ret = nvmem_add_one_cell(priv->nvmem, &info);
+	kfree(info.name);
+	if (ret) {
+		of_node_put(cell_np);
+		return ret;
+	}
+
+	return PTR_ERR_OR_ZERO(devm_pscrr_provider_register(dev, "nvmem",
+							    &pscrr_nvmem_ops, NULL,
+							    priv));
+}
+
+static int pscrr_nvmem_probe(struct nvmem_layout *layout)
+{
+	layout->add_cells = pscrr_nvmem_add_cells;
+
+	return nvmem_layout_register(layout);
+}
+
+static void pscrr_nvmem_remove(struct nvmem_layout *layout)
+{
+	nvmem_layout_unregister(layout);
+}
+
+static const struct of_device_id pscrr_nvmem_of_match[] = {
+	{ .compatible = "pscrr-nvmem" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pscrr_nvmem_of_match);
+
+static struct nvmem_layout_driver pscrr_nvmem_layout = {
+	.driver	= {
+		.name		= "pscrr-nvmem",
+		.of_match_table	= pscrr_nvmem_of_match,
+	},
+	.probe	= pscrr_nvmem_probe,
+	.remove	= pscrr_nvmem_remove,
+};
+module_nvmem_layout_driver(pscrr_nvmem_layout);
+
+MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
+MODULE_AUTHOR("Faruque Ansari <faruque.ansari@oss.qualcomm.com>");
+MODULE_DESCRIPTION("NVMEM recorder provider for PSCRR");
+MODULE_LICENSE("GPL");

-- 
2.34.1

