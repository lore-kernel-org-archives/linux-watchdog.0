Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACAF390601;
	Fri, 31 Jul 2026 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785492491; cv=none; b=O4ZAF/56iRgXwdW8XLoQFiRdKJwEGs7DIgDMSOdyl9L21WROr3thlVq00WPPZcCDxLlzYe1KtZntVTc0ivk5dANAbgjQBl4qn5xImfIpdkQE6O8pWRflfUox2ZEX52MV4+DH4vLVdT9+EKUrb9h1aJJlIHx06GJpdFTHkh9ECOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785492491; c=relaxed/simple;
	bh=sl+FXYBqYK9vLLLyrhRGq1IWxaVvqJl9obn6iOTd8S4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H6wm61VTfFjdsm4CZlpC9BeHD+ovlc7ZvHekSEO1EHFjhYjpP+b43DZSApacgVtCCzdIz5c5vcT3HgPO15zdbrR2WDW7XGEoTU0wjorXjkkzK2TeUqu7fYHvwFOACLRzOiyde2brLRYKvNCznwTICMWb0e5WelRYWjvcXn9NOUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0KC2jd4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0KC2jd4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F641F00A3A;
	Fri, 31 Jul 2026 10:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785492462;
	bh=ysQgmdpFFfR23d2EtlP3ee8lFYyeB9JGYuJORVyIcls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f0KC2jd4SLvKxCWG6R9eRx5ZNou6ykuNWIYQPh3Op/bLQquYGstQpJ+/+4W3pN1bf
	 cKuVui2wgu0jyEbA8MjNGJX2+e6ttB/tMgaY7fJGylG+7cnPIH0QDvADTo1OX5U6tV
	 gEkg4q83JFAQQ04jNe4P/NboprSHcaBpjEM+OObvrPpxIqn2xff4E5fNsXTCcstlJG
	 lhWxHaZMGuYJBAlq0gHitlEy2XxZ0nqffYfGn0L9tnJjW+LPQDz4YhNwbP4TrEWqrd
	 G1F7e0C9WWD7sBcKI1jaaOcFIoeRKK3wEo8HOoQ2J6VhEBsrGLGcLst+bSDJOCmbDz
	 CTSVqdNhXsX0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/5] mfd: aaeon: Add SRG-IMX8P MCU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFBlcnJvdCAoU2NobmVpZGVyIEVsZWN0cmljKQ==?= <thomas.perrot@bootlin.com>
Cc: conor+dt@kernel.org, Frank.Li@kernel.org, robh@kernel.org, imx@lists.linux.dev, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260731-dev-b4-aaeon-mcu-driver-v8-3-9ab00e80df2a@bootlin.com>
References: <20260731-dev-b4-aaeon-mcu-driver-v8-0-9ab00e80df2a@bootlin.com>
 <20260731-dev-b4-aaeon-mcu-driver-v8-3-9ab00e80df2a@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 10:07:41 +0000
Message-Id: <20260731100742.53F641F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The driver unconditionally sets the I2C_M_DMA_SAFE flag on the cal=
ler-provided val_buf in aaeon_mcu_regmap_read, bypassing the I2C core's bou=
nce buffering. If a child driver calls regmap_bulk_read() with a stack-allo=
cated buffer for a volatile register (e.g., GPIO inputs), regmap passes the=
 stack buffer directly to aaeon_mcu_regmap_read. This results in the I2C ho=
st controller performing DMA directly into a stack memory address, leading =
to cacheline sharing corruption or a kernel panic (especially on VMAP_STACK=
 configurations).
- [High] The driver implements the MCU's command-response sequence using tw=
o separate i2c_transfer() calls without explicitly locking the I2C bus. Sin=
ce i2c_transfer() internally acquires and releases the I2C adapter lock per=
 call, there is a race window between the command write and the response re=
