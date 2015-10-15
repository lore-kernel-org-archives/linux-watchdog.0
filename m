Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1bon0138.outbound.protection.outlook.com ([157.56.111.138]:53088
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752698AbbJOMV5 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 15 Oct 2015 08:21:57 -0400
From: Zhiqiang Hou <B48286@freescale.com>
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
Subject: [PATCH V4 2/6] watchdog: Add support for Freescale Layerscape platforms
Date: Thu, 15 Oct 2015 20:12:57 +0800
Message-ID: <1444911181-21696-2-git-send-email-B48286@freescale.com>
In-Reply-To: <1444911181-21696-1-git-send-email-B48286@freescale.com>
References: <1444911181-21696-1-git-send-email-B48286@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Shaohui Xie <Shaohui.Xie@freescale.com>

Modify watchdog/Kconfig file to support Layerscape platforms.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
Signed-off-by: Wenbin Song <Wenbin.Song@freescale.com>
Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
---
This patch has been acked in V3 by Guenter Roeck [linux@roeck-us.net].

V4: V3 V2
 - No change.

 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 79e1aa1..448dbaf 100644
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

