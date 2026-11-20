Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160168;
	b=VZWye+cvOC04KYgdABWRF6aKxQNYcSsn3qBPS1KEdEseSWqIWg/1tS3WdXV3Ev0SGBWy
	 APjMaWE/vcLl3XCEYREQnKtYnBeto2QSuiLYMMcuF44IdCqK/lOnO4orrI5MT4TqEwixY
	 vWwhKSbw4pZB8X+uYsepUWNxre4zSLOLIYnFh5pUcPO2+fkRDYDP3SXQyZAia021m3aRM
	 RBsZNogJH+yPeE8nnFm/523YYw8dgmJsOhqDoA2E/SBhuBb5p325nqK6M95VIEw1iGq/N
	 UHfINF1XB6S6MFic/5dnnazR8Gfndk62PqWil4j6/fZMfNz2xJl3AY/yxY/i64Afb1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160168;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fZ2a/u1Yu8y3ckl9ttzxLCQiCCtp9LfUIdcTGLAvjBI=;
	b=HD3qXyOhBVBB/YFjSaavHxTWfPsjaSF5EOJQWxvJ8oa2xeVeglxiKhSuleRZ6ulyYbOm
	 /+4+wl+ZKjsRms4HS9GnyGFQBJaQZIJLwpzCqCicW/Wog0hH3QyR7gjBlZfjTi6AKlZza
	 I3QU81KN6GrcOFwzv9SaY+EAWc87/+w1+DxdnVKi2MiSXqPPPDvN1pVG7tqAP5Lt54miF
	 6NaW1OQDIi7JidQIRVHc7ZepYyLy69St/kjMYeXCrWKMLWpDr31XEDtoWKsvyfwQtVCLw
	 d1CF0LGaxFHb8U3DZ/a5u20vnparv80TQzriHGPVlFObDlSiQE4brDyYU8B2EWPSZ1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQvGsENl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F407606A325;
	Fri, 20 Nov 2026 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQvGsENl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1C01F000C4;
	Fri, 20 Nov 2026 07:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795160167;
	bh=fZ2a/u1Yu8y3ckl9ttzxLCQiCCtp9LfUIdcTGLAvjBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SQvGsENl5ZOFCnFqwqN2mrl6NJqcelQoQ0eiinQ2DTLstpfHuLJvpnvYMPZSogfK6
	 Q7smk+2lAGgsHBU0usvb+3MCeYbqengamoeATm9uz+QiysrpDX+dKnKHoe9etYVJks
	 6i0Wc6gGmYgVR3SQJbXJiekOPmiPYn174Vudr4xfqGC5ww1H+214D0cP8RuseAv8hf
	 +7xCRqFWTdeAsycgnHiBsEtErdOYYglLOLKd2gbvsH4EkJ4i0fZU9fPPtsXmWkEv+B
	 DIuGJDqqgn37+4gheULiwzw43GgzSr4D7vi42S+O1tuiWXc/FYJvIaytdn7QCjxiS8
	 3uVJpioj4ffOw==
Message-ID: <sashiko-outbox-224633@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/5] mfd: aaeon: Add SRG-IMX8P MCU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFBlcnJvdCAoU2NobmVpZGVyIEVsZWN0cmljKQ==?= <thomas.perrot@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, imx@lists.linux.dev, linux-watchdog@vger.kernel.org, mfd@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org, lee@kernel.org
In-Reply-To: <20261120-dev-b4-aaeon-mcu-driver-v10-3-a756687e7997@bootlin.com>
References: <20261120-dev-b4-aaeon-mcu-driver-v10-0-a756687e7997@bootlin.com>
 <20261120-dev-b4-aaeon-mcu-driver-v10-3-a756687e7997@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 07:36:06 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] mfd: aaeon: unbounded GPIO argument in aaeon_mcu_volatile_reg()
--

commit 3bd6a7daf3a3071df36fa41d3683d38fca074776
Author: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>

mfd: aaeon: Add SRG-IMX8P MCU driver

This commit adds an MFD driver for the Aaeon SRG-IMX8P embedded controller,
providing a custom I2C regmap bus and registering GPIO and watchdog child
devices.

> diff --git a/drivers/mfd/aaeon-mcu.c b/drivers/mfd/aaeon-mcu.c
> new file mode 100644
> index 0000000000000..83a63e0b73739
> --- /dev/null
> +++ b/drivers/mfd/aaeon-mcu.c

[ ... ]

> +static bool aaeon_mcu_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	/*
> +	 * GPIO input registers are driven by external signals and can change
> +	 * at any time without CPU involvement, always read from hardware.
> +	 *
> +	 * The watchdog status register reflects hardware state and can change
> +	 * autonomously.
> +	 *
> +	 * All other registers are written by the driver and their values are
> +	 * stable, so they can be safely cached.
> +	 */
> +	if (AAEON_MCU_REG_OPCODE(reg) =3D=3D AAEON_MCU_READ_GPIO_OPCODE)
> +		return true;
> +	if (reg =3D=3D AAEON_MCU_WDT_STATUS_REG)
> +		return true;
> +	return false;
> +}
> +
> +static bool aaeon_mcu_readable_reg(struct device *dev, unsigned int reg)
> +{
> +	/*
> +	 * Every opcode but the GPIO input read and the watchdog status is a
> +	 * command: the frame sent for a read is identical to the one used to
> +	 * write it, so reading such a register would execute the command.
> +	 * Only the registers reflecting hardware state may be read.
> +	 */
> +	return aaeon_mcu_volatile_reg(dev, reg);
> +}

[Severity: Low]
Should aaeon_mcu_volatile_reg() bound the low-byte GPIO argument for
AAEON_MCU_READ_GPIO_OPCODE to the valid GPIO index range (0x00..0x0b)?

AAEON_MCU_MAX_REGISTER is AAEON_MCU_REG(0x77, 0x0B), so regmap debugfs
scans the entire 0x7200..0x72ff range.  Because aaeon_mcu_readable_reg()
delegates to aaeon_mcu_volatile_reg() and only the opcode byte is checked,
reading the debugfs registers file issues I2C READ_GPIO transfers for
non-existent GPIO arguments 0x0c..0xff.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-dev-b4-aae=
on-mcu-driver-v10-0-a756687e7997@bootlin.com?part=3D3
