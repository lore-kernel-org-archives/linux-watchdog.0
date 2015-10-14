Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bl2on0110.outbound.protection.outlook.com ([65.55.169.110]:9952
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753429AbbJNLmJ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 14 Oct 2015 07:42:09 -0400
From: Zhiqiang Hou <B48286@freescale.com>
To: <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
	<will.deacon@arm.com>, <linux-i2c@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <mark.rutland@arm.com>
CC: <Mingkai.Hu@freescale.com>, <Shaohui.Xie@freescale.com>,
	<scottwood@freescale.com>, <bhupesh.sharma@freescale.com>,
	<leoli@freescale.com>, <wsa@the-dreams.de>, <wim@iguana.be>,
	<corbet@lwn.net>, <mturquette@baylibre.com>,
	<sboyd@codeaurora.org>, <Wenbin.Song@freescale.com>,
	Hou Zhiqiang <B48286@freescale.com>
Subject: [PATCH V3 2/6] watchdog: Add support for Freescale Layerscape platforms
Date: Wed, 14 Oct 2015 19:34:54 +0800
Message-ID: <1444822498-16477-3-git-send-email-B48286@freescale.com>
In-Reply-To: <1444822498-16477-1-git-send-email-B48286@freescale.com>
References: <1444822498-16477-1-git-send-email-B48286@freescale.com>
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
V3:
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

