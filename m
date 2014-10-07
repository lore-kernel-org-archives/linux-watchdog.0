Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:57651 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753999AbaJGOg2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 Oct 2014 10:36:28 -0400
Received: by mail-ie0-f169.google.com with SMTP id tp5so5521680ieb.28
        for <linux-watchdog@vger.kernel.org>; Tue, 07 Oct 2014 07:36:28 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, linux@roeck-us.net
Subject: [PATCH 2/4] ARM: multi_v7_defconfig: Enable support for ST's LPC Watchdog
Date: Tue,  7 Oct 2014 15:36:10 +0100
Message-Id: <1412692572-14031-3-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1412692572-14031-1-git-send-email-lee.jones@linaro.org>
References: <1412692572-14031-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5fb95fb..034aeab 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -238,6 +238,7 @@ CONFIG_ST_THERMAL_SYSCFG=y
 CONFIG_ST_THERMAL_MEMMAP=y
 CONFIG_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
+CONFIG_ST_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
 CONFIG_MFD_AS3722=y
 CONFIG_MFD_BCM590XX=y
-- 
1.9.1

