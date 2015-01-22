Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:59596 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbbAVL4r (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 22 Jan 2015 06:56:47 -0500
Received: by mail-ie0-f182.google.com with SMTP id ar1so894694iec.13
        for <linux-watchdog@vger.kernel.org>; Thu, 22 Jan 2015 03:56:46 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, david.paris@st.com
Subject: [PATCH v2 3/9] ARM: multi_v7_defconfig: Enable support for ST's LPC RTC
Date: Thu, 22 Jan 2015 11:56:01 +0000
Message-Id: <1421927767-28889-4-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1421927767-28889-1-git-send-email-lee.jones@linaro.org>
References: <1421927767-28889-1-git-send-email-lee.jones@linaro.org>
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

