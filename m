Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54350 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715AbbGFUYh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 6 Jul 2015 16:24:37 -0400
Message-ID: <559AE3FE.7090202@roeck-us.net>
Date: Mon, 06 Jul 2015 13:24:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Francesco Lavra <francescolavra.fl@gmail.com>, wim@iguana.be,
	maxime.ripard@free-electrons.com, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: sunxi: fix activation of system reset
References: <559AC20B.4090601@gmail.com>
In-Reply-To: <559AC20B.4090601@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/06/2015 10:59 AM, Francesco Lavra wrote:
> Commit f2147de3 ("watchdog: sunxi: support parameterized compatible
> strings") introduced a regression in sunxi_wdt_start(), by which
> the system reset function of the watchdog is not enabled upon
> starting the watchdog. Fix it.
>
> Signed-off-by: Francesco Lavra <francescolavra.fl@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/sunxi_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
> index a29afb3..47bd8a1 100644
> --- a/drivers/watchdog/sunxi_wdt.c
> +++ b/drivers/watchdog/sunxi_wdt.c
> @@ -184,7 +184,7 @@ static int sunxi_wdt_start(struct watchdog_device *wdt_dev)
>   	/* Set system reset function */
>   	reg = readl(wdt_base + regs->wdt_cfg);
>   	reg &= ~(regs->wdt_reset_mask);
> -	reg |= ~(regs->wdt_reset_val);
> +	reg |= regs->wdt_reset_val;
>   	writel(reg, wdt_base + regs->wdt_cfg);
>
>   	/* Enable watchdog */
>

