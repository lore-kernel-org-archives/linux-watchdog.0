Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC8E3806DC;
	Thu, 10 Sep 2026 06:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021500; cv=none; b=IwZcUNuPjArA10kEdXSrQs8VjQZcVSdFcTZCTYKwkW6tyj0gcMY/QtSTa4bdRZ1b2wBjdg2AU3o5d2auY8NjxTbVEjTM9qbcW7I6pg4lN96v+xGfzZqPr1ePhgNCKbWfprl7I999rrlvlYdaCrmh0Sba98Di5pB89dauFYHgqSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021500; c=relaxed/simple;
	bh=aMzSKd5Mjcg+xCD5zfLPnt/B0PBjyFuywkDtpKKyT2k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QQPLoJ9O1JGld4U+PV5+4ppeeQ7utvfX3aGZbY/L0ilqzmHALQlwLK4oYHIyln5jshiNFcLglq4pW51E0PlGxptYPX5AnMrJlK3oCCdZzhgqvKLC0D7Aor15ukt0SWLQBnIWu163W2m8lfiLkmMG5UBHgEIL5rwYMPL2jWZFAE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbx49SVm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbx49SVm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99421F000FF;
	Thu, 10 Sep 2026 06:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789021498;
	bh=LfGd0fsd+J7Xvr0/mRFblxaRUqfrTJwOa4VroBqvA9s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cbx49SVmMm4LKgtjz2MFCgn2X4W6r5WdPV3/sMaGMrzUMnZxPx8IqDDdxMtVNFDv2
	 EawAGOxv1lOIuWpSIqsUdOPY0WeFRwfHvUvd6ECdqdPaw1BsgzgyDNnNzGnbf0psnY
	 dBy1dzT4FqkuZ4JHfSPt106pkq6tjeqySbiSfnQB+MlRslSLhQdsXV7nnuyoW6yjzo
	 J2rWdx6DaQLN0AIgg+dxVHKreW4bFL9b87BenhqSgVicTmW4v42ysuSZzQkRz5iN0j
	 xuXbcO8hwzEzm1vZn7337DrUQxcOiM0uutnYIrw5l+z7u97K7XkNCkfpX1VVFXPpCX
	 5i2qrsQ+trhvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] rtc: pcf8525: Add watchdog support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shiv Prakash Gupta" <shivprakash.gupta@nxp.com>
Cc: linux-rtc@vger.kernel.org, conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org, linux-hwmon@vger.kernel.org
In-Reply-To: <20260910060912.2443551-4-shivprakash.gupta@nxp.com>
References: <20260910060912.2443551-1-shivprakash.gupta@nxp.com>
 <20260910060912.2443551-4-shivprakash.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 06:24:57 +0000
Message-Id: <20260910062457.A99421F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Fake WDIOF_PRETIMEOUT support breaks pretimeout functionality and =
watchdog reset guarantees.
- [High] Watchdog is not stopped during system suspend if it is running but=
 not actively opened.
- [High] Unconditionally masking the INTB pin on driver unbind defeats the =
hardware watchdog reset guarantees.
- [High] Read-modify-write operations in pre-existing RTC handlers accident=
ally clear the newly-enabled watchdog flag (WDTF).
--

commit 64b260e0a56bf2f53534b37b3e23d2d66162de37
Author: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>

rtc: pcf8525: Add watchdog support

Adds watchdog support for NXP PCF8525 real time clock (RTC) device.

