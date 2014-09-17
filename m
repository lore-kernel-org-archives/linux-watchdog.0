Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:44727 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755939AbaIQUMY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 17 Sep 2014 16:12:24 -0400
Received: by mail-wg0-f41.google.com with SMTP id k14so1952875wgh.12
        for <linux-watchdog@vger.kernel.org>; Wed, 17 Sep 2014 13:12:23 -0700 (PDT)
From: Carlo Caione <carlo@caione.org>
To: linux@roeck-us.net, wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	maxime.ripard@free-electrons.com, b.galvani@gmail.com,
	linux@arm.linux.org.uk
Cc: Carlo Caione <carlo@caione.org>
Subject: [PATCH v2 1/4] ARM: docs: add documentation binding for meson watchdog
Date: Wed, 17 Sep 2014 22:12:03 +0200
Message-Id: <1410984726-18944-2-git-send-email-carlo@caione.org>
In-Reply-To: <1410984726-18944-1-git-send-email-carlo@caione.org>
References: <1410984726-18944-1-git-send-email-carlo@caione.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 Documentation/devicetree/bindings/watchdog/meson-wdt.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/meson-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/meson-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
new file mode 100644
index 0000000..e66c0c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
@@ -0,0 +1,13 @@
+Meson SoCs Watchdog timer
+
+Required properties:
+
+- compatible : should be "amlogic,meson-wdt"
+- reg : Specifies base physical address and size of the registers.
+
+Example:
+
+wdt: watchdog@c1109900 {
+	compatible = "amlogic,meson-wdt";
+	reg = <0xc1109900 0x8>;
+};
-- 
1.9.1

