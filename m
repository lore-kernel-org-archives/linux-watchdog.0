Return-Path: <markus.mayer@linaro.org>
From: Markus Mayer <markus.mayer@linaro.org>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Christian Daudt <bcm@fixthebug.org>
CC: Linaro Patches <patches@linaro.org>, Linux Watchdog List
	<linux-watchdog@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Markus Mayer <markus.mayer@linaro.org>
Subject: [PATCH 2/2] watchdog: bcm281xx: Turn on debugfs support for watchdog driver
Date: Tue, 31 Dec 2013 13:22:14 -0800
Message-ID: <1388524934-10563-3-git-send-email-markus.mayer@linaro.org>
In-Reply-To: <1388524934-10563-1-git-send-email-markus.mayer@linaro.org>
References: <1388524934-10563-1-git-send-email-markus.mayer@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: markus.mayer@linaro.org
List-ID: <linux-watchdog@vger.kernel.org>

This change turns on debugfs support for the BCM281xx watchdog driver.

Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
---
 arch/arm/configs/bcm_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
index 10d1392..d4d0083 100644
--- a/arch/arm/configs/bcm_defconfig
+++ b/arch/arm/configs/bcm_defconfig
@@ -128,3 +128,4 @@ CONFIG_XZ_DEC=y
 CONFIG_AVERAGE=y
 CONFIG_WATCHDOG=y
 CONFIG_BCM_KONA_WDT=y
+CONFIG_BCM_KONA_WDT_DEBUG=y
-- 
1.7.9.5
