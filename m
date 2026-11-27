Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.34.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795768706;
	b=XYv7Nid07c0+qcnDnmOVQkyOBABiaMI34uXDZ4+RwR2qaIM9vNL0zEaA2MYo4xCbABSW
	 0ige1vt136CZi1yUoP26BxjSY2L+OPMpUU2mmjCZrPBCn/DHuFRUEOoGTvd8ofNqms3GX
	 mwm5nQnYz5VQnycb1msMG2kt6I88BRNwCfJwhH1D+1zc/gkkrQdjybpXKGzrHeYiXFZdY
	 Oi42LwCk+eN6pxIdqyR93+fXkBCXbSGVt0WNC6KRSs7m5yorDHdVIcjwREn8MrePrRcE/
	 vlHvz/0vsXKl6gitzxRqV7V9Kp1kwcGhD3gNfN6tRFj9vx2LT+YfmyVhh7Xl7oEM6mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795768706;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=EAoCZsUZdpVA7P71lPyRp8smhUxNn/JcmuoaGK4VCcc=;
	b=KD+eRMgyhngFOllHVSl30t11gAdxgAt+UvVsnh8DE9J9LXzLEPiIJ8jDM6dBvFiNZFFn
	 JgvnqyPj+8lnWTQSSbr+lw57zq+xdSGclRK7TQDj2MyKg4KOMXz3ui0NDq+9XY+7SjyAP
	 9d1/bh35BSDOVpTRKGA5eMb/JhX48iFyS+U3Ri4/TvQz7HEbGab5+vl69DnxlT2PTZZiU
	 tw+FaCJ7gvuoOxjeqPUQqwX7Khbj1TckpafIyFykPm8BO5PFTuLdD6kvpSuRJ28zvIrS7
	 vtTiQC5jJFI/aONcmPRFsAFNQ7GWRIqBCkm7ZRcFo8Iev22tWpqWtY2O8WjRZG0a9Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	arc=none smtp.remote-ip=92.121.34.13
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B00606A32D;
	Fri, 27 Nov 2026 08:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43B00606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 565CE1A0034;
	Fri, 27 Nov 2026 09:38:19 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 21DEE1A002F;
	Fri, 27 Nov 2026 09:38:19 +0100 (CET)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AF32418000B7;
	Fri, 27 Nov 2026 16:38:15 +0800 (+08)
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
Subject: [PATCH v6 1/4] dt-bindings: rtc: Add NXP PCF8525 RTC
Date: Fri, 27 Nov 2026 14:08:04 +0530
Message-Id: <20261127083807.2844507-2-shivprakash.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127083807.2844507-1-shivprakash.gupta@nxp.com>
References: <20261127083807.2844507-1-shivprakash.gupta@nxp.com>
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

