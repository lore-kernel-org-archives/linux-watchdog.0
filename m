Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34000 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbcDRARJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Apr 2016 20:17:09 -0400
Date: Sun, 17 Apr 2016 17:17:13 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org
Subject: Re: watchdog: deadlock warning with imx2_wdt driver and systemd
Message-ID: <20160418001713.GA3758@roeck-us.net>
References: <20160417154107.GA6762@archie.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160417154107.GA6762@archie.localdomain>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Apr 17, 2016 at 05:41:07PM +0200, Clemens Gruber wrote:
> Hi,
> 
> I have an i.MX6Q board with the current mainline tree from Linus and
> systemd 229, which also acts as watchdog daemon.
> (RuntimeWatchdogSec=60)
> 
> Since commit 11d7aba9ceb7 ("watchdog: imx2: Convert to use
> infrastructure triggered keepalives") I get a kernel lockdep warning
> after systemd launches.
> 
> However, according to the backtrace, this happens in watchdog_dev.c
> (watchdog_release and watchdog_ping_work) which was not even touched
> by said commit.
> 
> It also only occurs during the first boot. (I added some initialization
> tasks there, e.g. generating SSH keys, expanding filesystems, etc.,
> which takes about one minute and must be connected to this somehow,
> because on all subsequent boots without that delay, it does not appear
> anymore)
> 
Looks like the watchdog device is being closed (only) during the first boot.
That should not cause a locking problem, but obviously I must have missed
something.I'll have a look into it.

Thanks a lot for the report!

Guenter

> Log output:
> 
> [    5.426747] ======================================================
> [    5.432941] [ INFO: possible circular locking dependency detected ]
> [    5.439221] 4.6.0-rc3-00191-gfabf418 #162 Not tainted
> [    5.444283] -------------------------------------------------------
> [    5.450552] systemd/1 is trying to acquire lock:
> [    5.455172]  ((&(&wd_data->work)->work)){+.+...}, at: [<80141650>] flush_work+0x0/0x280
> [    5.463271] 
>                but task is already holding lock:
> [    5.469114]  (&wd_data->lock){+.+...}, at: [<804acfa8>] watchdog_release+0x18/0x190
> [    5.476860] 
>                which lock already depends on the new lock.
> 
> [    5.485050] 
>                the existing dependency chain (in reverse order) is:
> [    5.492543] 
>                -> #1 (&wd_data->lock){+.+...}:
> [    5.496967]        [<80662310>] mutex_lock_nested+0x64/0x4a8
> [    5.502666]        [<804aca4c>] watchdog_ping_work+0x18/0x4c
> [    5.508359]        [<80143128>] process_one_work+0x1ac/0x500
> [    5.514044]        [<801434b4>] worker_thread+0x38/0x554
> [    5.519389]        [<80149510>] kthread+0xf4/0x108
> [    5.524217]        [<80107c10>] ret_from_fork+0x14/0x24
> [    5.529482] 
>                -> #0 ((&(&wd_data->work)->work)){+.+...}:
> [    5.534883]        [<8017c4e8>] lock_acquire+0x70/0x90
> [    5.540061]        [<8014169c>] flush_work+0x4c/0x280
> [    5.545144]        [<801440f8>] __cancel_work_timer+0x9c/0x1e0
> [    5.551008]        [<804acfcc>] watchdog_release+0x3c/0x190
> [    5.556612]        [<8022c5e8>] __fput+0x80/0x1c8
> [    5.561354]        [<80147b28>] task_work_run+0x94/0xc8
> [    5.566613]        [<8010b998>] do_work_pending+0x8c/0xb4
> [    5.572049]        [<80107ba8>] slow_work_pending+0xc/0x20
> [    5.577568] 
>                other info that might help us debug this:
> 
> [    5.585585]  Possible unsafe locking scenario:
> 
> [    5.591516]        CPU0                    CPU1
> [    5.596055]        ----                    ----
> [    5.600593]   lock(&wd_data->lock);
> [    5.604130]                                lock((&(&wd_data->work)->work));
> [    5.611137]                                lock(&wd_data->lock);
> [    5.617191]   lock((&(&wd_data->work)->work));
> [    5.621681] 
>                 *** DEADLOCK ***
> 
> [    5.627615] 1 lock held by systemd/1:
> [    5.631286]  #0:  (&wd_data->lock){+.+...}, at: [<804acfa8>] watchdog_release+0x18/0x190
> [    5.639488] 
>                stack backtrace:
> [    5.643861] CPU: 2 PID: 1 Comm: systemd Not tainted 4.6.0-rc3-00191-gfabf418 #162
> [    5.651353] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    5.657909] [<8010f5e4>] (unwind_backtrace) from [<8010c038>] (show_stack+0x10/0x14)
> [    5.665671] [<8010c038>] (show_stack) from [<8039d7fc>] (dump_stack+0xa8/0xd4)
> [    5.672911] [<8039d7fc>] (dump_stack) from [<80177ee0>] (print_circular_bug+0x214/0x334)
> [    5.681012] [<80177ee0>] (print_circular_bug) from [<80179230>] (check_prevs_add+0x4dc/0x8e8)
> [    5.689556] [<80179230>] (check_prevs_add) from [<8017b3d8>] (__lock_acquire+0xc6c/0x14ec)
> [    5.697831] [<8017b3d8>] (__lock_acquire) from [<8017c4e8>] (lock_acquire+0x70/0x90)
> [    5.705584] [<8017c4e8>] (lock_acquire) from [<8014169c>] (flush_work+0x4c/0x280)
> [    5.713076] [<8014169c>] (flush_work) from [<801440f8>] (__cancel_work_timer+0x9c/0x1e0)
> [    5.721183] [<801440f8>] (__cancel_work_timer) from [<804acfcc>] (watchdog_release+0x3c/0x190)
> [    5.729815] [<804acfcc>] (watchdog_release) from [<8022c5e8>] (__fput+0x80/0x1c8)
> [    5.737316] [<8022c5e8>] (__fput) from [<80147b28>] (task_work_run+0x94/0xc8)
> [    5.744465] [<80147b28>] (task_work_run) from [<8010b998>] (do_work_pending+0x8c/0xb4)
> [    5.752401] [<8010b998>] (do_work_pending) from [<80107ba8>] (slow_work_pending+0xc/0x20)
> 
> If you can't reproduce it but have an idea how to fix this, I would be
> happy to test your idea or patch.
> 
> Thanks,
> Clemens
