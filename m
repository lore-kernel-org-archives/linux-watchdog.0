Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:34433 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932410AbbCFIif (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Mar 2015 03:38:35 -0500
Received: by wesx3 with SMTP id x3so4605070wes.1
        for <linux-watchdog@vger.kernel.org>; Fri, 06 Mar 2015 00:38:34 -0800 (PST)
Message-ID: <54F96788.3010404@linaro.org>
Date: Fri, 06 Mar 2015 09:38:32 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lee Jones <lee.jones@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Reichel <sre@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 7/9] clocksource: atmel-st: properly initialize driver
References: <1425570594-13124-1-git-send-email-alexandre.belloni@free-electrons.com> <1425570594-13124-8-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1425570594-13124-8-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/05/2015 04:49 PM, Alexandre Belloni wrote:
> Use clocksource_of_init to initialize the system timer instead of rel=
ying on a
> custom function.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.co=
m>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

This patch should be before 6/9 but anyway ...

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/arm/mach-at91/at91rm9200.c      | 7 -------
>   arch/arm/mach-at91/generic.h         | 3 ---
>   drivers/clocksource/timer-atmel-st.c | 4 +++-
>   3 files changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at9=
1rm9200.c
> index 2386d08d65e8..5efb075294e5 100644
> --- a/arch/arm/mach-at91/at91rm9200.c
> +++ b/arch/arm/mach-at91/at91rm9200.c
> @@ -26,12 +26,6 @@
>
>   #include "generic.h"
>
> -static void __init at91rm9200_dt_timer_init(void)
> -{
> -	of_clk_init(NULL);
> -	at91rm9200_timer_init();
> -}
> -
>   static void __init at91rm9200_dt_device_init(void)
>   {
>   	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL)=
;
> @@ -48,7 +42,6 @@ static const char *at91rm9200_dt_board_compat[] __i=
nitconst =3D {
>   };
>
>   DT_MACHINE_START(at91rm9200_dt, "Atmel AT91RM9200")
> -	.init_time      =3D at91rm9200_dt_timer_init,
>   	.map_io		=3D at91_map_io,
>   	.init_machine	=3D at91rm9200_dt_device_init,
>   	.dt_compat	=3D at91rm9200_dt_board_compat,
> diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generi=
c.h
> index 583369ffc284..6c953bff13d6 100644
> --- a/arch/arm/mach-at91/generic.h
> +++ b/arch/arm/mach-at91/generic.h
> @@ -18,9 +18,6 @@
>   extern void __init at91_map_io(void);
>   extern void __init at91_alt_map_io(void);
>
> - /* Timer */
> -extern void at91rm9200_timer_init(void);
> -
>   /* idle */
>   extern void at91rm9200_idle(void);
>   extern void at91sam9_idle(void);
> diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksour=
ce/timer-atmel-st.c
> index b00d09555f2b..7d062ab32674 100644
> --- a/drivers/clocksource/timer-atmel-st.c
> +++ b/drivers/clocksource/timer-atmel-st.c
> @@ -222,7 +222,7 @@ err:
>   /*
>    * ST (system timer) module supports both clockevents and clocksour=
ce.
>    */
> -void __init at91rm9200_timer_init(void)
> +static void __init atmel_st_timer_init(struct device_node *node)
>   {
>   	/* For device tree enabled device: initialize here */
>   	of_at91rm9200_st_init();
> @@ -249,3 +249,5 @@ void __init at91rm9200_timer_init(void)
>   	/* register clocksource */
>   	clocksource_register_hz(&clk32k, AT91_SLOW_CLOCK);
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
