Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9754BEE22;
	Mon, 12 Oct 2026 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827261; cv=none; b=El0u2uSMk6bUfhnxzsnv1Cmpirw51stSE5YLvALw8Sn+BbP+o5j72XykPM+9nsyGkptCUoUoByg3CLXH5VhWl42spOlMkuJ45ddefwRvRxlDvisCxqbbF+CR2vqMFprPhfqHJkTFoELpTfzeDazWbgsDIs6zh817VwGl4iklIYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827261; c=relaxed/simple;
	bh=HRQ1O6EulqxQt/chiywfvk3Vf8YqlHGIWEKyKBBlgvI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rHBdVWrMKjOkBc7ioJHENMRlRi95HKdr3y4N8cKw1ns3DQTy/huMR/lDx6OrOG+gSE+lQ3ynbbtDI2v4f0FeHyKcEPIFY3RlrQ68b3sl21fQwZfN0s2JSyXaRuz12Vmn8X9/ZQV28M0k7L+NW2vvKKIBUudquIqWsCHnZHT2bm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJzdsUOj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJzdsUOj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B3D1F008A1;
	Mon, 12 Oct 2026 17:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791827259;
	bh=leu95z4p6M+Lzf/VaaXZ68TDFGBxwERu44pPSEaZqbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hJzdsUOjPdTlZys3SWLjCPElUc78QiYKWihNqM2uRWV/3BkR8OuaPDcJbZ4QAeJUX
	 D342o/Rc6oXkkYyJ2jP+VLGekMbTCIXtv4NR8qFK4n/t2Bj/0WtEdoc4TXHpYOoqzn
	 SREs1EPwlpzdeuV3i/uUkRQuk7l5lf4dfJwPyZFdOV7bU64TXxCF9eaAqjO0NWf7ws
	 z7KRQupOzD0ucMEo5MAhzCneKuqmPY3jvjtik31P9F7pnx6rd5dXvvcGBdBJUj7RAV
	 N8BkOA+GsCCMuonb8er9hiQo4HmZZp5oCRnZtAkkniSRUKQwkqbMtL9xES2JIyYPdV
	 l33nZ3cJdtjXA==
Message-ID: <sashiko-outbox-168492@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/11] gpio: Add Cortina Systems CS75xx GPIO driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-watchdog@vger.kernel.org, conor+dt@kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261012-b4-cs75xx-s2-v1-4-8a7641b7b79c@gmail.com>
References: <20261012-b4-cs75xx-s2-v1-0-8a7641b7b79c@gmail.com>
 <20261012-b4-cs75xx-s2-v1-4-8a7641b7b79c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 17:47:38 +0000
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] gpio: cs75xx: TOCTOU race overwrites IRQ trigger hardware state
- [Medium] gpio: cs75xx: BOTH_EDGES state corruption on invalid IRQ type
- [Medium] gpio: cs75xx: missing ngpios bounds check causes OOB read and sh=
ift UB
--

commit a5885a6ba82fad811f622ae265473cbbb66fe3ae
Author: Fil Dunsky <filipp.dunsky@gmail.com>

gpio: Add Cortina Systems CS75xx GPIO driver

This commit adds a driver for the GPIO banks of the Cortina Systems CS75xx
SoCs, handling data and direction registers via gpio-mmio and providing an
interrupt controller with level and edge trigger support.

> diff --git a/drivers/gpio/gpio-cs75xx.c b/drivers/gpio/gpio-cs75xx.c
> index 0000000000000..168af0e37ac20
> --- /dev/null
> +++ b/drivers/gpio/gpio-cs75xx.c
[ ... ]
> +static int cs75xx_gpio_irq_set_type(struct irq_data *d, unsigned int typ=
e)
> +{
> +	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +	struct cs75xx_gpio *g =3D gpiochip_get_data(gc);
> +	u32 mask =3D BIT(irqd_to_hwirq(d));
> +	u32 lvl, edge;
> +
> +	guard(gpio_generic_lock_irqsave)(&g->chip);
> +
> +	lvl =3D readl(g->base + CS75XX_GPIO_LVL);
> +	edge =3D readl(g->base + CS75XX_GPIO_EDGE);
> +	g->both_edges &=3D ~mask;
> +
> +	switch (type & IRQ_TYPE_SENSE_MASK) {
[ ... ]
> +	default:
> +		return -EINVAL;
> +	}

[Severity: Medium]
Does this sequence cause a regression in the BOTH_EDGES state if an invalid
IRQ type is requested?

The both_edges bitmask is modified before validating the requested type. If
the request falls through to the default case (e.g., IRQ_TYPE_NONE) and ret=
urns
-EINVAL, the state mutation is already committed.

If the pin was previously operating in IRQ_TYPE_EDGE_BOTH mode, the interru=
pt
handler will no longer flip its polarity on subsequent interrupts, causing
a regression in the pin's functionality.

Could we defer modifying g->both_edges until after all validation succeeds?

[ ... ]
> +static int cs75xx_gpio_irq_reqres(struct irq_data *d)
> +{
[ ... ]
> +	guard(gpio_generic_lock_irqsave)(&g->chip);
> +	g->irq_used |=3D BIT(hwirq);

[Severity: Medium]
Could this result in undefined shift behavior if hwirq is 32 or greater?

If a Device Tree specifies an ngpios value greater than 32, this assignment
could invoke shift undefined behavior because BIT(hwirq) is assigned into
32-bit state variables.

While the current in-tree DT might not specify ngpios, should we clamp
gc->ngpio to 32 during probe to protect against malformed DT inputs?

[ ... ]
> +static void cs75xx_gpio_irq_handler(struct irq_desc *desc)
> +{
> +	struct gpio_chip *gc =3D irq_desc_get_handler_data(desc);
> +	struct cs75xx_gpio *g =3D gpiochip_get_data(gc);
> +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> +	unsigned long pending;
> +	unsigned int offset;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	pending =3D readl(g->base + CS75XX_GPIO_INT) &
> +		  readl(g->base + CS75XX_GPIO_IE);
> +
> +	for_each_set_bit(offset, &pending, gc->ngpio) {

[Severity: Medium]
Will this loop read out of bounds if gc->ngpio exceeds BITS_PER_LONG?

If the Device Tree specifies a larger ngpios value, iterating over a single
stack-allocated unsigned long pending with gc->ngpio could cause a stack
out-of-bounds read on 32-bit architectures (where unsigned long is 32 bits).

> +		if (g->both_edges & BIT(offset)) {
> +			guard(gpio_generic_lock)(&g->chip);
> +			cs75xx_gpio_set_polarity(g, BIT(offset));
> +		}

[Severity: High]
Can this lockless condition check expose a Time-Of-Check to Time-Of-Use
(TOCTOU) race that can overwrite the IRQ trigger hardware state?

The g->both_edges bitmask is checked locklessly before acquiring g->chip.lo=
ck.
A concurrent call to cs75xx_gpio_irq_set_type() on another CPU could:

1. Acquire the lock
2. Reconfigure the trigger type (clearing the bit in g->both_edges)
3. Update the hardware LVL and EDGE registers
4. Release the lock

The interrupt handler would then acquire the lock and execute
cs75xx_gpio_set_polarity(), which blindly reads and overwrites the LVL regi=
ster
based on the current pin level. This would overwrite the new trigger
configuration just established by irq_set_type(), leaving the hardware in an
incorrect state.

Should we re-evaluate the both_edges condition after the lock is acquired, =
or
acquire the lock before performing the check?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-b4-cs75xx-=
s2-v1-0-8a7641b7b79c@gmail.com?part=3D4
