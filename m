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
	Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Tomasz Figa <t.figa@samsung.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4 2/7] arm64: Support restart through restart notifier call chain
Date: Sun, 13 Jul 2014 08:30:26 -0700
Message-Id: <1405265431-4561-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1405265431-4561-1-git-send-email-linux@roeck-us.net>
References: <1405265431-4561-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

The kernel core now supports a notifier call chain to restart
the system. Call it if arm_pm_restart is not set.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v4: No change.
v3: Use wrapper function to execute notifier call chain.
v2: Only call notifier call chain if arm_pm_restart is not set.
    Do not include linux/watchdog.h.

 arch/arm64/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 43b7c34..b2da6d5 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -174,6 +174,8 @@ void machine_restart(char *cmd)
 	/* Now call the architecture specific reboot code. */
 	if (arm_pm_restart)
 		arm_pm_restart(reboot_mode, cmd);
+	else
+		kernel_restart_notify(cmd);
 
 	/*
 	 * Whoops - the architecture was unable to reboot.
-- 
1.9.1
