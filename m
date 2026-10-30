Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.34.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358144;
	b=wp2k2jHm2+LukebLrViRYdB3C32tZf4PJiVX9maAH/5KHulYYkfjVv79+VdRr2s4JITy
	 mX2l7s4DgGzknFOjkRaxCfRi6GgZbnt6Krb9OpWDdvFmDBBqBMK/mKjwEMsw63bb+tgvx
	 YAH2fb/UMIzzlwZ0kk8U5LzJXOXp0wW83ZRLsbMxGroIpO84D+OfXreNNMEvInyVLRVbm
	 dRqidHG7SvGIwW1UHaq12XryK33cBIEfFdgZ2Z5IKtMyK/xa9WdqP9QV3eIZasBP2tMDz
	 YQhitty5liTfeZsuhwfHx5zZqkxGyaCp8ZgqKFWVJhvLHk0GIoIWqiKVQH/2CIARSgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358144;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=/kmVht9cYMSe6QjwACc2sQOg3rzrAjdFK+Qye+8iWhE=;
	b=ijNiIaDPT1QRWSCUyehFdgDEm/JuabgKApAh8Fdcud01fvibVxuKV1hVUbuJWhiHCEmO
	 nfVWQJeVNGO+J6Ar7q1Ot1ejX+ml1Tt6uVqpEBB673DubEY0k2lY+VxFNa8o0EA/8WzUl
	 3JV1g2QpH2GJn3BPMa1iwxLS/Dx3sL9tminYbI7js2TeBxEKBUtKFwIjZioT3Jlx/tURP
	 /k+DAafuiJadetHAeTyd02s6sSi5/VjCzV2hFE+tpqgztl1FPunu3em+TV5uU5vpSOVUO
	 srlFnecEoA1dqxxm0WtiiKe935dyjx8Azg/IPahA3vZ2uyqodNxgByiHK0y6UNe33eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	arc=none smtp.remote-ip=92.121.34.21
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B03606A322;
	Fri, 30 Oct 2026 11:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82B03606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9517D200014;
	Fri, 30 Oct 2026 12:02:16 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 60FD9200011;
	Fri, 30 Oct 2026 12:02:16 +0100 (CET)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 667CC180022C;
	Fri, 30 Oct 2026 19:02:15 +0800 (+08)
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
Subject: [PATCH v4 1/4] dt-bindings: rtc: Add NXP PCF8525 RTC
Date: Fri, 30 Oct 2026 16:31:36 +0530
Message-Id: <20261030110139.1929109-2-shivprakash.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030110139.1929109-1-shivprakash.gupta@nxp.com>
References: <20261030110139.1929109-1-shivprakash.gupta@nxp.com>
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

Add properties to select the external crystal load capacitance and
temperature-compensation crystal model. Also allow the common
start-year, wakeup-source and reset-source properties, with
reset-source enabling watchdog registration

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
Signed-off-by: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes in v2:
- No changes to DT binding
---
 .../devicetree/bindings/rtc/nxp,pcf8525.yaml  | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8525.yaml

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8525.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf8525.yaml
new file mode 100644
index 000000000000..bee71ec3da80
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8525.yaml
@@ -0,0 +1,86 @@
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
+      INTA, followed by INTB when both interrupt outputs are connected.
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: inta
+      - const: intb
+
+  quartz-load-femtofarads:
+    description:
+      Effective load capacitance of the external 32.768 kHz crystal.
+    enum: [6000, 7000]
+    default: 6000
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
+  reset-source: true
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
+            interrupts = <2 IRQ_TYPE_EDGE_FALLING>,
+                          <3 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "inta", "intb";
+            quartz-load-femtofarads = <7000>;
+            nxp,xtal-type = <2>;
+            reset-source;
+        };
+    };
-- 
2.34.1

