Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34345 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbcEIMe5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 9 May 2016 08:34:57 -0400
Received: by mail-pf0-f173.google.com with SMTP id y69so75215057pfb.1
        for <linux-watchdog@vger.kernel.org>; Mon, 09 May 2016 05:34:56 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: linux@roeck-us.net, wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, jk@ozlabs.org,
	benh@kernel.crashing.org, arnd@arndb.de
Subject: [PATCH 1/2] doc/devicetree: Add Aspeed watchdog timer bindings
Date: Mon,  9 May 2016 22:04:36 +0930
Message-Id: <1462797277-14969-2-git-send-email-joel@jms.id.au>
In-Reply-To: <1462797277-14969-1-git-send-email-joel@jms.id.au>
References: <1462797277-14969-1-git-send-email-joel@jms.id.au>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
new file mode 100644
index 000000000000..58184b161e0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
@@ -0,0 +1,14 @@
+Aspeed Watchdog Timer
+
+Required properties:
+ - compatible: must be "aspeed,wdt"
+ - reg: physical base address of the controller and length of memory mapped
+   region
+
+Example:
+
+	wdt1: wdt@1e785000 {
+		compatible = "aspeed,wdt";
+		reg = <0x1e785000 0x1c>;
+		interrupts = <27>;
+	};
-- 
2.8.1

