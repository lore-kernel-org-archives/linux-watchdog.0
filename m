Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.phycard.co.uk ([217.6.246.34]:55936 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754637AbcGENYr (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 5 Jul 2016 09:24:47 -0400
From: Stefan Christ <s.christ@phytec.de>
To: linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: [PATCH 0/6] Implement I2C restart handler
Date: Tue, 5 Jul 2016 15:22:17 +0200
Message-Id: <1467724943-13416-1-git-send-email-s.christ@phytec.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

this is a request for feedback about a lockdep-warning-free I2C
restart_handler.  I would like to know whether someone had the problem already
and how the best and mainline friendliest solution looks like.

I have an embedded board with the PMIC chip DA9063 that is also used as a
voltage regulator for DVFS. For a clean reboot/reset of the system I have to
set the bit nSHUTDOWN in the PMIC via I2C. The restart_handler call chain
is of type

    static ATOMIC_NOTIFIER_HEAD(restart_handler_list);

So any code running as a restart_handler cannot (should not) wait, for other
locks. When you use i2c_transfer/regmap you get lockdep warnings like [1].

If for example the I2C adapter lock is already held by another task, the system
blocks indefinitely. The other task maybe the dynamic voltage and frequency
scaling that is adjusting system voltages.

The first two patches fix the watchdog code. It's not allowed to trigger the
DA9063 watchdog too fast. This leads to random resets. I will port these
patches to the current master and resend them.

The subsequent patch implements a blocking and schedule-free I2C transfer
function in the i.MX6 I2C driver. For now the watchdog driver will access the
function master_xfer_blocking directly.

The next patch allows a single consumer to block an I2C adapter for other
consumers. The implementation is bad, but it should only show the idea. The
restart handler has to be the single consumer of the I2C adapter _and_ all
other consumers have to finish before the restart handler starts. Only this
driver should be allowed to acquire the I2C adapter lock now. In the restart
handler you cannot wait for other consumers to finish because they maybe gone
already.

The last patch implements the schedule-free I2C restart handler.

Any comments? 


These patchse are currently based on kernel version 4.1.x, but I will port them
to newer kernels after I got some feedback.


Stefan Christ (6):
  watchdog: da9063_wdt: don't trigger watchdog too fast
  watchdog: da9063_wdt: use delayed work to trigger
  i2c-imx: add blocking xfer function
  i2c-core: add possibility to block an adapter for a single user
  mfd: da9063: save i2c_client for later use
  watchdog: da9063_wdt: add schedule-free and race-free restart handler

 drivers/i2c/busses/i2c-imx.c    | 108 ++++++++++++++++++-------
 drivers/i2c/i2c-core.c          |   5 ++
 drivers/mfd/da9063-i2c.c        |   1 +
 drivers/watchdog/da9063_wdt.c   | 174 +++++++++++++++++++++++++++++++++++++---
 include/linux/i2c.h             |   3 +
 include/linux/mfd/da9063/core.h |   1 +
 6 files changed, 251 insertions(+), 41 deletions(-)

-- 
1.9.1

[1] lockdep warning:

[   13.797547] ===============================
[   13.801727] [ INFO: suspicious RCU usage. ]
[   13.805910] 4.1.18 #237 Not tainted
[   13.809404] -------------------------------
[   13.813593] include/linux/rcupdate.h:570 Illegal context switch in RCU read-side critical section!
[   13.822556] 
[   13.822556] other info that might help us debug this:
[   13.822556] 
[   13.830569] 
[   13.830569] rcu_scheduler_active = 1, debug_locks = 0
[   13.837096] 2 locks held by systemd-shutdow/1:
[   13.841536]  #0:  (reboot_mutex){+.+.+.}, at: [<8004df48>] SyS_reboot+0x84/0x1c8
[   13.849020]  #1:  (rcu_read_lock){......}, at: [<8004c584>] __atomic_notifier_call_chain+0x0/0x128
[   13.858069] 
[   13.858069] stack backtrace:
[   13.862436] CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 4.1.18 #237
[   13.869050] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   13.875574] Backtrace: 
[   13.878051] [<80013fbc>] (dump_backtrace) from [<800141d8>] (show_stack+0x18/0x1c)
[   13.885625]  r6:60030093 r5:00000000 r4:80b8bb4c r3:00000000
[   13.891346] [<800141c0>] (show_stack) from [<8081dba0>] (dump_stack+0xb4/0xe8)
[   13.898586] [<8081daec>] (dump_stack) from [<80069f2c>] (lockdep_rcu_suspicious+0xbc/0x11c)
[   13.906933]  r10:ae960400 r9:00000000 r8:80b6eae4 r7:809fa88c r6:0000023a r5:80a06b84
[   13.914834]  r4:af070000 r3:00000000
[   13.918449] [<80069e70>] (lockdep_rcu_suspicious) from [<808208f4>] (__schedule+0x3d4/0x6d0)
[   13.926882]  r7:80bd0ca3 r6:af070000 r5:80b69900 r4:af717900
[   13.932592] [<80820520>] (__schedule) from [<80820eec>] (preempt_schedule_common+0x28/0x44)
[   13.940947]  r10:ae960400 r9:00000000 r8:00000000 r7:00000000 r6:00000002 r5:803c8d10
[   13.948863]  r4:af056000
[   13.951415] [<80820ec4>] (preempt_schedule_common) from [<80820f48>] (_cond_resched+0x40/0x48)
[   13.960022]  r4:00000000 r3:af056000
[   13.963636] [<80820f08>] (_cond_resched) from [<80822a84>] (mutex_lock_nested+0x20/0x3ec)
[   13.971823] [<80822a64>] (mutex_lock_nested) from [<803c8d10>] (regmap_lock_mutex+0x14/0x18)
[   13.980256]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000002 r5:00000013
[   13.988156]  r4:ae960400
[   13.990711] [<803c8cfc>] (regmap_lock_mutex) from [<803cb424>] (regmap_write+0x38/0x68)
[   13.998729] [<803cb3ec>] (regmap_write) from [<80562428>] (da9063_wdt_restart_handler+0x40/0x68)
[   14.007518]  r6:00000000 r5:ffffffff r4:aea440c0 r3:ae8c9c90
[   14.013229] [<805623e8>] (da9063_wdt_restart_handler) from [<8004c4f8>] (notifier_call_chain+0x54/0x94)
[   14.022626]  r5:ffffffff r4:aea440c0
[   14.026240] [<8004c4a4>] (notifier_call_chain) from [<8004c600>] (__atomic_notifier_call_chain+0x7c/0x128)
[   14.035897]  r9:80bd0c9e r8:00000000 r7:80b7e190 r6:00000000 r5:00000000 r4:ffffffff
[   14.043710] [<8004c584>] (__atomic_notifier_call_chain) from [<8004c6cc>] (atomic_notifier_call_chain+0x20/0x28)
[   14.053887]  r9:af056000 r8:80010784 r7:00772a00 r6:fee1dead r5:80b7e190 r4:00000000
[   14.061700] [<8004c6ac>] (atomic_notifier_call_chain) from [<8004dc4c>] (do_kernel_restart+0x20/0x28)
[   14.070934] [<8004dc2c>] (do_kernel_restart) from [<8001297c>] (machine_restart+0x74/0x8c)
[   14.079209] [<80012908>] (machine_restart) from [<8004dd30>] (kernel_restart+0x40/0x58)
[   14.087217]  r5:80b7e190 r4:00000000
[   14.090823] [<8004dcf0>] (kernel_restart) from [<8004df78>] (SyS_reboot+0xb4/0x1c8)
[   14.098483]  r4:01234567 r3:01234567
[   14.102106] [<8004dec4>] (SyS_reboot) from [<800105a0>] (ret_fast_syscall+0x0/0x54)
[   14.109758]  r7:00000058 r6:553d0298 r5:00000000 r4:00000000
