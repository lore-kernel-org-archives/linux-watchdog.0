Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97834949F0;
	Wed, 19 Aug 2026 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160121; cv=none; b=bqTa8hcQB7lVf/tZ+ILaOmL3ty7YXR/bShMA2RTUNAbqStOUWgAMGwOBtq+VKZkYQeS0/ZQYR2o23wek1L+Mwxla2VqE+kca9BkUyG9/yiBbCUnVUhS8emK5sVrGpodPJY8jVdrAs0BOYzqIRVp1wycOsE0IAm/7AX+VZ3G+jWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160121; c=relaxed/simple;
	bh=tEsD09kXEspOGCM1rxlg4XeDrW+d7jp9nn8X4j6sYsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RowcH54ZY+zx1TCQMWKQz2wuAbMCvVXHiBoeoGSm08XhbxvI3W4WN02rkgkQYw+xI1ZIO+BCZv56H1PwUGU1pHwHDHutkGsoTwm74RGCi0tEU4U/j72mCxfAQDR35/S+vrdN1tt+0pLP/TVCwEnbpI8NDMz4cF6DiDv//eWeAi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bVJcekvw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bVJcekvw"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF1tFL212430;
	Wed, 19 Aug 2026 17:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	85OTsrxkL/kmvX8uAIMrFzn++PFMc1/cr3/U64dRb6s=; b=bVJcekvwX3Ok5mvi
	AEEnR3C71WbrJD6ic8TgpM32Ze+o093I9/TunI8SJbQH4P5ielKryoeu0yygEjgj
	p5w0ibDePUHx1/SMG/57tEysqIW6YcFeZzYOSnktA2BQJKXXhqGH9ONxuCh9e/Dr
	XHIN4xqzAm+W+HFKVd0nvoP3Q7+7IWZ2PiZVEMgpdAwCAZVt0KV7A3wkv1Zp/sIz
	j3vDc03ekjdz3A12jcLAymJ8aaSzCFdeeyjCk7qToqU2rHPGqONFlGGpYEMHYEPe
	s4vRsId/WJpErvy7OIYDkkptYqszLlF9gBFyGUUgL1hjoc1KJuZNoFkTli3zN+JM
	b0JNGQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es4gry4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 17:21:09 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JHL6kS027977;
	Wed, 19 Aug 2026 17:21:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 4g2h6kdd9m-1;
	Wed, 19 Aug 2026 17:21:06 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67JHL5e4027937;
	Wed, 19 Aug 2026 17:21:06 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 67JHL5jB027916;
	Wed, 19 Aug 2026 17:21:06 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 22:50:43 +0530
Subject: [PATCH v2 1/4] dt-bindings: power: reset: add PSCRR NVMEM recorder
 binding
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260819-pscrr-provider-v2-1-9072383e0f4d@oss.qualcomm.com>
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
X-Proofpoint-GUID: Gm1hxfWe71XXs4RgCPb6i0Fz448sxZsL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEzNCBTYWx0ZWRfX+g1Kol+Q5IY8
 DrngGRoOuCepG8QrRDd9LuigWTU/QsxKMfrLeJ2nfU8c+D7eVwpgeUU4VC42yE++qkHO15PcbiW
 5e+3+Lo6HAsFbWC5tykkAKL3y/VG4NNNzMt6qTl3XBEPVoMCelsj8r2rvT/b6VSckrEu9iQRkKj
 AZqOhIL0CWgezA+XGw+XfGA8ioChMlheVEpEdFsWKMK9v8RoAKl9DPZl6gI2l6ve8ZCm1WDEQ8E
 bIY4su0aWLrs46JPnH3pzUe2YDU3SqJ7TtoW6XrRpzAQWzIo66hsM0DYxpgGZQkO0208vV7j5Pa
 +o3jRN2bvPP5tDlU8mwcU/+2M6jL5PtW9TgQ2xynvxFmu+blpddeB9ltsZfWdnGWiXymWs4o1RS
 C52MGXADFkdG0sxOWvm8SeiMTb3iBAvVGHe0EHwrA9MwZ/TeTcv73iaZvAyP82PD+evqrM1Qjvt
 d9egFwdXXjq9fJtXwfg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEzNCBTYWx0ZWRfXyP0lOZQV9ypF
 8LqbrAvRse2q9tqTTi/EO+jRTg+ZMHWZq6LnGdGg6j9hh6nX0h5gz0czMJtJbWkrl1epeFkN3BT
 +hJ1nlfjzgwShxr7Ysc9Lr3evRhp0fo=
X-Authority-Analysis: v=2.4 cv=CN8amxrD c=1 sm=1 tr=0 ts=6a85e605 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=NqF8ssCafXS4OwuzjXwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: Gm1hxfWe71XXs4RgCPb6i0Fz448sxZsL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1011 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190134

Add binding for the PSCRR NVMEM recorder. Records the power state
change reason into a small NVMEM cell, such as a PMIC SDAM byte or
RTC scratch register — so the cause survives a power cycle and can be
read back on the next boot.

Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
 .../bindings/power/reset/pscrr-nvmem.yaml          | 59 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/pscrr-nvmem.yaml b/Documentation/devicetree/bindings/power/reset/pscrr-nvmem.yaml
new file mode 100644
index 000000000000..5334c923d644
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/pscrr-nvmem.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/pscrr-nvmem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVMEM Power State Change Reason recorder
+
+maintainers:
+  - Faruque Ansari <faruque.ansari@oss.qualcomm.com>
+  - Oleksij Rempel <o.rempel@pengutronix.de>
+
+description:
+  An NVMEM-backed recorder for Power State Change Reasons (PSCRR). Persists
+  the reboot or shutdown cause into a small NVMEM cell, such as an RTC
+  scratch register, a PMIC SDAM (Scratch Data Access Memory) byte, or an
+  EEPROM — so the reason survives a power cycle and can be read back on the
+  next boot. The cell is referenced via the standard nvmem-cells consumer
+  binding.
+
+allOf:
+  - $ref: /schemas/nvmem/nvmem-consumer.yaml#
+
+properties:
+  compatible:
+    const: pscrr-nvmem
+
+  nvmem-cells:
+    maxItems: 1
+
+  nvmem-cell-names:
+    items:
+      - const: pscr
+
+required:
+  - compatible
+  - nvmem-cells
+  - nvmem-cell-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    nvmem-layout {
+        compatible = "fixed-layout";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        reboot_reason_persist: reboot-reason-persist@49 {
+            reg = <0x49 0x1>;
+        };
+    };
+
+    reboot-reason {
+        compatible = "pscrr-nvmem";
+        nvmem-cells = <&reboot_reason_persist>;
+        nvmem-cell-names = "pscr";
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 19b9f6605d98..f329cd9d0491 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21693,6 +21693,7 @@ R:	Pengutronix Kernel Team <kernel@pengutronix.de>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-kernel-pscrr
+F:	Documentation/devicetree/bindings/power/reset/pscrr-nvmem.yaml
 F:	drivers/power/reset/pscrr/
 F:	include/linux/pscrr.h
 F:	tools/testing/selftests/pscrr/

-- 
2.34.1

