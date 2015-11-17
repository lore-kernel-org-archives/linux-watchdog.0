Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1bbn0108.outbound.protection.outlook.com ([157.56.111.108]:1280
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751884AbbKQKBy (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 17 Nov 2015 05:01:54 -0500
From: Zhiqiang Hou <Zhiqiang.Hou@freescale.com>
To: <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
	<will.deacon@arm.com>, <linux-i2c@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-clk@vger.kernel.org>
CC: <mark.rutland@arm.com>, <linux@roeck-us.net>, <wsa@the-dreams.de>,
	<wim@iguana.be>, <corbet@lwn.net>, <mturquette@baylibre.com>,
	<sboyd@codeaurora.org>, <Mingkai.Hu@freescale.com>,
	<Shaohui.Xie@freescale.com>, <scottwood@freescale.com>,
	<bhupesh.sharma@freescale.com>, <Wenbin.Song@freescale.com>,
	<B48286@freescale.com>
Subject: [PATCHv8 2/5] watchdog: Add support for Freescale Layerscape platforms
Date: Tue, 17 Nov 2015 17:53:19 +0800
Message-ID: <1447754002-40555-2-git-send-email-Zhiqiang.Hou@freescale.com>
In-Reply-To: <1447754002-40555-1-git-send-email-Zhiqiang.Hou@freescale.com>
References: <1447754002-40555-1-git-send-email-Zhiqiang.Hou@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Shaohui Xie <Shaohui.Xie@freescale.com>

Modify watchdog/Kconfig file to support Layerscape platforms.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
V8:
 - No change.

V6:
 - Remove a Signed-off.

V5: V4 V3 V2
 - No change.

 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 7a8a6c6..1c427be 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -446,7 +446,7 @@ config MAX63XX_WATCHDOG
 
 config IMX2_WDT
 	tristate "IMX2+ Watchdog"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || ARCH_LAYERSCAPE
 	select REGMAP_MMIO
 	select WATCHDOG_CORE
 	help
-- 
2.1.0.27.g96db324

