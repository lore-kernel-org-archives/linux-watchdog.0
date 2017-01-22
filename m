Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34280 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdAVWil (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 22 Jan 2017 17:38:41 -0500
Received: by mail-lf0-f47.google.com with SMTP id v186so84814231lfa.1
        for <linux-watchdog@vger.kernel.org>; Sun, 22 Jan 2017 14:38:40 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: Janos Laube <janos.dev@gmail.com>,
        Paulius Zaleckas <paulius.zaleckas@gmail.com>,
        openwrt-devel@openwrt.org, linux-watchdog@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 1/3] watchdog: add DT bindings for Cortina Gemini
Date: Sun, 22 Jan 2017 23:38:26 +0100
Message-Id: <20170122223826.29178-1-linus.walleij@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This adds DT bindings for the Cortina systems Gemini SoC
watchdog timer.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/watchdog/cortina,gemin-watchdog.txt        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/cortina,gemin-watchdog.txt

diff --git a/Documentation/devicetree/bindings/watchdog/cortina,gemin-watchdog.txt b/Documentation/devicetree/bindings/watchdog/cortina,gemin-watchdog.txt
new file mode 100644
index 000000000000..d8dfb9cc41cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/cortina,gemin-watchdog.txt
@@ -0,0 +1,17 @@
+Cortina Systems Gemini SoC Watchdog
+
+Required properties :
+- compatible : must be "cortina,gemini-watchdog"
+- reg : shall contain base register location and length
+- interrupts : shall contain the interrupt for the watchdog
+
+- timeout-sec : shall contain the default watchdog timeout in seconds,
+                if unset, the default timeout is 13 seconds
+
+Example:
+
+watchdog@41000000 {
+	compatible = "cortina,gemini-watchdog";
+	reg = <0x41000000 0x1000>;
+	interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.9.3

