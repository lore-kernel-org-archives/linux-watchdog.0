Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:33830 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbbBRLtZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 Feb 2015 06:49:25 -0500
Received: by mail-wg0-f41.google.com with SMTP id b13so678886wgh.0
        for <linux-watchdog@vger.kernel.org>; Wed, 18 Feb 2015 03:49:24 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, david.paris@st.com
Subject: [PATCH v3 2/8] ARM: multi_v7_defconfig: Enable support for ST's LPC RTC
Date: Wed, 18 Feb 2015 11:49:08 +0000
Message-Id: <1424260154-12868-3-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1424260154-12868-1-git-send-email-lee.jones@linaro.org>
References: <1424260154-12868-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 561ca4f..4e45e53 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -405,6 +405,7 @@ CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_MAX8907=y
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_PALMAS=y
+CONFIG_RTC_DRV_ST_LPC=y
 CONFIG_RTC_DRV_TWL4030=y
 CONFIG_RTC_DRV_TPS6586X=y
 CONFIG_RTC_DRV_TPS65910=y
-- 
1.9.1

