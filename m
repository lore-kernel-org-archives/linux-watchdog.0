Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:33223 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbbKPTQi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 16 Nov 2015 14:16:38 -0500
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Cc: shawnguo@kernel.org, kernel@pengutronix.de, wim@iguana.be,
	robh+dt@kernel.org, sameo@linux.intel.com, lee.jones@linaro.org,
	dinh.linux@gmail.com, linux@roeck-us.net,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v3 4/5] ARM: imx_v6_v7_defconfig: add TS-4800 watchdog
Date: Mon, 16 Nov 2015 14:06:53 -0500
Message-Id: <1447700814-5391-5-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1447700814-5391-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1447700814-5391-1-git-send-email-damien.riegel@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The TS-4800, based on an IMX.515, needs its watchdog support in order to
work.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 79194c6..8968166 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -195,6 +195,7 @@ CONFIG_THERMAL=y
 CONFIG_CPU_THERMAL=y
 CONFIG_IMX_THERMAL=y
 CONFIG_WATCHDOG=y
+CONFIG_TS4800_WATCHDOG=y
 CONFIG_IMX2_WDT=y
 CONFIG_MFD_DA9052_I2C=y
 CONFIG_MFD_MC13XXX_SPI=y
-- 
2.5.0

