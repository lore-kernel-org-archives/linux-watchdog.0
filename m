Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34095 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755583AbaITDIY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 19 Sep 2014 23:08:24 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XVB28-003vZ8-3K
	for linux-watchdog@vger.kernel.org; Sat, 20 Sep 2014 03:08:24 +0000
Message-ID: <541CEF86.9070606@roeck-us.net>
Date: Fri, 19 Sep 2014 20:07:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jisheng Zhang <jszhang@marvell.com>, wim@iguana.be
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] watchdog: dw_wdt: add restart handler support
References: <1411108199-1280-1-git-send-email-jszhang@marvell.com> <1411108199-1280-3-git-send-email-jszhang@marvell.com>
In-Reply-To: <1411108199-1280-3-git-send-email-jszhang@marvell.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/18/2014 11:29 PM, Jisheng Zhang wrote:
> The kernel core now provides an API to trigger a system restart.
> Register with it to support restarting the system via. watchdog.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>   drivers/watchdog/dw_wdt.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index ad0619d..4ca41e9 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -29,9 +29,11 @@
>   #include <linux/miscdevice.h>
>   #include <linux/module.h>
>   #include <linux/moduleparam.h>
> +#include <linux/notifier.h>
>   #include <linux/of.h>
>   #include <linux/pm.h>
>   #include <linux/platform_device.h>
> +#include <linux/reboot.h>
>   #include <linux/spinlock.h>
>   #include <linux/timer.h>
>   #include <linux/uaccess.h>
> @@ -62,6 +64,7 @@ static struct {
>   	unsigned long		next_heartbeat;
>   	struct timer_list	timer;
>   	int			expect_close;
> +	struct notifier_block	restart_handler;
>   } dw_wdt;
>
>   static inline int dw_wdt_is_enabled(void)
> @@ -119,6 +122,22 @@ static void dw_wdt_keepalive(void)
>   	       WDOG_COUNTER_RESTART_REG_OFFSET);
>   }
>
> +static int dw_wdt_restart_handle(struct notifier_block *this,
> +				unsigned long mode, void *cmd)
> +{
> +	u32 val;
> +
> +	writel(0, dw_wdt.regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
> +	val = readl(dw_wdt.regs + WDOG_CONTROL_REG_OFFSET);
> +	if (val & WDOG_CONTROL_REG_WDT_EN_MASK)
> +		writel(WDOG_COUNTER_RESTART_KICK_VALUE, dw_wdt.regs +
> +			WDOG_COUNTER_RESTART_REG_OFFSET);
> +	else
> +		writel(WDOG_CONTROL_REG_WDT_EN_MASK,
> +		       dw_wdt.regs + WDOG_CONTROL_REG_OFFSET);

Don't you have to write WDOG_COUNTER_RESTART_KICK_VALUE into
WDOG_COUNTER_RESTART_REG_OFFSET in the else case as well ?

Guenter

