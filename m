Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B89A36C0C8;
	Mon, 14 Sep 2026 04:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789360762; cv=none; b=Vx4l/8ca/Aw3amek2/WWSPOfmBICjX3Dlk4QvOV3BumuSCwPNuwOuJEZX6y7R7VXYqsGWGEcmVOLMSt+POJN8A9DfFm0glv5WVDUnLzCulUGaoS+nfGGoLFH7DINPbaIc2/dPeZo30LGY+QRPV5ADx3GEMogxLC4OLiJHLWD6yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789360762; c=relaxed/simple;
	bh=VJjrSad4SzOhXpiS1dIVw+JtDUq1migHoaHuJPWj/FI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TPJWAu+xmNah6iXtPEyFVT2DwowiT5F3rv5V7dyNZp3W6PwAJsiJHH7pTUqJ73ZBvgA7v5cJPa4Yw066WClGGalI8/41FHmu0zUi0/x7WVCimExICCSbW3Nh0jfR8wXq9Q2kHBHLpSCZoyAVtJ2t9gbBIxnTcHxYg9ObBpZL+0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iZTgSvWC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iZTgSvWC"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E2eUSg2808781;
	Mon, 14 Sep 2026 04:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LlFRuxFnfkxVRUGBHDo3F2
	r460o7HJNEOIOWZPWyvHk=; b=iZTgSvWClLBNNu0HbeGesdSoqwfCmOeiukMeUU
	wIK5Yg8VrkWWkll0IAMsFqJL5RYmMTGLR/bleDUxvESBptU/awe05mx+/FXvuGss
	/u0e/ZD3bg0aFgAlfVT8Ak4zfKLHSQR3sdJKnwWZvvn1LZin/9l9xBytGCcRVJJH
	Sx10R+RUYQ/vr+WZTMtEUh6izZe1NcrDYu/7rh81PTxaEsY8TrnwGuCjanV1BGbK
	+chg6eqDEkFA+FZF14ItGGxXlAahXF5gYKWcxtcoIzdSAs8/WyF9dLVhZgS7Q8cY
	SnKyYB6hr9BJ4TR5FKWdD2j4l7IJdhlMgKJMKnsIKqweJHmA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9cd0dx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 04:38:52 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68E4cmVG811228;
	Mon, 14 Sep 2026 04:38:48 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 68E4cm1j811221;
	Mon, 14 Sep 2026 04:38:48 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Subject: [PATCH v3 0/3] power: reset: Add NVMEM recorder provider for PSCRR
Date: Mon, 14 Sep 2026 10:08:44 +0530
Message-Id: <20260914-pscrr-provider-v3-0-c45cb16542e8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFV6p2oC/12OywqDMBBFf0WybtJJfKYr/6N00eqoATVxotJS/
 PemuiiUCxfOwBzum3kkg55dojcjXI03dgwQnyJWdfexRW7qwEyByqCAjDtfEXFHdjU1En/opmi
 SVOYgkYUnR9iY5y683g4mnJbgnY/jYcpjCToNEUpnkGZccisIB4d96XBsl5nsaJ6ixjP7ajrjZ
 0uvfeaqfp5C6v9Fq+LANeQqLmKEJqlL672Ylntf2WEQodht27YPPq4PYvoAAAA=
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
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: 57RNZ9TWEXYsuB6NMGgq02r-JNMQ-6is
X-Authority-Analysis: v=2.4 cv=Pv4G/AM3 c=1 sm=1 tr=0 ts=6aa77a5c cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=TO2YQlRO5dTc0fDaIgEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA2MSBTYWx0ZWRfXwDFBUk8M+O2S
 oOgUCAPzKyISo98UZsASdGTf7vo6Rp+2tZ9q9zdu/YQGCn0g2rRCEIZnszs/gjH5CmAPOJuHmLE
 ziAm52qesczOcQHstZOLlpI438qrE+c=
X-Proofpoint-ORIG-GUID: 57RNZ9TWEXYsuB6NMGgq02r-JNMQ-6is
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA2MSBTYWx0ZWRfXzHVYllfGiFOo
 dDiLzrLZnpviXsV5w9Q6dmpvmgkMWFLpR+GGAYGaQShQ+3CfcsqXzWf3p8D8zQsudQ9ydX07sJc
 SuR1FOw2xd2kJEAHKLsT/z+zSjLgCaoud/HJScXzzwzPOjsIRen5qBFuKLLKXpq/E8ryEBKjDaO
 2qSZaM3Cq226jlKlxtCtrGveLNnm3+mpf5rpafkXHqXBZXESM3NKpM8cE0vAmjY9dc0RPsAokfM
 h7TnpWqBhWAdC9H4qNRkQUGldgIfisqNYJwe5X6r4Sgt5SXk7i/bhOAanXEEmAsKopTNhfDRa4I
 nRBhHg353utJjYOFdV/1CUD8O4jqVjIPNqOyoYIrsiQyZCb3SiDwB7OHLncqUL9j0HZ5+6qsy2p
 1vl7Lwq1yWfEJTAyxTeseF08KtsXoKlJwlyv81SAITdnCo0PmMrYPD81HF0PTrbWsF2m936JciP
 MCSLgHsTiVqbWN++KDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140061

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

[1] https://lore.kernel.org/lkml/20260731095959.296056-1-o.rempel@pengutronix.de/

---
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
 MAINTAINERS                                        |   1 +
 arch/arm64/boot/dts/qcom/lemans-pmics.dtsi         |  11 +
 drivers/power/reset/pscrr/Kconfig                  |  14 ++
 drivers/power/reset/pscrr/Makefile                 |   1 +
 drivers/power/reset/pscrr/pscrr-nvmem.c            | 269 +++++++++++++++++++++
 7 files changed, 384 insertions(+)
---
base-commit: be461b2185ea3ff6d9c92deedcee0a62a57e1332
change-id: 20260806-pscrr-provider-b9f8f451701e

Best regards,
-- 
Faruque Ansari <faruque.ansari@oss.qualcomm.com>

