Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37415 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754840AbcE3OLw (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 May 2016 10:11:52 -0400
Received: by mail-wm0-f51.google.com with SMTP id z87so72914932wmh.0
        for <linux-watchdog@vger.kernel.org>; Mon, 30 May 2016 07:11:52 -0700 (PDT)
From: Neil Armstrong <narmstrong@baylibre.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org
Cc: Neil Armstrong <narmstrong@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-watchdog@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: watchdog: Add Meson GXBB Watchdog bindings
Date: Mon, 30 May 2016 16:12:06 +0200
Message-Id: <1464617526-29140-1-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1464614948-28247-1-git-send-email-narmstrong@baylibre.com>
References: <1464614948-28247-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/watchdog/meson-gxbb-wdt.txt      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
new file mode 100644
index 0000000..c7fe36f
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
@@ -0,0 +1,16 @@
+Meson GXBB SoCs Watchdog timer
+
+Required properties:
+
+- compatible : should be "amlogic,meson-gxbb-wdt"
+- reg : Specifies base physical address and size of the registers.
+- clocks : Should be a phandle to the Watchdog clock source, for GXBB the xtal
+	   is the default clock source.
+
+Example:
+
+wdt: watchdog@98d0 {
+	compatible = "amlogic,meson-gxbb-wdt";
+	reg = <0 0x98d0 0x0 0x10>;
+	clocks = <&xtal>;
+};
-- 
2.7.0

