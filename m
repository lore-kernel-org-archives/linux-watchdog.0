Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yh0-f42.google.com ([209.85.213.42]:58544 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817AbaIDOkq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 4 Sep 2014 10:40:46 -0400
Received: by mail-yh0-f42.google.com with SMTP id v1so6401471yhn.1
        for <linux-watchdog@vger.kernel.org>; Thu, 04 Sep 2014 07:40:46 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 2/4] ARM: multi_v7_defconfig: Enable support for ST's LPC Watchdog
Date: Thu,  4 Sep 2014 15:39:49 +0100
Message-Id: <1409841592-18890-3-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1409841592-18890-1-git-send-email-lee.jones@linaro.org>
References: <1409841592-18890-1-git-send-email-lee.jones@linaro.org>
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

