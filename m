Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:58597 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757739AbaISUgp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 19 Sep 2014 16:36:45 -0400
Received: by mail-we0-f180.google.com with SMTP id u56so326043wes.39
        for <linux-watchdog@vger.kernel.org>; Fri, 19 Sep 2014 13:36:44 -0700 (PDT)
From: Carlo Caione <carlo@caione.org>
To: linux@roeck-us.net, wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	maxime.ripard@free-electrons.com, b.galvani@gmail.com,
	linux@arm.linux.org.uk, jerry.cao@amlogic.com,
	victor.wan@amlogic.com
Cc: Carlo Caione <carlo@caione.org>
Subject: [PATCH v3 1/4] ARM: docs: add documentation binding for meson watchdog
Date: Fri, 19 Sep 2014 22:36:26 +0200
Message-Id: <1411158989-8075-2-git-send-email-carlo@caione.org>
In-Reply-To: <1411158989-8075-1-git-send-email-carlo@caione.org>
References: <1411158989-8075-1-git-send-email-carlo@caione.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 Documentation/devicetree/bindings/watchdog/meson6-wdt.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/meson6-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
new file mode 100644
index 0000000..9200fc2
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
@@ -0,0 +1,13 @@
+Meson SoCs Watchdog timer
+
+Required properties:
+
+- compatible : should be "amlogic,meson6-wdt"
+- reg : Specifies base physical address and size of the registers.
+
+Example:
+
+wdt: watchdog@c1109900 {
+	compatible = "amlogic,meson6-wdt";
+	reg = <0xc1109900 0x8>;
+};
-- 
1.9.1

