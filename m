Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AEF32B112;
	Fri,  7 Aug 2026 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092560; cv=none; b=gAhM5OiGzyn92RjFzCDY/OOsAN/6GZ2aqvcTaWFmVncD+TWUO44uQKBv9QYchx1VQHuYQa6j7Ygx98p34r1GKe8d71jiOLFYKl3l5pxEDIgI+OZvfqMRATd2zscjrWTZBmFmF0tn56izhzxq5uHIWR8Xn53q+kGqQk8srmbrfFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092560; c=relaxed/simple;
	bh=RyZjzD+NcR7wVGrDrS4z+XaFA+UQOah81d0FG6LHGVs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q/+bNAl50jXvCkKDUdwdjdH+8aQJhDRxpskoES3tpXqiXgp7MyBsTpdRw4+e/8fvORMFUgy9WP7zRnDbo7jqGC5sKA/XB5rZ1uu74FuvdA6ScHCsXAzCKmmLRa6dXhRp61n6GOIwTPyX/6osIWl2JXUHqixCZP6uCEI+xlgXKWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5fqZ5eU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5fqZ5eU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACBA1F000E9;
	Fri,  7 Aug 2026 08:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786092559;
	bh=MhO8LfYtzsQC9Iw0QG2WWmZwg2fB4XF9MtdjEHyOu8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h5fqZ5eUd/9bnsbvwJwcaZ0uWvV9ZCPUMqN7aVx1r1wrQQlLSNJPvJswtSni//nkL
	 ejVITxFp3Rz977GudFxRAeTAAwQkMuJHLJgWbjg0Gwssax+2Foz4Xf2rRq7GydQwDW
	 8DiZAXhGj70KG5TNFapyYcoXRshtarXbqtU9WgNOMvq6nWzdvAKSB00SaQDhRr0Vjw
	 lvmCnkTMwGIuoE3VC2f6+7B+KR4mX3wkiPxCXVAcyRXUAQ+zL+wwY7uqyuQ84D3mqV
	 ElyGY/Ufj3Q+g6zifFOfTg6ZTgBf/D2tgyVXV7PRDS3AQQtI7VdbC0E5DlgmZ5C21Z
	 7uP1OcMs/cUsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] rtc: pcf8525: Add NXP PCF8525 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shiv Prakash Gupta" <shivprakash.gupta@nxp.com>
Cc: linux-hwmon@vger.kernel.org, robh@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260807082855.3762394-3-shivprakash.gupta@nxp.com>
References: <20260807082855.3762394-1-shivprakash.gupta@nxp.com>
 <20260807082855.3762394-3-shivprakash.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 08:49:18 +0000
Message-Id: <20260807084918.DACBA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Unsynchronized concurrent access to the shared timestamp state (`t=
s` and `ts_valid`) between the threaded IRQ handler and sysfs callbacks.
- [High] Read-modify-write on Write-0-to-Clear (W0C) interrupt flags drops =
concurrent interrupts.
- [High] Hardware timestamp engine freezes after the first event in IRQ mod=
e due to missing CTS command.
- [High] The alarm interrupt is not properly configured as a system wake so=
urce, preventing the RTC alarm from waking the system from suspend.
- [Low] The I2C device ID array uses positional initializers rather than na=
med initializers.
--

--- Patch [2]: [PATCH 2/4] rtc: pcf8525: Add NXP PCF8525 RTC driver ---
commit b181a191f404e5910be38077d8059abeffe4a95b
Author: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>

rtc: pcf8525: Add NXP PCF8525 RTC driver

Add support for time and date, alarms, timestamp capture, backup
switch-over configuration, external crystal configuration and clock
offset correction.

