Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Russell King <linux@arm.linux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v7 4/6] ARM: imx_v6_v7_defconfig: add TS-4800 watchdog
Date: Mon, 30 Nov 2015 10:59:49 -0500
Message-Id: <1448899191-13891-5-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1448899191-13891-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1448899191-13891-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

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
