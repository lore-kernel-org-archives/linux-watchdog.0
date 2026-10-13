Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B535E3DC4D3
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884274; cv=none; b=Itp23s0YawJYhQHSM5hi455+kOjYbiWlYu01DcK4gjB3b477HUkm3TCULo2iW9DIpw39E6kbgXB5+3nvNvXSDzMSSnxGztZxeYoNtqM8nCVcktY4cBWsGxRwwiTzOGOs8UQAr3KOxs6EmP9q47bRlZhXjcZT1l8TcmZ0M55d00U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884274; c=relaxed/simple;
	bh=2ayAFFb+DUz96xoDh3MBAGQTWLWO2Yi4jW89/kvabEc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UDIN5MU3IAo6iBnAgpcO2hZUxKU431Qy+z/9vUCzeZWzi9dmF+Dbv6NE7215MduNEgqevvi3iJADpreOHJATOAIpiheOtqAmzgKWUrxpOiT24cKcTyU073vLeVnTO05WAqeQob0gDsQvCqnnBcmARQ84Mh5svzTCMlKW5ktvMK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=skhEaINj; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="skhEaINj"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1E4801A11F7
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 09:37:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DC11560362;
	Tue, 13 Oct 2026 09:37:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D19F811D703F1;
	Tue, 13 Oct 2026 11:37:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791884265; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references:autocrypt;
	bh=u2mEZ3XIqrqWo6anRB/8NKALcH+wjEUwjzjiCXOic6I=;
	b=skhEaINji+2Nx23tj0+vlVC+INBRqHuBEvOpI2GawllaxCVDWyN+Qywh+0RB9mojqG1a4p
	zNXxzbsrL5xabJySIFeqzN9/VYmZrQIncPaHdPqHeBIPjgEUDvglc8xgQEnIk/LHGs3gyh
	PagqOsWmOQoAjtaciZ2Ct33NgxOXoiYalRiffBBZPlKY3ruud10NKqXDXzxpV3W//2vFjd
	z65cSTnHGG98vfUKkzOrnK/3oEGSY7lK2BJ9aMsHjClFBTbzYM/JjHeKGzO+S7O+gvLOXi
	M6IWttiBNTMYM+GuJgJFRVmNPTRgqHqUvtb06dlM/qxlNehu6ouh4Y+MnX4pNA==
Message-ID: <7d6b1e81114dd98b5ff5f2c71f577c951af14250.camel@bootlin.com>
Subject: Re: [PATCH v8 5/5] watchdog: aaeon: Add watchdog driver for
 SRG-IMX8P MCU
From: Thomas Perrot <thomas.perrot@bootlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: thomas.perrot@bootlin.com, conor+dt@kernel.org, 
	linux-watchdog@vger.kernel.org, imx@lists.linux.dev, robh@kernel.org, 
	devicetree@vger.kernel.org, Frank.Li@kernel.org
Date: Tue, 13 Oct 2026 11:37:42 +0200
In-Reply-To: <20260731100434.195B51F000E9@smtp.kernel.org>
References: <20260731-dev-b4-aaeon-mcu-driver-v8-0-9ab00e80df2a@bootlin.com>
	 <20260731-dev-b4-aaeon-mcu-driver-v8-5-9ab00e80df2a@bootlin.com>
	 <20260731100434.195B51F000E9@smtp.kernel.org>
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
	protocol="application/pgp-signature"; boundary="=-Kr1WNLVwttji5ffo0/h/"
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3


--=-Kr1WNLVwttji5ffo0/h/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, 2026-07-31 at 10:04 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [Medium] Contradiction between driver code and DT binding regarding
> timeout-sec property
> --
>=20

I=E2=80=99ll add "timeout-sec: true" to the binding and reword the descript=
ion
in v9.

Kind regards,
Thomas Perrot

