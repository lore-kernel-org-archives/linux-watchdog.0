Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-by2on0103.outbound.protection.outlook.com ([207.46.100.103]:45783
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751151AbbJSMRq (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 19 Oct 2015 08:17:46 -0400
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
Subject: [PATCH V5 1/6] i2c: Add i2c support to Freescale Layerscape platforms
Date: Mon, 19 Oct 2015 19:56:09 +0800
Message-ID: <1445255774-32887-1-git-send-email-B48286@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Shaohui Xie <Shaohui.Xie@freescale.com>

Modify the I2C_IMX config to support to Layerscape platforms.

Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
Signed-off-by: Wenbin Song <Wenbin.Song@freescale.com>
Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
---
V5: V4 V3 V2
 - No change.

 drivers/i2c/busses/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 08b8617..14147ec 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -582,10 +582,10 @@ config I2C_IMG
 
 config I2C_IMX
 	tristate "IMX I2C interface"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || ARCH_LAYERSCAPE
 	help
 	  Say Y here if you want to use the IIC bus controller on
-	  the Freescale i.MX/MXC processors.
+	  the Freescale i.MX/MXC or Layerscape processors.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-imx.
-- 
2.1.0.27.g96db324

