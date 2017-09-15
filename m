Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:1766 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751587AbdIOTUs (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 15 Sep 2017 15:20:48 -0400
From: Mathieu Malaterre <malat@debian.org>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] dt: watchdog: Document compatibility with JZ4780
Date: Fri, 15 Sep 2017 21:20:40 +0200
Message-Id: <20170915192040.27768-1-malat@debian.org>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Suggested-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
Changes in v2:
* Document the new compatible string

 Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt b/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
index e27763ef0049..1a56061bfb06 100644
--- a/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
@@ -1,7 +1,7 @@
-Ingenic Watchdog Timer (WDT) Controller for JZ4740
+Ingenic Watchdog Timer (WDT) Controller for JZ4740 & JZ4780
 
 Required properties:
-compatible: "ingenic,jz4740-watchdog"
+compatible: "ingenic,jz4740-watchdog" or "ingenic,jz4780-watchdog"
 reg: Register address and length for watchdog registers
 
 Example:
-- 
2.11.0

