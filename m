Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36277 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030298AbbKFVzT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Nov 2015 16:55:19 -0500
Received: by wimw2 with SMTP id w2so38459205wim.1
        for <linux-watchdog@vger.kernel.org>; Fri, 06 Nov 2015 13:55:18 -0800 (PST)
From: Carlo Caione <carlo@caione.org>
To: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	drake@endlessm.com, jerry.cao@amlogic.com, victor.wan@amlogic.com,
	romain.perier@gmail.com
Cc: Carlo Caione <carlo@endlessm.com>
Subject: [PATCH 3/4] Documentation: watchdog: Add new bindings for meson8b
Date: Fri,  6 Nov 2015 22:55:05 +0100
Message-Id: <1446846906-31520-4-git-send-email-carlo@caione.org>
In-Reply-To: <1446846906-31520-1-git-send-email-carlo@caione.org>
References: <1446846906-31520-1-git-send-email-carlo@caione.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Carlo Caione <carlo@endlessm.com>

We make the documentation not meson6 specific anymore and add the new
binding for meson8b SoC.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 Documentation/devicetree/bindings/watchdog/meson-wdt.txt  | 13 +++++++++++++
 Documentation/devicetree/bindings/watchdog/meson6-wdt.txt | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/meson-wdt.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/meson6-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/meson-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
new file mode 100644
index 0000000..ae70185
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
@@ -0,0 +1,13 @@
+Meson SoCs Watchdog timer
+
+Required properties:
+
+- compatible : should be "amlogic,meson6-wdt" or "amlogic,meson8b-wdt"
+- reg : Specifies base physical address and size of the registers.
+
+Example:
+
+wdt: watchdog@c1109900 {
+	compatible = "amlogic,meson6-wdt";
+	reg = <0xc1109900 0x8>;
+};
diff --git a/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
deleted file mode 100644
index 9200fc2..0000000
--- a/Documentation/devicetree/bindings/watchdog/meson6-wdt.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-Meson SoCs Watchdog timer
-
-Required properties:
-
-- compatible : should be "amlogic,meson6-wdt"
-- reg : Specifies base physical address and size of the registers.
-
-Example:
-
-wdt: watchdog@c1109900 {
-	compatible = "amlogic,meson6-wdt";
-	reg = <0xc1109900 0x8>;
-};
-- 
1.9.1

