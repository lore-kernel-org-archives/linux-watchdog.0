Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747126;
	b=ngaR28FTUHaflpf0cJ/00xXEbq77X+7HTI1YrcE9HUFl1lddx8l1xSDfnMFxfCd0XQRq
	 PjEnJGiyyAyj5Guj0X4JXJCyIUnXpwe1JrGB67IuWx05YIKSURbvwqCX3Bbbgs6t1PdRH
	 TPEa09l3+PJjIJaHs1gaVB80mpyTLHA0HlqhkyKFL4tGkKoqHFZM/ha6+lzSHnjl0KA6+
	 4z9Tgmlx0stwnw1r2CVDB/iQnPYl9wxeuNQep7LsNdG7QXFkfRQVNckVW/SCoglD9sPjN
	 odVAOWH4qoolosiFUPQnf+ds5NtMYM1OZHAHarjm2oUCS0liSnAMd9BQAQCJwczcrkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747126;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=HVbfw3LWtA41Gw7QpcFN5osov7cP7IWH2VaLMp5lUsI=;
	b=AQ5D95rT+aVzr/ESDesIIzKLePwUGecGqHBaBNThsMCVwSA/kvmkmahY54JpiFvpnM5J
	 T3Xj3YvFtPJCgWwPZ4sCELD4sifqVlg3hpSZU/DoAOEv5OvML90A20J/1f3toGAUTOduh
	 2NpSvgdFHm3hz3IVFQn2mQuboxUF7AXe6cxFo+sGLcXLhHRUAAGG4YCZTvw4FKwbT6Gx7
	 a97xZlYvkaKg4dkHylXPBOz0YQmoEzta1MTx3wn21HntWe/UQsDxa8RejRfqNsBypBuBQ
	 wQXxiVkpsrS08wXqZcWcC/H0TSib5LnfW1xyPoONFlskO0X6IcPMizSDXTcTzi+omGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gImSatuU;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD9B606A31A;
	Fri, 23 Oct 2026 09:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACD9B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gImSatuU
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FP5X1048719;
	Fri, 23 Oct 2026 09:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HVbfw3LWtA41Gw7QpcFN5o
	sov7cP7IWH2VaLMp5lUsI=; b=gImSatuUmY4gyDKSDiRO0XM9dOckXvNNO+gbsf
	r/u+gUka42VQIiI3+y8Xo4WI0pNPf55V82UN2tN5Pe2s0lhqCSCaqtFN8YLddG7/
	IByf905vhrQMHgDKK0WqwWjPFDeTePpsFxQmkWjXcgQbpP1uBT0PGDJc2NLm6f77
	OiSYqsjd51QiajKxY/of6wEGb1iNuu0aZl7xNBJLuiV5P0h3gpo4ww4xZ9LVc0Q2
	3aYF+RVb/cuMnujm2XPu5GFvzNwNl5C7xAsMqh0qoP5q7vUsHLlmaveuhgGHTtRz
	l7uEEal79oSsa4LxlrprrksRbNHBtpXp8OLMALjYib259xNw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmbjyup-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 09:18:17 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69N9IESN4054733;
	Fri, 23 Oct 2026 09:18:14 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 69N9IEN14054700;
	Fri, 23 Oct 2026 09:18:14 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Subject: [PATCH v4 0/3] power: reset: Add NVMEM recorder provider for PSCRR
Date: Fri, 23 Oct 2026 14:47:52 +0530
Message-Id: <20261023-pscrr-provider-v4-0-e70fabb7e927@oss.qualcomm.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEAm22oC/23OTWrDMBAF4KsErStV/7ayyj1KF4k8TgSxpYxsk
 RB896j2ItCWgYE3MB/vSTJggEz2uydBKCGHONagP3bEX47jGWjoaiaSS8tbbmnKHpEmjCV0gPT
 k+rbXRjRcAKlPCaEP9xX8+t4ywm2u7rQdN6lRgjtTh0lnubFU0MgQhgTXQ4LxPE8Yx3BnHXySH
 +YS8hTxsdYs8u20wv1uVCTl1PFGqlYB73V3iDmz23y8+jgMrK5VLOqtOKH/KKoqXht/EtZoCe0
 /yrIsL3aZLitAAQAA
X-Change-ID: 20260806-pscrr-provider-b9f8f451701e
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
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNiBTYWx0ZWRfX3wnX1LCr7Z6i
 C8vmXxsE5v6nNm6A6AyQ5x/4awqYxbcOfEywOT8r2hVdOlb3CHRUE3MrenQlx3uF5Q8L3lGr8yb
 LR4b9zHAoTZM9HOoaPsOwxf/TsjcurQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNiBTYWx0ZWRfXx+WivEEOl+Pd
 lDN8LcgS6pxGzDWJKKEvCVDberiT1XjenAP7kJG0LSm7WkloRzUYcdMRb4J89QTKVqoq0MYE432
 KEVZYobXjHKg+EayrWvJtmcKdNlCYxgu6OTkVvZ/sCFzA3vtZT7+0cPISrr4pHAKUgltcv918Nn
 m+qRCophIX80Taa/1JgxmI0IPEKMptPggrLzRAvKiJA9ymL9hE3s/IrIXzBUJcvtDC6ELEZ4/mT
 x6bpO1hSdVVft9CZATe6jzP1UjAD7F0o79UAmZXhkhOG01pMU2sjwb8vr9KjWFZfm+gkt8CL4P5
 wkIKHoRYBq1BXCjTf5em95IVGP9cgzqEUQ5L8Fpds0XSjV/tC6DMxQClFUYug5EuJxW+NxtnnRI
 L63YOtsAL3kxt1OExQmSTpvTBMCqa3esgnEDPJlFEyJeOpYvsQhQQW7+bbQP+KecDYU4rT2Hdm+
 wq65tM6HBN8qvt0UIBQ==
