Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003773D5226;
	Fri, 31 Jul 2026 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785492295; cv=none; b=MsNIbgPvA4hTiAmROFMnZFJ8v+150tHOyMwANryseCzyl04BoyrHDK0UmcLUFJrinPnubeXdgRW2DMNTGgA/uTyTkyH5WgpJ98HjHy5J1rLNwGJtlvg9WmRrj/Vha3LicAaqqBuO3iIwFciJuVZuPN38cUvee6ldnfMqoI2BCxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785492295; c=relaxed/simple;
	bh=UGp3mgwKTZriJ/82sXDb5ZSKo3SNkGhvJarXt7DI+v8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DvgpiNDU8LLo/6cAePHc8yeutrk92O542NBbGYen6t5sU/fN+RuEqMJGuhSOO5xFqLhySHvD5+cHVJ5N24H0mAAEJ6/2hsdDWSix+3tW6CVZ0yMwPlJbB8yLv6csheMBTaraM6gFsjXTeyamen/MXWWw+WDsUHlxIhV7Rc29W64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvulSN0Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvulSN0Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195B51F000E9;
	Fri, 31 Jul 2026 10:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785492274;
	bh=mTalOiEQc0ahA4xC8niZMvvA4d3htX/Y4LcJCdrVYMQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FvulSN0QeIGcobjNQrJofNrPCVcd5sJIQrMD5cySSere7oyTVNLx8Wy2GkDDtRhgg
	 7KHt4ixVvAgXQap+G47KzPvNJ/W1Qq+yGhgf3sJpnSiIUZlQrov0W6K5QaXwaNA1q/
	 EId9XkUZz3qcgYgXEMvVTES0VabucYLXxrIzMoXoKQO57Nml5wlOhU9u1CZV+BrcJ2
	 GrdeQD/TmoAYAM2aSXNX5epfS5So2t5yQm4zKE20kCx3dBrLBvkMuBHa7w7rxjvfvE
	 Q8NAEcgZ3EHxIFh8f3cVb9gfs4kM+j9OKSz9xDtRIpq4y0F3VddgQrB2W8kAV+XS7f
	 QFARYr0DdDUrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/5] watchdog: aaeon: Add watchdog driver for
 SRG-IMX8P MCU
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFBlcnJvdCAoU2NobmVpZGVyIEVsZWN0cmljKQ==?= <thomas.perrot@bootlin.com>
Cc: conor+dt@kernel.org, linux-watchdog@vger.kernel.org, imx@lists.linux.dev, robh@kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260731-dev-b4-aaeon-mcu-driver-v8-5-9ab00e80df2a@bootlin.com>
References: <20260731-dev-b4-aaeon-mcu-driver-v8-0-9ab00e80df2a@bootlin.com>
 <20260731-dev-b4-aaeon-mcu-driver-v8-5-9ab00e80df2a@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 10:04:33 +0000
Message-Id: <20260731100434.195B51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Contradiction between driver code and DT binding regarding timeo=
ut-sec property
--

--- Patch [5]: [PATCH v8 5/5] watchdog: aaeon: Add watchdog driver for SRG-=
IMX8P MCU ---
commit fca789df9bd6f6279b387ae274aa7dc26fa4cecd
Author: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>

watchdog: aaeon: Add watchdog driver for SRG-IMX8P MCU

Add watchdog driver for the Aaeon SRG-IMX8P embedded controller.
This driver provides system monitoring and recovery capabilities
through the MCU's watchdog timer.

> diff --git a/drivers/watchdog/aaeon_mcu_wdt.c b/drivers/watchdog/aaeon_mc=
u_wdt.c
> new file mode 100644
> index 0000000000000..661d14393c6ec
> --- /dev/null
> +++ b/drivers/watchdog/aaeon_mcu_wdt.c
[ ... ]
> +static int aaeon_mcu_wdt_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	/*
> +	 * The MCU firmware has a fixed hardware timeout of 25 seconds that
> +	 * cannot be changed. The watchdog core handles automatic pinging to
> +	 * support software timeouts longer than the hardware limit. The default
> +	 * software timeout of 240 seconds can be overridden via the DT
> +	 * timeout-sec property or the watchdog_timeout kernel boot parameter.
> +	 */
> +	wdt->timeout =3D AAEON_MCU_WDT_TIMEOUT;
> +	wdt->min_timeout =3D AAEON_MCU_WDT_MIN_TIMEOUT;
> +	wdt->max_hw_heartbeat_ms =3D AAEON_MCU_WDT_HEARTBEAT_MS;
> +	watchdog_init_timeout(wdt, timeout, dev->parent);

[Severity: Medium]
Will this cause device tree validation failures when users specify the
timeout-sec property?

The driver code and comment indicate that the timeout can be overridden via
the DT timeout-sec property on the parent node. However, the DT schema for
the parent MFD (Documentation/devicetree/bindings/mfd/aaeon,srg-imx8p-mcu.y=
aml)
enforces additionalProperties: false and does not define the timeout-sec
property.

If a user follows the driver's instructions and adds the timeout-sec proper=
ty
to the MFD parent node, dtbs_check will fail. Should the timeout-sec proper=
ty
be added to the DT binding?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dev-b4-aae=
on-mcu-driver-v8-0-9ab00e80df2a@bootlin.com?part=3D5