ad. If another device driver on the same I2C bus initiates a transfer durin=
g this window, its transaction will be physically interleaved on the bus, d=
isrupting the MCU's state machine.
- [Low] The driver-specific header file aaeon-mcu.h is incorrectly placed i=
n the global include/linux/mfd/ directory, violating MFD subsystem guidelin=
es.
--

--- Patch [3]: [PATCH v8 3/5] mfd: aaeon: Add SRG-IMX8P MCU driver ---
commit 83256074ae86bd1d0d3b7e6e2bf9afe879bd3c73
Author: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>

mfd: aaeon: Add SRG-IMX8P MCU driver

This patch adds a Multi-Function Device (MFD) driver for the Aaeon
SRG-IMX8P embedded controller. It implements a custom regmap bus over
I2C to match the MCU's command format and registers child devices.

> diff --git a/drivers/mfd/aaeon-mcu.c b/drivers/mfd/aaeon-mcu.c
> new file mode 100644
> index 0000000000000..c06c99d02d648
> --- /dev/null
> +++ b/drivers/mfd/aaeon-mcu.c

[ ... ]

> +static int aaeon_mcu_regmap_write(void *context, const void *data, size_=
t count)
> +{

[ ... ]

> +	ret =3D i2c_transfer(client->adapter, &write_msg, 1);
> +	if (ret < 0)
> +		return ret;
> +	if (ret !=3D 1)
> +		return -EIO;
> +
> +	ret =3D i2c_transfer(client->adapter, &response_msg, 1);

[Severity: High]
Since i2c_transfer() internally acquires and releases the I2C adapter lock
per call, does issuing two separate transfers here leave a race window?

If another device driver on the same I2C bus initiates a transfer during
this window, its transaction could be physically interleaved on the bus.
Would it be safer to use i2c_lock_bus() and __i2c_transfer() to maintain
the lock across both the command write and response read?

> +	if (ret < 0)
> +		return ret;

[ ... ]

> +static int aaeon_mcu_regmap_read(void *context, const void *reg_buf,
> +				 size_t reg_size, void *val_buf, size_t val_size)
> +{

[ ... ]

> +	read_msg.addr  =3D client->addr;
> +	read_msg.flags =3D I2C_M_RD | I2C_M_DMA_SAFE;
> +	read_msg.buf   =3D val_buf;

[Severity: High]
Can val_buf point to a stack-allocated buffer?

When a child driver calls regmap_bulk_read() for a volatile register (like
GPIO inputs), regmap might pass a stack-allocated buffer directly to this
function. By unconditionally setting I2C_M_DMA_SAFE, doesn't this force
the I2C core to bypass bounce buffering?

If the I2C host controller then performs DMA directly into a stack memory
address, this could lead to cacheline sharing corruption or a kernel
panic, especially on VMAP_STACK configurations.

> +	read_msg.len   =3D val_size;
> +
> +	ret =3D i2c_transfer(client->adapter, &write_msg, 1);
> +	if (ret < 0)
> +		return ret;
> +	if (ret !=3D 1)
> +		return -EIO;
> +
> +	ret =3D i2c_transfer(client->adapter, &read_msg, 1);

[Severity: High]
Similar to the write path above, does releasing the I2C adapter lock
between the write command and the read response risk interleaving transfers
with other devices on the same I2C bus?

> +	if (ret < 0)
> +		return ret;

[ ... ]

> diff --git a/include/linux/mfd/aaeon-mcu.h b/include/linux/mfd/aaeon-mcu.h
> new file mode 100644
> index 0000000000000..3a1aeec85d60b
> --- /dev/null
> +++ b/include/linux/mfd/aaeon-mcu.h

[Severity: Low]
This isn't a bug, but should this driver-specific header be placed locally
in drivers/mfd/ instead of the global include/linux/mfd/ directory?

The MFD subsystem guidelines state that driver-specific header files used
only by the parent and its immediate children should be kept local to
drivers/mfd/.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dev-b4-aae=
on-mcu-driver-v8-0-9ab00e80df2a@bootlin.com?part=3D3
