Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9278E449EA6;
	Mon, 29 Jun 2026 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749110; cv=none; b=OHgL5I8xrnSIdqFXeaBNM5rceYTciCQmGiTbsAoU7KK20veSJZL3QC8DN+fQzba2GD0sOjcOKZymgYWHQqhGq9prl3Sz0szLIfdmoj/Jn3D/7dp9mEO4f6u0hS0PLhC67bCwbANUerJafwJ+CiYAo3cT3GUtiPUchioX3jZxvA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749110; c=relaxed/simple;
	bh=2CqpLrxkdTX7sOcbrrrZvxIln4gPdG+c93HFcDXzXnk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=so/D4YuP6KNl1GTu4EU0HN0LkFYx3GwpepKDLCQaWSSCGSeeguEISaFzZV29cmtdeYNy27QUh3c7OhKhbnW3v6pkarymqXuezH6LqnM+QuDJ8avDf19Vosi6H8hE52+fPxXjsNwYLVUlYOkB5f+rFS0Cp1REX2yuBluDYZ1y10M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZR26Xpj/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZR26Xpj/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 193F41A0C78;
	Mon, 29 Jun 2026 16:05:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CC0055FF96;
	Mon, 29 Jun 2026 16:05:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5043D106F1820;
	Mon, 29 Jun 2026 18:04:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782749105; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references:autocrypt;
	bh=JEjXI5ld7Y55/QqO5968kb9+2z9CP3Ygxw7dHEqom5Q=;
	b=ZR26Xpj/h2bjGnEy0rXxSf8ycA92obShxrsaA50vA52kd8FsTZE7hKWfj45lwvmZ0vpUD+
	CpUIgwZajjKpABmCqVzPtvHNToTYZULmlCgJYH50mOCHNklr/7EFWhOaikdFBh4Asl8OyU
	ch7IkaMi7YQgKppWdOiA9MnUOIFrKhNQ/8iVMwky19S30P9iMhDCVsHpzHaMYDQioTGKdE
	4Qt14sxoTHE31GtL7MuzaQVQmQQGxXKg9k/haUnxCq1MCHxk2Vl9MQvubsKjWKosHUr+pL
	zTWVID89XRmUAVM8XXdJQ+NDg2WpDuH7fDRsVGlLBIroIO52qb4o5+WJWqRxkw==
Message-ID: <31477953aace52bb6594461e82ddf99493af2329.camel@bootlin.com>
Subject: Re: [PATCH v5 0/5] Add support for AAEON SRG-IMX8P MCU
From: Thomas Perrot <thomas.perrot@bootlin.com>
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij	 <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Shawn Guo	 <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 =?ISO-8859-1?Q?J=E9r=E9mie?= Dautheribes <jeremie.dautheribes@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Lee Jones	 <lee@kernel.org>
Cc: "thomas.perrot@bootlin.com" <thomas.perrot@bootlin.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>, Conor Dooley
 <conor.dooley@microchip.com>,  Bartosz Golaszewski
 <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 18:04:59 +0200
In-Reply-To: <b4396f57-3501-4e89-9cf3-8dc5d7cad9b7@roeck-us.net>
References: <20260408-dev-b4-aaeon-mcu-driver-v5-0-ad98bd481668@bootlin.com>
							 <b4396f57-3501-4e89-9cf3-8dc5d7cad9b7@roeck-us.net>
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
	protocol="application/pgp-signature"; boundary="=-yncApkmTxr+3zEDpopn/"
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3


--=-yncApkmTxr+3zEDpopn/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Guenter,

On Sat, 2026-04-11 at 17:12 -0700, Guenter Roeck wrote:
> snip
>=20
> Sashiko has some interesting feedback that might be worth looking
> into.
>=20
> https://sashiko.dev/#/patchset/20260408-dev-b4-aaeon-mcu-driver-v5-0-ad98=
bd481668%40bootlin.com
>=20