X-Proofpoint-ORIG-GUID: XgRRe7D-AMa8veb5gkhCzCIMKvdR16ir
X-Authority-Analysis: v=2.4 cv=Nt1E4MdJ c=1 sm=1 tr=0 ts=6adb265a cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=Tb4baJqIJvETSDKJSKYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: XgRRe7D-AMa8veb5gkhCzCIMKvdR16ir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230036

The PSCRR framework[1] currently does not provide a recorder provider
capable of persisting power state change reasons across power cycles.

This series extends the PSCRR framework[1] with support for an
NVMEM-cell recorder provider, integrating PSCRR-recorded power state
change reasons with the NVMEM subsystem.

The recorder writes the power state change reason into a small NVMEM cell
(e.g. a PMIC SDAM byte or RTC scratch register) before shutdown or reset,
so the cause survives a power cycle and is available via
/sys/kernel/pscrr/ on the next boot.

Only the NVMEM-cell provider is included here. The PMIC hardware-register
provider will be submitted as a separate series.

[1] https://lore.kernel.org/all/20261019-pscrr-framework-v17-0-69ea6cdf4731@oss.qualcomm.com/

---
Changes in v4:
- Move the PSCRR NVMEM provider recorder from drivers/power/reset/pscrr/
  to drivers/nvmem/layouts/ and relocate its Kconfig/Makefile/MAINTAINERS
  entries accordingly, as suggested by Srinivas Kandagatla.
- Reject a layout that declares more than one reason cell with -EINVAL
  instead of silently using the first one - Srinivas Kandagatla.
- Consolidate the probe error paths onto a single of_node_put() unwind
  label instead of repeating the put on every failure - Srinivas Kandagatla.
- add Reviewed-by tags from Abel Vesa and Rob Herring.
- Link to v3: https://lore.kernel.org/r/20260914-pscrr-provider-v3-0-c45cb16542e8@oss.qualcomm.com

Changes in v3:
- Drop unnecessary nvmem_cell_get_size() and core compatibility
  detection changes because the layout now owns the compatible.
- Patch 1/3 (dt-bindings): Move compatible from the cell to the
  nvmem-layout node, relocate binding to nvmem/layouts/, and
  simplify the cell to a plain reg/bits child.
- Drop the trailing "binding" from the subject, as suggested by
  Krzysztof.
- Patch 2/3 (driver): Convert pscrr-nvmem from a consumer-based
  platform driver to an nvmem_layout_driver that directly manages
  its cell.
- Patch 3/3 (dts): Update DTS to place compatible on the layout
  node, add bits to reboot_reason_persist, and remove the separate
  reboot-reason consumer node.
- Link to v2: https://patch.msgid.link/20260819-pscrr-provider-v2-0-9072383e0f4d@oss.qualcomm.com

Changes in v2:
- Add reviewers to To/Cc list.
- Update patch 1/4:
   * Rename DT node from pscr-reason to reboot-reason.
   * Update DT binding example to use fixed-layout NVMEM layout.
   * Add reboot_reason_persist NVMEM cell under fixed-layout.
   * Update Qualcomm DTS example accordingly.
- Update patch 2/4 based on Uwe Kleine-König feedback:
   * Remove unnecessary #include <linux/mod_devicetable.h>
- Link to v1: https://lore.kernel.org/all/20260817-pscrr-provider-v1-0-88a318c13d41@oss.qualcomm.com/

---
Faruque Ansari (3):
      dt-bindings: nvmem: layouts: Add PSCRR NVMEM layout
      power: reset: Add PSCRR NVMEM recorder
      arm64: dts: qcom: lemans: Add PSCRR NVMEM recorder node

 .../bindings/nvmem/layouts/nvmem-layout.yaml       |   1 +
 .../bindings/nvmem/layouts/pscrr-nvmem.yaml        |  87 +++++++
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/qcom/lemans-pmics.dtsi         |  11 +
 drivers/nvmem/layouts/Kconfig                      |  10 +
 drivers/nvmem/layouts/Makefile                     |   1 +
 drivers/nvmem/layouts/pscrr-nvmem.c                | 270 +++++++++++++++++++++
 7 files changed, 382 insertions(+)
---
base-commit: be461b2185ea3ff6d9c92deedcee0a62a57e1332
change-id: 20260806-pscrr-provider-b9f8f451701e

Best regards,
-- 
Faruque Ansari <faruque.ansari@oss.qualcomm.com>

