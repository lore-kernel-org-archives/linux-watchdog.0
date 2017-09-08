Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:2511 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756800AbdIHSgQ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 8 Sep 2017 14:36:16 -0400
From: Mathieu Malaterre <malat@debian.org>
Cc: Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH 2/3] watchdog: jz4780: Allow selection of jz4740-wdt driver
Date: Fri,  8 Sep 2017 20:35:54 +0200
Message-Id: <20170908183558.1537-2-malat@debian.org>
In-Reply-To: <20170908183558.1537-1-malat@debian.org>
References: <20170908183558.1537-1-malat@debian.org>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This driver works for jz4740 & jz4780

Suggested-by: Maarten ter Huurne <maarten@treewalker.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c722cbfdc7e6..ca200d1f310a 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1460,7 +1460,7 @@ config INDYDOG
 
 config JZ4740_WDT
 	tristate "Ingenic jz4740 SoC hardware watchdog"
-	depends on MACH_JZ4740
+	depends on MACH_JZ4740 || MACH_JZ4780
 	select WATCHDOG_CORE
 	help
 	  Hardware driver for the built-in watchdog timer on Ingenic jz4740 SoCs.
-- 
2.11.0

