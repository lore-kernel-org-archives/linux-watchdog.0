Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33927 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898AbaITRJO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 20 Sep 2014 13:09:14 -0400
Received: by mail-wi0-f179.google.com with SMTP id d1so967445wiv.12
        for <linux-watchdog@vger.kernel.org>; Sat, 20 Sep 2014 10:09:12 -0700 (PDT)
From: Carlo Caione <carlo@caione.org>
To: linux@roeck-us.net, wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	maxime.ripard@free-electrons.com, b.galvani@gmail.com,
	linux@arm.linux.org.uk, jerry.cao@amlogic.com,
	victor.wan@amlogic.com
Cc: Carlo Caione <carlo@caione.org>
Subject: [PATCH v4 1/4] ARM: docs: add documentation binding for meson watchdog
Date: Sat, 20 Sep 2014 19:06:49 +0200
Message-Id: <1411232812-11594-2-git-send-email-carlo@caione.org>
In-Reply-To: <1411232812-11594-1-git-send-email-carlo@caione.org>
References: <1411232812-11594-1-git-send-email-carlo@caione.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
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

