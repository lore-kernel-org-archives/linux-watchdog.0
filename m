Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E31404BF3;
	Tue, 30 Jun 2026 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824580; cv=none; b=FimcHfXXFnIybwTJ6XNXQKzcJVdE1xUX9HvhOAd3sI5LBljTZlhyvYNst3XUjKBgor9aLn9A0J2rhCLqaEDFouxOeP389L9KuHCgZ1IcD8PY+Eo31Z2Y97UgHfntLx7Qx8JDZ9P9Id7gWRw2v0T3sZb1BpFP+oiGJBKWIWZC4Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824580; c=relaxed/simple;
	bh=IrGvTlERqpo/3pGq5R9mKLZ2ZN7AqLblURBN09By/oM=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JPL1A/DrFGWaOm4gycpKCKP1ee2IgUpaURPaLz0yLDmfEvItyNOfjPxyZBXiYVSCrNrKMeDgAsyMX0w9I+/BzA4ggKbupS/f7iZwBGeZi+u+vRpADAchk/HIALAPPpUHskpZXRjGDwFlH0GDg1wrzFcT0Dn0IvMhyEM/ZuDGdRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6sL8uCd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6sL8uCd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D025F1F000E9;
	Tue, 30 Jun 2026 13:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782824579;
	bh=DHxZ4ly54lO+A8eesypakFR+eEoSwHj6D5C65EtfJ7s=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=U6sL8uCdHqoy1EFgRy/O2PLcbf6CqyI7Wn+RKX5nBXz+8Ay1kLUktLaeekJNh5kVR
	 MnJ8KDkDGEkNye97yDbBhL3Kt0dGQ4UnvlMdlVYLQyd9l+YbNgY8Nrb8mP3ErnZZI2
	 GIHknoNfJ7b3B/eAF+G2M+LNm5uZTqcGBsgDqFVYNWqlnqVOPLiuZGrEmaZhLqcgxD
	 fit3J/hUN2UAlsR0ttNed/Dxo1zqUInjn5mj7dVMapBgP8CV0N7a7Gbc9Q17nqABwK
	 CXCDeHhY50fx57RkWOTMZ1gpi/+Kk9lv2JcORcN9Anw/jOm2gVQYIlmeHkCowcf/Nq
	 HY1mU45C/jXMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/5] mfd: aaeon: Add SRG-IMX8P MCU driver
Reply-To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org, linux-watchdog@vger.kernel.org, imx@lists.linux.dev, robh@kernel.org
In-Reply-To: <20260630-dev-b4-aaeon-mcu-driver-v6-3-d66b5fcbd2f0@bootlin.com>
References: <20260630-dev-b4-aaeon-mcu-driver-v6-0-d66b5fcbd2f0@bootlin.com>
 <20260630-dev-b4-aaeon-mcu-driver-v6-3-d66b5fcbd2f0@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 13:02:58 +0000
Message-Id: <20260630130258.D025F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Heap buffer overflow in `aaeon_mcu_regmap_write()` due to unconstr=
ained write sizes during bulk writes.
- [High] Unsafe use of `I2C_M_DMA_SAFE` with caller-supplied buffers causes=
 DMA mapping of stack memory in `aaeon_mcu_regmap_read()`.
- [High] DMA cacheline corruption due to `devm_kzalloc()` usage for I2C DMA=
 buffers.
- [Medium] I2C bus lock is dropped between write and read phases of a singl=
e MCU command, breaking atomicity.
--

commit aa13d82b96cec6318efcd3d2b062f9b98afc3a61
Author: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>

mfd: aaeon: Add SRG-IMX8P MCU driver
   =20
Add Multi-Function Device (MFD) driver for the Aaeon SRG-IMX8P
embedded controller. This driver provides the core I2C communication
interface and registers child devices (GPIO and watchdog controllers).

> diff --git a/drivers/mfd/aaeon-mcu.c b/drivers/mfd/aaeon-mcu.c
> new file mode 100644
> index 0000000000000..306aaac1bd60c
> --- /dev/null
> +++ b/drivers/mfd/aaeon-mcu.c

[ ... ]

