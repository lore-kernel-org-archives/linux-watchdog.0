Return-path: <lee.jones@linaro.org>
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	wim@iguana.be,
	a.zummo@towertech.it,
	linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com,
	linux@roeck-us.net
Cc: kernel@stlinux.com,
	Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 11/12] ARM: STi: Enable LPC Clocksource
Date: Tue, 12 May 2015 13:58:19 +0100
Message-Id: <1431435500-22899-12-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
References: <1431435500-22899-1-git-send-email-lee.jones@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

This timer can be used as the system (tick) timer.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-sti/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index 3b1ac46..cb886de 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -2,6 +2,7 @@ menuconfig ARCH_STI
 	bool "STMicroelectronics Consumer Electronics SOCs" if ARCH_MULTI_V7
 	select ARM_GIC
 	select ARM_GLOBAL_TIMER
+	select CLKSRC_ST_LPC
 	select PINCTRL
 	select PINCTRL_ST
 	select MFD_SYSCON
-- 
1.9.1