> diff --git a/drivers/rtc/rtc-pcf8525.c b/drivers/rtc/rtc-pcf8525.c
> --- a/drivers/rtc/rtc-pcf8525.c
> +++ b/drivers/rtc/rtc-pcf8525.c
[ ... ]
> @@ -879,6 +901,296 @@ static const struct rtc_class_ops pcf8525_rtc_ops =
=3D {
[ ... ]
> +static const struct watchdog_info pcf8525_wdt_info =3D {
> +	.identity =3D "NXP PCF8525 Watchdog",
> +	.options =3D WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_PRETIMEOUT,
> +};

[Severity: High]
Does advertising WDIOF_PRETIMEOUT here prevent the core from falling back to
hrtimer-based software pretimeout, despite the driver having no native
pretimeout support?

[ ... ]
> +static irqreturn_t pcf8525_wdt_irq(int irq, void *data)
> +{
[ ... ]
> +	/*
> +	 * W0C: clear WDTF. Include AF and MSF in the mask and write 1 to them
> +	 * so the RMW does not accidentally clear a concurrently asserted alarm
> +	 * or minute/second interrupt flag.
> +	 */
> +	ret =3D regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL2,
> +				 PCF8525_CTRL2_WDTF | PCF8525_CTRL2_AF |
> +				 PCF8525_CTRL2_MSF,
> +				 PCF8525_CTRL2_AF | PCF8525_CTRL2_MSF);
> +	if (ret)
> +		return IRQ_NONE;
> +

[Severity: High]
This isn't a bug introduced by this patch, but adding the WDTF flag exposes=
 a
pre-existing issue in other handlers.

In pre-existing code like pcf8525_irq() and pcf8525_set_alarm(),
read-modify-write operations on PCF8525_REG_CTRL2 accidentally clear this
newly-enabled WDTF flag.

For example, in pcf8525_irq():

    regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL2,
                       PCF8525_CTRL2_AF | PCF8525_CTRL2_MSF,
                       PCF8525_CTRL2_MSF);

If WDTF asserts between the read and write, will writing 0 to it accidental=
ly
clear the watchdog flag and lose the interrupt?

> +	watchdog_notify_pretimeout(&pcf8525->wdd);
> +	return IRQ_HANDLED;
> +}

[Severity: High]
If the final hardware timeout is unconditionally treated as a pretimeout he=
re,
will a subsequent hardware reset ever occur if wired as an interrupt?

Without a secondary timer to perform the actual reset, deployments relying =
on
this watchdog for system recovery might silently fail to reboot.

[ ... ]
> +static void pcf8525_mask_intb(void *data)
> +{
> +	struct pcf8525 *pcf8525 =3D data;
> +	unsigned int m1;
> +	int ret;
> +
> +	ret =3D regmap_read(pcf8525->regmap, PCF8525_REG_INTB_MASK1, &m1);
> +	if (!ret) {
> +		m1 |=3D PCF8525_MASK1_WD_CD;
> +		regmap_write(pcf8525->regmap, PCF8525_REG_INTB_MASK1, m1);
> +	}
> +}
> +
> +static int pcf8525_watchdog_init(struct device *dev,
> +				 struct pcf8525 *pcf8525)
> +{
[ ... ]
> +	/* Register a cleanup action to re-mask INTB on driver unbind. */
> +	ret =3D devm_add_action_or_reset(dev, pcf8525_mask_intb, pcf8525);

[Severity: High]
Does unconditionally masking the INTB pin on driver unbind defeat the hardw=
are
watchdog reset guarantees?

If the watchdog is configured with the nowayout feature, or closed without
the magic character, the core watchdog subsystem intentionally leaves the
hardware timer running on driver unbind to ensure the system is eventually
reset.

Will silencing the physical reset line here prevent the hardware from
asserting the reset?

[ ... ]
> +static int pcf8525_suspend(struct device *dev)
> +{
> +	struct pcf8525 *pcf8525 =3D dev_get_drvdata(dev);
> +
> +	if (IS_ENABLED(CONFIG_WATCHDOG_CORE) &&
> +	    device_property_read_bool(dev, "reset-source") &&
> +	    watchdog_active(&pcf8525->wdd))
> +		return pcf8525_wdt_stop(&pcf8525->wdd);
> +
> +	return 0;
> +}

[Severity: High]
If the hardware watchdog was started by the bootloader (meaning
WDOG_HW_RUNNING is set), will this fail to pause the watchdog during suspen=
d?

Since watchdog_active() is only true when userspace has opened the device,
this fails to stop the HW if it is only running in the background. If the
ping worker is frozen during suspend, could the hardware timer reset the
system while sleeping?

> +
> +static int pcf8525_resume(struct device *dev)
> +{
> +	struct pcf8525 *pcf8525 =3D dev_get_drvdata(dev);
> +
> +	if (IS_ENABLED(CONFIG_WATCHDOG_CORE) &&
> +	    device_property_read_bool(dev, "reset-source") &&
> +	    watchdog_active(&pcf8525->wdd))
> +		return pcf8525_wdt_ping(&pcf8525->wdd);
> +
> +	return 0;
> +}

[Severity: High]
Similarly, does this fail to resume a hardware-running watchdog on wake sin=
ce
it also relies on watchdog_active()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910060912.2443=
551-1-shivprakash.gupta@nxp.com?part=3D3
