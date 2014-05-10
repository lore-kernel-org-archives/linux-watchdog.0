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
Subject: [PATCH v2 2/5] arm64: Support reboot through watchdog subsystem
Date: Fri,  9 May 2014 17:31:20 -0700
Message-Id: <1399681883-891-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1399681883-891-1-git-send-email-linux@roeck-us.net>
References: <1399681883-891-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

The watchdog subsystem provides an API to perform a system reboot.
Use it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: No change

 arch/arm64/kernel/process.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 6391485..29c2bc0 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -42,6 +42,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/personality.h>
 #include <linux/notifier.h>
+#include <linux/watchdog.h>
 
 #include <asm/compat.h>
 #include <asm/cacheflush.h>
@@ -144,6 +145,8 @@ void machine_restart(char *cmd)
 	if (arm_pm_restart)
 		arm_pm_restart(reboot_mode, cmd);
 
+	watchdog_do_reboot(reboot_mode, cmd);
+
 	/*
 	 * Whoops - the architecture was unable to reboot.
 	 */
-- 
1.9.1
