Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:32940 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932177AbbKXWhs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Nov 2015 17:37:48 -0500
Message-ID: <5654E67A.9060800@gmail.com>
Date: Tue, 24 Nov 2015 14:36:42 -0800
From: Florian Fainelli <f.fainelli@gmail.com>
MIME-Version: 1.0
To: Simon Arlott <simon@fire.lp0.eu>,
	MIPS Mailing List <linux-mips@linux-mips.org>
CC: Jonas Gorski <jogo@openwrt.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Miguel Gaio <miguel.gaio@efixo.com>,
	Maxime Bizon <mbizon@freebox.fr>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH (v3) 2/10] MIPS: bmips: Add bcm6345-l2-timer interrupt
 controller
References: <5650BFD6.5030700@simon.arlott.org.uk>    <CAOiHx=k0Aa+qrBT1J7_cQaQRxndBmwsgSgi3x0eJOYTAy6Zq7Q@mail.gmail.com>    <5653612A.4050309@simon.arlott.org.uk>    <565361AF.20400@simon.arlott.org.uk> <70d031ae4c3aa29888d77b64686c39e7e7eaae92@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
In-Reply-To: <70d031ae4c3aa29888d77b64686c39e7e7eaae92@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 24/11/15 14:10, Simon Arlott wrote:
> Add the BCM6345/BCM6318 timer as an interrupt controller so that it can be
> used by the watchdog to warn that its timer will expire soon.
> 
> Support for clocksource/clockevents is not implemented as the timer
> interrupt is not per CPU (except on the BCM6318) and the MIPS clock is
> better. This could be added later if required without changing the device
> tree binding.
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> ---
> Fixed the offset of the count registers, they were writing off by one which
> caused it to set the watchdog timeout to 0.
> 
>  drivers/irqchip/Kconfig                |   5 +
>  drivers/irqchip/Makefile               |   1 +
>  drivers/irqchip/irq-bcm6345-l2-timer.c | 324 +++++++++++++++++++++++++++++++++
>  3 files changed, 330 insertions(+)
>  create mode 100644 drivers/irqchip/irq-bcm6345-l2-timer.c
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index d307bb3..21c3d9b 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -70,6 +70,11 @@ config BCM6345_L1_IRQ
>  	select GENERIC_IRQ_CHIP
>  	select IRQ_DOMAIN
> 
> +config BCM6345_L2_TIMER_IRQ
> +	bool
> +	select GENERIC_IRQ_CHIP
> +	select IRQ_DOMAIN
> +
>  config BCM7038_L1_IRQ
>  	bool
>  	select GENERIC_IRQ_CHIP
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index ded59cf..2687dea 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_XTENSA_MX)			+= irq-xtensa-mx.o
>  obj-$(CONFIG_IRQ_CROSSBAR)		+= irq-crossbar.o
>  obj-$(CONFIG_SOC_VF610)			+= irq-vf610-mscm-ir.o
>  obj-$(CONFIG_BCM6345_L1_IRQ)		+= irq-bcm6345-l1.o
> +obj-$(CONFIG_BCM6345_L2_TIMER_IRQ)	+= irq-bcm6345-l2-timer.o
>  obj-$(CONFIG_BCM7038_L1_IRQ)		+= irq-bcm7038-l1.o
>  obj-$(CONFIG_BCM7120_L2_IRQ)		+= irq-bcm7120-l2.o
>  obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o
> diff --git a/drivers/irqchip/irq-bcm6345-l2-timer.c b/drivers/irqchip/irq-bcm6345-l2-timer.c
> new file mode 100644
> index 0000000..4e6f71b
> --- /dev/null
> +++ b/drivers/irqchip/irq-bcm6345-l2-timer.c
> @@ -0,0 +1,324 @@
> +/*
> + * Copyright 2015 Simon Arlott
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * Based on arch/mips/bcm63xx/timer.c:
> + * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
> + *
> + * Registers for SoCs with 4 timers: BCM6345, BCM6328, BCM6362, BCM6816,
> + *                                   BCM68220,BCM63168, BCM63268
> + *   0x02: IRQ enable (u8)
> + *   0x03: IRQ status (u8)
> + *   0x04: Timer 0 control
> + *   0x08: Timer 1 control
> + *   0x0c: Timer 2 control
> + *   0x10: Timer 0 count
> + *   0x14: Timer 1 count
> + *   0x18: Timer 2 count
> + *   0x1c+: Watchdog registers
> + *
> + * Registers for SoCs with 5 timers: BCM6318
> + *   0x00: IRQ enable (u32)
> + *   0x04: IRQ status (u32)
> + *   0x08: Timer 0 control
> + *   0x0c: Timer 1 control
> + *   0x10: Timer 2 control
> + *   0x14: Timer 3 control
> + *   0x18: Timer 0 count
> + *   0x1c: Timer 1 count
> + *   0x20: Timer 2 count
> + *   0x24: Timer 3 count
> + *   0x28+: Watchdog registers
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/bitops.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqreturn.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/string.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
> +
> +#define REG_6345_IRQ_ENABLE		0x02
> +#define REG_6345_IRQ_STATUS		0x03
> +#define REG_6345_CONTROL_BASE		0x04
> +#define REG_6345_COUNT_BASE		0x10
> +
> +#define REG_6318_IRQ_ENABLE		0x00
> +#define REG_6318_IRQ_STATUS		0x04
> +#define REG_6318_CONTROL_BASE		0x08
> +#define REG_6318_COUNT_BASE		0x18
> +
> +#define NR_TIMERS_6345			4
> +#define WDT_TIMER_ID_6345		(NR_TIMERS_6345 - 1)
> +
> +#define NR_TIMERS_6318			5
> +#define WDT_TIMER_ID_6318		(NR_TIMERS_6318 - 1)
> +
> +/* Per-timer count register */
> +#define COUNT_MASK			(0x3fffffff)
> +
> +/* Per-timer control register */
> +#define CONTROL_COUNTDOWN_MASK		(0x3fffffff)
> +#define CONTROL_RSTCNTCLR_MASK		(1 << 30)
> +#define CONTROL_ENABLE_MASK		(1 << 31)
> +
> +enum bcm6345_timer_type {
> +	TIMER_TYPE_6345,
> +	TIMER_TYPE_6318,
> +};
> +
> +struct bcm6345_timer {
> +	raw_spinlock_t lock;
> +	void __iomem *base;
> +	unsigned int irq;
> +	struct irq_domain *domain;
> +
> +	enum bcm6345_timer_type type;
> +	unsigned int nr_timers;
> +	/* The watchdog timer has separate control/remaining registers
> +	 * and cannot be masked.
> +	 */
> +	int wdt_timer_id;
> +};
> +
> +static inline u32 bcm6345_timer_read_int_status(struct bcm6345_timer *timer)
> +{
> +	if (timer->type == TIMER_TYPE_6318)
> +		return __raw_readl(timer->base + REG_6318_IRQ_STATUS);
> +	else
> +		return __raw_readb(timer->base + REG_6345_IRQ_STATUS);

This is really error prone and does not scale to adding a third type of
timer if we ever had to. How about using the same logic and construction
as the following drivers: drivers/spi/spi-bcm63xx.c,
drivers/bus/brcmstb_gisb.c?
-- 
Florian
