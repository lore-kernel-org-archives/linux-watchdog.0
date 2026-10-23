Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747126;
	b=A9jnqAYNJ9nni1RSCgEReARm3pilp24RtMLjBGVOVyUd6i2+I5ch2J1zFkvwVMPFD5vT
	 E/5yU317Xcy2WqQfXS4D4CdaZthH5JtmYgza4TxBYjqxPozaDBynsz8QOigGh7+9KrkuE
	 IMKjsKjb4lb2DAAp+y21f3jc6x2SBKyTq7UfS5OjmlPh4VyodLbCNmSLt2QtKX5xRWGdX
	 YpdX8W8OC5mzujZq0dhR6VuFevpOaEBij5uur7vUj2vCdBfmfh70Gu7ITzsdiLYrOTAtp
	 K2rXVhn+Jnh4vMVq2d5F4w5XiB0dNBQQM1AP4cl1+J8ss/UR8pDEy4rkx9a28h7tpLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747126;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=57Cnjaqh9yW07mFneXNL8nTFOdmBF8ZmnDJCevxnPDo=;
	b=o3GvSSWaRAV4J9C4NfKYQaZ0S8BTq3LvajUTeLLDcSUK2Dem6neNlTzeGGSHOz3uiHYq
	 SduV7ptnFRafjfrlm5aPFbMplCzf2oNYi4gTQ7plKG8GMiAqrmz2uH1g7Dq6IKgl9FEVo
	 2ojbqDJtRsk4y6Pc8iG0BiAUhPWLdsQ5N+IdYOL7EQODZcFiu2gVdksylfn0oluAdIsp5
	 sZVOSSQ9/UDRbBPTrYuFUIdZXQ7/1V7oZFz49BgXboWD/uz7+iHtKTQ2ycg4M7EIQ/QWd
	 c4M389jrZWW1lMRNTwv24WBIi7O2WmkdOx29Y6uJZ39qRZ8gBKAS81zv+ZZTaUoP8/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="l0N/kShF";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF4B606A31B;
	Fri, 23 Oct 2026 09:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACF4B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l0N/kShF
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FAEa2092783;
	Fri, 23 Oct 2026 09:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	57Cnjaqh9yW07mFneXNL8nTFOdmBF8ZmnDJCevxnPDo=; b=l0N/kShF2uhix4xK
	nFjlqRqoeQo0u2aFPb1fq/dLuNJHNWVkYazkYVXmLJUPvOjfVhWLAJJaXQKjWOy7
	8zn27MdAOMdyYz/UPNgzgBUuZy0sBIGf6Z90CUJ8h3YPLXUHr5XnwdrZwnVWxf9R
	hTBD7ORj6AJtu+aINPSMkjHkbWfaCYcOgnRANCTRRId5rEaKF3xWkFSaYV0kQEZu
	lMqdp8pbuOb2hWoc3YIzo+E2QmrUa1xWwaoGIbOBAhsXy+6yb+cfBqjH7npc4jiq
	iPk2RKtlVjITAgPnKwGTCr82vOxsvMcbZ7Pp2V+ckiiTYdCPOFkRRttZEmdBctCd
	8KwOdg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hftyga4ra-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 09:18:19 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69N9IGVc4054764;
	Fri, 23 Oct 2026 09:18:16 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 69N9IEN34054700;
	Fri, 23 Oct 2026 09:18:15 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 14:47:54 +0530
Subject: [PATCH v4 2/3] power: reset: Add PSCRR NVMEM recorder
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-pscrr-provider-v4-2-e70fabb7e927@oss.qualcomm.com>
References: <20261023-pscrr-provider-v4-0-e70fabb7e927@oss.qualcomm.com>
In-Reply-To: <20261023-pscrr-provider-v4-0-e70fabb7e927@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=cZpHPXDM c=1 sm=1 tr=0 ts=6adb265b cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=4NpiubGSDSypE1FgfBwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNiBTYWx0ZWRfXzBtbZnhy9HQd
 0ASjlzO5CMsb7xE4Ei1qNh8wjIEgS4cf9W+JoUyHDZGQBfmClUy6GOHLbp5Ex+IGAHjOfZ6PEdI
 boGnB2+GCkblPCctX2ULB4ZMqVzhwjs=
X-Proofpoint-GUID: b6Edjw1dLjExPNeDESSMLPlUj3xn6ylE
X-Proofpoint-ORIG-GUID: b6Edjw1dLjExPNeDESSMLPlUj3xn6ylE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNiBTYWx0ZWRfX0Apnow9BQSWZ
 mI02uHzCVE8IZabYu1A5xEg6uNgqCBMSn/fLbI5NATSvvP8fFbBGids2AS+UAolv+UoespM2cS6
 NMUvLwO0v+OgG1njOWAz21IFk1V4lb/niU062xbVSZOiHFu8GGxFiwQM7wGr6EoO54zHRrfTBGa
 d19gNqjRatWaT2Vk2Y7p1s7tTvkjoWYrjIG2Kv+P9U1FSVgaf/zgcPXB4mtyPFQg5f/VzqfMDS1
 3TzuABeknnad4vT9ZlwHMwTdZ2GDirAloMKigikw8MAuxlyyiVkjKLySDTQAhKvvP5zJF2DkI14
 69exlIqYQR7drsDgWniAloR2iewRXtK8Cj3lwVbIBOObcMSh4QciAGEBYwZ7Y8irZ9Fr++RQzbp
 UVFD63Gq2RvzLXuwLft92y0bM0NcUUDX7+svsoA4QuhQsOVBdjfugD4wcgqV6P4LScihJIa4O07
 a0tQkQ/p4L95+uMxcRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230036

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
 MAINTAINERS                         |   1 +
 drivers/nvmem/layouts/Kconfig       |  10 ++
 drivers/nvmem/layouts/Makefile      |   1 +
 drivers/nvmem/layouts/pscrr-nvmem.c | 270 ++++++++++++++++++++++++++++++++++++
 4 files changed, 282 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 51f31e95f4ea..6c3e72114826 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21694,6 +21694,7 @@ L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-kernel-pscrr
 F:	Documentation/devicetree/bindings/nvmem/layouts/pscrr-nvmem.yaml
