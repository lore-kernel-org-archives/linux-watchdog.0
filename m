Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:53272 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbbAOQjK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 15 Jan 2015 11:39:10 -0500
Received: by mail-we0-f177.google.com with SMTP id q59so15705650wes.8
        for <linux-watchdog@vger.kernel.org>; Thu, 15 Jan 2015 08:39:09 -0800 (PST)
Message-ID: <54B7ED29.9060700@linaro.org>
Date: Thu, 15 Jan 2015 17:39:05 +0100
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
Subject: Re: [PATCH v3 5/8] ARM: at91: move the restart function to the system
 timer driver
References: <1421077023-30954-1-git-send-email-alexandre.belloni@free-electrons.com> <1421077023-30954-6-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1421077023-30954-6-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/12/2015 04:37 PM, Alexandre Belloni wrote:
> Restarting on an at91rm9200 is handled by using the system timer. Mov=
e that
> function to the system timer driver.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.co=
m>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>   arch/arm/mach-at91/at91rm9200.c      | 11 -----------
>   drivers/clocksource/timer-atmel-st.c | 12 ++++++++++++
>   2 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at9=
1rm9200.c
> index b52916947535..4ea889cd6091 100644
> --- a/arch/arm/mach-at91/at91rm9200.c
> +++ b/arch/arm/mach-at91/at91rm9200.c
> @@ -15,7 +15,6 @@
>
>   #include <asm/mach/map.h>
>   #include <asm/system_misc.h>
> -#include <mach/at91_st.h>
>   #include <mach/hardware.h>
>
>   #include "soc.h"
> @@ -30,15 +29,6 @@ static void at91rm9200_idle(void)
>   	at91_pmc_write(AT91_PMC_SCDR, AT91_PMC_PCK);
>   }
>
> -static void at91rm9200_restart(enum reboot_mode reboot_mode, const c=
har *cmd)
> -{
> -	/*
> -	 * Perform a hardware reset with the use of the Watchdog timer.
> -	 */
> -	at91_st_write(AT91_ST_WDMR, AT91_ST_RSTEN | AT91_ST_EXTEN | 1);
> -	at91_st_write(AT91_ST_CR, AT91_ST_WDRST);
> -}
> -
>   /* ----------------------------------------------------------------=
----
>    *  AT91RM9200 processor initialization
>    * ----------------------------------------------------------------=
---- */
> @@ -51,7 +41,6 @@ static void __init at91rm9200_map_io(void)
>   static void __init at91rm9200_initialize(void)
>   {
>   	arm_pm_idle =3D at91rm9200_idle;
> -	arm_pm_restart =3D at91rm9200_restart;
>   }
>
>
> diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksour=
ce/timer-atmel-st.c
> index 51761f8927b7..522583d6cc78 100644
> --- a/drivers/clocksource/timer-atmel-st.c
> +++ b/drivers/clocksource/timer-atmel-st.c
> @@ -29,6 +29,7 @@
>   #include <linux/of_irq.h>
>
>   #include <asm/mach/time.h>
> +#include <asm/system_misc.h>
>
>   #include <mach/at91_st.h>
>   #include <mach/hardware.h>
> @@ -180,6 +181,15 @@ static struct clock_event_device clkevt =3D {
>   	.set_mode	=3D clkevt32k_mode,
>   };
>
> +static void at91rm9200_restart(enum reboot_mode reboot_mode, const c=
har *cmd)
> +{
> +	/*
> +	 * Perform a hardware reset with the use of the Watchdog timer.
> +	 */
> +	at91_st_write(AT91_ST_WDMR, AT91_ST_RSTEN | AT91_ST_EXTEN | 1);
> +	at91_st_write(AT91_ST_CR, AT91_ST_WDRST);
> +}
> +
>   void __iomem *at91_st_base;
>   EXPORT_SYMBOL_GPL(at91_st_base);
>
> @@ -248,4 +258,6 @@ void __init at91rm9200_timer_init(void)
>
>   	/* register clocksource */
>   	clocksource_register_hz(&clk32k, AT91_SLOW_CLOCK);
> +
> +	arm_pm_restart =3D at91rm9200_restart;
>   }

Mmh, I can't clearly explain why but I have a problem with that.

Can you explain why restart code falls in the clockevents driver ?



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
