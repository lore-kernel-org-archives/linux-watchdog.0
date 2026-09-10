Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B6C3BB677;
	Thu, 10 Sep 2026 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021469; cv=none; b=A44xBh/E0GxAVbH+Tdj3kmF26NKFlpS7MrF5DJou41rpcJjAiPgm0YH74k6xWJRvZGDmQuHV8/6HSGdndvyQGHnhJVLUuhqjO86tdhEH7ATGdVmEEUWKHyHTMX9qYh7umxUSnpmlXa6NxW/1oDjdvOLAfnfr+JOvi5glM/cRtU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021469; c=relaxed/simple;
	bh=3VkPXhOVat9bta2US2+kUu8osrymZpLV6J7Y+lY+100=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h9ml8/FfdamQqBHD+WrcEV5qN8ZGpPrFe2DLYSQpdDdJivJVZjnM+KfpswiHTuH7MR1zEfIMtpqSVfeJ3owzw44dlCpm6uOR/NQBIffACAnvQfskMOj+Y/fBPr7MvHSiHEzMrbAfC5Jx9b/RpygZb3B6+Lb3SaZvISG7fSpQRek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=du72ABQ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="du72ABQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2CF1F000FF;
	Thu, 10 Sep 2026 06:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789021467;
	bh=rXISX+UNHS0qrMwr7CA1bwdG4ZmIl/0/rWhicBzT7ZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=du72ABQ43KLQ1vsT8pyIvJBpOLFPyXi5OEuuNYnUj8AFQZSJgDASSFBiuCphCU2SO
	 ft+pH2A4Nh5SAaQrBVRbYHKa2abCBNa1HSLsjt63/qeDRgy/M+UpdySx3LhrPT2odE
	 8QG/XyuGlny3Wv10LOqJJz0bVltS4iZdj650f6Qzj61lz+33fI5/Go0gFEf2dGtDPk
	 9M5Gq5/0D3twjWCmy+82y3tv4TM6qgQskQ0fpUE8rLrg2Dvz8O6fd1ndBeFHw2hIrQ
	 c5SGEbpQnHECgX3pLcWcZ7XxFW9+dsP5VbsHSq+qWEVYd3PqmgEhlKd4W6S30QR52V
	 fwl1OcwwzC0Pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] rtc: pcf8525: Add NXP PCF8525 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shiv Prakash Gupta" <shivprakash.gupta@nxp.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260910060912.2443551-3-shivprakash.gupta@nxp.com>
References: <20260910060912.2443551-1-shivprakash.gupta@nxp.com>
 <20260910060912.2443551-3-shivprakash.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 06:24:26 +0000
Message-Id: <20260910062426.7D2CF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] RMW operations on PCF8525_REG_CTRL2 accidentally clear the watchdo=
g interrupt flag (WDTF) by omitting it from the regmap_update_bits mask.
- [Medium] Missing cleanup for wake IRQ and wakeup source on probe failure =
and driver unbind leads to memory leaks and potential UAF.
- [Medium] Unchecked return value of regmap_write for the CTS command leads=
 to inconsistent software/hardware state.
--

commit d47460240cda581b03b6f4da9e28d366adee1b6a
Author: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>

rtc: pcf8525: Add NXP PCF8525 RTC driver

Add support for time and date, alarms, timestamp capture, backup
switch-over configuration, external crystal configuration and clock
offset correction.

> diff --git a/drivers/rtc/rtc-pcf8525.c b/drivers/rtc/rtc-pcf8525.c
> new file mode 100644
> index 0000000000000..9da8bcde7ef11
> --- /dev/null
> +++ b/drivers/rtc/rtc-pcf8525.c
[ ... ]
> +static int pcf8525_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct pcf8525 *pcf8525 =3D dev_get_drvdata(dev);
> +	u8 buf[7];
> +	int ret;
> +
> +	/*
> +	 * Clear AF (W0C). Include MSF in the mask and write 1 to preserve it:
> +	 * writing 0 to a W0C bit that asserted between the read and write would
> +	 * silently drop the event.
> +	 */
> +	ret =3D regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL2,
> +				 PCF8525_CTRL2_AF | PCF8525_CTRL2_MSF,
> +				 PCF8525_CTRL2_MSF);

