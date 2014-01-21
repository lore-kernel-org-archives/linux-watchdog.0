Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:40735 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366AbaAUJ5j (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 04:57:39 -0500
Received: by mail-wg0-f46.google.com with SMTP id x12so7670191wgg.13
        for <linux-watchdog@vger.kernel.org>; Tue, 21 Jan 2014 01:57:37 -0800 (PST)
Message-ID: <52DE4491.2000505@linaro.org>
Date: Tue, 21 Jan 2014 10:57:37 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
CC: Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 02/15] clocksource: orion: Use atomic access for shared
 registers
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com> <1390295561-3466-3-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1390295561-3466-3-git-send-email-ezequiel.garcia@free-electrons.com>
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/21/2014 10:12 AM, Ezequiel Garcia wrote:
> Replace the driver-specific thread-safe shared register API
> by the recently introduced atomic_io_clear_set().
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Hi Ezequiel,

in the future, put me in Cc when modifying files in clocksource that=20
will make my life easier to track the changes.

Thanks.
   -- Daniel

> ---
>   drivers/clocksource/time-orion.c | 28 ++++++++++------------------
>   1 file changed, 10 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/clocksource/time-orion.c b/drivers/clocksource/t=
ime-orion.c
> index 9c7f018..3f14e56 100644
> --- a/drivers/clocksource/time-orion.c
> +++ b/drivers/clocksource/time-orion.c
> @@ -35,20 +35,6 @@
>   #define ORION_ONESHOT_MAX	0xfffffffe
>
>   static void __iomem *timer_base;
> -static DEFINE_SPINLOCK(timer_ctrl_lock);
> -
> -/*
> - * Thread-safe access to TIMER_CTRL register
> - * (shared with watchdog timer)
> - */
> -void orion_timer_ctrl_clrset(u32 clr, u32 set)
> -{
> -	spin_lock(&timer_ctrl_lock);
> -	writel((readl(timer_base + TIMER_CTRL) & ~clr) | set,
> -		timer_base + TIMER_CTRL);
> -	spin_unlock(&timer_ctrl_lock);
> -}
> -EXPORT_SYMBOL(orion_timer_ctrl_clrset);
>   /*
>    * Free-running clocksource handling.
> @@ -68,7 +54,8 @@ static int orion_clkevt_next_event(unsigned long de=
lta,
>   {
>   	/* setup and enable one-shot timer */
>   	writel(delta, timer_base + TIMER1_VAL);
> -	orion_timer_ctrl_clrset(TIMER1_RELOAD_EN, TIMER1_EN);
> +	atomic_io_modify(timer_base + TIMER_CTRL,
> +		TIMER1_RELOAD_EN | TIMER1_EN, TIMER1_EN);

I am not convinced this change is worth.

Could you elaborate the race the spinlock should prevent ?

>
>   	return 0;
>   }
> @@ -80,10 +67,13 @@ static void orion_clkevt_mode(enum clock_event_mo=
de mode,
>   		/* setup and enable periodic timer at 1/HZ intervals */
>   		writel(ticks_per_jiffy - 1, timer_base + TIMER1_RELOAD);
>   		writel(ticks_per_jiffy - 1, timer_base + TIMER1_VAL);
> -		orion_timer_ctrl_clrset(0, TIMER1_RELOAD_EN | TIMER1_EN);
> +		atomic_io_modify(timer_base + TIMER_CTRL,
> +			TIMER1_RELOAD_EN | TIMER1_EN,
> +			TIMER1_RELOAD_EN | TIMER1_EN);
>   	} else {
>   		/* disable timer */
> -		orion_timer_ctrl_clrset(TIMER1_RELOAD_EN | TIMER1_EN, 0);
> +		atomic_io_modify(timer_base + TIMER_CTRL,
> +			TIMER1_RELOAD_EN | TIMER1_EN, 0);
>   	}
>   }
>
> @@ -131,7 +121,9 @@ static void __init orion_timer_init(struct device=
_node *np)
>   	/* setup timer0 as free-running clocksource */
>   	writel(~0, timer_base + TIMER0_VAL);
>   	writel(~0, timer_base + TIMER0_RELOAD);
> -	orion_timer_ctrl_clrset(0, TIMER0_RELOAD_EN | TIMER0_EN);
> +	atomic_io_modify(timer_base + TIMER_CTRL,
> +		TIMER0_RELOAD_EN | TIMER0_EN,
> +		TIMER0_RELOAD_EN | TIMER0_EN);
>   	clocksource_mmio_init(timer_base + TIMER0_VAL, "orion_clocksource"=
,
>   			      clk_get_rate(clk), 300, 32,
>   			      clocksource_mmio_readl_down);
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
