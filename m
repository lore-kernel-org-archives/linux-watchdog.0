Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49034 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbcCCEZH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Mar 2016 23:25:07 -0500
Date: Wed, 2 Mar 2016 20:25:05 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 5/6] watchdog: atlas7_wdt: test clock rate to avoid
 division by 0
Message-ID: <20160303042505.GA4578@roeck-us.net>
References: <1456958018-7849-1-git-send-email-wsa@the-dreams.de>
 <1456958018-7849-6-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456958018-7849-6-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 02, 2016 at 11:33:36PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> The clk API may return 0 on clk_get_rate, so we should check the result before
> using it as a divisor.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Should go individually via subsystem tree.
> 
>  drivers/watchdog/atlas7_wdt.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/watchdog/atlas7_wdt.c b/drivers/watchdog/atlas7_wdt.c
> index df6d9242a31958..ed80734befae16 100644
> --- a/drivers/watchdog/atlas7_wdt.c
> +++ b/drivers/watchdog/atlas7_wdt.c
> @@ -154,6 +154,11 @@ static int atlas7_wdt_probe(struct platform_device *pdev)
>  	writel(0, wdt->base + ATLAS7_WDT_CNT_CTRL);
>  
>  	wdt->tick_rate = clk_get_rate(clk);
> +	if (!wdt->tick_rate) {
> +		ret = -EINVAL;
> +		goto err1;
> +	}
> +
>  	wdt->clk = clk;
>  	atlas7_wdd.min_timeout = 1;
>  	atlas7_wdd.max_timeout = UINT_MAX / wdt->tick_rate;
> -- 
> 2.7.0
> 
