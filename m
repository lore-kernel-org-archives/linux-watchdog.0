Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44C538F250;
	Fri,  7 Aug 2026 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091853; cv=none; b=qXfU2jhB8lVTUnwiuRkexVqeXJGK+fmWM7kH2Kkpf/Uj4WK1IR0MXopwizK+2o19w4uhQx0Gy0HUU9upMhCTGn7pWva6JUbPPliDazaEDw1g8cAvZpkEIn3utXzX5xd2Ef+N28rD40TZi9AVh912G1t2Mv0NwK17OCJHvRJ0Ja8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091853; c=relaxed/simple;
	bh=HjIaqaME+hJhXa2BwQVC1JAHb0D3l0RuQ+tCPSOtXl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s/gXxl/i47iVqNYBRxRB06HusvWcSU2x94fB8Kut3yCBsL8tz2JWQooDweYQVRJE9nqHiHiX08bg9UicnbkvEVJEWtsHRDBNtnvD2VZybBxlPd6gLucUt8eUz0MBPnUA1+t89KYwzZyLpO2bRVVvbgHf8cGg00GfZLQ72TpxCSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D7D891A0040;
	Fri,  7 Aug 2026 10:29:30 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A02EC1A001C;
	Fri,  7 Aug 2026 10:29:30 +0200 (CEST)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 603B71800088;
	Fri,  7 Aug 2026 16:29:27 +0800 (+08)
From: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
To: linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: alexandre.belloni@bootlin.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux@roeck-us.net,
	wim@linux-watchdog.org,
	vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	lakshay.piplani@nxp.com,
	Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
Subject: [PATCH 1/4] dt-bindings: rtc: Add NXP PCF8525 RTC
Date: Fri,  7 Aug 2026 13:58:52 +0530
Message-Id: <20260807082855.3762394-2-shivprakash.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807082855.3762394-1-shivprakash.gupta@nxp.com>
References: <20260807082855.3762394-1-shivprakash.gupta@nxp.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
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

