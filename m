Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:39790 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799AbbLQI52 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 17 Dec 2015 03:57:28 -0500
From: roy.qing.li@gmail.com
To: linux-watchdog@vger.kernel.org, wim@iguana.be
Subject: [PATCH] watchdog: force to stop the watchdog when unregister
Date: Thu, 17 Dec 2015 16:57:22 +0800
Message-Id: <1450342642-13429-1-git-send-email-roy.qing.li@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Li RongQing <roy.qing.li@gmail.com>

force to stop the watchdog when unregister, otherwise the watchdog maybe
be suspended and be run after the module is unloaded, like the below:
   $modprobe softdog
   $echo 1 >/dev/watchdog
   $modprobe -r softdog

   CPU 20 Unable to handle kernel paging request at virtual address
   Oops[#1]:
   CPU: 20 PID: 0 Comm: swapper/20 Not tainted 4.1.13-WR8.0.0.0_standard #6
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

Signed-off-by: Li RongQing <roy.qing.li@gmail.com>
---
 drivers/watchdog/watchdog_dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 56a649e..2f3139b 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -569,6 +569,8 @@ int watchdog_dev_register(struct watchdog_device *wdd)
 
 int watchdog_dev_unregister(struct watchdog_device *wdd)
 {
+	watchdog_stop(wdd);
+
 	mutex_lock(&wdd->lock);
 	set_bit(WDOG_UNREGISTERED, &wdd->status);
 	mutex_unlock(&wdd->lock);
-- 
2.1.4

