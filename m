Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37081 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329AbbDIOro (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 9 Apr 2015 10:47:44 -0400
Received: by wiaa2 with SMTP id a2so101420593wia.0
        for <linux-watchdog@vger.kernel.org>; Thu, 09 Apr 2015 07:47:43 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, a.zummo@towertech.it, david.paris@st.com
Subject: [PATCH v7 2/9] ARM: multi_v7_defconfig: Enable support for ST's LPC Watchdog
Date: Thu,  9 Apr 2015 15:47:27 +0100
Message-Id: <1428590854-14095-3-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1428590854-14095-1-git-send-email-lee.jones@linaro.org>
References: <1428590854-14095-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

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

