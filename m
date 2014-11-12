Return-path: <root@danube-imgworks.hb.imgtec.org>
From: Naidu.Tellapati@imgtec.com
To: wim@iguana.be, linux@roeck-us.net, James.Hartley@imgtec.com,
        abrestic@chromium.org, Ezequiel.Garcia@imgtec.com
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Jude.Abraham@imgtec.com, Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Subject: [PATCH 2/2] DT: watchdog: Add ImgTec PDC Watchdog Timer binding documentation
Date: Wed, 12 Nov 2014 20:48:03 +0530
Message-Id: <1415805483-26268-3-git-send-email-Naidu.Tellapati@imgtec.com>
In-Reply-To: <1415805483-26268-1-git-send-email-Naidu.Tellapati@imgtec.com>
References: <1415805483-26268-1-git-send-email-Naidu.Tellapati@imgtec.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>

Add the devicetree binding document for ImgTec PDC Watchdog Timer.

Signed-off-by: Jude Abraham <Jude.Abraham@imgtec.com>
Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
---
 .../devicetree/bindings/watchdog/imgpdc-wdt.txt    |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt b/Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt
new file mode 100644
index 0000000..2f13896
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt
@@ -0,0 +1,18 @@
+*ImgTec PowerDown Controller (PDC) Watchdog Timer (WDT)
+
+Required properties:
+- compatible : Should be "img,pistachio-pdc-wdt"
+- reg : Should contain WDT registers location and length
+- clock-names: Should contain "wdt"
+- clocks: phandles to input clocks
+- interrupts : Should contain WDT interrupt
+
+Examples:
+
+wdt@18102100 {
+	compatible = "img,pistachio-pdc-wdt";
+	reg = <0x18102100 0x20>;
+	clocks = <&pdc_wdt_clk>;
+	clock-names = "wdt";
+	interrupts = <0 52 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
1.7.0.4
