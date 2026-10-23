Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792748596;
	b=r/DlJvY/xN1FLHbCbbn2WCJ8acnM1zTm1HdjuIT9cPGUEBlR9KsKWrChEn3jgGQGMQFU
	 O7cSz7JJNerq3fKTD8JWBtZlGggqQVoOh4vUsUdIq8jDfWdyieNYWezUUbfSeo9i1whHn
	 VojjpNtA6rpum1poJGw5YRhzFwQrymioLswqxvsT6no8UaVI91vnARWjZUCR0A9/XUbNl
	 XrrPJEudNv6jXV7MWuiu6Hqn4IOlTm/kHqwag4JjCz34Esmox/60se1l/F2ZjtbBZzvCs
	 mq4cl9UIO4ZTIlZUa1Yci7qLV9+vpgrAAWqLKUgtR8nN+7kPBo+5/9KMSFt9u8HE67A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748596;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zvK3Ly8RBAGWd5O0Ri13E/eflgNnR2Spx0fhghD9ZY0=;
	b=cKS8uvjDORPl8460wGVjfvJou4MpAuvSHOxE5tO3maGf5mZzG/OzYrxTi7yuT+6brdXx
	 uHJZAZhdl85h65PX719wlOI2G1At98drDEq+twmjEONdwYOul7hz6Rg7HFZ0z2p9s8Uy7
	 gA6RIKsFPPhSHj4AUnF4UKsPEmIkCfWMUtrvjnI7CUM1Tq6X17enZ8FuLwAgS6HHq24g7
	 CxlpOVF4LkBnHsHZK+mT13hWI8naxrEtN3JJSg9Ai/Jplcr0UYdb1TzkvYLT29nRIjjex
	 +8mcdneaDOcZmpq/XyQ/vFjhoWC008tlfkhDvZD0lAubP1wAKBNR2QKTST8zmHgjzvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NMvxtWiT;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79CB60A2601;
	Fri, 23 Oct 2026 09:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B79CB60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NMvxtWiT
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FAD42092782;
	Fri, 23 Oct 2026 09:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zvK3Ly8RBAGWd5O0Ri13E/eflgNnR2Spx0fhghD9ZY0=; b=NMvxtWiTS6WaFKAo
	LaClPDDG/M+fjJsza6VjtTYg43Lysy6f3ARYnspXrCu5pEhqnXymaDBZ0gpA/qXN
	UbLLBrLa5tj8GWvd9Q016VfYN8w/nAf+Hce7mZ2C/AXaLkxr1Fr/WQ/dX+6cSq4Y
	iKz3wp1rVzR0paQ7rEbHhxt5uARCqmus9xPfWtasHQHpivMagt60IAfwKc6KQh4S
	bWw4CZVNWBZiBhT680ImTnSLJxTkvIzl5wICCopvj4lABREXfIiBBBiRjo4Li++E
	FT3lFq2sNPeTWiCMX4YFE3QTkP7QR51+bIJ+5Lpvji+nNNJPbEzWtqe8V5d5xKDl
	UByDDA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hftyga88p-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 09:42:47 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69N9IF9U4054752;
	Fri, 23 Oct 2026 09:18:15 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 69N9IEN24054700;
	Fri, 23 Oct 2026 09:18:15 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 14:47:53 +0530
Subject: [PATCH v4 1/3] dt-bindings: nvmem: layouts: Add PSCRR NVMEM layout
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
Message-Id: <20261023-pscrr-provider-v4-1-e70fabb7e927@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=cZpHPXDM c=1 sm=1 tr=0 ts=6adb2c17 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=gEfo2CItAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=T2scfIwO0EnMTC8JHKIA:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzOCBTYWx0ZWRfX9t8kTn1b7Dxe
 HoVNJTJmyKhhaV0w+vx0rrGBOmWWcGz9Z+Idsyf19vKVgHqeW2t1tG8Bl/nk0rMZY3O3lB193y2
 pq05RL7bCTsONlYXiJhsDFogZpQhZVg=
X-Proofpoint-GUID: R8Bp7kSJzy75MQ0H_QDLtyRVJMnaPjGa
X-Proofpoint-ORIG-GUID: R8Bp7kSJzy75MQ0H_QDLtyRVJMnaPjGa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzOCBTYWx0ZWRfX6kz0nAEM7GJ0
 LkUBbe6PAFpjY21t49HQTOAAAF/k2Zvuo9nOEQ5TGPECRhzsZPs68XMx2oX6MMX8qoR+M3P96D1
 D88CBL0Tze82pOn3wSQdKv2Ak3pRfKJNvdq0drsMzX9z0OynC/5fFMbIj+6wnFzNsUSGgzwSQoX
 JoJR23thggbMBao7xPcjFKbbYI0px/4hpBHkjTeDFD/hOj2LoypEMrtmhoUPxH3FIy6d6Q/5/Ub
 IuVAEeiCgkA8juClHVxGFlor6ocEWILZ4ClAGLykvi6IcuKHd4Aqh2t39uWm/NRhTelwZL8l6/Y
 m/+ZTZgUt0HBi6owkK4yGpnY039TAk3tRlugDGm2TH9tJAno4OFV44NWtITzXJ8vCKXRFSXwPl3
 t/E76EPuhKd5Q9JLoDxJnhfBTHbjE8SM6dE8vqmE5yL3O1dO7K+38xnssWv4gCH3dan1g809q49
 x4nlvbubpOJf5f5AUSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230038

Add a schema for the PSCRR NVMEM layout, which persists the power
state change reason in a single NVMEM cell so it survives a power
cycle and can be read back on the next boot.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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