--- a/drivers/rtc/rtc-pcf8525.c
+++ b/drivers/rtc/rtc-pcf8525.c
[ ... ]
> +static ssize_t timestamp_show_common(struct device *dev, char *buf, int =
id)
> +{
> +	struct pcf8525 *pcf8525 =3D dev_get_drvdata(dev->parent);
> +	unsigned int ctrl4;
> +	time64_t ts;
> +	int ret;
> +
> +	if (id < 0 || id > 1)
> +		return 0;
> +
> +	if (pcf8525->irq_enabled) {
> +		if (!pcf8525->ts_valid[id])
> +			return 0;
> +		ts =3D pcf8525->ts[id];
> +		return sysfs_emit(buf, "%llu\n", (unsigned long long)ts);

[Severity: High]
Is it possible for the threaded IRQ handler to update the timestamp state
concurrently with this sysfs read?

If a user-space process reads the sysfs timestamp attribute at the same time
an RTC timestamp interrupt is being processed in pcf8525_ts_snapshot(),
this could result in a torn read on 32-bit platforms where time64_t requires
two 32-bit memory accesses.

Should a mutex or memory barrier be used to synchronize access to the
timestamp state?

> +	}
[ ... ]
> +static ssize_t timestamp_store_common(struct device *dev, const char *bu=
f,
> +				      size_t count, int id)
> +{
> +	struct pcf8525 *pcf8525 =3D dev_get_drvdata(dev->parent);
> +	int ret;
> +
> +	if (id < 0 || id > 1)
> +		return -EINVAL;
> +
> +	if (pcf8525->irq_enabled) {
> +		pcf8525->ts_valid[id] =3D false;
> +		return count;
> +	}

[Severity: High]
When in IRQ mode, this function returns early without sending the Clear
Timestamp (CTS) command to the hardware.

Since the hardware is configured in freeze mode (PCF8525_TS_CTL1_TSM), it
will ignore new events until the CTS command is issued. The interrupt handl=
er
pcf8525_irq() only clears the TSF interrupt flag.

Will this cause the timestamp engine to stop capturing events after the fir=
st
one in IRQ mode?

> +
> +	/*
> +	 * Clear timestamp via RESET CTS command.
[ ... ]
> +static irqreturn_t pcf8525_irq(int irq, void *data)
> +{
> +	struct device *dev =3D data;
> +	struct pcf8525 *pcf8525 =3D dev_get_drvdata(dev);
> +	unsigned int ctrl2, ctrl4;
> +	int ret;
> +
> +	ret =3D regmap_read(pcf8525->regmap, PCF8525_REG_CTRL2, &ctrl2);
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	ret =3D regmap_read(pcf8525->regmap, PCF8525_REG_CTRL4, &ctrl4);
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	if (!(ctrl2 & (PCF8525_CTRL2_AF | PCF8525_CTRL2_MSF)) &&
> +	    !(ctrl4 & PCF8525_CTRL4_TSF))
> +		return IRQ_NONE;
> +
> +	/* Timestamp */
> +	if (ctrl4 & PCF8525_CTRL4_TSF) {
> +		pcf8525_ts_snapshot(dev);
> +		/* Clear TSF */
> +		regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL4, PCF8525_CTRL4_T=
SF, 0);
> +	}
> +
> +	/* Alarm */
> +	if (ctrl2 & PCF8525_CTRL2_AF) {
> +		rtc_update_irq(pcf8525->rtc, 1, RTC_IRQF | RTC_AF);
> +		/* Clear AF */
> +		regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL2, PCF8525_CTRL2_A=
F, 0);

[Severity: High]
Does using regmap_update_bits() here risk dropping concurrent interrupts?

This function performs a read-modify-write. If it writes 0 to clear AF or M=
SF,
it writes back 0 for any other Write-0-to-Clear flag that was 0 at the time
of the read. If a new hardware event sets another W0C flag between the read
and write, the write of 0 will inadvertently clear the new event before it =
can
be handled.

> +	}
> +
> +	if (ctrl2 & PCF8525_CTRL2_MSF) {
> +		ret =3D regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL2, PCF8525=
_CTRL2_MSF, 0);
> +		if (ret)
> +			return IRQ_NONE;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
[ ... ]
> +static int pcf8525_probe(struct i2c_client *client)
> +{
[ ... ]
> +	/* Optional IRQ */
> +	if (client->irq > 0) {
> +		ret =3D devm_request_threaded_irq(dev, client->irq,
> +						NULL, pcf8525_irq,
> +						IRQF_ONESHOT,
> +						dev_name(dev), dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to request INTA IRQ\n");
> +
> +		pcf8525->irq_enabled =3D true;
> +
> +		/* Route/unmask alarm + timestamp to INTA by default */
> +		ret =3D pcf8525_unmask_irqs_intA(pcf8525);
> +		if (ret)
> +			return ret;
> +
> +		device_init_wakeup(dev, true);
> +		set_bit(RTC_FEATURE_ALARM, pcf8525->rtc->features);

[Severity: High]
This declares wakeup capability, but is the IRQ ever connected as a wake
source?

Without calling dev_pm_set_wake_irq() or implementing suspend/resume
callbacks with enable_irq_wake(), the IRQ controller is never instructed to
keep the interrupt armed during suspend.

Could this prevent the RTC alarm from waking the system from suspend?

> +	}
> +
> +	/* Register device */
> +	ret =3D devm_rtc_register_device(pcf8525->rtc);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id pcf8525_of_match[] =3D {
> +	{ .compatible =3D "nxp,pcf8525" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pcf8525_of_match);
> +
> +static const struct i2c_device_id pcf8525_i2c_id[] =3D {
> +	{ "pcf8525", 0 },
> +	{ }
> +};

[Severity: Low]
Could this use named initializers?

The I2C subsystem guidelines require initialized arrays of type
struct i2c_device_id to use named initializers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807082855.3762=
394-1-shivprakash.gupta@nxp.com?part=3D2
