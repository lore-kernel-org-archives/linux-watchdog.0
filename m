Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34580 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbcELORb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 12 May 2016 10:17:31 -0400
Received: by mail-pf0-f194.google.com with SMTP id 145so6614029pfz.1
        for <linux-watchdog@vger.kernel.org>; Thu, 12 May 2016 07:17:31 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: linux@roeck-us.net, wim@iguana.be
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, jk@ozlabs.org,
	benh@kernel.crashing.org
Subject: [PATCH v2 1/2] doc/devicetree: Add Aspeed watchdog timer bindings
Date: Thu, 12 May 2016 23:47:10 +0930
Message-Id: <1463062631-16432-2-git-send-email-joel@jms.id.au>
In-Reply-To: <1463062631-16432-1-git-send-email-joel@jms.id.au>
References: <1462797277-14969-1-git-send-email-joel@jms.id.au>
 <1463062631-16432-1-git-send-email-joel@jms.id.au>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../devicetree/bindings/watchdog/aspeed-wdt.txt          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
new file mode 100644
index 000000000000..78ad314eaab9
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
+	watchdog1: watchdog@1e785000 {
+		compatible = "aspeed,ast2400-wdt";
+		reg = <0x1e785000 0x1c>;
+	};
-- 
2.8.1

