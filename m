Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:44635 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbbAOQF6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 15 Jan 2015 11:05:58 -0500
Received: by mail-we0-f173.google.com with SMTP id q58so15570390wes.4
        for <linux-watchdog@vger.kernel.org>; Thu, 15 Jan 2015 08:05:57 -0800 (PST)
Message-ID: <54B7E561.8090008@linaro.org>
Date: Thu, 15 Jan 2015 17:05:53 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 6/8] clocksource: atmel-st: properly initialize driver
References: <1421077023-30954-1-git-send-email-alexandre.belloni@free-electrons.com> <1421077023-30954-7-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1421077023-30954-7-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/12/2015 04:37 PM, Alexandre Belloni wrote:
> Use clocksource_of_init to initialize the system timer instead of rel=
ying on a
> custom function.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.co=
m>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/arm/mach-at91/board-dt-rm9200.c | 7 -------
>   arch/arm/mach-at91/generic.h         | 3 ---
>   drivers/clocksource/timer-atmel-st.c | 4 +++-
>   3 files changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-at91/board-dt-rm9200.c b/arch/arm/mach-at9=
1/board-dt-rm9200.c
> index 76dfe8f9af50..d9a45f49c208 100644
> --- a/arch/arm/mach-at91/board-dt-rm9200.c
> +++ b/arch/arm/mach-at91/board-dt-rm9200.c
> @@ -24,19 +24,12 @@
>
>   #include "generic.h"
>
> -static void __init at91rm9200_dt_timer_init(void)
> -{
> -	of_clk_init(NULL);
> -	at91rm9200_timer_init();
> -}
> -
>   static const char *at91rm9200_dt_board_compat[] __initdata =3D {
>   	"atmel,at91rm9200",
>   	NULL
>   };
>
>   DT_MACHINE_START(at91rm9200_dt, "Atmel AT91RM9200 (Device Tree)")
> -	.init_time      =3D at91rm9200_dt_timer_init,
>   	.map_io		=3D at91_map_io,
>   	.init_early	=3D at91rm9200_dt_initialize,
>   	.dt_compat	=3D at91rm9200_dt_board_compat,
> diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generi=
c.h
> index d53324210adf..fc12f3d4b93c 100644
> --- a/arch/arm/mach-at91/generic.h
> +++ b/arch/arm/mach-at91/generic.h
> @@ -29,9 +29,6 @@ extern void __init at91_dt_initialize(void);
>   extern void __init at91_sysirq_mask_rtc(u32 rtc_base);
>   extern void __init at91_sysirq_mask_rtt(u32 rtt_base);
>
> - /* Timer */
> -extern void at91rm9200_timer_init(void);
> -
>   /* idle */
>   extern void at91sam9_idle(void);
>
> diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksour=
ce/timer-atmel-st.c
> index 522583d6cc78..ed0267f1c892 100644
> --- a/drivers/clocksource/timer-atmel-st.c
> +++ b/drivers/clocksource/timer-atmel-st.c
> @@ -232,7 +232,7 @@ err:
>   /*
>    * ST (system timer) module supports both clockevents and clocksour=
ce.
>    */
> -void __init at91rm9200_timer_init(void)
> +static void __init atmel_st_timer_init(struct device_node *node)
>   {
>   	/* For device tree enabled device: initialize here */
>   	of_at91rm9200_st_init();
> @@ -261,3 +261,5 @@ void __init at91rm9200_timer_init(void)
>
>   	arm_pm_restart =3D at91rm9200_restart;
>   }
> +CLOCKSOURCE_OF_DECLARE(atmel_st_timer, "atmel,at91rm9200-st",
> +		       atmel_st_timer_init);
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
