Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53425 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756329AbbKRQqP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 Nov 2015 11:46:15 -0500
From: Martyn Welch <martyn.welch@collabora.co.uk>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	Martyn Welch <martyn.welch@collabora.co.uk>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: [PATCH 1/2] Add binding documentation for Zodiac Watchdog Timer
Date: Wed, 18 Nov 2015 16:38:50 +0000
Message-Id: <1447864731-24673-1-git-send-email-martyn.welch@collabora.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patchs adds documentation for the binding of the Zodiac RAVE
Switch Watchdog Processor. This is an i2c based watchdog.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
---
 Documentation/devicetree/bindings/watchdog/ziirave-wdt.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/ziirave-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/ziirave-wdt.txt b/Documentation/devicetree/bindings/watchdog/ziirave-wdt.txt
new file mode 100644
index 0000000..2f34157
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/ziirave-wdt.txt
@@ -0,0 +1,12 @@
+Zodiac RAVE Watchdog Timer
+
+Required properties:
+- compatible: must be "zii,rave-wdt"
+- reg: i2c slave address of device, usually 0x38
+
+Example:
+
+	watchdog@38 {
+		compatible = "zii,rave-wdt";
+		reg = <0x38>;
+	};
-- 
2.1.4

