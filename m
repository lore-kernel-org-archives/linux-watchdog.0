Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Cochran <rcochran@linutronix.de>
To: <linux-kernel@vger.kernel.org>
Cc: <rt@linutronix.de>, Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Subject: [PATCH 2/5] watchdog: octeon: Handle the FROZEN hot plug notifier actions.
Date: Fri, 18 Mar 2016 22:26:08 +0100
Message-Id: <1458336371-17748-2-git-send-email-rcochran@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

When performing a suspend operation, the kernel brings all of the
non-boot CPUs offline, calling the hot plug notifiers with the flag,
CPU_TASKS_FROZEN, set in the action code.  Similarly, during resume,
the CPUs are brought back online, but again the notifiers have the
FROZEN flag set.

While some very few drivers really need to treat suspend/resume
specially, this driver unintentionally ignores the notifications.

This patch changes the driver to disable the watchdog interrupt
whenever the CPU goes offline, and to enable it whenever the CPU goes
back online.  As a result, the suspended state is no longer a special
case that leaves the watchdog active.

Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Signed-off-by: Richard Cochran <rcochran@linutronix.de>
---
 drivers/watchdog/octeon-wdt-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 14521c8..b55981f 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -431,7 +431,7 @@ static int octeon_wdt_cpu_callback(struct notifier_block *nfb,
 {
 	unsigned int cpu = (unsigned long)hcpu;
 
-	switch (action) {
+	switch (action & ~CPU_TASKS_FROZEN) {
 	case CPU_DOWN_PREPARE:
 		octeon_wdt_disable_interrupt(cpu);
 		break;
-- 
2.1.4
