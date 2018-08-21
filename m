Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:56664 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeHUUh4 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 21 Aug 2018 16:37:56 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc: od@zcrc.me, Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v7 02/24] dt-bindings: ingenic: Add DT bindings for TCU clocks
Date: Tue, 21 Aug 2018 19:16:13 +0200
Message-Id: <20180821171635.22740-3-paul@crapouillou.net>
In-Reply-To: <20180821171635.22740-1-paul@crapouillou.net>
References: <20180821171635.22740-1-paul@crapouillou.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This header provides clock numbers for the ingenic,tcu
DT binding.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
     v2: Use SPDX identifier for the license
    
     v3: No change
    
     v4: No change
    
     v5: s/JZ47*_/TCU_/ and dropped *_CLK_LAST defines
    
     v6: No change
    
     v7: No change

 include/dt-bindings/clock/ingenic,tcu.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 include/dt-bindings/clock/ingenic,tcu.h

diff --git a/include/dt-bindings/clock/ingenic,tcu.h b/include/dt-bindings/clock/ingenic,tcu.h
new file mode 100644
index 000000000000..d569650a7945
--- /dev/null
+++ b/include/dt-bindings/clock/ingenic,tcu.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides clock numbers for the ingenic,tcu DT binding.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_INGENIC_TCU_H__
+#define __DT_BINDINGS_CLOCK_INGENIC_TCU_H__
+
+#define TCU_CLK_TIMER0	0
+#define TCU_CLK_TIMER1	1
+#define TCU_CLK_TIMER2	2
+#define TCU_CLK_TIMER3	3
+#define TCU_CLK_TIMER4	4
+#define TCU_CLK_TIMER5	5
+#define TCU_CLK_TIMER6	6
+#define TCU_CLK_TIMER7	7
+#define TCU_CLK_WDT	8
+#define TCU_CLK_OST	9
+
+#endif /* __DT_BINDINGS_CLOCK_INGENIC_TCU_H__ */
-- 
2.11.0
