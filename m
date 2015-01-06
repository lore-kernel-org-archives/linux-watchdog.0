Return-path: <Ezequiel.Garcia@imgtec.com>
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	James Hartley <james.hartley@imgtec.com>, Andrew Bresticker
	<abrestic@chromium.org>, James Hogan <james.hogan@imgtec.com>
CC: <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>, "Naidu
 Tellapati" <naidu.tellapati@gmail.com>, Naidu Tellapati
	<Naidu.Tellapati@imgtec.com>, Jude Abraham <Jude.Abraham@gmail.com>,
	"Ezequiel Garcia" <ezequiel.garcia@imgtec.com>
Subject: [PATCH v7 2/2] DT: watchdog: Add ImgTec PDC Watchdog Timer binding documentation
Date: Tue, 6 Jan 2015 10:19:35 -0300
Message-ID: <1420550375-22867-3-git-send-email-ezequiel.garcia@imgtec.com>
In-Reply-To: <1420550375-22867-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1420550375-22867-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

From: Naidu Tellapati <naidu.tellapati@gmail.com>

Add the devicetree binding document for ImgTec PDC Watchdog Timer.

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Signed-off-by: Jude Abraham <Jude.Abraham@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 .../devicetree/bindings/watchdog/imgpdc-wdt.txt       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt b/Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt
new file mode 100644
index 0000000..b2fa11f
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt
@@ -0,0 +1,19 @@
+*ImgTec PowerDown Controller (PDC) Watchdog Timer (WDT)
+
+Required properties:
+- compatible : Should be "img,pdc-wdt"
+- reg : Should contain WDT registers location and length
+- clocks: Must contain an entry for each entry in clock-names.
+- clock-names: Should contain "wdt" and "sys"; the watchdog counter
+               clock and register interface clock respectively.
+- interrupts : Should contain WDT interrupt
+
+Examples:
+
+watchdog@18102100 {
+	compatible = "img,pdc-wdt";
+	reg = <0x18102100 0x100>;
+	clocks = <&pdc_wdt_clk>, <&sys_clk>;
+	clock-names = "wdt", "sys";
+	interrupts = <0 52 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.2.1
