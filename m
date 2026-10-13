Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0198B3B05A4
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883413; cv=none; b=m58LXn6VFYDfpAZEB7dvueasApDPE7A3mmlkZgI0+3Dw4W3r14ydoDAmvTSDm/Qua32YCQyESKOR7nMy2Dh2x/TtunVF/bPrHMvqbRJQfkzX44TbFeE/OhIVZDbaLvQj/oavm6T66HgCsIIE2zJpnex4S7XRAjFGpyXf0/N6w4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883413; c=relaxed/simple;
	bh=KJBT1sJVmV0yG3/+Ov+fj0LOXlBa7KDH9hD5vMGCIdU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p+7+AzPMLu1AQfaA7dKqMMmWtXxoxMYRBTqXYVYeWkBCFLpOg9RYd8+YYssBQvzZBmm5IljUv71Nw7Mjzk8f6nrWj7uqL38kGmo6If77Grlt3Fxza4g1oOD/kt3yMWSZ4RxYG6jQPZgUVFrEIkZ9pI6s1oPH1bXLemfliCD2toQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CcucAUwQ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CcucAUwQ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6B70F4E411A5;
	Tue, 13 Oct 2026 09:23:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 382E160362;
	Tue, 13 Oct 2026 09:23:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F34A011D70DCF;
	Tue, 13 Oct 2026 11:23:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791883407; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references:autocrypt;
	bh=GVVyGjCCMj65Kp5EaL4cVp6o5zOIowOFcg4eacDgwZM=;
	b=CcucAUwQRQimzTD3Y2Os7xMPBGCH3jw/b/ulnl5hZSt1bQF04YYNaBzDJ9AcxdiX0aDucb
	k2LdFRzB1+9YASe2ZBWOBLKRgrK7CfbQuf9ZvHG6keGf7a/sdtF1uyC+8CtcVr66/C3tvE
	ZOD4NzCgZf6YbSP5dhalo13E6lxjdl7tlWEeI8CIO/tksA+OC4ZloYbbqCIHOYfiHg33hW
	XlkQ9tNZZakYuCD+9SC+CryGss6XxhJJImMy+gnMCcohc1p2Nge9Npe2MSSD2vGzSRtF39
	1/wIvRXPUpR/MSlcXPRnPoKpAsto8Zr4ULRSmKF8xnSm9zaZVx0g7i/DdR74Ig==
Message-ID: <69083881b86150b3d0e3e3d255e41f10186c4f14.camel@bootlin.com>
Subject: Re: [PATCH v8 3/5] mfd: aaeon: Add SRG-IMX8P MCU driver
From: Thomas Perrot <thomas.perrot@bootlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: thomas.perrot@bootlin.com, conor+dt@kernel.org, Frank.Li@kernel.org, 
	robh@kernel.org, imx@lists.linux.dev, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, lee@kernel.org
Date: Tue, 13 Oct 2026 11:23:24 +0200
In-Reply-To: <20260731100742.53F641F00A3A@smtp.kernel.org>
References: <20260731-dev-b4-aaeon-mcu-driver-v8-0-9ab00e80df2a@bootlin.com>
	 <20260731-dev-b4-aaeon-mcu-driver-v8-3-9ab00e80df2a@bootlin.com>
	 <20260731100742.53F641F00A3A@smtp.kernel.org>
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
	protocol="application/pgp-signature"; boundary="=-vDWV5RZ3wDUzbOBPhiV1"
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3


--=-vDWV5RZ3wDUzbOBPhiV1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, 2026-07-31 at 10:07 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
> - [High] The driver unconditionally sets the I2C_M_DMA_SAFE flag on
> the caller-provided val_buf in aaeon_mcu_regmap_read, bypassing the
> I2C core's bounce buffering. If a child driver calls
> regmap_bulk_read() with a stack-allocated buffer for a volatile
> register (e.g., GPIO inputs), regmap passes the stack buffer directly
> to aaeon_mcu_regmap_read. This results in the I2C host controller
> performing DMA directly into a stack memory address, leading to
> cacheline sharing corruption or a kernel panic (especially on
> VMAP_STACK configurations).

I agreed. The read path now reads into the driver's DMA-safe response
buffer and copies the byte out, so a caller-supplied buffer is never
marked DMA-safe ; It will be fixed into the v9.

> - [High] The driver implements the MCU's command-response sequence
> using two separate i2c_transfer() calls without explicitly locking
> the I2C bus. Since i2c_transfer() internally acquires and releases
> the I2C adapter lock per call, there is a race window between the
> command write and the response read. If another device driver on the
> same I2C bus initiates a transfer during this window, its transaction
> will be physically interleaved on the bus, disrupting the MCU's state
> machine.

The MCU needs a STOP between command and response, hence two transfers.
They are now issued under a single i2c_lock_bus()/__i2c_transfer()
section so nothing can be interleaved.

> - [Low] The driver-specific header file aaeon-mcu.h is incorrectly
> placed in the global include/linux/mfd/ directory, violating MFD
> subsystem guidelines.

It doesn=E2=80=99t seem relevant because the header is shared by drivers/gp=
io
and drivers/watchdog, so it can=E2=80=99t be local to drivers/mfd/.

Kind regards,
Thomas Perrot

