Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:39289 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758396AbbCDSGt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 4 Mar 2015 13:06:49 -0500
Received: by wggx12 with SMTP id x12so48410358wgg.6
        for <linux-watchdog@vger.kernel.org>; Wed, 04 Mar 2015 10:06:47 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, david.paris@st.com, a.zummo@towertech.it
Subject: [PATCH v5 2/9] ARM: multi_v7_defconfig: Enable support for ST's LPC Watchdog
Date: Wed,  4 Mar 2015 18:06:31 +0000
Message-Id: <1425492398-27340-3-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1425492398-27340-1-git-send-email-lee.jones@linaro.org>
References: <1425492398-27340-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e8a4c95..0f172f8 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -288,6 +288,7 @@ CONFIG_WATCHDOG=y
 CONFIG_XILINX_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
+CONFIG_ST_LPC_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
 CONFIG_MESON_WATCHDOG=y
 CONFIG_MFD_AS3722=y
-- 
1.9.1

