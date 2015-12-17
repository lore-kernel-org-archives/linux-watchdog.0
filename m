Return-path: <rongqing.li@windriver.com>
From: roy.qing.li@gmail.com
To: linux-watchdog@vger.kernel.org, wim@iguana.be, linux@roeck-us.net
Subject: [PATCH] watchdog: refuse to unload softdog module when its timer is running
Date: Thu, 17 Dec 2015 21:30:02 +0800
Message-Id: <1450359002-26577-1-git-send-email-roy.qing.li@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Li RongQing <roy.qing.li@gmail.com>

the softdog has static variables which are accessed if its timer is
still running after the driver is unloaded. and lead to crash:

   $modprobe softdog
   $echo 1 >/dev/watchdog
   $modprobe -r softdog

   CPU 20 Unable to handle kernel paging request at virtual address
   Oops[#1]:
   CPU: 20 PID: 0 Comm: swapper/20 Not tainted 4.1.13-WR8.0.0.0_standard
   ...
   Modules linked in: [last unloaded: softdog]
    ....
   Call Trace:
   [<ffffffff801e142c>] cascade+0x34/0xb0
   [<ffffffff801e1964>] run_timer_softirq+0x30c/0x368
   [<ffffffff80181044>] __do_softirq+0x1ec/0x418
   [<ffffffff801815d0>] irq_exit+0x90/0x98
   [<ffffffff8010749c>] plat_irq_dispatch+0xa4/0x140
   [<ffffffff80152740>] ret_from_irq+0x0/0x4
   [<ffffffff801529e0>] __r4k_wait+0x20/0x40
   [<ffffffff801c2278>] cpu_startup_entry+0x2a0/0x368
   [<ffffffff8015fa64>] start_secondary+0x444/0x4d8

add the module ref when timer is running to avoid to unload the softdog
module

Signed-off-by: Li RongQing <roy.qing.li@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net> 
---
 drivers/watchdog/softdog.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index 0dc5e323d..86ce3f9 100644
--- a/drivers/watchdog/softdog.c
+++ b/drivers/watchdog/softdog.c
@@ -87,6 +87,7 @@ static struct timer_list watchdog_ticktock =
 
 static void watchdog_fire(unsigned long data)
 {
+	module_put(THIS_MODULE);
 	if (soft_noboot)
 		pr_crit("Triggered - Reboot ignored\n");
 	else if (soft_panic) {
@@ -105,13 +106,16 @@ static void watchdog_fire(unsigned long data)
 
 static int softdog_ping(struct watchdog_device *w)
 {
-	mod_timer(&watchdog_ticktock, jiffies+(w->timeout*HZ));
+	if (!mod_timer(&watchdog_ticktock, jiffies+(w->timeout*HZ)))
+		__module_get(THIS_MODULE);
 	return 0;
 }
 
 static int softdog_stop(struct watchdog_device *w)
 {
-	del_timer(&watchdog_ticktock);
+	if (del_timer(&watchdog_ticktock))
+		module_put(THIS_MODULE);
+
 	return 0;
 }
 
-- 
2.1.4
