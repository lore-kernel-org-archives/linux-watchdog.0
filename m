Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061FA4A3407;
	Tue, 14 Jul 2026 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784045182; cv=none; b=TZcoUQNjVAY+NRqze1ZLIWuvOg0IG31elo0KAxvLeDFRQTNDjjKpMRr1P/05j6C6dxTEbvOvWOkXJL6lvbjZ0Xal7lzUh6qVCo0mzU8nQtpmXcMab7x25nhCBXCiDkPdZZilziQlZJdtQHWsWJWu5F9+WBi8SO3gS0CpOZeVYgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784045182; c=relaxed/simple;
	bh=ujPgGHzUSyBnrJ91YCbS/50az1L62OtAWxAYKm4qQU0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BzVSQ3MO/hctscnZK2CXrjIiEV6N9BZYV/41K8ow8hn3hBvAafOgU1iRmWLaF5CRaSHvr6PfIRGN8tLwGRrtWyKBv7eQoK/VufqbFO3qVprH0eND9/e8qLhVk9YQIvwFvFWCkY46v9H/mXRpiaHzdpiT5ZQ9fOf39Aqu1YE5PsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNeFzgvS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNeFzgvS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920661F00A3A;
	Tue, 14 Jul 2026 16:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784045180;
	bh=MyPA2eXZCwcOhKWW34UxN0vhMKieaPiRIYUcoCQpjrk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lNeFzgvSDPPBhp5jR+Ve0lLXIR+OqaTi7yfrGpqcW6A6+vkb0qhvLcv1fczooea70
	 mXGJw4zI9Z8NdT7J0kXmHs1Wz+L11RndZKkwr+PFYbs0y2cP46Q4fNIZPYfDJ/rsBD
	 gEjjVAAri5lvX1yCtkT9O3gwSll5JKI5PShaT4pdJt1ZDmyJ1D+j6ZI2QbxsgKYTgh
	 1RfXOeaR+jjNxQtHTUqk8PoBomr7dLQEqKqGPOC0M9zU1UtC89Aoh2pOyzKdKaIzMb
	 avPrckp1ssbut22NKYz0rs8D63cTTABUaQAelBn7MFfiBpTT7HjKM9gWavqATl7SU2
	 EWkEEp4ZYZQ/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/8] Add Advantech EIO GPIO driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ramiro Oliveira" <ramiro.oliveira@advantech.com>
Cc: mfd@lists.linux.dev, lee@kernel.org, linux-hwmon@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260714-upstream-v2-v2-2-76e5e41026db@advantech.com>
References: <20260714-upstream-v2-v2-0-76e5e41026db@advantech.com>
 <20260714-upstream-v2-v2-2-76e5e41026db@advantech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 16:06:20 +0000
Message-Id: <20260714160620.920661F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] Off-by-one boundary check in `check_pin()` allows out-of-bounds ar=
ray read of `group_map`.
- [High] Integer shift overflow when generating a 64-bit mask using the `BI=
T()` macro on 32-bit architectures.
- [Medium] The supported pins bitmask (`avail`) is calculated but never enf=
orced, allowing interaction with unsupported pins.
- [Medium] Failure to check the return value of `pmc_write` allows silent f=
ailures when configuring pin direction.
- [Medium] Meaningful error codes returned by `gpio_init()` are squashed to=
 `-EIO` in `gpio_probe()`.
- [Medium] Setting GPIO direction to output before configuring the output l=
evel causes a physical hardware glitch.
- [Medium] Endianness mismatch when reading hardware registers byte-by-byte=
 into a multi-byte integer address.
- [Low] Off-by-one boundary check in `pmc_read()` allows out-of-bounds arra=
y read.
- [Low] Returning `-ENOMEM` instead of `-EINVAL` for invalid control argume=
nts in `pmc_read` and `pmc_write`.
--

--- Patch [2]: [PATCH v2 2/8] Add Advantech EIO GPIO driver ---
commit 22717cbc8cf200661da102ffdd6bee43f768b719
Author: Ramiro Oliveira <ramiro.oliveira@advantech.com>

Add Advantech EIO GPIO driver

This driver controls the GPIO component of the Advantech EIO chip.

> diff --git a/drivers/gpio/gpio-eio.c b/drivers/gpio/gpio-eio.c
> new file mode 100644
> index 0000000000000..34e1aefd0716c
> --- /dev/null
> +++ b/drivers/gpio/gpio-eio.c

[ ... ]