> --
>=20
> --- Patch [3]: [PATCH v8 3/5] mfd: aaeon: Add SRG-IMX8P MCU driver --
> -
> commit 83256074ae86bd1d0d3b7e6e2bf9afe879bd3c73
> Author: Thomas Perrot (Schneider Electric)
> <thomas.perrot@bootlin.com>
>=20
> mfd: aaeon: Add SRG-IMX8P MCU driver
>=20
> This patch adds a Multi-Function Device (MFD) driver for the Aaeon
> SRG-IMX8P embedded controller. It implements a custom regmap bus over
> I2C to match the MCU's command format and registers child devices.
>=20
> > diff --git a/drivers/mfd/aaeon-mcu.c b/drivers/mfd/aaeon-mcu.c
> > new file mode 100644
> > index 0000000000000..c06c99d02d648
> > --- /dev/null
> > +++ b/drivers/mfd/aaeon-mcu.c
>=20
> [ ... ]
>=20
> > +static int aaeon_mcu_regmap_write(void *context, const void *data,
> > size_t count)
> > +{
>=20
> [ ... ]
>=20
> > +	ret =3D i2c_transfer(client->adapter, &write_msg, 1);
> > +	if (ret < 0)
> > +		return ret;
> > +	if (ret !=3D 1)
> > +		return -EIO;
> > +
> > +	ret =3D i2c_transfer(client->adapter, &response_msg, 1);
>=20
> [Severity: High]
> Since i2c_transfer() internally acquires and releases the I2C adapter
> lock
> per call, does issuing two separate transfers here leave a race
> window?
>=20
> If another device driver on the same I2C bus initiates a transfer
> during
> this window, its transaction could be physically interleaved on the
> bus.
> Would it be safer to use i2c_lock_bus() and __i2c_transfer() to
> maintain
> the lock across both the command write and response read?
>=20
> > +	if (ret < 0)
> > +		return ret;
>=20
> [ ... ]
>=20
> > +static int aaeon_mcu_regmap_read(void *context, const void
> > *reg_buf,
> > +				 size_t reg_size, void *val_buf,
> > size_t val_size)
> > +{
>=20
> [ ... ]
>=20
> > +	read_msg.addr=C2=A0 =3D client->addr;
> > +	read_msg.flags =3D I2C_M_RD | I2C_M_DMA_SAFE;
> > +	read_msg.buf=C2=A0=C2=A0 =3D val_buf;
>=20
> [Severity: High]
> Can val_buf point to a stack-allocated buffer?
>=20
> When a child driver calls regmap_bulk_read() for a volatile register
> (like
> GPIO inputs), regmap might pass a stack-allocated buffer directly to
> this
> function. By unconditionally setting I2C_M_DMA_SAFE, doesn't this
> force
> the I2C core to bypass bounce buffering?
>=20
> If the I2C host controller then performs DMA directly into a stack
> memory
> address, this could lead to cacheline sharing corruption or a kernel
> panic, especially on VMAP_STACK configurations.
>=20
> > +	read_msg.len=C2=A0=C2=A0 =3D val_size;
> > +
> > +	ret =3D i2c_transfer(client->adapter, &write_msg, 1);
> > +	if (ret < 0)
> > +		return ret;
> > +	if (ret !=3D 1)
> > +		return -EIO;
> > +
> > +	ret =3D i2c_transfer(client->adapter, &read_msg, 1);
>=20
> [Severity: High]
> Similar to the write path above, does releasing the I2C adapter lock
> between the write command and the read response risk interleaving
> transfers
> with other devices on the same I2C bus?
>=20
> > +	if (ret < 0)
> > +		return ret;
>=20
> [ ... ]
>=20
> > diff --git a/include/linux/mfd/aaeon-mcu.h
> > b/include/linux/mfd/aaeon-mcu.h
> > new file mode 100644
> > index 0000000000000..3a1aeec85d60b
> > --- /dev/null
> > +++ b/include/linux/mfd/aaeon-mcu.h
>=20
> [Severity: Low]
> This isn't a bug, but should this driver-specific header be placed
> locally
> in drivers/mfd/ instead of the global include/linux/mfd/ directory?
>=20
> The MFD subsystem guidelines state that driver-specific header files
> used
> only by the parent and its immediate children should be kept local to
> drivers/mfd/.

--=20
Thomas Perrot, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--=-vDWV5RZ3wDUzbOBPhiV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEh0B3xqajCiMDqBIhn8ALBXH+Cu0FAmrN+IwACgkQn8ALBXH+
Cu15OAv8DcnpwTIEMtCFei2MW1N+Evxc89rVwDGImWNGHWmVadYOa6WTkZkxv1LP
zAAX87pOatolaRpBiVYFkaZC97l6/Osbc2epIsMmz5y26i0Ob/XzHLWGtfxRx/0v
lctv4bn5LKczU2kddYxOVYr3gcyRsarQ14jiWWqQumUhnyREw6EHW03u0WPXTYh1
JFfFqo+8ipjAYEpJ9114iaROGC89x6W+vDRKhsmdlDOXi+YAI21cs+AxGKOy74ax
SQv3NMjHjXgM6JefefWqGIHhi8RcdL6u/vLUdG/91TFLa9Ye0erlTGqU2/6Clp0N
LK076y55VY25wunA3vpmJJiYyOzN8l2cSTxq5nEqbUFzDwn64cILUdhuy/TNOtSi
JOw2WyBEQ5Hl4cct+pR2fAhTfuzleppk7NesiFfdGVCB7WXI5V8SZ9otFsAhb6im
CzyCemZ7wpD1sP31t42EWISzZikFVOQstv7CPj1llyvOSYXS1Pyk4r6n+gxugBTQ
4hPhw+KK
=6ZUt
-----END PGP SIGNATURE-----

--=-vDWV5RZ3wDUzbOBPhiV1--