> --- Patch [5]: [PATCH v8 5/5] watchdog: aaeon: Add watchdog driver
> for SRG-IMX8P MCU ---
> commit fca789df9bd6f6279b387ae274aa7dc26fa4cecd
> Author: Thomas Perrot (Schneider Electric)
> <thomas.perrot@bootlin.com>
>=20
> watchdog: aaeon: Add watchdog driver for SRG-IMX8P MCU
>=20
> Add watchdog driver for the Aaeon SRG-IMX8P embedded controller.
> This driver provides system monitoring and recovery capabilities
> through the MCU's watchdog timer.
>=20
> > diff --git a/drivers/watchdog/aaeon_mcu_wdt.c
> > b/drivers/watchdog/aaeon_mcu_wdt.c
> > new file mode 100644
> > index 0000000000000..661d14393c6ec
> > --- /dev/null
> > +++ b/drivers/watchdog/aaeon_mcu_wdt.c
> [ ... ]
> > +static int aaeon_mcu_wdt_probe(struct platform_device *pdev)
> > +{
> [ ... ]
> > +	/*
> > +	 * The MCU firmware has a fixed hardware timeout of 25
> > seconds that
> > +	 * cannot be changed. The watchdog core handles automatic
> > pinging to
> > +	 * support software timeouts longer than the hardware
> > limit. The default
> > +	 * software timeout of 240 seconds can be overridden via
> > the DT
> > +	 * timeout-sec property or the watchdog_timeout kernel
> > boot parameter.
> > +	 */
> > +	wdt->timeout =3D AAEON_MCU_WDT_TIMEOUT;
> > +	wdt->min_timeout =3D AAEON_MCU_WDT_MIN_TIMEOUT;
> > +	wdt->max_hw_heartbeat_ms =3D AAEON_MCU_WDT_HEARTBEAT_MS;
> > +	watchdog_init_timeout(wdt, timeout, dev->parent);
>=20
> [Severity: Medium]
> Will this cause device tree validation failures when users specify
> the
> timeout-sec property?
>=20
> The driver code and comment indicate that the timeout can be
> overridden via
> the DT timeout-sec property on the parent node. However, the DT
> schema for
> the parent MFD (Documentation/devicetree/bindings/mfd/aaeon,srg-
> imx8p-mcu.yaml)
> enforces additionalProperties: false and does not define the timeout-
> sec
> property.
>=20
> If a user follows the driver's instructions and adds the timeout-sec
> property
> to the MFD parent node, dtbs_check will fail. Should the timeout-sec
> property
> be added to the DT binding?

--=20
Thomas Perrot, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--=-Kr1WNLVwttji5ffo0/h/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEh0B3xqajCiMDqBIhn8ALBXH+Cu0FAmrN++YACgkQn8ALBXH+
Cu25yAv+K91gmW41FZGVkEKepYv1T/G7POoLs3EWiP9U5GngGOC8QKvVjPc4Fupu
CjOOnlXxz8oVUDziimHtPtFs36753Gd5ansCDLbnsTc22vsN7qm7cx9gU22nNiQd
+a8kt0HpMpj2nl2N1ki6AKHuLoYXM0ThY1HAgchZKt2Vfk0BtJH/EWGUBklATw5d
wEqbgjstnPL48WozVUsgo8C4kz/6Rf+t5eAOZTB6oXe+2BH4YUmUOODrL4Ylz3Kn
DinT+rxVaFRNncFoe5A7UvJjIauN5LxKjHT6yU65NRozt0Z46bevv4Sn8Xlt6AjP
Art5kFD2BWHDbvUnzpG4/9mFC1TtrgF28CftD9mTXqxWDu1peCZcZy1A8ewXm5/B
EaRUEuv/GaAucE0P0hPj33icKSsAE8S7iYgHFs6GJmaI2MbpQAE/tzQ8kxTSEJ6x
4l02V1cLmYjfYkR72mHS0VsbEpWOrjA7pfpq4ZffFOA8o01n7mUQWCbRCk3OX6uX
XD3Xxyod
=Jyec
-----END PGP SIGNATURE-----

--=-Kr1WNLVwttji5ffo0/h/--
