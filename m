Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51227 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932323AbbLQLEP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 17 Dec 2015 06:04:15 -0500
Subject: Re: [PATCH] watchdog: force to stop the watchdog when unregister
To: roy.qing.li@gmail.com, linux-watchdog@vger.kernel.org,
	wim@iguana.be
References: <1450342642-13429-1-git-send-email-roy.qing.li@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <567296AC.4090607@roeck-us.net>
Date: Thu, 17 Dec 2015 03:04:12 -0800
MIME-Version: 1.0
In-Reply-To: <1450342642-13429-1-git-send-email-roy.qing.li@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/17/2015 12:57 AM, roy.qing.li@gmail.com wrote:
> From: Li RongQing <roy.qing.li@gmail.com>
>
> force to stop the watchdog when unregister, otherwise the watchdog maybe
> be suspended and be run after the module is unloaded, like the below:
>     $modprobe softdog
>     $echo 1 >/dev/watchdog
>     $modprobe -r softdog
>
>     CPU 20 Unable to handle kernel paging request at virtual address
>     Oops[#1]:
>     CPU: 20 PID: 0 Comm: swapper/20 Not tainted 4.1.13-WR8.0.0.0_standard #6
>     ...
>     Modules linked in: [last unloaded: softdog]
>     	....
>     Call Trace:
>     [<ffffffff801e142c>] cascade+0x34/0xb0
>     [<ffffffff801e1964>] run_timer_softirq+0x30c/0x368
>     [<ffffffff80181044>] __do_softirq+0x1ec/0x418
>     [<ffffffff801815d0>] irq_exit+0x90/0x98
>     [<ffffffff8010749c>] plat_irq_dispatch+0xa4/0x140
>     [<ffffffff80152740>] ret_from_irq+0x0/0x4
>     [<ffffffff801529e0>] __r4k_wait+0x20/0x40
>     [<ffffffff801c2278>] cpu_startup_entry+0x2a0/0x368
>     [<ffffffff8015fa64>] start_secondary+0x444/0x4d8
>
> Signed-off-by: Li RongQing <roy.qing.li@gmail.com>

Real problem, wrong solution. We can not unconditionally stop all watchdogs
in the watchdog core when unregistering a watchdog.

Do you get an error message telling you that the watchdog isn't stopped
after the echo command ? There should have been a "watchdog did not stop!"
message on the console. This is per design.

The problem here is that the softdog has static variables which are accessed
if its timer is still running after the driver is unloaded. This is a problem
in the softdog driver, not in the watchdog core.

The softdog driver should refuse to unload while still running. Anything
else would defeat the purpose of MAGICCLOSE and the requirement to write
the magic character before closing the watchdog.

Thanks,
Guenter

> ---
>   drivers/watchdog/watchdog_dev.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 56a649e..2f3139b 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -569,6 +569,8 @@ int watchdog_dev_register(struct watchdog_device *wdd)
>
>   int watchdog_dev_unregister(struct watchdog_device *wdd)
>   {
> +	watchdog_stop(wdd);
> +
>   	mutex_lock(&wdd->lock);
>   	set_bit(WDOG_UNREGISTERED, &wdd->status);
>   	mutex_unlock(&wdd->lock);
>

