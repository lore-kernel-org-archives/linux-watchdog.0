Return-path: <naidu.tellapati@gmail.com>
From: Naidu Tellapati <naidu.tellapati@gmail.com>
To: wim@iguana.be,
	linux@roeck-us.net,
	abrestic@chromium.org,
	ezequiel.garcia@imgtec.com,
	james.hartley@imgtec.com,
	james.hogan@imgtec.com
Cc: naidu.tellapati@imgtec.com,
	arul.ramasamy@imgtec.com,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	Naidu Tellapati <Naidu.Tellapati@gmail.com>,
	Naidu Tellapati <Naidu.Tellapati@imgtec.com>,
	Jude Abraham <Jude.Abraham@gmail.com>
Subject: [PATCH RESEND v6 2/2] DT: watchdog: Add ImgTec PDC Watchdog Timer binding documentation
Date: Thu, 27 Nov 2014 10:24:05 +0530
Message-Id: <1417064045-13274-3-git-send-email-Naidu.Tellapati@gmail.com>
In-Reply-To: <1417064045-13274-1-git-send-email-Naidu.Tellapati@gmail.com>
References: <1417064045-13274-1-git-send-email-Naidu.Tellapati@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

Add the devicetree binding document for ImgTec PDC Watchdog Timer.

Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Signed-off-by: Jude Abraham <Jude.Abraham@gmail.com>
Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
---
No changes from v5.
---
 .../devicetree/bindings/watchdog/imgpdc-wdt.txt    |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt b/Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt
new file mode 100644
index 0000000..2f9ba77
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt
@@ -0,0 +1,18 @@
+*ImgTec PowerDown Controller (PDC) Watchdog Timer (WDT)
+
+Required properties:
+- compatible : Should be "img,pdc-wdt"
+- reg : Should contain WDT registers location and length
+- clocks: Must contain an entry for each entry in clock-names.
+- clock-names: Should contain "wdt" and "sys"
+- interrupts : Should contain WDT interrupt
+
+Examples:
+
+wdt@18102100 {
+	compatible = "img,pdc-wdt";
+	reg = <0x18102100 0x100>;
+	clocks = <&pdc_wdt_clk>, <&sys_clk>;
+	clock-names = "wdt", "sys";
+	interrupts = <0 52 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
1.7.0.4
