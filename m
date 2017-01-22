Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:36735 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdAVWju (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 22 Jan 2017 17:39:50 -0500
Received: by mail-lf0-f53.google.com with SMTP id z134so84766243lff.3
        for <linux-watchdog@vger.kernel.org>; Sun, 22 Jan 2017 14:39:49 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: Janos Laube <janos.dev@gmail.com>,
        Paulius Zaleckas <paulius.zaleckas@gmail.com>,
        openwrt-devel@openwrt.org, linux-watchdog@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/3] ARM: dts: add watchdog to the Gemini
Date: Sun, 22 Jan 2017 23:39:43 +0100
Message-Id: <20170122223943.29380-1-linus.walleij@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This adds watchdog support to the Gemini SoC DTSI file.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This pach is FYI only, I will carry this to the ARM SoC tree.
---
 arch/arm/boot/dts/gemini.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index 19c93cfbeae3..405d6cedf409 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -33,6 +33,12 @@
 		};
 	};
 
+	watchdog@41000000 {
+		compatible = "cortina,gemini-watchdog";
+		reg = <0x41000000 0x1000>;
+		interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	timer@43000000 {
 		compatible = "cortina,gemini-timer";
 		reg = <0x43000000 0x1000>;
-- 
2.9.3

