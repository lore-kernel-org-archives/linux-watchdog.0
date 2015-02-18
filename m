Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:39467 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbbBRLtX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 Feb 2015 06:49:23 -0500
Received: by mail-wi0-f176.google.com with SMTP id h11so40360331wiw.3
        for <linux-watchdog@vger.kernel.org>; Wed, 18 Feb 2015 03:49:22 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, david.paris@st.com
Subject: [PATCH v3 1/8] ARM: multi_v7_defconfig: Enable support for ST's LPC Watchdog
Date: Wed, 18 Feb 2015 11:49:07 +0000
Message-Id: <1424260154-12868-2-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1424260154-12868-1-git-send-email-lee.jones@linaro.org>
References: <1424260154-12868-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 7afc0a2..561ca4f 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -274,6 +274,7 @@ CONFIG_WATCHDOG=y
 CONFIG_XILINX_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
+CONFIG_ST_LPC_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
 CONFIG_MESON_WATCHDOG=y
 CONFIG_MFD_AS3722=y
-- 
1.9.1

