Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34281 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbcERIVX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 May 2016 04:21:23 -0400
Received: by mail-pa0-f68.google.com with SMTP id yl2so4212141pac.1
        for <linux-watchdog@vger.kernel.org>; Wed, 18 May 2016 01:21:22 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: linux@roeck-us.net, wim@iguana.be, robh@kernel.org
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, jk@ozlabs.org,
	benh@kernel.crashing.org
Subject: [PATCH v3 1/2] doc/devicetree: Add Aspeed watchdog timer bindings
Date: Wed, 18 May 2016 17:50:59 +0930
Message-Id: <1463559661-14170-2-git-send-email-joel@jms.id.au>
In-Reply-To: <1463559661-14170-1-git-send-email-joel@jms.id.au>
References: <1463062631-16432-1-git-send-email-joel@jms.id.au>
 <1463559661-14170-1-git-send-email-joel@jms.id.au>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../devicetree/bindings/watchdog/aspeed-wdt.txt          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
new file mode 100644
index 000000000000..c5e74d7b4406
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
@@ -0,0 +1,16 @@
+Aspeed Watchdog Timer
+
+Required properties:
+ - compatible: must be one of:
+	- "aspeed,ast2400-wdt"
+	- "aspeed,ast2500-wdt"
+
+ - reg: physical base address of the controller and length of memory mapped
+   region
+
+Example:
+
+	wdt1: watchdog@1e785000 {
+		compatible = "aspeed,ast2400-wdt";
+		reg = <0x1e785000 0x1c>;
+	};
-- 
2.8.1

