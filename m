Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBC13D47C7;
	Tue, 10 Mar 2026 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163999; cv=none; b=mT7FW0t/+Ss0ZyjJDiRMuH7r0ZG/LbCL/02heTKVqDynTzCRABKMrE1C6x0ki4tClmr5pc6HlpONMJLAsah0l5Rw/Z6wmARrAPq+l1xDxDAg5+U1o3N79RGoE9ycpqlEf2tEvSTaKGa66DbIs3g00KxyWYZGwiTBPzz2FNNnSpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163999; c=relaxed/simple;
	bh=rw5CNRLMFys610e++cev4bsw0a7rDV7XO3NZVgUWgWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fvy0eVvrd/SvUx0hX6Jl5HiIoQZdAf5jf8KQw8UiZYun4qAwrnJa9eUITL3M+b7r1BCl7vGbYus8mjfh1LzrxzmW6TukVc7h6RIYOjQvgdwJ6f1Vfi/1l8VQ/YsODee/r90eUyZgPnfDcVsKxakMra+wMXbZtpkGXMOw2W9WFyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Bn3la5Pf; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Bn3la5Pf"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BCAB94E425F2;
	Tue, 10 Mar 2026 17:33:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 929F060002;
	Tue, 10 Mar 2026 17:33:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 403AE103695CB;
	Tue, 10 Mar 2026 18:33:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773163995; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=feEz3+qO75OIwcAuVbGFyb0mGQaBJCrWpdr0PhToImM=;
	b=Bn3la5PfE6o3tJHQ1hGEyUQpPSAc3ByQsVmOdAEgF72hukTli+LkUi2j8gPLKe08z7T8CK
	j/RbyaX2Ms2omTEcNsXpO5j4AbHO/QBqx/osiAkYUHnbMYKttGM/W3zBMy74sDjB/fZ7JH
	JD9OFk/uwQ/HkY4GFV2cjdSHAhKgH9qPyIkAzFCiUq2BZh2ilHBYRObSF0MFm1obCMtMMz
	IJffiIa6WuQ81BuOuD8tg0r5QIPR3kzNrDfZ3aE+2448/YclQLWoCSclFKHFjlIoR1sogG
	33tz4phwdUpYIZb2j9+NelWDBzYD1NpR+j5CTzfACpnD6nsl+dmp5T+YrlDZsQ==
From: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	"Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Subject: [PATCH 3/5] dt-bindings: watchdog: renesas,rzn1-wdt: Document the reset line
Date: Tue, 10 Mar 2026 18:32:44 +0100
Message-ID: <20260310173249.161354-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310173249.161354-1-herve.codina@bootlin.com>
References: <20260310173249.161354-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Watchdogs available in the RZ/N1 SoC can use their specific hardware
reset line to reset the system on watchdog timeout.

This line is not documented in the current binding.

Fill this lack and describe this per watchdog reset line.

Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>
---
 .../bindings/watchdog/renesas,rzn1-wdt.yaml   | 22 +++++++++++++++++++
 .../dt-bindings/watchdog/renesas,rzn1-wdt.h   | 16 ++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 include/dt-bindings/watchdog/renesas,rzn1-wdt.h

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,rzn1-wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,rzn1-wdt.yaml
index 7e3ee533cd56..40a9a4ebc716 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,rzn1-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,rzn1-wdt.yaml
@@ -26,6 +26,26 @@ properties:
 
   timeout-sec: true
 
+  renesas,reset-line:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description: |
+      The watchdog reset line (dt-bindings/watchdog/renesas,rzn1-wdt.h defines
+      these values). A wachdog timeout asserts this reset line to perform a
+      hardware system reset. Two watchdogs are present in the RZ/N1 SoC and
+      each of them has a dedicated reset line.
+
+        - 0: RZN1_WDT_A7_0
+          This reset line can be asserted only by the A7 0 watchdog. This
+          watchdog is the one mapped at 0x40008000 on RZ/N1 SoCs.
+
+        - 1: RZN1_WDT_A7_1
+          This reset line can be asserted only by the A7 1 watchdog. This
+          watchdog is the one mapped at 0x40009000 on RZ/N1 SoCs.
+
+      If the renesas,reset-line property is not present, the watchdog timeout
+      only triggers an interrupt.
+
 required:
   - compatible
   - reg
@@ -41,10 +61,12 @@ examples:
   - |
     #include <dt-bindings/clock/r9a06g032-sysctrl.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/watchdog/renesas,rzn1-wdt.h>
 
     watchdog@40008000 {
             compatible = "renesas,r9a06g032-wdt", "renesas,rzn1-wdt";
             reg = <0x40008000 0x1000>;
             interrupts = <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>;
             clocks = <&sysctrl R9A06G032_CLK_WATCHDOG>;
+            renesas,reset-line = <RZN1_WDT_A7_0>;
     };
diff --git a/include/dt-bindings/watchdog/renesas,rzn1-wdt.h b/include/dt-bindings/watchdog/renesas,rzn1-wdt.h
new file mode 100644
index 000000000000..fe534aff0609
--- /dev/null
+++ b/include/dt-bindings/watchdog/renesas,rzn1-wdt.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * RZ/N1 watchdog reset lines
+ *
+ * Copyright (C) 2026 Bootlin
+ *
+ * Herve Codina <herve.codina@bootlin.com>
+ */
+
+#ifndef __DT_BINDINGS_RZN1_WDT_H__
+#define __DT_BINDINGS_RZN1_WDT_H__
+
+#define RZN1_WDT_A7_0		0
+#define RZN1_WDT_A7_1		1
+
+#endif /* __DT_BINDINGS_RZN1_WDT_H__ */
-- 
2.53.0

