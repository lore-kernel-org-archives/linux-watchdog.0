Return-Path: <groeck7@gmail.com>
Return-Path: <groeck7@gmail.com>
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Russell King <linux@arm.linux.org.uk>,
	Jonas Jensen <jonas.jensen@gmail.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 3/5] arm: Support reboot through watchdog subsystem
Date: Fri,  9 May 2014 17:31:21 -0700
Message-Id: <1399681883-891-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1399681883-891-1-git-send-email-linux@roeck-us.net>
References: <1399681883-891-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

The watchdog subsystem provides an API to perform a system reboot.
Use it.

With this change, the arm_pm_restart callback is now optional,
so check if it is set before calling it.

Tested-by: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: No change

 arch/arm/kernel/process.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 81ef686..c3b7b5e 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -32,6 +32,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/leds.h>
 #include <linux/reboot.h>
+#include <linux/watchdog.h>
 
 #include <asm/cacheflush.h>
 #include <asm/idmap.h>
@@ -230,7 +231,10 @@ void machine_restart(char *cmd)
 	local_irq_disable();
 	smp_send_stop();
 
-	arm_pm_restart(reboot_mode, cmd);
+	if (arm_pm_restart)
+		arm_pm_restart(reboot_mode, cmd);
+
+	watchdog_do_reboot(reboot_mode, cmd);
 
 	/* Give a grace period for failure to restart of 1s */
 	mdelay(1000);
-- 
1.9.1