+F:	drivers/nvmem/layouts/pscrr-nvmem.c
 F:	drivers/power/reset/pscrr/
 F:	include/linux/pscrr.h
 F:	tools/testing/selftests/pscrr/
diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
index 5e586dfebe47..fcd234b8ad88 100644
--- a/drivers/nvmem/layouts/Kconfig
+++ b/drivers/nvmem/layouts/Kconfig
@@ -37,6 +37,16 @@ config NVMEM_LAYOUT_U_BOOT_ENV
 
 	  If unsure, say N.
 
+config NVMEM_LAYOUT_PSCRR
+	tristate "PSCRR NVMEM recorder provider"
+	depends on PSCRR
+	help
+	  PSCRR recorder that stores the power state change reason in a
+	  small NVMEM cell (such as an RTC scratch register) and reads it
+	  back on the next boot, so the cause survives a power cycle.
+
+	  If unsure, say N.
+
 endmenu
 
 endif
diff --git a/drivers/nvmem/layouts/Makefile b/drivers/nvmem/layouts/Makefile
index dd6c6c70b1a9..0079e935c4ad 100644
--- a/drivers/nvmem/layouts/Makefile
+++ b/drivers/nvmem/layouts/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_NVMEM_LAYOUTS) += fixed-layout.o
 obj-$(CONFIG_NVMEM_LAYOUT_SL28_VPD) += sl28vpd.o
 obj-$(CONFIG_NVMEM_LAYOUT_ONIE_TLV) += onie-tlv.o
 obj-$(CONFIG_NVMEM_LAYOUT_U_BOOT_ENV) += u-boot-env.o
+obj-$(CONFIG_NVMEM_LAYOUT_PSCRR) += pscrr-nvmem.o
diff --git a/drivers/nvmem/layouts/pscrr-nvmem.c b/drivers/nvmem/layouts/pscrr-nvmem.c
new file mode 100644
index 000000000000..ba501f126117
--- /dev/null
+++ b/drivers/nvmem/layouts/pscrr-nvmem.c
@@ -0,0 +1,270 @@
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
+		/*
+		 * The binding describes a single reason cell. Reject a layout
+		 * that lists more than one rather than silently using the first.
+		 */
+		if (cell_np) {
+			of_node_put(cell_np);
+			of_node_put(layout_np);
+			return ERR_PTR(dev_err_probe(dev, -EINVAL,
+						     "expected a single pscr nvmem cell\n"));
+		}
+
+		cell_np = of_node_get(child);
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
+		ret = dev_err_probe(dev, -EINVAL,
+				    "unsupported pscr nvmem cell size\n");
+		goto err_put;
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
+		ret = dev_err_probe(dev, -EINVAL, "bits exceed cell size\n");
+		goto err_put;
+	}
+
+	/* PSCR_REASON_COUNT must fit in the allotted bits. */
+	if (PSCR_REASON_COUNT > (1U << priv->nbits)) {
+		ret = dev_err_probe(dev, -EINVAL,
+				    "too few bits for the reason range\n");
+		goto err_put;
+	}
+
+	ret = pscrr_nvmem_cell_read(priv, &val);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to read the pscr nvmem cell\n");
+		goto err_put;
+	}
+
+	priv->reason = val < PSCR_REASON_COUNT ? val : PSCR_UNKNOWN;
+
+	ret = pscrr_nvmem_cell_write(priv, PSCR_UNKNOWN);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to clear the pscr nvmem cell\n");
+		goto err_put;
+	}
+
+	info.name = kasprintf(GFP_KERNEL, "%pOFn", cell_np);
+	if (!info.name) {
+		ret = -ENOMEM;
+		goto err_put;
+	}
+	info.offset = reg[0];
+	info.bytes = reg[1];
+	info.bit_offset = priv->bit_offset;
+	info.nbits = priv->nbits;
+	info.np = cell_np;
+
+	ret = nvmem_add_one_cell(priv->nvmem, &info);
+	kfree(info.name);
+	if (ret)
+		goto err_put;
+
+	return PTR_ERR_OR_ZERO(devm_pscrr_provider_register(dev, "nvmem",
+							    &pscrr_nvmem_ops, NULL,
+							    priv));
+
+err_put:
+	of_node_put(cell_np);
+	return ret;
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

