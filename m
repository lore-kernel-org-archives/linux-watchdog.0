Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52138 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab1ELMrv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 12 May 2011 08:47:51 -0400
Received: by wwa36 with SMTP id 36so1720748wwa.1
        for <linux-watchdog@vger.kernel.org>; Thu, 12 May 2011 05:47:50 -0700 (PDT)
From: Florian Fainelli <florian@openwrt.org>
To: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH] Watchdog: mtx-1: fix abuse of gpio registers
Date: Thu, 12 May 2011 14:52:17 +0200
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
References: <1304968714-3362-1-git-send-email-manuel.lauss@googlemail.com>
In-Reply-To: <1304968714-3362-1-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201105121452.17517.florian@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Manuel,

On Monday 09 May 2011 21:18:34 Manuel Lauss wrote:
> This patch replaces the drivers racy abuse of the gpio2 direction
> register with calls to the gpio library.
> 
> Cc: Florian Fainelli <florian@openwrt.org>
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>

I will give a try at this patch, it looks good at first glance.

> ---
>  drivers/watchdog/mtx-1_wdt.c |   17 ++++++++++-------
>  1 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
> index 5ec5ac1..011fee4 100644
> --- a/drivers/watchdog/mtx-1_wdt.c
> +++ b/drivers/watchdog/mtx-1_wdt.c
> @@ -66,6 +66,7 @@ static struct {
>  	int default_ticks;
>  	unsigned long inuse;
>  	unsigned gpio;
> +	int gstate;
>  } mtx1_wdt_device;
> 
>  static void mtx1_wdt_trigger(unsigned long unused)
> @@ -75,13 +76,13 @@ static void mtx1_wdt_trigger(unsigned long unused)
>  	spin_lock(&mtx1_wdt_device.lock);
>  	if (mtx1_wdt_device.running)
>  		ticks--;
> -	/*
> -	 * toggle GPIO2_15
> -	 */
> -	tmp = au_readl(GPIO2_DIR);
> -	tmp = (tmp & ~(1 << mtx1_wdt_device.gpio)) |
> -	      ((~tmp) & (1 << mtx1_wdt_device.gpio));
> -	au_writel(tmp, GPIO2_DIR);
> +
> +	/* toggle wdt gpio */
> +	mtx1_wdt_device.gstate = ~mtx1_wdt_device.gstate;
> +	if (mtx1_wdt_device.gstate)
> +		gpio_direction_output(mtx1_wdt_device.gpio, 1);
> +	else
> +		gpio_direction_input(mtx1_wdt_device.gpio);
> 
>  	if (mtx1_wdt_device.queue && ticks)
>  		mod_timer(&mtx1_wdt_device.timer, jiffies + MTX1_WDT_INTERVAL);
> @@ -103,6 +104,7 @@ static void mtx1_wdt_start(void)
>  	spin_lock_irqsave(&mtx1_wdt_device.lock, flags);
>  	if (!mtx1_wdt_device.queue) {
>  		mtx1_wdt_device.queue = 1;
> +		mtx1_wdt_device.gstate = 1;
>  		gpio_set_value(mtx1_wdt_device.gpio, 1);
>  		mod_timer(&mtx1_wdt_device.timer, jiffies + MTX1_WDT_INTERVAL);
>  	}
> @@ -117,6 +119,7 @@ static int mtx1_wdt_stop(void)
>  	spin_lock_irqsave(&mtx1_wdt_device.lock, flags);
>  	if (mtx1_wdt_device.queue) {
>  		mtx1_wdt_device.queue = 0;
> +		mtx1_wdt_device.gstate = 0;
>  		gpio_set_value(mtx1_wdt_device.gpio, 0);
>  	}
>  	ticks = mtx1_wdt_device.default_ticks;
