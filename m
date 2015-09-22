Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1on0114.outbound.protection.outlook.com ([157.56.110.114]:19264
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932399AbbIVMkp (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 22 Sep 2015 08:40:45 -0400
From: Zhiqiang Hou <B48286@freescale.com>
To: <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
	<will.deacon@arm.com>, <linux-i2c@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <mark.rutland@arm.com>
CC: <wsa@the-dreams.de>, <wim@iguana.be>, <corbet@lwn.net>,
	<mturquette@baylibre.com>, <sboyd@codeaurora.org>,
	<Mingkai.Hu@freescale.com>, <Shaohui.Xie@freescale.com>,
	<Wenbin.Song@freescale.com>, <scottwood@freescale.com>,
	<bhupesh.sharma@freescale.com>, <leoli@freescale.com>,
	Hou Zhiqiang <B48286@freescale.com>
Subject: [PATCH V2 3/6] Documentation: DT: Add entry for FSL LS1043ARDB board
Date: Tue, 22 Sep 2015 20:34:02 +0800
Message-ID: <1442925245-39246-3-git-send-email-B48286@freescale.com>
In-Reply-To: <1442925245-39246-1-git-send-email-B48286@freescale.com>
References: <1442925245-39246-1-git-send-email-B48286@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Mingkai Hu <Mingkai.Hu@freescale.com>

Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 34c88b0..752a685 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -131,6 +131,10 @@ Example:
 Freescale ARMv8 based Layerscape SoC family Device Tree Bindings
 ----------------------------------------------------------------
 
+LS1043A ARMv8 based RDB Board
+Required root node properties:
+    - compatible = "fsl,ls1043a-rdb", "fsl,ls1043a";
+
 LS2080A ARMv8 based Simulator model
 Required root node properties:
     - compatible = "fsl,ls2080a-simu", "fsl,ls2080a";
-- 
2.1.0.27.g96db324

