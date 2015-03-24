Return-path: <lee.jones@linaro.org>
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux@roeck-us.net,
	david.paris@st.com,
	a.zummo@towertech.it
Cc: lee.jones@linaro.org,
	kernel@stlinux.com
Subject: [PATCH v6 2/9] ARM: multi_v7_defconfig: Enable support for ST's LPC Watchdog
Date: Tue, 24 Mar 2015 09:25:33 +0000
Message-Id: <1427189140-1935-3-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1427189140-1935-1-git-send-email-lee.jones@linaro.org>
References: <1427189140-1935-1-git-send-email-lee.jones@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index b7e6b6fb..138e68a 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -324,6 +324,7 @@ CONFIG_WATCHDOG=y
 CONFIG_XILINX_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
+CONFIG_ST_LPC_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
 CONFIG_MESON_WATCHDOG=y
 CONFIG_MFD_AS3711=y
-- 
1.9.1
