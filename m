Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194613B38B8;
	Mon, 24 Aug 2026 07:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555345; cv=none; b=EYlcPaupW/ZjllYgcA1+NWRFhVTX1S1Lawz9BsEkgsBwklDlgZqnqA0szV6SYFlXbiaE1SIjoR6+tfjFs3eqz89MUixIMdi03dJ7OC9LMQ2nekCONrs1clgyBUwj/LkAG+LnWKOzfvbcKd0Y0HaubIYs9FBr30TrUPVx6EZ1yBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555345; c=relaxed/simple;
	bh=Y82996GUghOrVqOsTcxJKrpSHnpuxn5rs9GT/EHQiWU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dc2XuBTgiyWmna3SM1J9yfO+P1UoFFoYRuJb1kgLdoPDTS8L7FrZCgUL4Ad5kIriGcTAIPu9qdEf6xgNcbqV8GY6zmZ2cSIgH6l1FxZAWVfVN0G2Wv77sld2gx9TtWH4G9Pkwr0h5dY/KEynT5sLGkq5OalpZkDb0a8rgdJ7bqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anhaRWJc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anhaRWJc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6E51F000E9;
	Mon, 24 Aug 2026 07:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787555342;
	bh=MuqXsN2Lbqhc9HF1rAT/JgKdjXIpLysNHrM0e02YjgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=anhaRWJc7/AdWpbilVzA/7wZb4RBHHw1sBOCZGj2q0TUnKDxVDOMkX1+ksvv7CSyA
	 hQF33eAee65dWooxlUksJYPjwDvW92I0/Nea89bTipywhd6KXi2qWzDxzfvxQyNMRd
	 DfhRwgt9A2WsogzjCwuMxarKGmZUC6wWw7a7DzveDZKwvmc/O4wdq4IQM3QCoK6jKf
	 98Db5NJcFU3U4tqfuclqk0xvSRHD7e4jJdIjk+M2DFYTPLiegzTSeUhuqgka24MTNC
	 SCLBbSy7ccJSmetnysMmIJOwa7y5LlYxZyL8L/FV4Qiv0YPvyVdCLN/OJpjWNgzT9B
	 +bP4ObNJlvZtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] rtc: pcf8525: Add watchdog support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shiv Prakash Gupta" <shivprakash.gupta@nxp.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260824065531.693701-4-shivprakash.gupta@nxp.com>
References: <20260824065531.693701-1-shivprakash.gupta@nxp.com>
 <20260824065531.693701-4-shivprakash.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 07:09:01 +0000
Message-Id: <20260824070901.BD6E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] devm_request_threaded_irq is called before the hardware is configu=
red, risking an interrupt storm.
- [High] The watchdog is not stopped or paused during system suspend, leadi=
ng to unintended system resets.
- [Medium] Missing WDIOF_PRETIMEOUT flag prevents the pretimeout feature fr=
om functioning.

Pre-existing issues:
- [High] Read-modify-write race condition on Write-0-to-Clear (W0C) bits in=
 the CTRL2 register.
- [High] Hardware interrupts are left unmasked on driver unbind and probe e=
rror paths.
--

--- Patch [3]: [PATCH v2 3/4] rtc: pcf8525: Add watchdog support ---
commit a10f54adc977106a229d75b8d56bf77bb2ae1d33
Author: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>

rtc: pcf8525: Add watchdog support

This commit adds watchdog support for the NXP PCF8525 real time clock devic=
e.
It adds support for setting timeouts and handling pretimeout notifications
using the INTB interrupt.

