Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.34.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795677111;
	b=hTyLyRN868N/XKNGPcI7hARyskIrkq9GUkVvMXbXrxAM6DHrXybxtb4yoiNPDX/FFzm2
	 53nG42Jl7xWWerI6M/vH4Yt+nZ8nsi0xU5CvNqnXwaGziuEGdmAE32vci+erodOzCU/mn
	 XOYz5apg5n7ZV6otqMMeTWcNeOlapPvGJUpGVb1fiPzeioILy/wNltkbcBt8yoVf8Fkmd
	 AgpjwTh5fmjk7ARpscQBiMRCqnxj/frvQjwKOwnWZRJQC2iFFhCxH3KAbbq7Zv3XmJKCR
	 S97YEQbMfC2xK8YVqJ/V1SjUr4miTN06cBxjWQJuxGqIk9CqxMXRUYBZXgIsPIfoI0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795677111;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=EAoCZsUZdpVA7P71lPyRp8smhUxNn/JcmuoaGK4VCcc=;
	b=TFCHBoLOEvhOXisTcqUf/22AfZtU+ApLOlDBwwYwkFzZwwdQkjYuCjDVerx/hf4vQtNT
	 SgIDCVRyF0kSwor+5qLirnia641OJbIele7sNvfs+gQHcPKRwQBWeP0Lwrf/TC84daU3R
	 b1MTX3LQxcfLcLOScv7jj1aqP+WO6+QtAP3R50Y4/71OH7G9L5cXRJkR6BAa2IGPdUv55
	 L5fsJjK4RfhpV3isfq21P2QasVEoyqyPY0GzX3yK8hUoO7iuH+bOoHtYz+aDN4J1mErWE
	 D1k9/cC7TMjlEXeC6aJpLHzzcScBqiT5UFj9sesOHOhnCZek4BXPB5cQhzTsZyGcYrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	arc=none smtp.remote-ip=92.121.34.21
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A41E606A68C;
	Thu, 26 Nov 2026 07:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A41E606A68C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A5C8920002E;
	Thu, 26 Nov 2026 08:11:43 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 79D8E20004F;
	Thu, 26 Nov 2026 08:11:43 +0100 (CET)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 548C018000BE;
	Thu, 26 Nov 2026 15:11:40 +0800 (+08)
From: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
To: linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	alexandre.belloni@bootlin.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux@roeck-us.net,
	wim@linux-watchdog.org
Cc: vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	lakshay.piplani@nxp.com,
	Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
Subject: [PATCH v5 1/4] dt-bindings: rtc: Add NXP PCF8525 RTC
Date: Thu, 26 Nov 2026 12:41:21 +0530
Message-Id: <20261126071124.2383368-2-shivprakash.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261126071124.2383368-1-shivprakash.gupta@nxp.com>
References: <20261126071124.2383368-1-shivprakash.gupta@nxp.com>
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

Add a Devicetree binding for the NXP PCF8525 I2C RTC. Describe the
optional INTA interrupt used for RTC alarm and timestamp events, and
the INTB interrupt used by the watchdog.

Add a property to select the temperature-compensation crystal model.
Also allow the common start-year and wakeup-source properties.

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
Signed-off-by: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
---
 .../devicetree/bindings/rtc/nxp,pcf8525.yaml  | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8525.yaml

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8525.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf8525.yaml
new file mode 100644
index 000000000000..a2fe4c2d36a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8525.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/nxp,pcf8525.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PCF8525 Real Time Clock
+
+description:
+  The PCF8525 is an I2C real-time clock with alarm, timestamp, watchdog,
+  backup battery switch-over, and temperature compensation for an external
+  32.768 kHz crystal.
+
+allOf:
+  - $ref: rtc.yaml#
+  - if:
+      required:
+        - wakeup-source
+        - interrupt-names
+    then:
+      properties:
+        interrupt-names:
+          contains:
+            const: inta
+
+maintainers:
+  - Lakshay Piplani <lakshay.piplani@nxp.com>
+  - Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - nxp,pcf8525
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+    description:
+      One interrupt may be INTA or INTB as identified by interrupt-names.
+      When both outputs are connected, INTA is followed by INTB.
+
+  interrupt-names:
+    oneOf:
+      - items:
+          - enum: [inta, intb]
+      - items:
+          - const: inta
+          - const: intb
+
+  nxp,xtal-type:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Crystal model used by the temperature compensation engine.
+      Value 1 selects -0.035 ppm/degC^2 and value 2 selects
+      -0.04 ppm/degC^2.
+    enum: [1, 2]
+    default: 1
+
+  start-year: true
+
+  wakeup-source: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@51 {
+            compatible = "nxp,pcf8525";
+            reg = <0x51>;
+            interrupt-parent = <&gpio2>;
+            interrupts = <2 IRQ_TYPE_LEVEL_LOW>,
+                          <3 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-names = "inta", "intb";
+            nxp,xtal-type = <2>;
+        };
+    };
-- 
2.34.1

