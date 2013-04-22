Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:53203 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755989Ab3DVJzj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Apr 2013 05:55:39 -0400
From: Linus Walleij <linus.walleij@stericsson.com>
To: <linux-arm-kernel@lists.infradead.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	<linux-watchdog@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	<devicetree-discuss@lists.ozlabs.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 10/23] ARM: u300: add the COH 901 327 watchdog to device tree
Date: Mon, 22 Apr 2013 11:55:18 +0200
Message-ID: <1366624518-6471-1-git-send-email-linus.walleij@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds the COH 901 327 watchdog to the U300 device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-u300.dts | 7 +++++++
 arch/arm/mach-u300/core.c      | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index 9c08d5e..b1b63bb 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -49,6 +49,13 @@
 		reg = <0xc0011000 0x1000>;
 	};
 
+	watchdog: watchdog@c0012000 {
+		compatible = "stericsson,coh901327";
+		reg = <0xc0012000 0x1000>;
+		interrupt-parent = <&vicb>;
+		interrupts = <3>;
+	};
+
 	i2c0: i2c@c0004000 {
 		compatible = "st,ddci2c";
 		reg = <0xc0004000 0x1000>;
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index fedad38..f97b65c 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -709,6 +709,8 @@ static struct of_dev_auxdata u300_auxdata_lookup[] __initdata = {
 		"pinctrl-u300", NULL),
 	OF_DEV_AUXDATA("stericsson,gpio-coh901", U300_GPIO_BASE,
 		"u300-gpio", &u300_gpio_plat),
+	OF_DEV_AUXDATA("stericsson,coh901327", U300_WDOG_BASE,
+		"coh901327_wdog", NULL),
 	OF_DEV_AUXDATA("arm,primecell", U300_UART0_BASE,
 		"uart0", &uart0_plat_data),
 	OF_DEV_AUXDATA("arm,primecell", U300_UART1_BASE,
-- 
1.7.11.3

