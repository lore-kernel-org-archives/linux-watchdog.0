Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51]:55379 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbaLQQpt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 17 Dec 2014 11:45:49 -0500
Received: by mail-yh0-f51.google.com with SMTP id a41so7243682yho.24
        for <linux-watchdog@vger.kernel.org>; Wed, 17 Dec 2014 08:45:49 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com, a.zummo@towertech.it,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net, arnd@arndb.de
Subject: [PATCH 3/8] ARM: multi_v7_defconfig: Enable support for ST's LPC RTC
Date: Wed, 17 Dec 2014 16:45:22 +0000
Message-Id: <1418834727-1602-4-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1418834727-1602-1-git-send-email-lee.jones@linaro.org>
References: <1418834727-1602-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e34d5c6..09b8bce 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -344,6 +344,7 @@ CONFIG_RTC_DRV_AS3722=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_MAX8907=y
 CONFIG_RTC_DRV_PALMAS=y
+CONFIG_RTC_DRV_ST_LPC=y
 CONFIG_RTC_DRV_TWL4030=y
 CONFIG_RTC_DRV_TPS6586X=y
 CONFIG_RTC_DRV_TPS65910=y
-- 
1.9.1