[Severity: High]
Does this regmap_update_bits() call accidentally clear the watchdog
interrupt flag?

Since PCF8525_CTRL2_WDTF is omitted from the mask, a concurrent
assertion of the watchdog pretimeout flag between the regmap read
and write might be cleared unintentionally, causing the pretimeout
handler to be dropped.

> +	if (ret)
> +		return ret;
[ ... ]
> +static ssize_t timestamp_store_common(struct device *dev, const char *bu=
f,
> +				      size_t count, int id)
> +{
> +	struct pcf8525 *pcf8525 =3D dev_get_drvdata(dev->parent);
> +	int ret;
[ ... ]
> +	if (pcf8525->irq_enabled) {
> +		/*
> +		 * Hold the mutex across the software state update and the
> +		 * hardware CTS + TSF-clear sequence.
> +		 *
> +		 * pcf8525_irq() re-reads CTRL4 under the same mutex before
> +		 * touching the timestamp registers.  Clearing TSF here ensures
> +		 * that if the IRQ handler is blocked waiting for the mutex, it
> +		 * will see TSF=3D0 on its re-read and skip reading the now-zeroed
> +		 * CTS registers.  Without this clear the IRQ could read all-
> +		 * zeros from the CTS-wiped registers and cache garbage.
> +		 */
> +		mutex_lock(&pcf8525->ts_mutex);
> +		pcf8525->ts_valid[id] =3D false;
> +		regmap_write(pcf8525->regmap, PCF8525_REG_RESET,
> +			     PCF8525_RESET_CTS_CMD);
> +		regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL4,
> +				   PCF8525_CTRL4_TSF, 0);

[Severity: Medium]
What happens if the underlying regmap_write() or regmap_update_bits() fails?

The lack of error checks here leaves the driver assuming the hardware state
was successfully cleared. If the clear failed, userspace receives a false
success, and the software cache could become desynchronized from the hardwa=
re,
potentially causing the IRQ handler to incorrectly repopulate the cache with
the same old timestamp.

> +		mutex_unlock(&pcf8525->ts_mutex);
> +		return count;
> +	}
[ ... ]
> +static irqreturn_t pcf8525_irq(int irq, void *data)
> +{
> +	struct device *dev =3D data;
> +	struct pcf8525 *pcf8525 =3D dev_get_drvdata(dev);
[ ... ]
> +	if (ctrl2 & PCF8525_CTRL2_MSF) {
> +		/*
> +		 * W0C: clear MSF, protect AF from being accidentally cleared
> +		 * by writing 1 to it.
> +		 */
> +		ret =3D regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL2,
> +					 PCF8525_CTRL2_MSF | PCF8525_CTRL2_AF,
> +					 PCF8525_CTRL2_AF);

[Severity: High]
Does this operation risk dropping the watchdog interrupt?

Similar to pcf8525_set_alarm(), the PCF8525_CTRL2_WDTF flag is missing
from the mask, exposing the watchdog interrupt to being accidentally cleared
when acknowledging RTC interrupts.

> +		if (ret)
> +			return IRQ_NONE;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
[ ... ]
> +static int pcf8525_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct pcf8525 *pcf8525;
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
> +		dev_pm_set_wake_irq(dev, client->irq);
> +		set_bit(RTC_FEATURE_ALARM, pcf8525->rtc->features);
> +	}

[Severity: Medium]
Will this leak the unmanaged wake IRQ and wakeup source if probe fails later
or when the driver is unbound?

The driver sets the wake IRQ using dev_pm_set_wake_irq() (ignoring the
return value) but does not clean it up on error paths in pcf8525_probe()
(like devm_rtc_register_device() failure) or via a registered .remove
callback/devm action. This can leak the struct wake_irq and leave a dangling
pointer in dev->power.wakeirq, causing subsequent driver rebinds to fail.

> +
> +	/* Register device */
> +	ret =3D devm_rtc_register_device(pcf8525->rtc);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910060912.2443=
551-1-shivprakash.gupta@nxp.com?part=3D2
