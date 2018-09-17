Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:48461 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbeIQLsv (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Sep 2018 07:48:51 -0400
Message-Id: <e3e0bcfd7b779b978d07e088a8bd667ea9ddf4aa.1537163780.git.christophe.leroy@c-s.fr>
In-Reply-To: <c09f541d459c29aca40d54fff152d5645e24b50d.1537163776.git.christophe.leroy@c-s.fr>
References: <c09f541d459c29aca40d54fff152d5645e24b50d.1537163776.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 3/3] dt-bindings: watchdog: add mpc8xxx-wdt support
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Radu Rendec <radu.rendec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Date: Mon, 17 Sep 2018 06:22:53 +0000 (UTC)
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add description of DT bindings for mpc8xxx-wdt driver which
handles the CPU watchdog timer on the mpc83xx, mpc86xx and mpc8xx.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 .../devicetree/bindings/watchdog/mpc8xxx-wdt.txt   | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt b/Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt
new file mode 100644
index 000000000000..e176face472a
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt
@@ -0,0 +1,25 @@
+* Freescale mpc8xxx watchdog driver (For 83xx, 86xx and 8xx)
+
+Required properties:
+- compatible: Shall contain one of the following:
+	"mpc83xx_wdt" for an mpc83xx
+	"fsl,mpc8610-wdt" for an mpc86xx
+	"fsl,mpc823-wdt" for an mpc8xx
+- reg: base physical address and length of the area hosting the
+       watchdog registers.
+		On the 83xx, "Watchdog Timer Registers" area:	<0x200 0x100>
+		On the 86xx, "Watchdog Timer Registers" area:	<0xe4000 0x100>
+		On the 8xx, "General System Interface Unit" area: <0x0 0x10>
+
+Optional properties:
+- reg: additional physical address and length (4) of location of the
+       Reset Status Register (called RSTRSCR on the mpc86xx)
+       		On the 83xx, it is located at offset 0x910
+       		On the 86xx, it is located at offset 0xe0094
+       		On the 8xx, it is located at offset 0x288
+
+Example:
+		WDT: watchdog@0 {
+		    compatible = "fsl,mpc823-wdt";
+		    reg = <0x0 0x10 0x288 0x4>;
+		};
-- 
2.13.3
