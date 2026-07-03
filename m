Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12657346A02
	for <linux-watchdog@vger.kernel.org>; Fri,  3 Jul 2026 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076459; cv=none; b=KO8pmcnucS7irec0QN5uaJrOMODJ3ASapdQ3Xo2pOW7KaMT6n/9Rb97jw8XDvfBCLrCUM1Anh47pZ7sZxDG+NHhaNwcTh1yzAERAXj96fJc3CrQsOgwNRjc4G947JCHTIMPAuDTJwAEFuUWtS3Hw3nLoMDK7Srb9c+g6S9Unw48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076459; c=relaxed/simple;
	bh=KF4PYzd4QpVqQctLB1X3TIU1Beyh4krzNY6wZfbMYTk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a9qRqB21t4JPJtmcwCpmo28WygMGkW+iG73p3jYwZeZUB8EKL0BY77cHx4Q7+u5XzjyawbBsdyBGH56Aov3Iz1UC0M3xpGHhxTWsUPzol27C8Fi+1wmhsCB+QSuBU4mCVeiB9wqglso6UnFKDDNGerybS5HOt9AMDXr0ssUidPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pKDTG8AI; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pKDTG8AI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C26B7C79ABE;
	Fri,  3 Jul 2026 11:01:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DF22860300;
	Fri,  3 Jul 2026 11:00:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 31629104C9573;
	Fri,  3 Jul 2026 13:00:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783076454; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references:autocrypt;
	bh=tYlcpJ6f3u67IWkL7tEFKVx4Px8m/+qr9gJGkqxbauE=;
	b=pKDTG8AIgN9e3RHvh1fQhOPC0ZiZVZOKR1WcO6TBaWOCxwGHHUBmXmgmjdMlmYyGesOnhy
	cAzjH2QYqEyWi586aY8E7+EgHZ0XHyDb2ZUzjyuoRYFBFGBvznrIvLt5MtBg3tI8tvs4tJ
	fb2rMzIEAQ8hNX/ZJILsxmSTUXIkA0JgTEczu7QK4ARJ6HiJDKJWtLHe+rtdE0nbnZXF5z
	alPLRz97m8DQoc/HoM9Q0ZQ5nsPivMrk50gmF8XPmLHf6zF9WW98+gP+uje2vPIJdnZZmX
	eFz+b88y+EMy07uqEAwKu7yz6gaR5ZeCzOTdgUO4Ca9P56j8sweHcuL/a2o60w==
Message-ID: <abfc86c41c19c73e9e41dc9654935a0fc89bc5e2.camel@bootlin.com>
Subject: Re: [PATCH v6 4/5] gpio: aaeon: Add GPIO driver for SRG-IMX8P MCU
From: Thomas Perrot <thomas.perrot@bootlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: thomas.perrot@bootlin.com, Frank.Li@kernel.org,
 devicetree@vger.kernel.org, 	linux-watchdog@vger.kernel.org,
 conor+dt@kernel.org, robh@kernel.org, 	imx@lists.linux.dev
Date: Fri, 03 Jul 2026 13:00:51 +0200
In-Reply-To: <20260630131017.60D8C1F000E9@smtp.kernel.org>
References: <20260630-dev-b4-aaeon-mcu-driver-v6-0-d66b5fcbd2f0@bootlin.com>
	 <20260630-dev-b4-aaeon-mcu-driver-v6-4-d66b5fcbd2f0@bootlin.com>
	 <20260630131017.60D8C1F000E9@smtp.kernel.org>
