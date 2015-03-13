Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:33092 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbbCMKRE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Mar 2015 06:17:04 -0400
Received: by wggz12 with SMTP id z12so22266627wgg.0
        for <linux-watchdog@vger.kernel.org>; Fri, 13 Mar 2015 03:17:03 -0700 (PDT)
Message-ID: <5502B91D.4050002@linaro.org>
Date: Fri, 13 Mar 2015 11:17:01 +0100
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
Subject: Re: [PATCH v5 08/10] clocksource: atmel-st: use syscon/regmap
References: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com> <1426162054-9987-9-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1426162054-9987-9-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/12/2015 01:07 PM, Alexandre Belloni wrote:
> The register range from the system timer is also used by the watchdog=
 driver.
> Use a regmap to handle concurrent accesses.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.co=
m>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/clocksource/timer-atmel-st.c | 94 ++++++++++++++-----------=
-----------
>   1 file changed, 35 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksour=
ce/timer-atmel-st.c
> index 7d062ab32674..674ef2519d6b 100644
> --- a/drivers/clocksource/timer-atmel-st.c
> +++ b/drivers/clocksource/timer-atmel-st.c
> @@ -24,18 +24,19 @@
>   #include <linux/irq.h>
>   #include <linux/clockchips.h>
>   #include <linux/export.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mfd/syscon/atmel-st.h>
>   #include <linux/of_irq.h>
> +#include <linux/regmap.h>
>
>   #include <asm/mach/time.h>
>
> -#include <mach/at91_st.h>
>   #include <mach/hardware.h>
>
>   static unsigned long last_crtr;
>   static u32 irqmask;
>   static struct clock_event_device clkevt;
> +static struct regmap *regmap_st;
>
>   #define RM9200_TIMER_LATCH	((AT91_SLOW_CLOCK + HZ/2) / HZ)
>
> @@ -46,11 +47,11 @@ static struct clock_event_device clkevt;
>    */
>   static inline unsigned long read_CRTR(void)
>   {
> -	unsigned long x1, x2;
> +	unsigned int x1, x2;
>
> -	x1 =3D at91_st_read(AT91_ST_CRTR);
> +	regmap_read(regmap_st, AT91_ST_CRTR, &x1);
>   	do {
> -		x2 =3D at91_st_read(AT91_ST_CRTR);
> +		regmap_read(regmap_st, AT91_ST_CRTR, &x2);
>   		if (x1 =3D=3D x2)
>   			break;
>   		x1 =3D x2;
> @@ -63,7 +64,10 @@ static inline unsigned long read_CRTR(void)
>    */
>   static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id=
)
>   {
> -	u32	sr =3D at91_st_read(AT91_ST_SR) & irqmask;
> +	u32 sr;
> +
> +	regmap_read(regmap_st, AT91_ST_SR, &sr);
> +	sr &=3D irqmask;
>
>   	/*
>   	 * irqs should be disabled here, but as the irq is shared they are=
 only
> @@ -115,23 +119,25 @@ static struct clocksource clk32k =3D {
>   static void
>   clkevt32k_mode(enum clock_event_mode mode, struct clock_event_devic=
e *dev)
>   {
> +	unsigned int val;
> +
>   	/* Disable and flush pending timer interrupts */
> -	at91_st_write(AT91_ST_IDR, AT91_ST_PITS | AT91_ST_ALMS);
> -	at91_st_read(AT91_ST_SR);
> +	regmap_write(regmap_st, AT91_ST_IDR, AT91_ST_PITS | AT91_ST_ALMS);
> +	regmap_read(regmap_st, AT91_ST_SR, &val);
>
>   	last_crtr =3D read_CRTR();
>   	switch (mode) {
>   	case CLOCK_EVT_MODE_PERIODIC:
>   		/* PIT for periodic irqs; fixed rate of 1/HZ */
>   		irqmask =3D AT91_ST_PITS;
> -		at91_st_write(AT91_ST_PIMR, RM9200_TIMER_LATCH);
> +		regmap_write(regmap_st, AT91_ST_PIMR, RM9200_TIMER_LATCH);
>   		break;
>   	case CLOCK_EVT_MODE_ONESHOT:
>   		/* ALM for oneshot irqs, set by next_event()
>   		 * before 32 seconds have passed
>   		 */
>   		irqmask =3D AT91_ST_ALMS;
> -		at91_st_write(AT91_ST_RTAR, last_crtr);
> +		regmap_write(regmap_st, AT91_ST_RTAR, last_crtr);
>   		break;
>   	case CLOCK_EVT_MODE_SHUTDOWN:
>   	case CLOCK_EVT_MODE_UNUSED:
> @@ -139,7 +145,7 @@ clkevt32k_mode(enum clock_event_mode mode, struct=
 clock_event_device *dev)
>   		irqmask =3D 0;
>   		break;
>   	}
> -	at91_st_write(AT91_ST_IER, irqmask);
> +	regmap_write(regmap_st, AT91_ST_IER, irqmask);
>   }
>
>   static int
> @@ -147,6 +153,7 @@ clkevt32k_next_event(unsigned long delta, struct =
clock_event_device *dev)
>   {
>   	u32		alm;
>   	int		status =3D 0;
> +	unsigned int	val;
>
>   	BUG_ON(delta < 2);
>
> @@ -162,12 +169,12 @@ clkevt32k_next_event(unsigned long delta, struc=
t clock_event_device *dev)
>   	alm =3D read_CRTR();
>
>   	/* Cancel any pending alarm; flush any pending IRQ */
> -	at91_st_write(AT91_ST_RTAR, alm);
> -	at91_st_read(AT91_ST_SR);
> +	regmap_write(regmap_st, AT91_ST_RTAR, alm);
> +	regmap_read(regmap_st, AT91_ST_SR, &val);
>
>   	/* Schedule alarm by writing RTAR. */
>   	alm +=3D delta;
> -	at91_st_write(AT91_ST_RTAR, alm);
> +	regmap_write(regmap_st, AT91_ST_RTAR, alm);
>
>   	return status;
>   }
> @@ -180,57 +187,26 @@ static struct clock_event_device clkevt =3D {
>   	.set_mode	=3D clkevt32k_mode,
>   };
>
> -void __iomem *at91_st_base;
> -EXPORT_SYMBOL_GPL(at91_st_base);
> -
> -static const struct of_device_id at91rm9200_st_timer_ids[] =3D {
> -	{ .compatible =3D "atmel,at91rm9200-st" },
> -	{ /* sentinel */ }
> -};
> -
> -static int __init of_at91rm9200_st_init(void)
> -{
> -	struct device_node *np;
> -	int ret;
> -
> -	np =3D of_find_matching_node(NULL, at91rm9200_st_timer_ids);
> -	if (!np)
> -		goto err;
> -
> -	at91_st_base =3D of_iomap(np, 0);
> -	if (!at91_st_base)
> -		goto node_err;
> -
> -	/* Get the interrupts property */
> -	ret =3D irq_of_parse_and_map(np, 0);
> -	if (!ret)
> -		goto ioremap_err;
> -	at91rm9200_timer_irq.irq =3D ret;
> -
> -	of_node_put(np);
> -
> -	return 0;
> -
> -ioremap_err:
> -	iounmap(at91_st_base);
> -node_err:
> -	of_node_put(np);
> -err:
> -	return -EINVAL;
> -}
> -
>   /*
>    * ST (system timer) module supports both clockevents and clocksour=
ce.
>    */
>   static void __init atmel_st_timer_init(struct device_node *node)
>   {
> -	/* For device tree enabled device: initialize here */
> -	of_at91rm9200_st_init();
> +	unsigned int val;
> +
> +	regmap_st =3D syscon_node_to_regmap(node);
> +	if (IS_ERR(regmap_st))
> +		panic(pr_fmt("Unable to get regmap\n"));
>
>   	/* Disable all timer interrupts, and clear any pending ones */
> -	at91_st_write(AT91_ST_IDR,
> +	regmap_write(regmap_st, AT91_ST_IDR,
>   		AT91_ST_PITS | AT91_ST_WDOVF | AT91_ST_RTTINC | AT91_ST_ALMS);
> -	at91_st_read(AT91_ST_SR);
> +	regmap_read(regmap_st, AT91_ST_SR, &val);
> +
> +	/* Get the interrupts property */
> +	at91rm9200_timer_irq.irq  =3D irq_of_parse_and_map(node, 0);
> +	if (!at91rm9200_timer_irq.irq)
> +		panic(pr_fmt("Unable to get IRQ from DT\n"));
>
>   	/* Make IRQs happen for the system timer */
>   	setup_irq(at91rm9200_timer_irq.irq, &at91rm9200_timer_irq);
> @@ -239,7 +215,7 @@ static void __init atmel_st_timer_init(struct dev=
ice_node *node)
>   	 * directly for the clocksource and all clockevents, after adjusti=
ng
>   	 * its prescaler from the 1 Hz default.
>   	 */
> -	at91_st_write(AT91_ST_RTMR, 1);
> +	regmap_write(regmap_st, AT91_ST_RTMR, 1);
>
>   	/* Setup timer clockevent, with minimum of two ticks (important!!)=
 */
>   	clkevt.cpumask =3D cpumask_of(0);
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
