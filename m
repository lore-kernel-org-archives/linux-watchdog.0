Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:43281 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbbCMKVj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Mar 2015 06:21:39 -0400
Received: by widem10 with SMTP id em10so4694169wid.2
        for <linux-watchdog@vger.kernel.org>; Fri, 13 Mar 2015 03:21:38 -0700 (PDT)
Message-ID: <5502BA2F.4040600@linaro.org>
Date: Fri, 13 Mar 2015 11:21:35 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v5 09/10] clocksource: atmel-st: remove mach/hardware
 dependency
References: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com> <1426162054-9987-10-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1426162054-9987-10-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/12/2015 01:07 PM, Alexandre Belloni wrote:
> Remove the mach/hardware dependency to prepare the driver for multipl=
atform
> support.
> Also switch from setup_irq() to request_irq()
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.co=
m>
> ---
>   drivers/clocksource/timer-atmel-st.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksour=
ce/timer-atmel-st.c
> index 674ef2519d6b..91d6cbb7a56b 100644
> --- a/drivers/clocksource/timer-atmel-st.c
> +++ b/drivers/clocksource/timer-atmel-st.c
> @@ -31,13 +31,12 @@
>
>   #include <asm/mach/time.h>

Couldn't the header above be removed ?

Other than that:

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> -#include <mach/hardware.h>
> -
>   static unsigned long last_crtr;
>   static u32 irqmask;
>   static struct clock_event_device clkevt;
>   static struct regmap *regmap_st;
>
> +#define AT91_SLOW_CLOCK		32768
>   #define RM9200_TIMER_LATCH	((AT91_SLOW_CLOCK + HZ/2) / HZ)
>
>   /*
> @@ -96,13 +95,6 @@ static irqreturn_t at91rm9200_timer_interrupt(int =
irq, void *dev_id)
>   	return IRQ_NONE;
>   }
>
> -static struct irqaction at91rm9200_timer_irq =3D {
> -	.name		=3D "at91_tick",
> -	.flags		=3D IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
> -	.handler	=3D at91rm9200_timer_interrupt,
> -	.irq		=3D NR_IRQS_LEGACY + AT91_ID_SYS,
> -};
> -
>   static cycle_t read_clk32k(struct clocksource *cs)
>   {
>   	return read_CRTR();
> @@ -193,6 +185,7 @@ static struct clock_event_device clkevt =3D {
>   static void __init atmel_st_timer_init(struct device_node *node)
>   {
>   	unsigned int val;
> +	int irq, ret;
>
>   	regmap_st =3D syscon_node_to_regmap(node);
>   	if (IS_ERR(regmap_st))
> @@ -204,12 +197,16 @@ static void __init atmel_st_timer_init(struct d=
evice_node *node)
>   	regmap_read(regmap_st, AT91_ST_SR, &val);
>
>   	/* Get the interrupts property */
> -	at91rm9200_timer_irq.irq  =3D irq_of_parse_and_map(node, 0);
> -	if (!at91rm9200_timer_irq.irq)
> +	irq  =3D irq_of_parse_and_map(node, 0);
> +	if (!irq)
>   		panic(pr_fmt("Unable to get IRQ from DT\n"));
>
>   	/* Make IRQs happen for the system timer */
> -	setup_irq(at91rm9200_timer_irq.irq, &at91rm9200_timer_irq);
> +	ret =3D request_irq(irq, at91rm9200_timer_interrupt,
> +			  IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
> +			  "at91_tick", regmap_st);
> +	if (ret)
> +		panic(pr_fmt("Unable to setup IRQ\n"));
>
>   	/* The 32KiHz "Slow Clock" (tick every 30517.58 nanoseconds) is us=
ed
>   	 * directly for the clocksource and all clockevents, after adjusti=
ng
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