> +static int pmc_write(struct device *mfd_dev, u8 ctrl, u8 dev_id, void *d=
ata)
> +{
> +	struct pmc_op op =3D {
> +		 .cmd       =3D EIO_GPIO_WRITE,
> +		 .control   =3D ctrl,
> +		 .device_id =3D dev_id,
> +		 .payload   =3D (u8 *)data,
> +	};
> +
> +	if (ctrl >=3D ARRAY_SIZE(ctrl_para))
> +		return -ENOMEM;

[Severity: Low]
Should this bounds check return -EINVAL instead of -ENOMEM?=20

Returning -ENOMEM signifies a memory allocation failure to the caller, but
no allocation is occurring here.

[ ... ]

> +static int pmc_read(struct device *mfd_dev, u8 ctrl, u8 dev_id, void *da=
ta)
> +{
> +	struct pmc_op op =3D {
> +		 .cmd       =3D EIO_GPIO_READ,
> +		 .control   =3D ctrl,
> +		 .device_id =3D dev_id,
> +		 .payload   =3D (u8 *)data,
> +	};
> +
> +	if (ctrl > ARRAY_SIZE(ctrl_para))
> +		return -ENOMEM;

[Severity: Low]
Is there an off-by-one error in this boundary check?

Using greater-than allows an input exactly equal to the array size to bypass
the check, which could lead to an out-of-bounds read on the following line.

[Severity: Low]
Additionally, should this return -EINVAL instead of -ENOMEM when the control
argument is invalid?

[ ... ]

> +static int dir_output(struct gpio_chip *chip, unsigned int offset, int v=
alue)
> +{
> +	u8 dir =3D 1;
> +	u8 val =3D value;
> +
> +	pmc_write(chip->parent, EIO_GPIO_PIN_DIR, offset, &dir);
> +
> +	return pmc_write(chip->parent, EIO_GPIO_PIN_LEVEL, offset, &val);
> +}

[Severity: Medium]
Does setting the GPIO direction to output before configuring the output lev=
el
cause a physical hardware glitch?

Every time a pin is reconfigured as an output, it might briefly drive whate=
ver
stale default value resides in its output latch until the second write comm=
and
completes.

[Severity: Medium]
Does this also silently discard the return value of the initial direction
configuration?

If the first pmc_write() call fails due to an I/O communication error, the
pin direction may remain misconfigured as an input while the driver falsely
reports success and proceeds to drive the level.

[ ... ]

> +static int check_pin(struct device *dev, int pin)
> +{
> +	int ret;
> +	int group, bit;
> +	u16 data;
> +
> +	/* Get pin mapping */
> +	ret =3D pmc_read(dev, EIO_GPIO_MAPPING, pin, &data);

[Severity: Medium]
Does reading hardware registers byte-by-byte into a multi-byte integer
introduce an endianness mismatch?

When pmc_read() iterates and places bytes sequentially into the target addr=
ess,
it assumes a Little-Endian memory layout. On Big-Endian platforms, the
multi-byte integer will be assembled with the wrong byte order.

> +	if (ret)
> +		return ret;
> +
> +	if ((data & 0xFF) > ARRAY_SIZE(group_map))
> +		return -EINVAL;

[Severity: High]
Is there an off-by-one boundary check here that could allow an out-of-bounds
array read?

If the hardware embedded controller returns a mapping value where
(data & 0xFF) exactly equals the array size, it would bypass this check and
cause an out-of-bounds access on group_map in the next line.

> +
> +	group =3D group_map[data & 0xFF].group;
> +	bit   =3D data >> 8;
> +
> +	/* Check mapped pin */
> +	ret =3D pmc_read(dev, EIO_GPIO_GROUP_AVAIL, group, &data);
> +	if (ret)
> +		return ret;
> +
> +	return data & BIT(bit) ? 0 : -EOPNOTSUPP;

[Severity: High]
Can using the unvalidated hardware value for the bit shift amount cause
undefined behavior on 32-bit architectures?

[ ... ]

> +static int gpio_init(struct device *mfd, struct eio_gpio_dev *eio_gpio)
> +{
> +	int ret, i;
> +
> +	ret =3D check_support(mfd);
> +	if (ret)
> +		return dev_err_probe(eio_gpio->dev, ret, "GPIO not supported\n");
> +
> +	eio_gpio->avail =3D 0;
> +
> +	for (i =3D 0 ; i < EIO_GPIO_MAX_PINS ; i++) {
> +		ret =3D check_pin(mfd, i);
> +		if (ret)
> +			continue;
> +
> +		eio_gpio->avail |=3D BIT(i);

[Severity: High]
Does this cause an integer shift overflow when generating the 64-bit mask?

Since EIO_GPIO_MAX_PINS is 48, using the 32-bit BIT() macro will shift by 32
or more on 32-bit systems, causing undefined behavior. Should this use
BIT_ULL() instead?

[ ... ]

> +static int gpio_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct eio_gpio_dev *eio_gpio;
> +	struct eio_dev *eio_dev =3D dev_get_drvdata(dev->parent);
> +
> +	if (!eio_dev)
> +		return dev_err_probe(dev, -ENODEV, "Error contact eio_core\n");
> +
> +	eio_gpio =3D devm_kzalloc(dev, sizeof(*eio_gpio), GFP_KERNEL);
> +	if (!eio_gpio)
> +		return -ENOMEM;
> +
> +	eio_gpio->dev =3D dev;
> +
> +	if (gpio_init(dev->parent, eio_gpio))
> +		return -EIO;

[Severity: Medium]
Is it intentional to discard the meaningful error codes returned by gpio_in=
it()
and replace them with -EIO?

This might disrupt the standard kernel error propagation, specifically brea=
king
deferred probing if gpio_init() returns -EPROBE_DEFER.

> +
> +	eio_gpio->chip.parent =3D dev->parent;
> +	eio_gpio->chip.ngpio =3D eio_gpio->max;

[Severity: Medium]
The supported pins bitmask eio_gpio->avail is computed during gpio_init() b=
ut
never seems to be enforced.

Does the gpio_chip need to be populated with an .init_valid_mask callback so
that gpiolib enforces the valid pins mask? Otherwise, gpiolib will implicit=
ly
assume all pins in the range are valid, and unsupported pins could be
accessed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-upstream-v=
2-v2-0-76e5e41026db@advantech.com?part=3D2
