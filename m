Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:53290 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751177AbaJVOlK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Oct 2014 10:41:10 -0400
Message-ID: <5447C13B.6030608@free-electrons.com>
Date: Wed, 22 Oct 2014 16:37:47 +0200
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
CC: Jason Cooper <jason@lakedaemon.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nadav Haklai <nadavh@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 1/4] clocksource: armada-370-xp: Add missing clock enable
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com> <1413984884-20273-2-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1413984884-20273-2-git-send-email-ezequiel.garcia@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Ezequiel,

On 22/10/2014 15:34, Ezequiel Garcia wrote:
> This commit makes sure the timer clock is prepared and enabled
> before retrieving its rate.

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/clocksource/time-armada-370-xp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
> index 0451e62..d8555f9 100644
> --- a/drivers/clocksource/time-armada-370-xp.c
> +++ b/drivers/clocksource/time-armada-370-xp.c
> @@ -293,6 +293,7 @@ static void __init armada_xp_timer_init(struct device_node *np)
>  
>  	/* The 25Mhz fixed clock is mandatory, and must always be available */
>  	BUG_ON(IS_ERR(clk));
> +	clk_prepare_enable(clk);
>  	timer_clk = clk_get_rate(clk);
>  
>  	armada_370_xp_timer_common_init(np);
> @@ -305,6 +306,7 @@ static void __init armada_370_timer_init(struct device_node *np)
>  	struct clk *clk = of_clk_get(np, 0);
>  
>  	BUG_ON(IS_ERR(clk));
> +	clk_prepare_enable(clk);
>  	timer_clk = clk_get_rate(clk) / TIMER_DIVIDER;
>  	timer25Mhz = false;
>  
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