> diff --git a/drivers/rtc/rtc-pcf8525.c b/drivers/rtc/rtc-pcf8525.c
> index 843d4bb266847..415615ea0a406 100644
> --- a/drivers/rtc/rtc-pcf8525.c
> +++ b/drivers/rtc/rtc-pcf8525.c
[ ... ]
> @@ -249,6 +249,11 @@ static int pcf8525_wdt_set_timeout(struct watchdog_d=
evice *wdd,
> +static const struct watchdog_info pcf8525_wdt_info =3D {
> +	.identity =3D "NXP PCF8525 Watchdog",
> +	.options =3D WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,

[Severity: Medium]
Is the WDIOF_PRETIMEOUT flag missing here? Without this flag,
watchdog_have_pretimeout() returns false, which prevents the watchdog
core from attaching a pretimeout governor. When the hardware interrupt fire=
s,
watchdog_notify_pretimeout() might just return without taking action.

> +};
[ ... ]
> @@ -267,6 +272,31 @@ static int pcf8525_watchdog_get_period(int n, int f1=
000)
> +static irqreturn_t pcf8525_wdt_irq(int irq, void *data)
> +{
[ ... ]
> +	if (!(ctrl2 & PCF8525_CTRL2_WDTF))
> +		return IRQ_NONE;
> +
> +	ret =3D regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL2,
> +				 PCF8525_CTRL2_WDTF, 0);

[Severity: High]
This is a pre-existing issue, but does using regmap_update_bits() here
and in pcf8525_watchdog_config() introduce a race condition?

The PCF8525 CTRL2 register contains multiple Write-0-to-Clear flags.
Since regmap_update_bits() performs a read-modify-write cycle, if a hardware
event like an alarm asserts the AF flag between the read and the write,
won't writing back the read value of 0 silently wipe out the new interrupt
flag? This also applies to the pre-existing regmap_update_bits() usage in
pcf8525_irq() clearing PCF8525_CTRL2_AF.

> +	if (ret)
> +		return IRQ_NONE;
> +
> +	watchdog_notify_pretimeout(&pcf8525->wdd);
> +	return IRQ_HANDLED;
> +}
> +
> +static int pcf8525_watchdog_config(struct device *dev,
> +				   struct pcf8525 *pcf8525)
> +{
[ ... ]
> +	/* Route watchdog only to INTB, and keep RTC interrupts masked on INTB.=
 */
> +	ret =3D regmap_read(pcf8525->regmap, PCF8525_REG_INTB_MASK1, &m1);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Clear any stale WDTF before unmasking the watchdog on INTB.
> +	 * With battery backup the flag survives a power cycle and would
> +	 * assert INTB immediately on the next boot, causing an infinite
> +	 * reset loop if INTB is wired to a hardware reset line.
> +	 */
> +	ret =3D regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL2,
> +				 PCF8525_CTRL2_WDTF, 0);
> +	if (ret)
> +		return ret;
> +
> +	m1 |=3D PCF8525_MASK1_BIE |
> +	      PCF8525_MASK1_AIE |
> +	      PCF8525_MASK1_OSIE |
> +	      PCF8525_MASK1_SI |
> +	      PCF8525_MASK1_MI;
> +	m1 &=3D ~PCF8525_MASK1_WD_CD;
> +
> +	ret =3D regmap_write(pcf8525->regmap, PCF8525_REG_INTB_MASK1, m1);

[Severity: High]
This is a pre-existing issue, but are hardware interrupts left unmasked on
driver unbind and probe error paths?

The driver unmasks hardware interrupts here and in pcf8525_unmask_irqs_intA=
().
It relies on devm to free the IRQ handler, but lacks an i2c_driver.remove
function or a devm_add_action callback to explicitly mask these interrupts =
in
the device registers on teardown. If the driver is unbound, could the exter=
nal
device actively assert the open-drain interrupt lines and cause an unhandled
interrupt storm?

> +	if (ret)
> +		return ret;
> +
[ ... ]
> +static int pcf8525_watchdog_init(struct device *dev,
> +				 struct pcf8525 *pcf8525)
> +{
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_WATCHDOG_CORE) ||
> +	    !device_property_read_bool(dev, "reset-source"))
> +		return 0;
> +
> +	if (pcf8525->irq_intb > 0) {
> +		ret =3D devm_request_threaded_irq(dev, pcf8525->irq_intb,
> +						NULL, pcf8525_wdt_irq,
> +						IRQF_ONESHOT,
> +						"pcf8525-wdt", dev);

[Severity: High]
Should the IRQ be requested after the hardware is configured?

In pcf8525_watchdog_config(), the INTB/CLKOUT pin defaults to a clock output
(CLKOE=3D1). Requesting the IRQ here before pcf8525_watchdog_config() disab=
les
CLKOE could flood the CPU with interrupts. The IRQ handler will read WDTF as
0 and return IRQ_NONE repeatedly, which might cause the spurious interrupt
detector to permanently disable the IRQ line.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D pcf8525_watchdog_config(dev, pcf8525);
> +	if (ret)
> +		return ret;
> +
[ ... ]
> +	pcf8525->wdd.status =3D WATCHDOG_NOWAYOUT_INIT_STATUS;
> +
> +	watchdog_set_drvdata(&pcf8525->wdd, pcf8525);
> +	watchdog_stop_on_reboot(&pcf8525->wdd);

[Severity: High]
Does the watchdog continue running during system suspend?

The driver lacks dev_pm_ops suspend/resume callbacks to manually stop or
pause the watchdog. Since the PCF8525 is an external RTC that continues
ticking independently from the host CPU, could the hardware watchdog count
down and assert a reset signal (via the reset-source property) while the
system is asleep, causing an unintended hard reset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824065531.6937=
01-1-shivprakash.gupta@nxp.com?part=3D3
