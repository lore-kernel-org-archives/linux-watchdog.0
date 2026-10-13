Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460083B52F8;
	Tue, 13 Oct 2026 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883577; cv=none; b=hpINBSFeQ2XaaiYyfTiQ6g2sD4Rw/BlNy9gme8kSPJfrKWpgMixdoJos552DCzlQooTWeXHBYnetf7+vHzJrzMl7/t9t+dNRqz42GVRCn+ZKpIEiTCxvlJWbfeB74PWjngPuPAoeqHjhj1pyrDuZO+D3l73xFn/JxrQTSy/4Nxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883577; c=relaxed/simple;
	bh=0IeIRDYTDfbt7ksOOdF/bT5gc6lOUOkRn+GPXF1YWPc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D2mO2lh2S06kOcAF3GAeLlEicd4tB2QMJ+Vk/J+1S3aytMJVvurr0xnkVe5ZjMC/onH3msYOCxm7OKUY4Zo73Jj0eKVzP0IQdpAu12uijKZoNSF+4nx/Ul0hiAy/e6p51iJtgkmm1ULFzappMNAruPIxu4vf4DFHSMa6IwYS77o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c6AkaJap; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c6AkaJap"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9F0FD1A11F7;
	Tue, 13 Oct 2026 09:26:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 73CCD60362;
	Tue, 13 Oct 2026 09:26:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5395311D70089;
	Tue, 13 Oct 2026 11:26:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791883569; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references:autocrypt;
	bh=vsOsSf9jxUI3+A73+7N9gg0DzlCByL3n4laVO3gqWTY=;
	b=c6AkaJapoiF2q8hwYO2ylhn5Y9DhczLgmUx5MWfjXQaWZAPLP6ceefnoDsdHpRC1/BzjXe
	9ADIR1bTZWAMJU37rPWSHeOSrntVxjSWz3/fAytEZnAzz/T9CdTSNM8xuapLPrwGX02Qtw
	OjlO/C9wNd1H4/hbH1Y6n2hfAueNbOFAkJB2zzYQ+1vF1JuYR3YLr5YQfVWDEACXkabFfZ
	r0SosyuiC0unrY9w6zxfQ50xNwhbT0ZKNvv9tZy19NrRAyJXEaH8IUFjCKJwHDyWYHxKj2
	LUoT5tdgrWKjv5VNNQOiSlDRX5XE5iOlQJeIqhk7ZkjZzieYN1BLHBBR+mloGA==
Message-ID: <a3c97dd05ac410a9468855ec89f495cb2b5896e3.camel@bootlin.com>
Subject: Re: [PATCH v8 4/5] gpio: aaeon: Add GPIO driver for SRG-IMX8P MCU
From: Thomas Perrot <thomas.perrot@bootlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: thomas.perrot@bootlin.com, imx@lists.linux.dev, Frank.Li@kernel.org, 
	robh@kernel.org, devicetree@vger.kernel.org,
 linux-watchdog@vger.kernel.org, 	conor+dt@kernel.org
Date: Tue, 13 Oct 2026 11:26:07 +0200
In-Reply-To: <20260731100149.AC6D61F000E9@smtp.kernel.org>
References: <20260731-dev-b4-aaeon-mcu-driver-v8-0-9ab00e80df2a@bootlin.com>
	 <20260731-dev-b4-aaeon-mcu-driver-v8-4-9ab00e80df2a@bootlin.com>
	 <20260731100149.AC6D61F000E9@smtp.kernel.org>
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
	protocol="application/pgp-signature"; boundary="=-1nYg9/8HH/nxLAHpH0fX"
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3


--=-1nYg9/8HH/nxLAHpH0fX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, 2026-07-31 at 10:01 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [High] Unconditionally resetting all GPIO and GPO pin states during
> probe breaks bootloader handoff and can cause severe hardware
> glitches.

The MCU doesn't provide way to read back pin direction/output state and
keeps it across soft reboots, so the driver has to establish a known
state for get_direction() to be truthful.

