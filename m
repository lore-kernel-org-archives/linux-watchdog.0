Return-path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	Paul Burton <paul.burton@imgtec.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Maarten ter Huurne <maarten@treewalker.org>,
	linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] MIPS: Use do_kernel_restart() as the default restart handler
Date: Sat, 10 Jan 2015 19:29:08 +0100
Message-Id: <1420914550-18335-1-git-send-email-lars@metafoo.de>
List-ID: <linux-watchdog@vger.kernel.org>

Use the recently introduced do_kernel_restart() function as the default restart
handler if the platform did not explicitly provide a restart handler. This
allows use restart handler that have been registered by device drivers to
restart the machine.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/kernel/reset.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
index 07fc524..36cd80c 100644
--- a/arch/mips/kernel/reset.c
+++ b/arch/mips/kernel/reset.c
@@ -19,7 +19,7 @@
  * So handle all using function pointers to machine specific
  * functions.
  */
-void (*_machine_restart)(char *command);
+void (*_machine_restart)(char *command) = do_kernel_restart;
 void (*_machine_halt)(void);
 void (*pm_power_off)(void);
 
-- 
1.7.10.4
