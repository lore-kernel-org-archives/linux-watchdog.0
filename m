Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:24773 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757367AbbH0Wyo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Aug 2015 18:54:44 -0400
From: Justin Chen <justinpopo6@gmail.com>
To: <linux-kernel@vger.kernel.org>
CC: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<devicetree@vger.kernel.org>, <wim@iguana.be>,
	<linux-watchdog@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH v2 1/2] watchdog: bcm7038: add device tree binding documentation
Date: Thu, 27 Aug 2015 15:53:23 -0700
Message-ID: <1440716004-27022-2-git-send-email-justinpopo6@gmail.com>
In-Reply-To: <1440716004-27022-1-git-send-email-justinpopo6@gmail.com>
References: <1440716004-27022-1-git-send-email-justinpopo6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add device tree binding documentation for the watchdog hardware block
on bcm7038 and newer SoCs.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
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

