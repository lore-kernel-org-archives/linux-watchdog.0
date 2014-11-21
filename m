Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:57988 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbaKUT0x (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 21 Nov 2014 14:26:53 -0500
From: naidu.tellapati@gmail.com
To: wim@iguana.be, linux@roeck-us.net, abrestic@chromium.org,
	ezequiel.garcia@imgtec.com, james.hartley@imgtec.com,
	james.hogan@imgtec.com
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	arul.ramasamy@imgtec.com, Jude Abraham <Jude.Abraham@imgtec.com>,
	Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Subject: [PATCH RESEND v5 2/2] DT: watchdog: Add ImgTec PDC Watchdog Timer binding documentation
Date: Sat, 22 Nov 2014 00:55:57 +0530
Message-Id: <1416597957-10516-3-git-send-email-Naidu.Tellapati@gmail.com>
In-Reply-To: <1416597957-10516-1-git-send-email-Naidu.Tellapati@gmail.com>
References: <1416597957-10516-1-git-send-email-Naidu.Tellapati@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Jude Abraham <Jude.Abraham@imgtec.com>

Add the devicetree binding document for ImgTec PDC Watchdog Timer.

Signed-off-by: Jude Abraham <Jude.Abraham@imgtec.com>
Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
---
No changes from v4.
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

