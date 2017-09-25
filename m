Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:54141 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933486AbdIYKgp (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 25 Sep 2017 06:36:45 -0400
Received: by mail-pg0-f48.google.com with SMTP id j70so3730539pgc.10
        for <linux-watchdog@vger.kernel.org>; Mon, 25 Sep 2017 03:36:45 -0700 (PDT)
Subject: Re: NULL pointer dereference in watchdog_open
To: Oleksij Rempel <ore@pengutronix.de>,
        linux-watchdog@vger.kernel.org, kernel@pengutronix.de
References: <20170925061424.nr4wo4uj6npwsut4@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <2808a46c-85e5-c77d-009f-b6ed6b3bb01e@roeck-us.net>
Date: Mon, 25 Sep 2017 03:36:42 -0700
MIME-Version: 1.0
In-Reply-To: <20170925061424.nr4wo4uj6npwsut4@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/24/2017 11:14 PM, Oleksij Rempel wrote:
> Hi Guenter,
> 
> I noticed a kernel crash on reboot which is only reproducible if
> watchdog is supporting .stop.
> 
> To reproduce: run wathchdog -F /dev/watchdog. Kill this task and then run reboot. As result
> I will get kernel oops:
> [  240.428103] Unable to handle kernel NULL pointer dereference at virtual address 00000059
> [  240.436166] pgd = bf2dc000
> [  240.438909] [00000059] *pgd=00000000
> [  240.442482] Internal error: Oops: 5 [#1] SMP ARM
> [  240.447079] Modules linked in:
> [  240.450127] CPU: 0 PID: 1 Comm: systemd Not tainted 4.13.0-20170921-1-00020-g91488b6-dirty #1
> [  240.458611] Hardware name: Altera SOCFPGA
> [  240.462603] task: bf0e0000 task.stack: bf0da000
> [  240.467122] PC is at watchdog_open+0x58/0xf4
> [  240.471375] LR is at watchdog_open+0x4c/0xf4
> [  240.475626] pc : [<80514c10>]    lr : [<80514c04>]    psr: 60010013
> [  240.481863] sp : bf0dbd40  ip : 00000000  fp : bf0dbd64
> [  240.487064] r10: 80739b28  r9 : bf0c8c90  r8 : be88e030
> [  240.492265] r7 : beb63a80  r6 : 00000082  r5 : 00000005  r4 : bf0c8c00
> [  240.498761] r3 : 00000001  r2 : be7d4a81  r1 : bf0c8c90  r0 : 00000000
> [  240.505260] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [  240.512362] Control: 10c5387d  Table: 3f2dc04a  DAC: 00000051
> [  240.518081] Process systemd (pid: 1, stack limit = 0xbf0da218)
> [  240.523888] Stack: (0xbf0dbd40 to 0xbf0dc000)
> [  240.528230] bd40: 80a42c94 80a36020 00000082 80a3600c beb63a80 be88e030 bf0dbd94 bf0dbd68
> [  240.536373] bd60: 8044962c 80514bc4 80449564 8072c89c 00000000 bf293c40 be88e030 beb63a80
> [  240.544515] bd80: 00000000 00000000 bf0dbdc4 bf0dbd98 802507a0 80449570 beb63a88 00000000
> [  240.552658] bda0: beb63a80 be88e030 beb63a88 802506c4 00020001 bf0dbea8 bf0dbdec bf0dbdc8
> [  240.560800] bdc0: 80248390 802506d0 bf0dbea8 beb63a80 00000000 00000000 00020001 bf0dbea8
> [  240.568943] bde0: bf0dbe14 bf0dbdf0 802495f4 80248184 bf0dbe14 bf0dbe00 80259108 00000000
> [  240.577086] be00: bf0dbf5c 00000000 bf0dbea4 bf0dbe18 8025a304 802495a4 00000073 76e98000
> [  240.585228] be20: 00000064 76e98894 be8f6038 8022a794 bf0dbeac 807bdac4 bf0da000 80119c74
> [  240.593370] be40: bf29b700 00000041 be88e030 beb63a80 00000002 00000000 00000000 00000002
> [  240.601511] be60: be88e030 bf0d1210 bede4dd0 00000000 00000000 00000000 be8f6034 00000004
> [  240.609654] be80: bf0dbea8 bf0dbf5c 00000001 80108184 bf0da000 00000000 bf0dbf4c bf0dbea8
> [  240.617795] bea0: 8025c2b4 80259fb8 bf0d1210 bede4dd0 4e89f222 00000008 be6fc015 80262ff8
> [  240.625937] bec0: 00000000 bec28cc0 be88e030 00000101 00000002 000002a8 00000000 00000000
> [  240.634080] bee0: 00000000 bf0dbee8 ffffff9c 00000004 bf05ae00 be72cb40 00000000 00010000
> [  240.642221] bf00: bf0dbf3c bf0dbf10 8026bdd8 8026b560 000a0001 000a0001 be6fc000 00000000
> [  240.650363] bf20: fffff000 00000000 ffffff9c 00000000 00000004 ffffff9c be6fc000 fffff000
> [  240.658505] bf40: bf0dbf94 bf0dbf50 802499dc 8025c24c 8024d49c 8013eb18 bf0dbf8c 00020001
> [  240.666648] bf60: 80130000 00000002 00000100 00000001 00080001 76f04fac 00519050 00000005
> [  240.674791] bf80: 80108184 bf0da000 bf0dbfa4 bf0dbf98 80249ab4 802498c0 00000000 bf0dbfa8
> [  240.682933] bfa0: 80107fc0 80249a98 00080001 76f04fac 76f04fac 000a0001 00000000 00000000
> [  240.691075] bfc0: 00080001 76f04fac 00519050 00000005 23c345ff 00000000 005182e0 00519254
> [  240.699217] bfe0: 00000005 7ec16b98 76da3ea1 76da5426 80010030 76f04fac 04401288 78284015
> [  240.707370] [<80514c10>] (watchdog_open) from [<8044962c>] (misc_open+0xc8/0x17c)
> [  240.714831] [<8044962c>] (misc_open) from [<802507a0>] (chrdev_open+0xdc/0x19c)
> [  240.722115] [<802507a0>] (chrdev_open) from [<80248390>] (do_dentry_open+0x218/0x320)
> [  240.729914] [<80248390>] (do_dentry_open) from [<802495f4>] (vfs_open+0x5c/0x8c)
> [  240.737283] [<802495f4>] (vfs_open) from [<8025a304>] (path_openat+0x358/0xf34)
> [  240.744566] [<8025a304>] (path_openat) from [<8025c2b4>] (do_filp_open+0x74/0xd8)
> [  240.752020] [<8025c2b4>] (do_filp_open) from [<802499dc>] (do_sys_open+0x128/0x1d8)
> [  240.759645] [<802499dc>] (do_sys_open) from [<80249ab4>] (SyS_open+0x28/0x2c)
> [  240.766756] [<80249ab4>] (SyS_open) from [<80107fc0>] (ret_fast_syscall+0x0/0x3c)
> [  240.774209] Code: eb056b24 e3500000 1a000025 e5945040 (e5953054)
> [  240.780387] ---[ end trace 16f7b1cea0605800 ]---
> [  240.786329] systemd: 18 output lines suppressed due to ratelimiting
> [  240.793253] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [  240.793253]
> [  240.802358] CPU1: stopping
> [  240.805062] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         4.13.0-20170921-1-00020-g91488b6-dirty #1
> [  240.814930] Hardware name: Altera SOCFPGA
> [  240.818942] [<801112ec>] (unwind_backtrace) from [<8010ca00>] (show_stack+0x20/0x24)
> [  240.826660] [<8010ca00>] (show_stack) from [<806709cc>] (dump_stack+0x8c/0xa0)
> [  240.833856] [<806709cc>] (dump_stack) from [<8010f4f4>] (handle_IPI+0x2bc/0x338)
> [  240.841224] [<8010f4f4>] (handle_IPI) from [<80101530>] (gic_handle_irq+0x84/0x88)
> [  240.848764] [<80101530>] (gic_handle_irq) from [<8010d74c>] (__irq_svc+0x6c/0x90)
> [  240.856211] Exception stack(0xbf101f28 to 0xbf101f70)
> [  240.861243] 1f20:                   00000001 00000000 00000000 8011a9a0 bf100000 80a03cb4
> [  240.869386] 1f40: 80a03c68 809727a8 00000000 00000000 bf101f98 bf101f84 bf101f88 bf101f78
> [  240.877526] 1f60: 80108b68 80108b6c 60070013 ffffffff
> [  240.882564] [<8010d74c>] (__irq_svc) from [<80108b6c>] (arch_cpu_idle+0x48/0x4c)
> [  240.889935] [<80108b6c>] (arch_cpu_idle) from [<8068a294>] (default_idle_call+0x30/0x3c)
> [  240.897997] [<8068a294>] (default_idle_call) from [<8015c29c>] (do_idle+0x1b0/0x1dc)
> [  240.905711] [<8015c29c>] (do_idle) from [<8015c574>] (cpu_startup_entry+0x28/0x2c)
> [  240.913253] [<8015c574>] (cpu_startup_entry) from [<8010efc4>] (secondary_start_kernel+0x15c/0x164)
> [  240.922261] [<8010efc4>] (secondary_start_kernel) from [<0010192c>] (0x10192c)
> [  240.929458] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> 
> the code responsible for this oops is:
> watchdog_release()
> ....
> if (!running) {
> 	... this part is only executed if .stop is implemented...
> 	module_put(wd_data->cdev.owner);
> 	... the data is freed but cdev is still existing ...
> 	kref_put(&wd_data->kref, watchdog_core_data_release);
> }
> 
> I don't why it is expected to free the wd data even if cdev is exist, so
> it is probably better to ask the author :)
> 
It isn't; there should be a matching kref_get(). Do you have
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED disabled, buy any chance ?
I think there is now a bug in the code if it is disabled because
in that case the __module_get() and kref_get() are no longer executed.

Guenter
