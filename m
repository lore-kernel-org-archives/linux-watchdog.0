Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94CB36494B;
	Mon, 14 Sep 2026 04:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789360762; cv=none; b=A9ua08IHGfzP6HOsIR3/PZV0F8QXLr77ET1E2b0zEt8FVzULby+KaZ/HnB4z2GPUl/tdz8CK8YUZJ+jSZb87qjP4huZzzD2ga0ijidjx+94PyMsTYHpGJcw2tJc0chYoHjX84cEbvcHUGMtU9s0aue1wJGBp+K9qzWPvOOshs+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789360762; c=relaxed/simple;
	bh=Jf//lRDz3flR2m9+z2nB27S+N9VfH8xw32JAlPzTShA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NZidpwaM+i+pg2gpi5YdEuQL1NubMe+OXWzOpOAQgK8irlqJ7BlolLHOIADf1HbjEndALZYSTcbUGm0m1M4JtM73a8HYT/KlZbR5HD3J6Ph6WPuueuCNjp3qZwJeWB3MBhO4VAbz+DfNXxGm3n+eYSbXO7G45xClZ/zqBc0zBwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OfpN3HFK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OfpN3HFK"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E2ejIH3349103;
	Mon, 14 Sep 2026 04:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3txe3yu6jGxScXy2YvkNYUJwJvPmVYDUc+F0+CCds34=; b=OfpN3HFKNWJhyMD6
	HcOA5kB9PxZN6onRmoxnkuOYbxXpjruFJV5r6Asvc54g8H721bwNYDq6W6NgEe4+
	Y74adieNF7DbIjOO9RrCkAGAdlJkYPqzQ2w1+joOs589U/mnM/ThPWDs+2g7ybCq
	uTYPXS6nLoHMEiXPi9uSUgMHneeaNMjSD65AVNVMa1yc+DxoWj9dU1a+g+bR/Ain
	ndelylfvrKDdP4TGb071aiC5Q9ibPhTzTFsFYyFtQPtaSKOijD6kNEGqxHAQ7Pd2
	rE8SLVLMKOkihQVdNIL7UsC6tLGiK14nZxPGo0Lef4q/aS5HRkWsXW+wY1B7e6G5
	Yka7Ow==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dd0qw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 04:38:51 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68E4cnfQ811242;
	Mon, 14 Sep 2026 04:38:49 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 68E4cm1k811221;
	Mon, 14 Sep 2026 04:38:49 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 10:08:45 +0530
Subject: [PATCH v3 1/3] dt-bindings: nvmem: layouts: Add PSCRR NVMEM layout
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-pscrr-provider-v3-1-c45cb16542e8@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA2MSBTYWx0ZWRfX/GylF/Y7QMW5
 hDVmY/J5Ct6CYYdHaneh2x1DsNYQM2kpV1/YTFC7vZDypfXI2JiCyTeu/OQbZX67Z1QAmWZ8X33
 Tevdi737BVkCP0ERYMsOEoOvmeYYD9wY4fTiHnisXxwxEFLeNGXu1fxE4l54+qZfT3caI+oKmiT
 2zGwCunygpaPf5T0ppM9WW5q3Mu8pfaoBKT09G10D/WlPo4ocg07IKqmBSZpWKYUsxri1feS04b
 JJkEK00rWsaAiTT2jYi9YPxBkYddaql383SbP54D5DY3VURhCyve6wRi98LUIX25tYeW/z2Pce8
 jf0DX+2Ayuw6fJ8wwYsvEvTm1spVTjHY4BDDrTx0UH0fn+Wx5EBEODemXjGG0MIjyCBc5/BZumL
 HaRagGNbSx2XEehGAhdcPj95z1tynWRfLJMxHdmLpF0jemV24TtoY17vsf0bcdtFHObSi5Xqk+f
 sabknjtu4qOE9mCyxdw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA2MSBTYWx0ZWRfX9rsEnXumNPKu
 qCcfdDs3rmnVyluNk8FyLnmv+lTZzCYy4DHfJk0aNLbuh2Kd5G7QQI2sz0N2U0GAYVT3t9RzPEx
 uJv8QBRIp/XPuuMGvFeocOyqpuIrfIc=
X-Proofpoint-GUID: s8esPd92c-UOiuQyFCC_OUsilfC16_zX
X-Authority-Analysis: v=2.4 cv=OeUNnRTY c=1 sm=1 tr=0 ts=6aa77a5c cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=T2scfIwO0EnMTC8JHKIA:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: s8esPd92c-UOiuQyFCC_OUsilfC16_zX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140061

Add a schema for the PSCRR NVMEM layout, which persists the power
state change reason in a single NVMEM cell so it survives a power
cycle and can be read back on the next boot.

Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
 .../bindings/nvmem/layouts/nvmem-layout.yaml       |  1 +
 .../bindings/nvmem/layouts/pscrr-nvmem.yaml        | 87 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 3 files changed, 89 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
index 382507060651..24545db61416 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
@@ -21,6 +21,7 @@ oneOf:
   - $ref: fixed-layout.yaml
   - $ref: kontron,sl28-vpd.yaml
   - $ref: onie,tlv-layout.yaml
+  - $ref: pscrr-nvmem.yaml
   - $ref: u-boot,env.yaml
 
 properties:
diff --git a/Documentation/devicetree/bindings/nvmem/layouts/pscrr-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/layouts/pscrr-nvmem.yaml
new file mode 100644
index 000000000000..118669d33f5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/layouts/pscrr-nvmem.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/layouts/pscrr-nvmem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVMEM layout for the Power State Change Reason recorder (PSCRR)
+
+maintainers:
+  - Faruque Ansari <faruque.ansari@oss.qualcomm.com>
+  - Oleksij Rempel <o.rempel@pengutronix.de>
+
+description:
+  An NVMEM layout for a Power State Change Reason (PSCRR) recorder. The
+  reboot or shutdown cause is persisted into a single small NVMEM cell,
+  such as an RTC scratch register, a PMIC SDAM (Scratch Data Access Memory)
+  byte, or an EEPROM byte, so the reason survives a power cycle and can be
+  read back on the next boot.
+
+select: false
+
+properties:
+  compatible:
+    const: pscrr-nvmem
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+    description:
+      The single NVMEM cell used to persist the power state change reason.
+
+    properties:
+      reg:
+        items:
+          - items:
+              - description: Offset, in bytes, of the cell within the
+                  parent NVMEM device.
+              - const: 1
+        description:
+          Offset and size, in bytes, of the cell within the parent NVMEM
+          device. The reason value occupies a single byte, so the size
+          must be 1.
+
+      bits:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        items:
+          - minimum: 0
+            maximum: 7
+            description:
+              Bit offset within the byte addressed by reg.
+          - minimum: 1
+            maximum: 8
+            description:
+              Number of bits used to store the reason. Must be wide enough
+              to hold every value of enum psc_reason (currently 4 bits or
+              more).
+        description:
+          Optional. When absent, the whole byte addressed by reg is used.
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    nvmem-layout {
+        compatible = "pscrr-nvmem";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        reboot-reason-persist@49 {
+            reg = <0x49 0x1>;
+            bits = <0 4>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 19b9f6605d98..51f31e95f4ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21693,6 +21693,7 @@ R:	Pengutronix Kernel Team <kernel@pengutronix.de>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-kernel-pscrr
+F:	Documentation/devicetree/bindings/nvmem/layouts/pscrr-nvmem.yaml
 F:	drivers/power/reset/pscrr/
 F:	include/linux/pscrr.h
 F:	tools/testing/selftests/pscrr/

-- 
2.34.1

