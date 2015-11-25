Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:53841 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159AbbKYTdn (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 Nov 2015 14:33:43 -0500
From: Oleksij Rempel <linux@rempel-privat.de>
To: linux-watchdog@vger.kernel.org, linux@roeck-us.net, wim@iguana.be,
	devicetree@vger.kernel.org, robh@kernel.org
Cc: Oleksij Rempel <linux@rempel-privat.de>
Subject: [PATCH v4 2/2] DT: watchdog: add Alphascale asm9260 watchdog binding documentation.
Date: Wed, 25 Nov 2015 20:33:23 +0100
Message-Id: <1448480003-8029-3-git-send-email-linux@rempel-privat.de>
In-Reply-To: <1448480003-8029-1-git-send-email-linux@rempel-privat.de>
References: <5652BFA5.9010101@roeck-us.net>
 <1448480003-8029-1-git-send-email-linux@rempel-privat.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
---
 .../bindings/watchdog/alphascale-asm9260.txt       | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt

diff --git a/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt b/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
new file mode 100644
index 0000000..75b265a
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
@@ -0,0 +1,35 @@
+Alphascale asm9260 Watchdog timer
+
+Required properties:
+
+- compatible : should be "alphascale,asm9260-wdt".
+- reg : Specifies base physical address and size of the registers.
+- clocks : the clocks feeding the watchdog timer. See clock-bindings.txt
+- clock-names : should be set to
+	"mod" - source for tick counter.
+	"ahb" - ahb gate.
+- resets : phandle pointing to the system reset controller with
+	line index for the watchdog.
+- reset-names : should be set to "wdt_rst".
+
+Optional properties:
+- timeout-sec : shall contain the default watchdog timeout in seconds,
+	if unset, the default timeout is 30 seconds.
+- alphascale,mode : three modes are supported
+	"hw" - hw reset (default).
+	"sw" - sw reset.
+	"debug" - no action is taken.
+
+Example:
+
+watchdog0: watchdog@80048000 {
+	compatible = "alphascale,asm9260-wdt";
+	reg = <0x80048000 0x10>;
+	clocks = <&acc CLKID_SYS_WDT>, <&acc CLKID_AHB_WDT>;
+	clock-names = "mod", "ahb";
+	interrupts = <55>;
+	resets = <&rst WDT_RESET>;
+	reset-names = "wdt_rst";
+	timeout-sec = <30>;
+	alphascale,mode = "hw";
+};
-- 
2.5.0

