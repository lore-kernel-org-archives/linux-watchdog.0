Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.34.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008049;
	b=jOfvSa9Wlf4ErQHe+DznPgci/4kntEUD5FnN0mYNVNt/qDNzvSCQs4QMFR7bgjhfmjhR
	 KeYZ+RVcqDzL84Qtfi8Reiw7Ta8uiuNDrnXPIR9evZ+NSruJZqyjC8C8a3zEMzLZqMIDg
	 oZsDT4fgSQY8FK6E+Z+OVqj5bT6qhDt1srC01YiBZ9Dk+kn75txYlbyXJoZLhGMY2C2kE
	 ayxKh/QbhOshI4juwvI2K362RtkSfLy2UL6ioF2VtgNOzKquzG1MNMqQUJfCduVPMoGWT
	 EHSKcjb0+tHPFNAOUocQxMjD9I7a7Exs/eNmqjcGFOF4deR+V7WkbAYERxG2l9j90yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008049;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=noJMziJjnsO4goZkWtPhdnAaZOZV5rE6hJVNsup0CJ8=;
	b=VQvlWnsGbzYs8xr2Xau70ocDThAr6CzGPi8JO8iTBkjpoOindpDNq+srKJNRDKprsSvV
	 sF6whAIzFXorRpRgSz9jGsbS6FpX4hXTOCmqqzSGYsDCNSdg++71vlcOBwFNEwXyRniZr
	 cF4zZIX25VG4AxeMpXgvhZL6/1KG4euQqgZk0EtoQSXRuQxutlbZTPATllzTAWfxNHQU6
	 HKfy06OQZzoMFwlyPW3mvjiYx8dWuHFlb46AycMD2E81guqNlL2p0XK9O/rziOpyFA9VZ
	 vxxyEbc9ndopSxf82s9ZphEdE2EPg5l4lPyIW7ZV+c8zM5sk0X86o+puzTmZrxeqh2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	arc=none smtp.remote-ip=92.121.34.13
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649F9606A32C;
	Mon, 26 Oct 2026 09:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 649F9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 72C051A0057;
	Mon, 26 Oct 2026 10:47:21 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3B5681A0059;
	Mon, 26 Oct 2026 10:47:21 +0100 (CET)
Received: from lsv03900.swis.in-blr01.nxp.com (lsv03900.swis.in-blr01.nxp.com [10.12.177.15])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2CFB4180006C;
	Mon, 26 Oct 2026 17:47:18 +0800 (+08)
From: Lakshay Piplani <lakshay.piplani@nxp.com>
To: alexandre.belloni@bootlin.com,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	wim@linux-watchdog.org,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net
Cc: vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	Lakshay Piplani <lakshay.piplani@nxp.com>
Subject: [PATCH v8 1/5] dt-bindings: rtc: nxp,pcf85363: add timestamp mode config
Date: Mon, 26 Oct 2026 15:17:08 +0530
Message-Id: <20261026094712.205214-1-lakshay.piplani@nxp.com>
X-Mailer: git-send-email 2.25.1
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

NXP PCF85263/PCF85363 provides three timestamp registers (TSR1-TSR3)
which latch the current time when a selected event occurs. Add a
vendor specific property, nxp,timestamp-mode, to select the event
source for each register.

Also introduce a new header 'pcf85363-tsr.h' to expose
macros for timestamp mode fields, improving readability
of device tree file.

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

V7 -> V8:
- No change.

V6 -> V7:
- No change.

V5 -> V6:
- No change

V4 -> V5:
- No change

V3 -> V4:
- Added Reviewed-by tag in commit message (previously only in changelog) 

V2 -> V3:
- No changes in v3
- Added Reviewed-by: Rob Herring <robh@kernel.org>

V1 -> V2:
- Addressed review comments from Rob Herring:
  * use $ref: /schemas/types.yaml#/definitions/uint32-array
  * tuple form with exactly 3 items (TSR1/TSR2/TSR3), per items decimal enums
  * define 'nxp,timestamp-mode' clearly
  * drop watchdog related vendor properties
  * remove watchdog related vendor properties from i2c example

 .../devicetree/bindings/rtc/nxp,pcf85363.yaml | 23 ++++++++++++++-
 include/dt-bindings/rtc/pcf85363-tsr.h        | 28 +++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/rtc/pcf85363-tsr.h

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml
index 52aa3e2091e9..cf9c155162d6 100644
--- a/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/rtc/nxp,pcf85363.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Philips PCF85263/PCF85363 Real Time Clock
+title: NXP PCF85263/PCF85363 Real Time Clock
 
 maintainers:
   - Alexandre Belloni <alexandre.belloni@bootlin.com>
@@ -39,6 +39,24 @@ properties:
   start-year: true
   wakeup-source: true
 
+  nxp,timestamp-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - enum: [0, 1, 2] # TSR1: NONE, FE, LE
+        description: TSR1 mode
+      - enum: [0, 1, 2, 3, 4, 5] # TSR2: NONE, FB, LB, LV, FE, LE
+        description: TSR2 mode
+      - enum: [0, 1, 2, 3] # TSR3: NONE, FB, LB, LV
+        description: TSR3 mode
+    description: |
+      Defines timestamp modes for TSR1, TSR2, and TSR3.
+      Use macros from <dt-bindings/rtc/pcf85363-tsr.h>.
+
+      Each value corresponds to a mode constant:
+        - TSR1: NONE, FE, LE
+        - TSR2: NONE, FB, LB, LV, FE, LE
+        - TSR3: NONE, FB, LB, LV
+
 required:
   - compatible
   - reg
@@ -47,6 +65,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/rtc/pcf85363-tsr.h>
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -56,5 +75,7 @@ examples:
             reg = <0x51>;
             #clock-cells = <0>;
             quartz-load-femtofarads = <12500>;
+            wakeup-source;
+            nxp,timestamp-mode = <PCF85363_TSR1_FE PCF85363_TSR2_LB PCF85363_TSR3_LV>;
         };
     };
diff --git a/include/dt-bindings/rtc/pcf85363-tsr.h b/include/dt-bindings/rtc/pcf85363-tsr.h
new file mode 100644
index 000000000000..1fb5b9b3601e
--- /dev/null
+++ b/include/dt-bindings/rtc/pcf85363-tsr.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef _DT_BINDINGS_RTC_PCF85363_TSR_H
+#define _DT_BINDINGS_RTC_PCF85363_TSR_H
+
+/* TSR1 modes */
+#define PCF85363_TSR1_NONE 0x00
+#define PCF85363_TSR1_FE 0x01
+#define PCF85363_TSR1_LE 0x02
+
+/* TSR2 modes */
+#define PCF85363_TSR2_NONE 0x00
+#define PCF85363_TSR2_FB 0x01
+#define PCF85363_TSR2_LB 0x02
+#define PCF85363_TSR2_LV 0x03
+#define PCF85363_TSR2_FE 0x04
+#define PCF85363_TSR2_LE 0x05
+
+/* TSR3 modes */
+#define PCF85363_TSR3_NONE 0x00
+#define PCF85363_TSR3_FB 0x01
+#define PCF85363_TSR3_LB 0x02
+#define PCF85363_TSR3_LV 0x03
+
+#endif /* _DT_BINDINGS_RTC_PCF85363_TSR_H */
-- 
2.25.1

