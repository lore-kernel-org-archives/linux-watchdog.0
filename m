Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35298 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755424AbbDIOrq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 9 Apr 2015 10:47:46 -0400
Received: by widdi4 with SMTP id di4so95164494wid.0
        for <linux-watchdog@vger.kernel.org>; Thu, 09 Apr 2015 07:47:45 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, a.zummo@towertech.it, david.paris@st.com
Subject: [PATCH v7 3/9] ARM: multi_v7_defconfig: Enable support for ST's LPC RTC
Date: Thu,  9 Apr 2015 15:47:28 +0100
Message-Id: <1428590854-14095-4-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1428590854-14095-1-git-send-email-lee.jones@linaro.org>
References: <1428590854-14095-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 138e68a..136b8da 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -490,6 +490,7 @@ CONFIG_RTC_DRV_MAX8907=y
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_RS5C372=m
 CONFIG_RTC_DRV_PALMAS=y
+CONFIG_RTC_DRV_ST_LPC=y
 CONFIG_RTC_DRV_TWL4030=y
 CONFIG_RTC_DRV_TPS6586X=y
 CONFIG_RTC_DRV_TPS65910=y
-- 
1.9.1

