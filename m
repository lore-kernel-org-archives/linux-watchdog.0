Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:42716 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbbIHRqP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 8 Sep 2015 13:46:15 -0400
From: Justin Chen <justinpopo6@gmail.com>
To: <linux-kernel@vger.kernel.org>
CC: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<justinpopo6@gmail.com>, <linux@roeck-us.net>,
	<devicetree@vger.kernel.org>, <wim@iguana.be>,
	<linux-watchdog@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcomc.com>
Subject: [PATCH 1/2 v3] watchdog: bcm7038: add device tree binding documentation
Date: Tue, 8 Sep 2015 10:45:47 -0700
Message-ID: <1441734348-11138-2-git-send-email-justinpopo6@gmail.com>
In-Reply-To: <1441734348-11138-1-git-send-email-justinpopo6@gmail.com>
References: <1441734348-11138-1-git-send-email-justinpopo6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add device tree binding documentation for the watchdog hardware block
on bcm7038 and newer SoCs.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 .../devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt b/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt
new file mode 100644
index 0000000..39e5cf5
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt
@@ -0,0 +1,19 @@
+BCM7038 Watchdog timer
+
+Required properties:
+
+- compatible : should be "brcm,bcm7038-wdt"
+- reg : Specifies base physical address and size of the registers.
+
+Optional properties:
+
+- clocks: The clock running the watchdog. If no clock is found the
+	  driver will default to 27000000 HZ.
+
+Example:
+
+watchdog {
+	compatible = "brcm,bcm7038-wdt";
+	clocks = <&upg_fixed>;
+	reg = <0xf040a7e8 0x16>;
+};
-- 
2.1.0