Thanks for the pointer. I went through all findings and addressed the
  valid ones in v6:

  MFD driver:
   - Set I2C_M_DMA_SAFE on all i2c_msg flags. The buffers were already
     heap-allocated for DMA safety but the flag was missing, which
     would have caused unnecessary bounce-buffering by the host driver.
   - Add select REGMAP to config MFD_AAEON_MCU
   - "Kconfig COMPILE_TEST link failure": I2C || COMPILE_TEST lets
     MFD_AAEON_MCU=3Dy even when I2C=3Dm (tristate OR caps to y), which
     would fail to link since i2c_transfer(), only exist when I2C
     itself is built in. Will drop the COMPILE_TEST escape and just use
     depends on I2C, matching the other I2C MFD drivers in this file.

  GPIO driver:
   - Replace __set_bit/__clear_bit/__assign_bit with their atomic
     counterparts. gpiolib does not serialize across pins, so
     concurrent direction changes on different pins could race on the
     shared bitmaps.
   - Reverse the order in aaeon_mcu_gpio_config_output_cmd(): write the
     output value first, then switch the pin to output mode, to avoid a
     potential glitch if the previously latched value differs.
   - Add MODULE_ALIAS("platform:aaeon-mcu-gpio") for udev auto-loading.

  Watchdog driver:
   - Add WDIOF_SETTIMEOUT and watchdog_init_timeout() so the software
     timeout is configurable via ioctl, DT timeout-sec, or the
     watchdog_timeout boot parameter. This also addresses the concern
     you raised about the hardcoded 240s timeout.
   - Add watchdog_stop_on_reboot() so the MCU watchdog is stopped
     during system shutdown, preventing a spurious reset from the
     external MCU.
   - Add MODULE_ALIAS("platform:aaeon-mcu-wdt") for udev auto-loading.

  The following findings were considered false positives:

   - "Heap buffer overflow during bulk writes": with reg_bits=3D16 and
     val_bits=3D8, regcache_sync() calls _regmap_write() per register, so
     the write callback always receives exactly 3 bytes (2 reg + 1
val).
     No bulk path reaches the custom bus callback.

   - "Stack DMA violation in read path": val_buf comes from regmap's
own
     heap-allocated work_buf, not a stack pointer, so DMA safety is
     guaranteed by the regmap core.

   - "I2C interleaving race": Concurrent access from child drivers
     (GPIO and watchdog) is serialized by regmap's internal mutex,
     which is held for the entire bus transaction ; both i2c_transfer()
     calls complete under that lock before another caller can enter.

   - "Missing PM suspend/resume callbacks": the watchdog core already
     handles this via watchdog_pm_ops, which calls wdt->ops->stop() on
     system suspend.

Kind regards,
Thomas


> Guenter
>=20

--=20
Thomas Perrot, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--=-yncApkmTxr+3zEDpopn/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEh0B3xqajCiMDqBIhn8ALBXH+Cu0FAmpCl6sACgkQn8ALBXH+
Cu3gtwv/WZRg+KDlEazT/qmm8H0EzbCYvvDakncblFOk6oJq75kaC7outXtOGBPs
RK5rwW7VB2GP37sLS2vrA+JhrJ4gUgY53HnLtpgZhYgV5q449bqqb/8VGSBFYvw/
CBdvzUlHzP4zA6fxilChd6n8LVFAvxNLMe+wzm5iq8Q5687omtSQG6/Z1DDy/RHo
B8xahs7i3PGGPoWD3TQXKptPBfMBuZHZb391TGsWs4dmG7JLi1QTM1Z30NBRY3ov
CQfyzsvn44wcFZosCgWBVtM8n6UZZrIpuUtq/EbRFnk7UzdNB7Tv025plUbXJbRV
cuKEFUs1DaW7Rlv4DL6Q2sV0DeoLYM24/7Tac7txF4D+8Caqd4u8QPtlqpWmzMfI
HbHdcQB3sIkbGvVn4wNxmzKNgGqjOUs+p/UqwVhb7w9B7W7DxuH5gTswBWBo2X9O
vx+YKBejGUw52tqYkAedq8Xi+KwwFwWI5oP2wa/cOmP4YHn1jabk0DCIGmlKfxlj
hKzlP3Xi
=aAXr
-----END PGP SIGNATURE-----

--=-yncApkmTxr+3zEDpopn/--
