Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:44808 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbbBYNwo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 Feb 2015 08:52:44 -0500
Received: by wesk11 with SMTP id k11so3698629wes.11
        for <linux-watchdog@vger.kernel.org>; Wed, 25 Feb 2015 05:52:43 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, david.paris@st.com, a.zummo@towertech.it
Cc: lee.jones@linaro.org, kernel@stlinux.com
Subject: [PATCH v4 2/9] ARM: multi_v7_defconfig: Enable support for ST's LPC Watchdog
Date: Wed, 25 Feb 2015 13:52:22 +0000
Message-Id: <1424872349-4155-3-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1424872349-4155-1-git-send-email-lee.jones@linaro.org>
References: <1424872349-4155-1-git-send-email-lee.jones@linaro.org>
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