Autocrypt: addr=thomas.perrot@bootlin.com; prefer-encrypt=mutual;
 keydata=mQGNBF+/ZOUBDAC2DghCjZvmgYcve02OG7dGZ7Iy58uEwne3LB7w7nRwdAxKw7ZaiVqwY
 O+yNGVi+GVx7oA6Wn4pv46z+QDRLQiq6OseuXhkSGCg7U/yBCUq12B/GRGO1Qt2Qi1mJJT1s+1qZ5
 Gxv6Nypz9qKVn94GM2bR1hXBga0t87vBpebThOHmX5d/0dqIcVxRCM7onNb0dDyRoVgLS5rBhQzrL
 CMrJaCy39xZUy0J1SOlH4Mgk6EhJIPYY4wlzikGX6urg+Tc9EjGd78ry0e0p5U5qgjFR5QGJDy1Gn
 U3CfwbT9sowdCASDbQDUoltlv2iWJCLa0xl97KVchCa0pr7HKbFA3J5SLKqFYUBCkFL+5WudYlz2n
 XxiUgyviMQxyK+ij66kEi6/2zFDAecd43pHV7790ptqZBC3Jc67Emj7Vo3ShX6RXPPxxbeCTOF2uk
 I45aJ9XcVFH/MFE96NjXj8uahnIsiTPyuCUoJu8tj7TSQyue874qJqVQvqlFyt2aZYJZ8ruq8AEQE
 AAbQpVGhvbWFzIFBlcnJvdCA8dGhvbWFzLnBlcnJvdEBib290bGluLmNvbT6JAc4EEwEIADgCGwMF
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQSHQHfGpqMKIwOoEiGfwAsFcf4K7QUCX79mdwAKCRCfw
 AsFcf4K7fhbC/wP0kSl6id2E/K3+UdXk6CLMVRbCFLCREzQs5WFpQ6l/I0WGOamhrOgegdszheiVF
 orlUP8d37XSpFAqydhKGaN78V5Dps0Wmwm4lIlS4MtQXJtSLUHXDJLIZLW0pw8tiPLKsd1o/yDkXE
 dnpsjJTRG6SdDSHnyOB2/gh4p+yTaLytFdARk/r4/P26+L+FiH0fFl+RnBt19LPklfKgeDc7GwIif
 ja+nIWpp3W23DAUuI6xduEut25Q89yu7Ci8CliLfAiLy9bIGjBQWU2Y+1/j/7KuPj6VbBsZWLTZY0
 hUmpJSTnWAqc9SMsNxo7NSQuddgviz5e2tqucaRqxP02FGzNa8U4NAKdWaXrlHG5Dglj9XH0DK+SH
 +c96qqFewYD8VPQ6XAGxQcXbrtJmiMor1R2DfziispLRvJcfYs8xqabbCtoS3ouXB9XRi8hn7A2kh
 ME1ryS+Oh63JshXHnw6bmjCpVd/p+fGLIGU6A47pJOpviKR4jEO84pl2ejtDZ3Tc=
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-sykvhHvoBFGpNBeq5KNz"
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3


--=-sykvhHvoBFGpNBeq5KNz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Sashiko,