Moreover, the bootloader does not drive these lines.

Kind regards,
Thomas Perrot

> --
>=20
> --- Patch [4]: [PATCH v8 4/5] gpio: aaeon: Add GPIO driver for SRG-
> IMX8P MCU ---
> commit 039db3f85a7d9e8ca0a6aa50fb1e051d88e24a0b
> Author: Thomas Perrot (Schneider Electric)
> <thomas.perrot@bootlin.com>
>=20
> gpio: aaeon: Add GPIO driver for SRG-IMX8P MCU
>=20
> Add GPIO driver for the Aaeon SRG-IMX8P embedded controller. This
> driver supports 7 GPO (General Purpose Output) pins and 12 GPIO pins
> that can be configured as inputs or outputs.
>=20
> > diff --git a/drivers/gpio/gpio-aaeon-mcu.c b/drivers/gpio/gpio-
> > aaeon-mcu.c
> > new file mode 100644
> > index 0000000000000..a9e048c865f5c
> > --- /dev/null
> > +++ b/drivers/gpio/gpio-aaeon-mcu.c
> [ ... ]
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
> > +	}
> > +
> > +	/* Reset all GPIOs */
> > +	for (i =3D MAX_GPOS; i < MAX_GPOS + MAX_GPIOS; i++) {
> > +		ret =3D aaeon_mcu_gpio_config_input_cmd(data, i);
> > +		if (ret < 0)
> > +			dev_warn(dev, "Failed to reset GPIO %u
> > state: %d\n", i, ret);
> > +		set_bit(i, data->dir_in);
> > +	}
> > +}
> [ ... ]
> > +static int aaeon_mcu_gpio_probe(struct platform_device *pdev)
> > +{
> > +	struct aaeon_mcu_gpio *data;
> [ ... ]
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
> Does this unconditional reset during probe interfere with bootloader
> handoff?
>=20
> If the bootloader has set a GPO high or configured a GPIO as an
> output to
> drive a critical component (like a voltage regulator or display
> backlight),
> forcing it low or to an input state could immediately cut power or
> cause a
> hardware glitch.
>=20
> Could the driver read the hardware registers to populate its internal
> state
> instead of wiping the physical state during initialization?
>=20
> > +
> > +	return devm_gpiochip_add_data(&pdev->dev, &data->gc,
> > data);
> > +}

--=20
Thomas Perrot, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--=-1nYg9/8HH/nxLAHpH0fX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEh0B3xqajCiMDqBIhn8ALBXH+Cu0FAmrN+S8ACgkQn8ALBXH+
Cu2lRwv7BG9EOf+StPCrj5z8pyUP/iuN0CiwxNbzVgzYajgAvqbh+P2uFt3TC++i
uSyToujHYRBA95V9Nmiu1bfHPZMKP1peQrYvIOY1iBAhfOBIJMBDy6hWRoGqSH+i
zzFsyS66M9cgrFxkCKPI6K+rjzNoIF5gsbrJHjD//pn8RPj5LWHfQj9pelg+44WN
sjos33FW5v/YjVH/Yix2aolt4xupXb3P4J634I3XF512oxG2bi+s3HUJ2EU4AwZJ
4r+L1Xxll4s+4aPrlErHQxDiSPisd1z9nG9ALJG3bX47pCT8GzOD9kVZQPbd9oZX
qSdq6Fn+mpfupifrONGXpuucJ75uZhR1dxK5Mrwq4O4gA9UkZxc3FXueX46UogRD
tBdA8T0/ta1RS886ovM0z4flQRj5U8S8uDO+TzXpsN96FRwddioLcpHSczJKJ4Me
0Mvr9vi0ZWRLvhKz6NX3evcQehfflV1hTQOp1rYUpppegM8F0hxT+W+8kMFfmPdk
2McUrpeS
=EWvY
-----END PGP SIGNATURE-----

--=-1nYg9/8HH/nxLAHpH0fX--
