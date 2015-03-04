Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:41525 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758407AbbCDSGu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 4 Mar 2015 13:06:50 -0500
Received: by wevm14 with SMTP id m14so48037831wev.8
        for <linux-watchdog@vger.kernel.org>; Wed, 04 Mar 2015 10:06:49 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, david.paris@st.com, a.zummo@towertech.it
Subject: [PATCH v5 3/9] ARM: multi_v7_defconfig: Enable support for ST's LPC RTC
Date: Wed,  4 Mar 2015 18:06:32 +0000
Message-Id: <1425492398-27340-4-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1425492398-27340-1-git-send-email-lee.jones@linaro.org>
References: <1425492398-27340-1-git-send-email-lee.jones@linaro.org>
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

