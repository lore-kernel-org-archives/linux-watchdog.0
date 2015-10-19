Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53589 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320AbbJSD7N (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 18 Oct 2015 23:59:13 -0400
Subject: Re: [PATCH] watchdog: pnx4008: fix warnings caused by enabling
 unprepared clock
To: Vladimir Zapolskiy <vz@mleia.com>, Wim Van Sebroeck <wim@iguana.be>
References: <1445106496-2074-1-git-send-email-vz@mleia.com>
Cc: linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56246A8E.7040104@roeck-us.net>
Date: Sun, 18 Oct 2015 20:59:10 -0700
MIME-Version: 1.0
In-Reply-To: <1445106496-2074-1-git-send-email-vz@mleia.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/17/2015 11:28 AM, Vladimir Zapolskiy wrote:
> If common clock framework is configured, the driver generates a warning,
> which is fixed by this change:
>
>      WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:727 clk_core_enable+0x2c/0xa4()
>      Modules linked in:
>      CPU: 0 PID: 1 Comm: swapper Tainted: G        W       4.3.0-rc2+ #171
>      Hardware name: LPC32XX SoC (Flattened Device Tree)
>      Backtrace:
>      [<>] (dump_backtrace) from [<>] (show_stack+0x18/0x1c)
>      [<>] (show_stack) from [<>] (dump_stack+0x20/0x28)
>      [<>] (dump_stack) from [<>] (warn_slowpath_common+0x90/0xb8)
>      [<>] (warn_slowpath_common) from [<>] (warn_slowpath_null+0x24/0x2c)
>      [<>] (warn_slowpath_null) from [<>] (clk_core_enable+0x2c/0xa4)
>      [<>] (clk_core_enable) from [<>] (clk_enable+0x24/0x38)
>      [<>] (clk_enable) from [<>] (pnx4008_wdt_probe+0x78/0x11c)
>      [<>] (pnx4008_wdt_probe) from [<>] (platform_drv_probe+0x50/0xa0)
>      [<>] (platform_drv_probe) from [<>] (driver_probe_device+0x18c/0x408)
>      [<>] (driver_probe_device) from [<>] (__driver_attach+0x70/0x94)
>      [<>] (__driver_attach) from [<>] (bus_for_each_dev+0x74/0x98)
>      [<>] (bus_for_each_dev) from [<>] (driver_attach+0x20/0x28)
>      [<>] (driver_attach) from [<>] (bus_add_driver+0x11c/0x248)
>      [<>] (bus_add_driver) from [<>] (driver_register+0xa4/0xe8)
>      [<>] (driver_register) from [<>] (__platform_driver_register+0x50/0x64)
>      [<>] (__platform_driver_register) from [<>] (platform_wdt_driver_init+0x18/0x20)
>      [<>] (platform_wdt_driver_init) from [<>] (do_one_initcall+0x11c/0x1dc)
>      [<>] (do_one_initcall) from [<>] (kernel_init_freeable+0x10c/0x1d4)
>      [<>] (kernel_init_freeable) from [<>] (kernel_init+0x10/0xec)
>      [<>] (kernel_init) from [<>] (ret_from_fork+0x14/0x24)
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

