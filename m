Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9BE41C2EA;
	Tue, 30 Jun 2026 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782825566; cv=none; b=iJH60BAANO1UJUwCw0ha+jUQERn+3e6DK+cJoqYBlxGy2BnyHM77/Y/9rw92uUczeR6MthK3mPGNhssyY1OaZ55kO7L1hKykz34DlxUgoRA5uceGvd93m0/oVAxYxFd1uw5DDzH+2M4DHibYJB5uERPYHsCi3RyTFUm/wTJZ264=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782825566; c=relaxed/simple;
	bh=1FkcqdOGqEDn13KLVgWBY0vMUbZS3S1TLLEJwcdQ8gA=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nK3FokztuAB+GKgzrU54dst/jnyjt54LmzM2o1ttL3uU/ziDrhJiKo/ZE9djVQ+pNQwijlBBgMQwl0lmZcKnbhwrWLLmjgcD3K9RKu+FM1bn/NBEdD3q1zAN0rpZp3UMMXWpJErHwVYZ4GQt0k7Rj2RNtQfWC7MhShGlIerO18I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlQQjWyx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlQQjWyx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00081F000E9;
	Tue, 30 Jun 2026 13:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782825564;
	bh=X2huV41tJ0rz8l0aDtoqZqmqn9ylvKGcaUxEC++7rR8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=LlQQjWyxYIgd5RQfxzCRSXT3munQUYGNFy8m7AUrqWXixrxJG+u1fA9hS94lkQqyQ
	 UWUfHIhdAtJRYjEyi3FElTOFQdKQJbn7a3RS/h4f8CTtWXN5WnfH/F3QhNtwb2Nn+C
	 tjy3/utkBuF+HhMeENDotyNwlac44OFA4Ly+o5lOnTQzyZZWOkXhofn4/mED1pQCHB
	 ocOI5hh3Zi9PMmZb9rPhwLZfYn6tmCyVzQnye59pd4gfn6mipwFxTnrQEWuUQKnzNX
	 6PaDUxoFTPeRzTYa1HoX6wEqDiFoW/B1m1uAxeo67bxddbKG2u/xbKZz5yg60U+Sxr
	 sOVop1h8QdPuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/5] watchdog: aaeon: Add watchdog driver for
 SRG-IMX8P MCU
Reply-To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org
In-Reply-To: <20260630-dev-b4-aaeon-mcu-driver-v6-5-d66b5fcbd2f0@bootlin.com>
References: <20260630-dev-b4-aaeon-mcu-driver-v6-0-d66b5fcbd2f0@bootlin.com>
 <20260630-dev-b4-aaeon-mcu-driver-v6-5-d66b5fcbd2f0@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 13:19:23 +0000
Message-Id: <20260630131923.B00081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing PM hooks to stop the hardware watchdog during system suspe=
nd.
- [Medium] The `timeout-sec` device tree property is ignored because the dr=
iver reads it from the child MFD device instead of the parent device.
--

commit 0395f10fd7f7a423d535b7eff45bb1cf967808e5
Author: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>

watchdog: aaeon: Add watchdog driver for SRG-IMX8P MCU

Add watchdog driver for the Aaeon SRG-IMX8P embedded controller.
This driver provides system monitoring and recovery capabilities
through the MCU's watchdog timer.

> diff --git a/drivers/watchdog/aaeon_mcu_wdt.c b/drivers/watchdog/aaeon_mc=
u_wdt.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/watchdog/aaeon_mcu_wdt.c

[ ... ]

> +static int aaeon_mcu_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;

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
> +	wdt->max_timeout =3D AAEON_MCU_WDT_MAX_TIMEOUT;
> +	wdt->max_hw_heartbeat_ms =3D AAEON_MCU_WDT_HEARTBEAT_MS;
> +	watchdog_init_timeout(wdt, timeout, dev);

[Severity: Medium]
Does this pass the correct device for reading the DT timeout-sec property?

Since dev is a child platform device instantiated by the MFD core, it typic=
ally
lacks an of_node. Should this be dev->parent instead, so that
device_property_read_u32() in the watchdog core can successfully find the
timeout-sec property?

> +
> +	watchdog_set_drvdata(wdt, data);
> +	watchdog_stop_on_reboot(wdt);

[ ... ]

> +	return devm_watchdog_register_device(dev, wdt);
> +}
> +
> +static struct platform_driver aaeon_mcu_wdt_driver =3D {
> +	.driver		=3D {
> +		.name	=3D "aaeon-mcu-wdt",
> +	},
> +	.probe		=3D aaeon_mcu_wdt_probe,
> +};

[Severity: High]
Will this cause unexpected system resets during suspend?

If the system enters suspend while the watchdog is active, the watchdog cor=
e's
ping worker is frozen. Since there are no PM hooks provided here to stop the
hardware timer or configure it for sleep, will the MCU's 25-second hardware
watchdog tick down and reset the board if suspend lasts longer than 25 seco=
nds?

> +
> +module_platform_driver(aaeon_mcu_wdt_driver);
> +
> +MODULE_ALIAS("platform:aaeon-mcu-wdt");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-dev-b4-aae=
on-mcu-driver-v6-0-d66b5fcbd2f0@bootlin.com?part=3D5
