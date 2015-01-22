Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:35667 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbbAVL4m (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 22 Jan 2015 06:56:42 -0500
Received: by mail-ie0-f179.google.com with SMTP id x19so902174ier.10
        for <linux-watchdog@vger.kernel.org>; Thu, 22 Jan 2015 03:56:41 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, david.paris@st.com
Subject: [PATCH v2 2/9] ARM: multi_v7_defconfig: Enable support for ST's LPC Watchdog
Date: Thu, 22 Jan 2015 11:56:00 +0000
Message-Id: <1421927767-28889-3-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1421927767-28889-1-git-send-email-lee.jones@linaro.org>
References: <1421927767-28889-1-git-send-email-lee.jones@linaro.org>
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