> +static int aaeon_mcu_regmap_write(void *context, const void *data, size_=
t count)
> +{
> +	struct aaeon_mcu *mcu =3D context;
> +	struct i2c_client *client =3D mcu->client;
> +	struct i2c_msg write_msg;
> +	/* The MCU always sends a response byte after each command; discard it.=
 */
> +	struct i2c_msg response_msg;
> +	int ret;
> +
> +	memcpy(mcu->cmd, data, count);

[Severity: High]
Does this code overflow the mcu->cmd buffer if a bulk write is triggered?

The mcu->cmd buffer is strictly allocated with a length of 3 bytes.
If a bulk write occurs (e.g., via regcache_sync() or regmap debugfs), the
count could exceed 3 bytes.

Could the aaeon_mcu_regmap_config missing .use_single_write =3D true allow
these bulk writes to occur?

> +
> +	write_msg.addr  =3D client->addr;
> +	write_msg.flags =3D I2C_M_DMA_SAFE;
> +	write_msg.buf   =3D mcu->cmd;
> +	write_msg.len   =3D count;
> +
> +	response_msg.addr  =3D client->addr;
> +	response_msg.flags =3D I2C_M_RD | I2C_M_DMA_SAFE;
> +	response_msg.buf   =3D mcu->response;
> +	response_msg.len   =3D 1;
> +
> +	ret =3D i2c_transfer(client->adapter, &write_msg, 1);
> +	if (ret < 0)
> +		return ret;
> +	if (ret !=3D 1)
> +		return -EIO;
> +
> +	ret =3D i2c_transfer(client->adapter, &response_msg, 1);

[Severity: Medium]
Could this sequence of two separate i2c_transfer() calls cause the MCU
command phases to be interleaved with other bus traffic?

The I2C bus lock is dropped between the write phase and the response read
phase.

If another I2C device shares the bus, can its transfers interleave here and
break the atomicity of the MCU command?

> +	if (ret < 0)
> +		return ret;
> +	if (ret !=3D 1)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int aaeon_mcu_regmap_read(void *context, const void *reg_buf,
> +				 size_t reg_size, void *val_buf, size_t val_size)
> +{
> +	struct aaeon_mcu *mcu =3D context;
> +	struct i2c_client *client =3D mcu->client;
> +	struct i2c_msg write_msg;
> +	struct i2c_msg read_msg;
> +	int ret;
> +
> +	/*
> +	 * reg_buf holds the 2-byte big-endian register address [opcode, arg].
> +	 * Append a trailing 0x00 to form the full 3-byte MCU command.
> +	 */
> +	mcu->cmd[0] =3D ((u8 *)reg_buf)[0];
> +	mcu->cmd[1] =3D ((u8 *)reg_buf)[1];
> +	mcu->cmd[2] =3D 0x00;
> +
> +	write_msg.addr  =3D client->addr;
> +	write_msg.flags =3D I2C_M_DMA_SAFE;
> +	write_msg.buf   =3D mcu->cmd;
> +	write_msg.len   =3D AAEON_MCU_CMD_LEN;
> +
> +	read_msg.addr  =3D client->addr;
> +	read_msg.flags =3D I2C_M_RD | I2C_M_DMA_SAFE;
> +	read_msg.buf   =3D val_buf;

[Severity: High]
Is it safe to flag a caller-supplied buffer with I2C_M_DMA_SAFE here?

If a child driver or the regmap core passes a stack-allocated buffer for
val_buf (e.g., during regmap_bulk_read()), tagging it with I2C_M_DMA_SAFE
bypasses the I2C core's bounce buffers.

Could this cause a kernel panic due to a DMA API violation on architectures
with virtually mapped stacks?

> +	read_msg.len   =3D val_size;
> +
> +	ret =3D i2c_transfer(client->adapter, &write_msg, 1);
> +	if (ret < 0)
> +		return ret;
> +	if (ret !=3D 1)
> +		return -EIO;
> +
> +	ret =3D i2c_transfer(client->adapter, &read_msg, 1);

[Severity: Medium]
Similarly to the write path, could dropping the I2C adapter lock between
the write_msg and read_msg transfers allow other traffic to interrupt the
sequence?

> +	if (ret < 0)
> +		return ret;
> +	if (ret !=3D 1)
> +		return -EIO;
> +
> +	return 0;
> +}

[ ... ]

> +static int aaeon_mcu_probe(struct i2c_client *client)
> +{
> +	struct aaeon_mcu *ddata;
> +	struct regmap *regmap;
> +
> +	ddata =3D devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	ddata->client =3D client;
> +
> +	ddata->cmd =3D devm_kzalloc(&client->dev, AAEON_MCU_CMD_LEN * sizeof(*d=
data->cmd),
> +				   GFP_KERNEL);

[Severity: High]
Does allocating the DMA buffers with devm_kzalloc() cause cacheline
corruption?

Since devres allocations prepend a hidden struct devres header which is not
padded to ARCH_DMA_MINALIGN, the returned buffer can share a cacheline
with this header.

During I2C DMA transactions on non-cache-coherent architectures, could the
cacheline invalidation destroy concurrent CPU writes to the devres header?

> +	if (!ddata->cmd)
> +		return -ENOMEM;
> +
> +	ddata->response =3D devm_kzalloc(&client->dev, sizeof(*ddata->response)=
, GFP_KERNEL);
> +	if (!ddata->response)
> +		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-dev-b4-aae=
on-mcu-driver-v6-0-d66b5fcbd2f0@bootlin.com?part=3D3
