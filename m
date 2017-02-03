Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36676 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbdBCT4F (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 3 Feb 2017 14:56:05 -0500
Received: by mail-lf0-f51.google.com with SMTP id z134so15667124lff.3
        for <linux-watchdog@vger.kernel.org>; Fri, 03 Feb 2017 11:56:04 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Cc: Janos Laube <janos.dev@gmail.com>,
        Paulius Zaleckas <paulius.zaleckas@gmail.com>,
        openwrt-devel@openwrt.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 2/3 v3] watchdog: add DT bindings for Cortina Gemini
Date: Fri,  3 Feb 2017 20:55:51 +0100
Message-Id: <20170203195551.4825-1-linus.walleij@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This adds DT bindings for the Cortina systems Gemini SoC
watchdog timer.

Cc: devicetree@vger.kernel.org
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Fixed spelling error in filename "gemin" to "gemini"
- Collected ACKs
ChangeLog v1->v2:
- Make the timeout an optional property
- Do not mention any Linux defaults if the property is not there
---
 .../bindings/watchdog/cortina,gemini-watchdog.txt       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/cortina,gemini-watchdog.txt

diff --git a/Documentation/devicetree/bindings/watchdog/cortina,gemini-watchdog.txt b/Documentation/devicetree/bindings/watchdog/cortina,gemini-watchdog.txt
new file mode 100644
index 000000000000..bc4b865d178b
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/cortina,gemini-watchdog.txt
@@ -0,0 +1,17 @@
+Cortina Systems Gemini SoC Watchdog
+
+Required properties:
+- compatible : must be "cortina,gemini-watchdog"
+- reg : shall contain base register location and length
+- interrupts : shall contain the interrupt for the watchdog
+
+Optional properties:
+- timeout-sec : the default watchdog timeout in seconds.
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

