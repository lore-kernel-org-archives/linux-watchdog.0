Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C133509B;
	Tue, 13 Oct 2026 06:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791873873; cv=none; b=D0sjSNRI3T2I+Y3NQOANCfXDalCz18oiuFiq7LH1xuIfZMWfxho6UjQ3NWRagbWqPvGVNN1ZFduQvRa6lYiq6nL5lKSbwOCqu3fBOymSq/6jKnP4mqkrbqb0XsXGUlHHNHzTOPCfuIqFVodey/n4gQrYQR3QbnAgdtNbWV8tkwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791873873; c=relaxed/simple;
	bh=2Ym+t6NmXVFHyuotyT1pguCo3fEc7FTAw51gkwAofrU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=lWVNceimdyBXqW9dm67f+GXHTEd5LaZsExXE9WQ/xOny3kkjs6s+CFA3crn0MtUQsUZk9GnrsRMCYWqbs8Y1Jhgz1xRMF03UOnimyVQ6jilO2izQls7+bofQjK5KIyA96JeUURd7CQvK6psbOLYOeqWMMOOhKPEGR5UvKXcTRJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXhK8jdP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXhK8jdP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22391F00893;
	Tue, 13 Oct 2026 06:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791873872;
	bh=Jb5WZy+SYai/GZOWR1P2tHJc0Ng2g8m0jo8oKVesebQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FXhK8jdPJQcR/PJlFfCnAUDfDamtS0K49dShoq1hiyC1H59De3t4R7tt9gYtiD0eA
	 GW1efJ0wJa7x6XvznfvdbzCzTWV+6ru8UmdPLP5tDl1yNYpFEMRcuNk/w1k+FwLUq6
	 t9GSKmR8x0TLZnUFZ7HaqSkNSk7w9ajTe5W31lGmUBIakOsTxelf9tmBQMmDucb9TE
	 hXyOrepxjYiFJy+LdfNi4o6Z3d0iK2z4Qqx/6XuQKjRV5zYq5Z5CTupf7vg7TEBtDN
	 IXKKJIkGIPfmV2Z8M3Q9K7wAKcP2IMLR8AH2BmrQ43nsMciVYpTw6YvyHUGDa+fYLX
	 kcFZLcO4DwspQ==
Message-ID: <sashiko-outbox-169127@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/11] gpio: Add Cortina Systems CS75xx GPIO driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261013-b4-cs75xx-s2-v3-4-181bb0d23f4c@gmail.com>
References: <20261013-b4-cs75xx-s2-v3-0-181bb0d23f4c@gmail.com>
 <20261013-b4-cs75xx-s2-v3-4-181bb0d23f4c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 06:44:31 +0000
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] gpio: hardware direction mutated before acquiring IRQ ownership
- [Medium] gpio: cs75xx_gpio_irq_handler drops latched edges due to early p=
olarity flip
- [Low] kconfig: unmet dependency warning for GPIO_GENERIC without HAS_IOMEM
--

commit 4137a122e8274d6f113967f6692bbb652886d35a
Author: Fil Dunsky <filipp.dunsky@gmail.com>

gpio: Add Cortina Systems CS75xx GPIO driver

Add a driver for the GPIO banks of the Cortina Systems CS75xx SoCs.
The data and direction registers are handled by gpio-mmio; each bank
has its own interrupt with level and edge triggers.

> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
[ ... ]
> @@ -300,6 +300,18 @@ config GPIO_CLPS711X
>  	help
>  	  Say yes here to support GPIO on CLPS711X SoCs.
> =20
> +config GPIO_CS75XX
> +	tristate "Cortina Systems CS75xx GPIO support"
> +	depends on ARCH_CORTINA_ACCESS || COMPILE_TEST
> +	select GPIO_GENERIC

[Severity: Low]
Does this Kconfig setup trigger an unmet dependency warning when HAS_IOMEM =
is
not set?=20

By enabling COMPILE_TEST, this configuration allows the driver to be built =
on
architectures like User-Mode Linux which lack HAS_IOMEM. However, it uses
select GPIO_GENERIC without inheriting its dependency on HAS_IOMEM. This
could lead to unmet direct dependency warnings and potential build failures.
Consider adding depends on HAS_IOMEM here to safely propagate the requireme=
nt.

> diff --git a/drivers/gpio/gpio-cs75xx.c b/drivers/gpio/gpio-cs75xx.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpio/gpio-cs75xx.c
[ ... ]
> +static void cs75xx_gpio_irq_ack(struct irq_data *d)
> +{
> +	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +	struct cs75xx_gpio *g =3D gpiochip_get_data(gc);
> +
> +	writel(BIT(irqd_to_hwirq(d)), g->base + CS75XX_GPIO_INT);
> +}
[ ... ]
> +static int cs75xx_gpio_irq_reqres(struct irq_data *d)
> +{
> +	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
> +	struct cs75xx_gpio *g =3D gpiochip_get_data(gc);
> +	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
> +	int ret;
> +
> +	/* The boot loader may leave the line configured as an output */
> +	ret =3D gc->direction_input(gc, hwirq);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D gpiochip_reqres_irq(gc, hwirq);

[Severity: Medium]
Is it safe to mutate the hardware direction before successfully acquiring
the gpiolib IRQ ownership?

If the GPIO line is concurrently requested and actively driven as an output
by another subsystem, changing its hardware direction abruptly could break
the output signal and corrupt the hardware state. While gpiochip_reqres_irq=
()
checks the in-use state and will ultimately reject the request if it is an
output, the hardware has already been improperly modified here. The core
gpiolib ownership check should likely happen before the hardware state is
changed.

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
> +		scoped_guard(gpio_generic_lock, &g->chip) {
> +			if (g->both_edges & BIT(offset))
> +				cs75xx_gpio_set_polarity(g, BIT(offset));
> +		}
> +		generic_handle_domain_irq(gc->irq.domain, offset);

[Severity: Medium]
Could this drop latched edge interrupts due to an early polarity flip?

In this handler, the edge polarity is toggled to arm the hardware for the
opposite edge, followed by generic_handle_domain_irq(), which uses
handle_edge_irq(). The generic edge handler invokes cs75xx_gpio_irq_ack()
which explicitly clears the interrupt status bit unconditionally.

If the pin state flips again in the small window between
cs75xx_gpio_set_polarity() and cs75xx_gpio_irq_ack(), the hardware latches
the new edge, but the subsequent ack clears it. This could result in edge
interrupts being permanently lost, potentially causing peripheral drivers
waiting for GPIO events to hang.

> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
s2-v3-0-181bb0d23f4c@gmail.com?part=3D4
