Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5261D35F5E7;
	Fri,  7 Aug 2026 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092732; cv=none; b=aSFJjsLT7SfvYFI4OK0mTUCAeFJy3iPzJQhC/PkG1Oi7A+2MqOswcSt9pctZRhl4l2EjlLHdWX39xs6FGG4ZOQ0hAkY43adGAx+p5yyRcwvmFVWeF6QblF7r9qr/qxQnSuVwFMq+Th0PCEOtILuz9cbtPSgQopHmODuvmN/LXT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092732; c=relaxed/simple;
	bh=VGRsE+iQ7oewd9lj9RxyMgqujBDDpsJ7YPQchYHmw6E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OmcLFE5YRk3imqS/WjdwaKjVf/MoOapbizGBMUAvIb6qJCXH1nEu6FYPksZL6n/wc2Mk8jBDI1Gh1euBnY+oiItZ3hZ901nVCAlTUs+9JmTK2UlhffSok/jnqPqGsDhqBsRCaQLfCgauQrPpcNEBLdNJ0muF1tfN/dHkMhAO5zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkwcruE5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkwcruE5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AD71F000E9;
	Fri,  7 Aug 2026 08:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786092730;
	bh=N9OXTHZSPFkQMBVvuhrPMUP5AX/jU01HoRETO+4Hy/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CkwcruE5IgC8fpeOskfEnUYSCETGc9AGZJ7Yt+0h0ifzagP/rgHHSoky7wxk0t48I
	 UlJ8l/lqlIIwbNhQAQ7Qv2a6OLA/tUbyUeT6ai9aKQkYfno3kP7s2d49aL4Turov4p
	 4kIZD6X01UVkDF8hKJDh0GCd/P/kcu4eFqKERlnJq6uzkj5+t0Jf8k5HVaKNSJ6IXo
	 E4EoUSiao+wy+AVrobH8iWb15C3WGBZtJfo+2R02jODffT54F+pOZKP9DmN3nmiJ60
	 k+YopPFcl8cJZsG6n1Cc18LHCDgIzk1LYuNAV368Xr6ZL0DWE7gvQMNYHymgM0iTrp
	 wVM0s3UfM2CbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] rtc: pcf8525: Add watchdog support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shiv Prakash Gupta" <shivprakash.gupta@nxp.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-watchdog@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-hwmon@vger.kernel.org
In-Reply-To: <20260807082855.3762394-4-shivprakash.gupta@nxp.com>
References: <20260807082855.3762394-1-shivprakash.gupta@nxp.com>
 <20260807082855.3762394-4-shivprakash.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 08:52:09 +0000
Message-Id: <20260807085209.B0AD71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Critical] Unmasking watchdog interrupt without clearing persistent WDTF =
flag causes inescapable boot loop.
- [High] Watchdog IRQ handler silently clears timeout flag, aborting hardwa=
re resets and defeating the watchdog.
- [High] Missing WDOG_HW_RUNNING reporting causes spurious system resets if=
 the watchdog is armed by the bootloader.
- [High] Requesting INTB without IRQF_SHARED breaks probe on boards tying I=
NTA and INTB together.
- [Medium] Watchdog initialization occurs after RTC registration, creating =
a race condition exposing the uninitialized device.

Pre-existing issues:
- [High] Read-modify-write on CTRL2 causes lost hardware interrupts for RTC=
 alarm and watchdog.
--

--- Patch [3]: [PATCH 3/4] rtc: pcf8525: Add watchdog support ---
commit 3cb38601cbc74987657b19d7480456e2da5babc7
Author: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>

rtc: pcf8525: Add watchdog support

This commit adds watchdog support for the NXP PCF8525 real time clock devic=
e.

> diff --git a/drivers/rtc/rtc-pcf8525.c b/drivers/rtc/rtc-pcf8525.c
> index 7dfb4f0f64047..4ef648bdfc5b9 100644
> --- a/drivers/rtc/rtc-pcf8525.c
> +++ b/drivers/rtc/rtc-pcf8525.c
[ ... ]
> +static irqreturn_t pcf8525_wdt_irq(int irq, void *data)
> +{
> +	struct device *dev =3D data;
> +	struct pcf8525 *pcf8525 =3D dev_get_drvdata(dev);
> +	unsigned int ctrl2;
> +	int ret;
> +
> +	ret =3D regmap_read(pcf8525->regmap, PCF8525_REG_CTRL2, &ctrl2);
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	if (!(ctrl2 & PCF8525_CTRL2_WDTF))
> +		return IRQ_NONE;
> +
> +	ret =3D regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL2,
> +				 PCF8525_CTRL2_WDTF, 0);

