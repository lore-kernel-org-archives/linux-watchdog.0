Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:37899 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdHLSnq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 12 Aug 2017 14:43:46 -0400
Received: by mail-lf0-f50.google.com with SMTP id y15so26871386lfd.5
        for <linux-watchdog@vger.kernel.org>; Sat, 12 Aug 2017 11:43:45 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 07/11] watchdog: ftwdt010: Delete surplus bindings
Date: Sat, 12 Aug 2017 20:43:14 +0200
Message-Id: <20170812184318.10144-8-linus.walleij@linaro.org>
In-Reply-To: <20170812184318.10144-1-linus.walleij@linaro.org>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

With the MOXA ART and Aspeed DT bindings covered by the
FTWDT010 binding, these surplus bindings can be deleted.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/watchdog/aspeed-wdt.txt          | 16 ----------------
 .../bindings/watchdog/moxa,moxart-watchdog.txt           | 15 ---------------
 2 files changed, 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/moxa,moxart-watchdog.txt

diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
deleted file mode 100644
index c5e74d7b4406..000000000000
--- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Aspeed Watchdog Timer
-
-Required properties:
- - compatible: must be one of:
-	- "aspeed,ast2400-wdt"
-	- "aspeed,ast2500-wdt"
-
- - reg: physical base address of the controller and length of memory mapped
-   region
-
-Example:
-
-	wdt1: watchdog@1e785000 {
-		compatible = "aspeed,ast2400-wdt";
-		reg = <0x1e785000 0x1c>;
-	};
diff --git a/Documentation/devicetree/bindings/watchdog/moxa,moxart-watchdog.txt b/Documentation/devicetree/bindings/watchdog/moxa,moxart-watchdog.txt
deleted file mode 100644
index 1169857d1d12..000000000000
--- a/Documentation/devicetree/bindings/watchdog/moxa,moxart-watchdog.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-MOXA ART Watchdog timer
-
-Required properties:
-
-- compatible : Must be "moxa,moxart-watchdog"
-- reg : Should contain registers location and length
-- clocks : Should contain phandle for the clock that drives the counter
-
-Example:
-
-	watchdog: watchdog@98500000 {
-		compatible = "moxa,moxart-watchdog";
-		reg = <0x98500000 0x10>;
-		clocks = <&coreclk>;
-	};
-- 
2.13.4