On Tue, 2026-06-30 at 13:10 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> - [High] Unconditional resetting of all hardware pins in the `probe`
> function breaks bootloader hand-off and destroys firmware
> configuration.
> - [Medium] Ignoring critical hardware errors during probe
> initialization leads to inconsistent software state.
> --
>=20
> commit 73ee6d66b506331ac77e36c415e83febae316cf0
> Author: Thomas Perrot (Schneider Electric)
> <thomas.perrot@bootlin.com>
>=20
> gpio: aaeon: Add GPIO driver for SRG-IMX8P MCU
>=20
> This commit adds a GPIO driver for the Aaeon SRG-IMX8P embedded
> controller.
> It supports 7 GPO pins and 12 GPIO pins, providing access to pins
> handled
> by the microcontroller. During probe, all pins are reset to a known
> state.
>=20
> > diff --git a/drivers/gpio/gpio-aaeon-mcu.c b/drivers/gpio/gpio-
> > aaeon-mcu.c
> > new file mode 100644
> > index 0000000000000..a9e048c865f5c
> > --- /dev/null
> > +++ b/drivers/gpio/gpio-aaeon-mcu.c
>=20
> [ ... ]
>=20
> > +static void aaeon_mcu_gpio_reset(struct aaeon_mcu_gpio *data,
> > struct device *dev)
> > +{
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	/* Reset all GPOs */
> > +	for (i =3D 0; i < MAX_GPOS; i++) {
> > +		ret =3D aaeon_mcu_gpo_set_cmd(data, i, 0);
> > +		if (ret < 0)
> > +			dev_warn(dev, "Failed to reset GPO %u
> > state: %d\n", i, ret);
> > +		clear_bit(i, data->dir_in);
>=20
> [Severity: Medium]
> Is it safe to update the internal software state tracking when the
> hardware
> command fails?

aaeon_mcu_gpio_reset() is a best-effort initialization: the MCU does
not reset GPIO state on soft reboot, so the driver attempts to bring
both hardware and software into a known state at probe time.

If an I2C error occurs, the true hardware state is unknown and
unrecoverable without a power cycle. Keeping the software bitmaps at
the desired post-reset state (GPOs as outputs, GPIOs as inputs) is
safer than preserving stale values from the previous boot, which could
cause get_direction() to return wrong results for subsequent callers.=C2=A0
Any ongoing I2C fault will surface as errors in the regular GPIO ops.

>=20
> If aaeon_mcu_gpo_set_cmd() returns an error because the underlying
> bus is
> temporarily inaccessible, clear_bit() is still executed. This could
> result
> in the GPIO controller registering with a mismatched view of the
> hardware.
>=20
> > +	}
> > +
> > +	/* Reset all GPIOs */
> > +	for (i =3D MAX_GPOS; i < MAX_GPOS + MAX_GPIOS; i++) {
> > +		ret =3D aaeon_mcu_gpio_config_input_cmd(data, i);
> > +		if (ret < 0)
> > +			dev_warn(dev, "Failed to reset GPIO %u
> > state: %d\n", i, ret);
> > +		set_bit(i, data->dir_in);
>=20
> [Severity: Medium]
> Similarly, does this code lead to an inconsistent state by blindly
> updating
> data->dir_in even if aaeon_mcu_gpio_config_input_cmd() fails?
>=20

Please refer to my other answers.

> > +	}
> > +}
> > +
> > +static int aaeon_mcu_gpio_probe(struct platform_device *pdev)
> > +{
>=20
> [ ... ]
>=20
> > +	/*
> > +	 * Reset all GPIO states to a known configuration. The MCU
> > does not
> > +	 * reset GPIO state on soft reboot, only on power cycle
> > (hard reboot).
> > +	 * Without this reset, GPIOs would retain their previous
> > state across
> > +	 * reboots, which could lead to unexpected behavior.
> > +	 */
> > +	aaeon_mcu_gpio_reset(data, &pdev->dev);
>=20
> [Severity: High]
> Could forcing all output pins to low and resetting GPIO
> configurations to
> inputs unconditionally during probe disrupt the state established by
> the
> bootloader?
>=20

There is currently no bootloader support for the SRG-IMX8P MCU, so no
bootloader-established GPIO state exists to preserve. The reset at
probe time ensures a known quiescent state on every boot, which is
necessary because the MCU retains GPIO state across soft reboots
(kexec, reboot) but not across power cycles. Without it, GPIO state
would be non-deterministic depending on the boot path.

Kind regards,
Thomas

> Overriding the hardware state on every boot could inadvertently cut
> power to
> critical system components like regulators, eMMC, or displays that
> were left
> on by the bootloader or previous kernel execution.
>=20
> > +
> > +	return devm_gpiochip_add_data(&pdev->dev, &data->gc,
> > data);
> > +}

--=20
Thomas Perrot, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--=-sykvhHvoBFGpNBeq5KNz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEh0B3xqajCiMDqBIhn8ALBXH+Cu0FAmpHlmMACgkQn8ALBXH+
Cu3segv/WPTTakAXGaVG+gZhTD71CddcNfzJqf1VYZSLWZ4flJ+bzuOCAl6zUg2J
EWZCFtxXT8xON/DKoz8o2MywoJoPk/FiLLDTCsL1tmiWRmi/dnFc8NC/tW6gSmAB
WDhU+tjykBMG7e7QXd+nc2KU+1+JyIvb02lPy4aydVHTU6QGhy+8sXlD5SFUR84q
bIHv7RqFNhqlQzc5VdUknY0RkPcP2sKBjFs5sNM3Ma5H69E+IeU5y+b5iCgU3nDl
RHQZffajxi7of0pyPO1V3Hr+P+Xlot/hIjpCrhSWpYOJGvEV79ia3u4YXUomxfAA
/9QfIQH0D+1yI+2GQmkjxUBcDuWSfGCpNYRGQ33QZ5JtyvIUVaGnsQGdr4d+zRkY
k0jkkp1IwM4scE4stLjg35FI8OBZfMikP6nNDc6yiJG8ENy7QH4f6pqb0sj1VvCN
Pv0K8Vg+co2toV/gMkJdCC47KZe+7nJ0g90NRxaTELOXl7Itx2Z/TwBubDToWNfN
ldb9ecGd
=wpFY
-----END PGP SIGNATURE-----

--=-sykvhHvoBFGpNBeq5KNz--