[Severity: High]
Does returning IRQ_HANDLED here without notifying the watchdog core or
invoking panic() silently abort the hardware reset? If INTB is routed to
a reset controller, de-asserting it before the reset cycle completes might
leave the system in a hung state rather than resetting it.

[Severity: High]
This isn't a bug introduced by this patch, but this read-modify-write
on the CTRL2 register extends a pre-existing race condition to the
watchdog handler thread.

CTRL2 contains write-0-to-clear flags like AF, MSF, and WDTF. Because
regmap_update_bits() reads the register and writes it back, if a hardware
flag asserts after the read but before the write, could this write back
a 0 and accidentally clear the newly asserted flag?

This same pattern exists in pcf8525_irq() when clearing AF, which could
cause lost hardware interrupts.

> +	if (ret)
> +		return IRQ_NONE;
> +
> +	return IRQ_HANDLED;
> +}
[ ... ]
> +static int pcf8525_watchdog_config(struct device *dev,
> +				   struct pcf8525 *pcf8525)
> +{
[ ... ]
> +	m1 |=3D PCF8525_MASK1_BIE |
> +	      PCF8525_MASK1_AIE |
> +	      PCF8525_MASK1_OSIE |
> +	      PCF8525_MASK1_SI |
> +	      PCF8525_MASK1_MI;
> +	m1 &=3D ~PCF8525_MASK1_WD_CD;
> +
> +	ret =3D regmap_write(pcf8525->regmap, PCF8525_REG_INTB_MASK1, m1);

[Severity: Critical]
If the watchdog resets the system, the battery-backed RTC retains the WDTF
(Watchdog Timeout Flag) set to 1. On reboot, when this unmasks the watchdog
interrupt on the INTB pin, will it immediately assert INTB since WDTF is
still 1? This regression could trigger the hardware reset again and cause
an inescapable boot loop.

> +	if (ret)
> +		return ret;
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
Many hardware designs tie open-drain I2C interrupts (INTA and INTB) to a
single SoC GPIO. If they are mapped to the same IRQ, will this request fail
because it lacks IRQF_SHARED and uses the same dev_id token (dev)?
This could result in a -EBUSY error and cause the entire device probe
to fail.

[ ... ]
> +	pcf8525->wdd.timeout =3D PCF8525_WD_DEFAULT_TIMEOUT_S;
> +	watchdog_init_timeout(&pcf8525->wdd, 0, dev);
> +	pcf8525->wdd.min_hw_heartbeat_ms =3D PCF8525_WD_MIN_HW_HEARTBEAT_MS;
> +	pcf8525->wdd.status =3D WATCHDOG_NOWAYOUT_INIT_STATUS;
> +
> +	watchdog_set_drvdata(&pcf8525->wdd, pcf8525);
> +	watchdog_stop_on_reboot(&pcf8525->wdd);
> +
> +	return devm_watchdog_register_device(dev, &pcf8525->wdd);

[Severity: High]
If the bootloader starts the watchdog, does unconditionally setting the
status without checking if the hardware timer is active cause issues?
Because it fails to set WDOG_HW_RUNNING, the watchdog core will not
initiate the ping worker, which might allow the timer to expire and
cause a spurious system reboot during boot.

[ ... ]
> @@ -902,6 +1139,10 @@ static int pcf8525_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
> =20
> +	ret =3D pcf8525_watchdog_init(dev, pcf8525);
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }

[Severity: Medium]
Could initializing the watchdog after RTC registration expose the RTC
device to userspace prematurely? If pcf8525_watchdog_init() fails,
probe will return an error and devres will unregister the RTC,
which might cause operations on the opened device to fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807082855.3762=
394-1-shivprakash.gupta@nxp.com?part=3D3
