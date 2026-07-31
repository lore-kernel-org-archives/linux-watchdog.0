Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9183E3D90;
	Fri, 31 Jul 2026 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785492119; cv=none; b=AnXpa6YzAusZLQPHaQuOtsdk2DYF/ABcQC7/EJbDw9eRLdwNfbNOEiWsYXfq89L8A3AougsEOwNGcKL4LYSJ/jV6iK61F77gim6WSOZBd/bA3kDnfiPGq+lF3Ej5OLrDFkGZ5s0n4IO0UeOQO0x2KkeFVGPM2LQe8zwZntUw02w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785492119; c=relaxed/simple;
	bh=OK1tX6l6OXYqoETpubtnYdp/5rM1/28rbjfPaCJ2U+I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cTHV9aWL4jomT03RAj11RdAyJCOgLGuEuFLD21FqWYFgx1EThwdnV/WsIj8N53TCXBhnyK/1d55ZzcUzmS2UiiiUdQ/lWXn4E+t2c5RtzAsLPbbFO0t6bISBtrw1r32gIBWXjC+mBQm7k4pqvIslMbTsjli8Nts/xodAHt8U7v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjALqy0K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjALqy0K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6D61F000E9;
	Fri, 31 Jul 2026 10:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785492110;
	bh=4tS2IepPr6lSygjkA3uQSPFrss/f1OyjD21LnxxmLIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WjALqy0KOmPTVVA6iTgG8eNT2Mn6pVoirUpebyDoByDT+oTcu+1tX470V3QbBgIjz
	 4p57g+XFy1fDoj8KjgAyMPBW1gz7yyH+2WUgXhlVqThd7n071zLutTzZvkNej5dAbw
	 oMdHQw9JDefQQtYDHjqvkwGxvjWQquD3jb5dR6S0rikJSvd1KBQmdDU0enmC43WRun
	 9hf2CU1gmbs2d/llyZCaDTeMJAxGvxsbxUvaGNuX5rVEh6/IHVXwo3mx/i7QTmaSIb
	 xv2S50KgNpUzi1IRGFHTex9mwKoMzOmBXx0GdROmx5ChRpS+b8yBzq1lIUbNo8ZIls
	 LVBWVE4c6DRnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/5] gpio: aaeon: Add GPIO driver for SRG-IMX8P MCU
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFBlcnJvdCAoU2NobmVpZGVyIEVsZWN0cmljKQ==?= <thomas.perrot@bootlin.com>
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260731-dev-b4-aaeon-mcu-driver-v8-4-9ab00e80df2a@bootlin.com>
References: <20260731-dev-b4-aaeon-mcu-driver-v8-0-9ab00e80df2a@bootlin.com>
 <20260731-dev-b4-aaeon-mcu-driver-v8-4-9ab00e80df2a@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 10:01:49 +0000
Message-Id: <20260731100149.AC6D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditionally resetting all GPIO and GPO pin states during probe=
 breaks bootloader handoff and can cause severe hardware glitches.
--

--- Patch [4]: [PATCH v8 4/5] gpio: aaeon: Add GPIO driver for SRG-IMX8P MC=
U ---
commit 039db3f85a7d9e8ca0a6aa50fb1e051d88e24a0b
Author: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>

gpio: aaeon: Add GPIO driver for SRG-IMX8P MCU

Add GPIO driver for the Aaeon SRG-IMX8P embedded controller. This
driver supports 7 GPO (General Purpose Output) pins and 12 GPIO pins
that can be configured as inputs or outputs.

> diff --git a/drivers/gpio/gpio-aaeon-mcu.c b/drivers/gpio/gpio-aaeon-mcu.c
> new file mode 100644
> index 0000000000000..a9e048c865f5c
> --- /dev/null
> +++ b/drivers/gpio/gpio-aaeon-mcu.c
[ ... ]
> +static void aaeon_mcu_gpio_reset(struct aaeon_mcu_gpio *data, struct dev=
ice *dev)
> +{
> +	unsigned int i;
> +	int ret;
> +
> +	/* Reset all GPOs */
> +	for (i =3D 0; i < MAX_GPOS; i++) {
> +		ret =3D aaeon_mcu_gpo_set_cmd(data, i, 0);
> +		if (ret < 0)
> +			dev_warn(dev, "Failed to reset GPO %u state: %d\n", i, ret);
> +		clear_bit(i, data->dir_in);
> +	}
> +
> +	/* Reset all GPIOs */
> +	for (i =3D MAX_GPOS; i < MAX_GPOS + MAX_GPIOS; i++) {
> +		ret =3D aaeon_mcu_gpio_config_input_cmd(data, i);
> +		if (ret < 0)
> +			dev_warn(dev, "Failed to reset GPIO %u state: %d\n", i, ret);
> +		set_bit(i, data->dir_in);
> +	}
> +}
[ ... ]
> +static int aaeon_mcu_gpio_probe(struct platform_device *pdev)
> +{
> +	struct aaeon_mcu_gpio *data;
[ ... ]
> +	/*
> +	 * Reset all GPIO states to a known configuration. The MCU does not
> +	 * reset GPIO state on soft reboot, only on power cycle (hard reboot).
> +	 * Without this reset, GPIOs would retain their previous state across
> +	 * reboots, which could lead to unexpected behavior.
> +	 */
> +	aaeon_mcu_gpio_reset(data, &pdev->dev);

[Severity: High]
Does this unconditional reset during probe interfere with bootloader handof=
f?

If the bootloader has set a GPO high or configured a GPIO as an output to
drive a critical component (like a voltage regulator or display backlight),
forcing it low or to an input state could immediately cut power or cause a
hardware glitch.

Could the driver read the hardware registers to populate its internal state
instead of wiping the physical state during initialization?

> +
> +	return devm_gpiochip_add_data(&pdev->dev, &data->gc, data);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dev-b4-aae=
on-mcu-driver-v8-0-9ab00e80df2a@bootlin.com?part=3D4
