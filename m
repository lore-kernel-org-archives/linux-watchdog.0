Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:46148 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828AbbBYNwq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 Feb 2015 08:52:46 -0500
Received: by wevm14 with SMTP id m14so3689155wev.13
        for <linux-watchdog@vger.kernel.org>; Wed, 25 Feb 2015 05:52:45 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, david.paris@st.com, a.zummo@towertech.it
Cc: lee.jones@linaro.org, kernel@stlinux.com
Subject: [PATCH v4 3/9] ARM: multi_v7_defconfig: Enable support for ST's LPC RTC
Date: Wed, 25 Feb 2015 13:52:23 +0000
Message-Id: <1424872349-4155-4-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1424872349-4155-1-git-send-email-lee.jones@linaro.org>
References: <1424872349-4155-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 0f172f8..1a861c9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -423,6 +423,7 @@ CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_MAX8907=y
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_PALMAS=y
+CONFIG_RTC_DRV_ST_LPC=y
 CONFIG_RTC_DRV_TWL4030=y
 CONFIG_RTC_DRV_TPS6586X=y
 CONFIG_RTC_DRV_TPS65910=y
-- 
1.9.1

