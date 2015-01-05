Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:32522 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268AbbAEOac (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 5 Jan 2015 09:30:32 -0500
Message-ID: <54AAA013.3020901@atmel.com>
Date: Mon, 5 Jan 2015 15:30:43 +0100
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Boris Brezillon <boris.brezillon@free-electrons.com>,
	"Jean-Christophe Plagniol-Villard" <plagnioj@jcrosoft.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Samuel Ortiz" <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>,
	"Wim Van Sebroeck" <wim@iguana.be>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 7/8] clocksource: atmel-st: use syscon/regmap
References: <1420459605-24561-1-git-send-email-alexandre.belloni@free-electrons.com> <1420459605-24561-8-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1420459605-24561-8-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Le 05/01/2015 13:06, Alexandre Belloni a =E9crit :
> The register range from the system timer is also used by the watchdog d=
river.
> Use a regmap to handle concurrent accesses.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/clocksource/timer-atmel-st.c | 103 +++++++++++++--------------=
--------
>  1 file changed, 39 insertions(+), 64 deletions(-)
>=20
> diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource=
/timer-atmel-st.c
> index ed0267f1c892..0a089b9fc3d2 100644
> --- a/drivers/clocksource/timer-atmel-st.c
> +++ b/drivers/clocksource/timer-atmel-st.c
> @@ -24,20 +24,20 @@
>  #include <linux/irq.h>
>  #include <linux/clockchips.h>
>  #include <linux/export.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> +#include <linux/mfd/atmel-st.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/of_irq.h>
> +#include <linux/regmap.h>
> =20
>  #include <asm/mach/time.h>
>  #include <asm/system_misc.h>
> =20
> -#include <mach/at91_st.h>
> -#include <mach/hardware.h>
> -
>  static unsigned long last_crtr;
>  static u32 irqmask;
>  static struct clock_event_device clkevt;
> +static struct regmap *regmap_st;
> =20
> +#define AT91_SLOW_CLOCK		32768 /* DT compatibility */
>  #define RM9200_TIMER_LATCH	((AT91_SLOW_CLOCK + HZ/2) / HZ)
> =20
>  /*
> @@ -47,11 +47,11 @@ static struct clock_event_device clkevt;
>   */
>  static inline unsigned long read_CRTR(void)
>  {
> -	unsigned long x1, x2;
> +	unsigned int x1, x2;
> =20
> -	x1 =3D at91_st_read(AT91_ST_CRTR);
> +	regmap_read(regmap_st, AT91_ST_CRTR, &x1);
>  	do {
> -		x2 =3D at91_st_read(AT91_ST_CRTR);
> +		regmap_read(regmap_st, AT91_ST_CRTR, &x2);
>  		if (x1 =3D=3D x2)
>  			break;
>  		x1 =3D x2;
> @@ -64,7 +64,10 @@ static inline unsigned long read_CRTR(void)
>   */
>  static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
>  {
> -	u32	sr =3D at91_st_read(AT91_ST_SR) & irqmask;
> +	u32 sr;
> +
> +	regmap_read(regmap_st, AT91_ST_SR, &sr);
> +	sr &=3D irqmask;
> =20
>  	/*
>  	 * irqs should be disabled here, but as the irq is shared they are on=
ly
> @@ -97,7 +100,7 @@ static struct irqaction at91rm9200_timer_irq =3D {
>  	.name		=3D "at91_tick",
>  	.flags		=3D IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
>  	.handler	=3D at91rm9200_timer_interrupt,
> -	.irq		=3D NR_IRQS_LEGACY + AT91_ID_SYS,
> +	.irq		=3D 0,
>  };
> =20
>  static cycle_t read_clk32k(struct clocksource *cs)
> @@ -116,23 +119,25 @@ static struct clocksource clk32k =3D {
>  static void
>  clkevt32k_mode(enum clock_event_mode mode, struct clock_event_device *=
dev)
>  {
> +	unsigned int val;
> +
>  	/* Disable and flush pending timer interrupts */
> -	at91_st_write(AT91_ST_IDR, AT91_ST_PITS | AT91_ST_ALMS);
> -	at91_st_read(AT91_ST_SR);
> +	regmap_write(regmap_st, AT91_ST_IDR, AT91_ST_PITS | AT91_ST_ALMS);
> +	regmap_read(regmap_st, AT91_ST_SR, &val);
> =20
>  	last_crtr =3D read_CRTR();
>  	switch (mode) {
>  	case CLOCK_EVT_MODE_PERIODIC:
>  		/* PIT for periodic irqs; fixed rate of 1/HZ */
>  		irqmask =3D AT91_ST_PITS;
> -		at91_st_write(AT91_ST_PIMR, RM9200_TIMER_LATCH);
> +		regmap_write(regmap_st, AT91_ST_PIMR, RM9200_TIMER_LATCH);
>  		break;
>  	case CLOCK_EVT_MODE_ONESHOT:
>  		/* ALM for oneshot irqs, set by next_event()
>  		 * before 32 seconds have passed
>  		 */
>  		irqmask =3D AT91_ST_ALMS;
> -		at91_st_write(AT91_ST_RTAR, last_crtr);
> +		regmap_write(regmap_st, AT91_ST_RTAR, last_crtr);
>  		break;
>  	case CLOCK_EVT_MODE_SHUTDOWN:
>  	case CLOCK_EVT_MODE_UNUSED:
> @@ -140,7 +145,7 @@ clkevt32k_mode(enum clock_event_mode mode, struct c=
lock_event_device *dev)
>  		irqmask =3D 0;
>  		break;
>  	}
> -	at91_st_write(AT91_ST_IER, irqmask);
> +	regmap_write(regmap_st, AT91_ST_IER, irqmask);
>  }
> =20
>  static int
> @@ -148,6 +153,7 @@ clkevt32k_next_event(unsigned long delta, struct cl=
ock_event_device *dev)
>  {
>  	u32		alm;
>  	int		status =3D 0;
> +	unsigned int	val;
> =20
>  	BUG_ON(delta < 2);
> =20
> @@ -163,12 +169,12 @@ clkevt32k_next_event(unsigned long delta, struct =
clock_event_device *dev)
>  	alm =3D read_CRTR();
> =20
>  	/* Cancel any pending alarm; flush any pending IRQ */
> -	at91_st_write(AT91_ST_RTAR, alm);
> -	at91_st_read(AT91_ST_SR);
> +	regmap_write(regmap_st, AT91_ST_RTAR, alm);
> +	regmap_read(regmap_st, AT91_ST_SR, &val);
> =20
>  	/* Schedule alarm by writing RTAR. */
>  	alm +=3D delta;
> -	at91_st_write(AT91_ST_RTAR, alm);
> +	regmap_write(regmap_st, AT91_ST_RTAR, alm);
> =20
>  	return status;
>  }
> @@ -186,47 +192,8 @@ static void at91rm9200_restart(enum reboot_mode re=
boot_mode, const char *cmd)
>  	/*
>  	 * Perform a hardware reset with the use of the Watchdog timer.
>  	 */
> -	at91_st_write(AT91_ST_WDMR, AT91_ST_RSTEN | AT91_ST_EXTEN | 1);
> -	at91_st_write(AT91_ST_CR, AT91_ST_WDRST);
> -}
> -
> -void __iomem *at91_st_base;
> -EXPORT_SYMBOL_GPL(at91_st_base);
> -
> -static struct of_device_id at91rm9200_st_timer_ids[] =3D {
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


Same for this driver: as we remove the DT function call, we may be able
to remove some #includes...


> -err:
> -	return -EINVAL;
> +	regmap_write(regmap_st, AT91_ST_WDMR, AT91_ST_RSTEN | AT91_ST_EXTEN |=
 1);
> +	regmap_write(regmap_st, AT91_ST_CR, AT91_ST_WDRST);
>  }
> =20
>  /*
> @@ -234,13 +201,21 @@ err:
>   */
>  static void __init atmel_st_timer_init(struct device_node *node)
>  {
> -	/* For device tree enabled device: initialize here */
> -	of_at91rm9200_st_init();
> +	unsigned int val;
> +
> +	regmap_st =3D syscon_node_to_regmap(node);
> +	if (IS_ERR(regmap_st))
> +		panic(pr_fmt("Unable to get regmap\n"));
> =20
>  	/* Disable all timer interrupts, and clear any pending ones */
> -	at91_st_write(AT91_ST_IDR,
> +	regmap_write(regmap_st, AT91_ST_IDR,
>  		AT91_ST_PITS | AT91_ST_WDOVF | AT91_ST_RTTINC | AT91_ST_ALMS);
> -	at91_st_read(AT91_ST_SR);
> +	regmap_read(regmap_st, AT91_ST_SR, &val);
> +
> +	/* Get the interrupts property */
> +	at91rm9200_timer_irq.irq  =3D irq_of_parse_and_map(node, 0);
> +	if (!at91rm9200_timer_irq.irq)
> +		panic(pr_fmt("Unable to get IRQ from DT\n"));
> =20
>  	/* Make IRQs happen for the system timer */
>  	setup_irq(at91rm9200_timer_irq.irq, &at91rm9200_timer_irq);
> @@ -249,7 +224,7 @@ static void __init atmel_st_timer_init(struct devic=
e_node *node)
>  	 * directly for the clocksource and all clockevents, after adjusting
>  	 * its prescaler from the 1 Hz default.
>  	 */
> -	at91_st_write(AT91_ST_RTMR, 1);
> +	regmap_write(regmap_st, AT91_ST_RTMR, 1);
> =20
>  	/* Setup timer clockevent, with minimum of two ticks (important!!) */
>  	clkevt.cpumask =3D cpumask_of(0);
>=20


--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
