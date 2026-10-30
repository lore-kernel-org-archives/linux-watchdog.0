Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793359198;
	b=JFLvZj92J0Gd+fAfQ7gZE6zbWOfi1BoSr68GCr5Og+uII6Mhr6TP0rCA8lfR14R6udoo
	 lFYZkjBXKRTBaoQ7Ljvgm8/VZ3o4KKpOFHcqtRAzB3rUswK0k8INVZu7lOShr1c63fHgj
	 I+7tW6tetszchgcGO7pisO2NJZvSigYqPle0+MhTRYfGdaUVM9uhc9DhiXYBR7leVeTMT
	 Exx6pcTHFLgFgyQijwv6lP9kXJnBSqX6Rm9JuE4JYCiGCs+Z56gapTVNP3bv7J9GAWAcZ
	 6AMbh8XpwtNT3uiOVMqQz1HOvj4CmQMNBG4FAQHWO15BY/n7ZIA5p3f0FBDUGK6adBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359198;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dobZiynETOefxU8kPgcXMmu6lWh6DyYOPl1H91g6Njw=;
	b=ofRf7FCJVGu8FySZ+CbN364cS8fxS38+YbgGT7iL57f6ClVdsDQNjW37cvUbLQkE0wnq
	 92L+oJwCIz4doOt3MMB4bh+Win3igiCdQiDLgKvFl6zz7I0WL82Baz1X1oWY5PVYqzpOr
	 pZGUTmQ0jr6FZaVl4Z3uRWHOc1jnYejMKJ9OPfmLBVYbrs9TivHwu3waBkNw9nQq3JG8R
	 g8QBoL5sBuiZr43t5xkDyTuY/g5x/m1Hy6d9TzoH7QWk3ChDfmtY/jD+AjpVGDMEjOSsh
	 oOphqCtNO5e+09ESI3XP191lnPE1EsAe4SFemzOgw/txVat8gm1F65JdL6D3/2DpWOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Kaj/3D1R";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522C6606A31A;
	Fri, 30 Oct 2026 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kaj/3D1R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78ED1F0093A;
	Fri, 30 Oct 2026 11:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793359198;
	bh=dobZiynETOefxU8kPgcXMmu6lWh6DyYOPl1H91g6Njw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kaj/3D1RvcXKMSNV35IGdLKSc/Mtm68X9n9jd/g2bEcUQUokRckhvJPAcf9QwrEMp
	 xDregVqS/KdnsyllM6GsHO2pKY5VzXFv1+CYomlZiUl9bIUhnCjqKdbSRb4ZJBwPI7
	 MwiXK89Jb9SOyJgtnFG+5U+HOCnDvnvtgYa/oeZTgdyffnCMqJaELowKpvjAjhaDaD
	 IHiLvMbEv2V/YkIRWpV0XMtPMeY2XOOvEvuxFS3D9KV0x+hmGG8w6NdIf1JSoSuPTZ
	 0dPIbbPIG25zynKUepYK0W2cbnwubAR82a1fah4i76ZG2u9EVyUOWvwG3srkle1vzX
	 MoNI3/YeXpNwg==
Message-ID: <sashiko-outbox-190934@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] rtc: pcf8525: Add watchdog support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shiv Prakash Gupta" <shivprakash.gupta@nxp.com>, linux-rtc@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Cc: robh@kernel.org, conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261030110139.1929109-4-shivprakash.gupta@nxp.com>
References: <20261030110139.1929109-1-shivprakash.gupta@nxp.com>
 <20261030110139.1929109-4-shivprakash.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 11:19:57 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] rtc: pcf8525: premature nINTB pin switch in pcf8525_watchdog_confi=
g()
- [High] rtc: pcf8525: uncanceled deferred ping worker in pcf8525_suspend()
- [Medium] rtc: pcf8525: unthrottled duplicate ping in pcf8525_wdt_set_time=
out()
- [Medium] rtc: pcf8525: min_hw_heartbeat_ms equals min_timeout in pcf8525_=
watchdog_init()
- [Medium] rtc: pcf8525: missing WDIOF_MAGICCLOSE in pcf8525_wdt_info
- [Medium] rtc: pcf8525: missing watchdog_stop_on_unregister() in probe
- [Low] rtc: pcf8525: unquantized timeout in pcf8525_watchdog_init()
--

commit ef4793891aaa47f5f86ec5e83faae0a7013999b0
Author: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>

rtc: pcf8525: Add watchdog support

This commit extends the PCF8525 RTC driver with optional hardware watchdog
support when the reset-source device property is present.

> diff --git a/drivers/rtc/rtc-pcf8525.c b/drivers/rtc/rtc-pcf8525.c
> index 3c5f15f95a9ed..f8fbc00bb464d 100644
> --- a/drivers/rtc/rtc-pcf8525.c
> +++ b/drivers/rtc/rtc-pcf8525.c

[ ... ]

> @@ -906,6 +923,211 @@ static const struct rtc_class_ops pcf8525_rtc_ops =
=3D {
>  	.param_set =3D pcf8525_param_set,
>  };
> =20

[ ... ]

> +static int pcf8525_wdt_set_timeout(struct watchdog_device *wdd,
> +				   unsigned int timeout)
> +{
> +	unsigned int wd_val;
> +
> +	wd_val =3D pcf8525_wdt_timeout_to_val(timeout);
> +	/* Report the achieved timeout, not the requested value. */
> +	wdd->timeout =3D pcf8525_watchdog_get_period(wd_val,
> +						   PCF8525_WD_CLOCK_HZ_X1000);
> +
> +	return pcf8525_wdt_active_ping(wdd);
> +}

[Severity: Medium]
In pcf8525_wdt_set_timeout(), does calling pcf8525_wdt_active_ping() bypass
wdd->min_hw_heartbeat_ms and cause duplicate writes to PCF8525_REG_WD_VAL?

When userspace invokes ioctl(WDIOC_SETTIMEOUT), watchdog_ioctl() in
drivers/watchdog/watchdog_dev.c calls watchdog_set_timeout() and then
immediately calls watchdog_ping() -> __watchdog_ping():

	case WDIOC_SETTIMEOUT:
		if (get_user(val, p))
			return -EFAULT;
		err =3D watchdog_set_timeout(wdd, val);
		if (err < 0)
			return err;
		/* If the watchdog is active then we send a keepalive ping
		 * to make sure that the watchdog keep's running (and if
		 * possible that it takes the new timeout) */
		err =3D watchdog_ping(wdd);
		if (err < 0)
			return err;

Because pcf8525_wdt_set_timeout() -> pcf8525_wdt_active_ping() ->
pcf8525_wdt_ping() writes PCF8525_REG_WD_VAL directly when watchdog_active()
is true, it neither checks wdd->min_hw_heartbeat_ms (4000 ms) nor updates
wd_data->last_hw_keepalive. If less than 4000 ms has elapsed since the prior
hardware write, pcf8525_wdt_active_ping() writes to the hardware immediately
in violation of min_hw_heartbeat_ms, and if at least 4000 ms has elapsed,
pcf8525_wdt_active_ping() writes PCF8525_REG_WD_VAL and watchdog_ping()
immediately writes PCF8525_REG_WD_VAL a second time back-to-back. Also, if
regmap_write() in pcf8525_wdt_active_ping() fails, wdd->timeout has already
been overwritten.

Should pcf8525_wdt_set_timeout() only update wdd->timeout and let the
watchdog core's subsequent watchdog_ping() call handle the hardware write
and rate limiting?

> +
> +static const struct watchdog_info pcf8525_wdt_info =3D {
> +	.identity =3D "NXP PCF8525 Watchdog",
> +	.options =3D WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
> +};

[Severity: Medium]
Should pcf8525_wdt_info.options include WDIOF_MAGICCLOSE?

Without WDIOF_MAGICCLOSE, when CONFIG_WATCHDOG_NOWAYOUT is disabled and the
userspace watchdog daemon crashes or closes /dev/watchdog without writing
the magic 'V' character, watchdog_release() sees !(wdd->info->options &
WDIOF_MAGICCLOSE) and silently stops the hardware watchdog via
watchdog_stop() instead of allowing it to reset the system.

> +
> +static const struct watchdog_ops pcf8525_watchdog_ops =3D {
> +	.owner =3D THIS_MODULE,
> +	.start =3D pcf8525_wdt_start,
> +	.stop =3D pcf8525_wdt_stop,
> +	.ping =3D pcf8525_wdt_ping,
> +	.set_timeout =3D pcf8525_wdt_set_timeout,
> +};
> +
> +static int pcf8525_watchdog_config(struct device *dev,
> +				   struct pcf8525 *pcf8525)
> +{
> +	unsigned int m1, m2;
> +	int ret;
> +
> +	/*
> +	 * WD_VAL is write-only, so a watchdog started by firmware cannot be
> +	 * detected reliably. Stop it explicitly to establish a known state
> +	 * before registering the Linux watchdog device.
> +	 */
> +	ret =3D regmap_write(pcf8525->regmap, PCF8525_REG_WD_VAL,
> +			   PCF8525_WD_VAL_STOP);
> +	if (ret)
> +		return ret;
> +
> +	/* Configure nINTB/CLKOUT as nINTB open-drain interrupt output. */
> +	ret =3D regmap_update_bits(pcf8525->regmap, PCF8525_REG_CLKOUT,
> +				 PCF8525_CLKOUT_CLKOE, 0);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Select 1/4 Hz clock source: TF[1:0] =3D 10.
> +	 * Do NOT enable WD_CD yet; enable it only after clearing stale WDTF
> +	 * to avoid a spurious INTB assertion on a stale flag.
> +	 */
> +	ret =3D regmap_update_bits(pcf8525->regmap, PCF8525_REG_WD_CTL,
> +				 PCF8525_WD_CTL_WD_CD |
> +				 PCF8525_WD_CTL_TF1 |
> +				 PCF8525_WD_CTL_TF0,
> +				 PCF8525_WD_CTL_TF1);
> +	if (ret)
> +		return ret;
> +
> +	/* Keep watchdog masked on INTA. */
> +	ret =3D regmap_read(pcf8525->regmap, PCF8525_REG_INTA_MASK1, &m1);
> +	if (ret)
> +		return ret;
> +
> +	m1 |=3D PCF8525_MASK1_WD_CD;
> +	ret =3D regmap_write(pcf8525->regmap, PCF8525_REG_INTA_MASK1, m1);
> +	if (ret)
> +		return ret;
> +
> +	/* Read INTB mask; mask all non-watchdog sources on INTB first. */
> +	ret =3D regmap_read(pcf8525->regmap, PCF8525_REG_INTB_MASK1, &m1);
> +	if (ret)
> +		return ret;
> +
> +	m1 |=3D PCF8525_MASK1_BIE |
> +	      PCF8525_MASK1_AIE |
> +	      PCF8525_MASK1_OSIE |
> +	      PCF8525_MASK1_SI |
> +	      PCF8525_MASK1_MI |
> +	      PCF8525_MASK1_WD_CD;   /* keep WD masked until WDTF is clear */
> +
> +	ret =3D regmap_write(pcf8525->regmap, PCF8525_REG_INTB_MASK1, m1);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(pcf8525->regmap, PCF8525_REG_INTB_MASK2, &m2);
> +	if (ret)
> +		return ret;
> +
> +	m2 |=3D PCF8525_MASK2_TSIE;
> +	ret =3D regmap_write(pcf8525->regmap, PCF8525_REG_INTB_MASK2, m2);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Clear stale WDTF before enabling WD_CD and unmasking INTB to
> +	 * avoid asserting the watchdog output immediately.
> +	 */
> +	ret =3D regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL2,
> +				 PCF8525_CTRL2_WDTF | PCF8525_CTRL2_AF |
> +				 PCF8525_CTRL2_MSF,
> +				 PCF8525_CTRL2_AF | PCF8525_CTRL2_MSF);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable WD_CD now that WDTF has been cleared. */
> +	ret =3D regmap_update_bits(pcf8525->regmap, PCF8525_REG_WD_CTL,
> +				 PCF8525_WD_CTL_WD_CD,
> +				 PCF8525_WD_CTL_WD_CD);
> +	if (ret)
> +		return ret;
> +
> +	/* Unmask watchdog on INTB. */
> +	m1 &=3D ~PCF8525_MASK1_WD_CD;
> +	return regmap_write(pcf8525->regmap, PCF8525_REG_INTB_MASK1, m1);
> +}

[Severity: High]
Can clearing PCF8525_CLKOUT_CLKOE at the beginning of
pcf8525_watchdog_config() cause an immediate spurious board reset during
probe?

In pcf8525_probe(), before pcf8525_watchdog_init() ->
pcf8525_watchdog_config() runs, the driver already enables timestamp capture
and PCF8525_CTRL5_TSIE, and across a warm reboot or prior firmware activity,
stale interrupt flags (such as WDTF, AF, MSF, or TSF) and unmasked bits in
PCF8525_REG_INTB_MASK1 / PCF8525_REG_INTB_MASK2 or PCF8525_WD_CTL_WD_CD may
already be active.

Although the comments note that WD_CD and INTB_MASK1 must remain
disabled/masked until non-watchdog sources are masked and stale WDTF is
cleared, pcf8525_watchdog_config() switches the physical nINTB/CLKOUT pin to
active-low nINTB by clearing PCF8525_CLKOUT_CLKOE before clearing WD_CD,
before masking non-watchdog sources in PCF8525_REG_INTB_MASK1 and
PCF8525_REG_INTB_MASK2, and before clearing stale WDTF in PCF8525_REG_CTRL2.
During those intervening I2C transactions, any pending unmasked INTB source
can drive nINTB low and reset the system.

Should clearing PCF8525_CLKOUT_CLKOE in PCF8525_REG_CLKOUT be moved to the
end of pcf8525_watchdog_config(), after all INTB masks, stale flags, and
WD_CTL have been configured?

> +
> +static int pcf8525_watchdog_init(struct device *dev,
> +				 struct pcf8525 *pcf8525)
> +{
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_WATCHDOG_CORE) ||
> +	    !device_property_read_bool(dev, "reset-source"))
> +		return 0;
> +
> +	/*
> +	 * Configure the hardware first: this switches the nINTB/CLKOUT pin
> +	 * from clock output (CLKOE=3D1) to open-drain output before the
> +	 * watchdog is registered.
> +	 */
> +	ret =3D pcf8525_watchdog_config(dev, pcf8525);
> +	if (ret)
> +		return ret;
> +
> +	pcf8525->wdd.parent =3D dev;
> +	pcf8525->wdd.info =3D &pcf8525_wdt_info;
> +	pcf8525->wdd.ops =3D &pcf8525_watchdog_ops;
> +	pcf8525->wdd.min_timeout =3D pcf8525_watchdog_get_period(2,
> +							       PCF8525_WD_CLOCK_HZ_X1000);
> +	pcf8525->wdd.max_timeout =3D pcf8525_watchdog_get_period(255,
> +							       PCF8525_WD_CLOCK_HZ_X1000);
> +	pcf8525->wdd.timeout =3D PCF8525_WD_DEFAULT_TIMEOUT_S;
> +	watchdog_init_timeout(&pcf8525->wdd, 0, dev);

[Severity: Low]
When timeout-sec is provided in Device Tree with a value that is not a
multiple of the 4-second hardware period, watchdog_init_timeout() stores the
unquantized value into pcf8525->wdd.timeout, whereas pcf8525_wdt_ping()
programs a rounded-up multiple of 4 seconds into PCF8525_REG_WD_VAL. Should
pcf8525->wdd.timeout be normalized via pcf8525_wdt_timeout_to_val() and
pcf8525_watchdog_get_period() after watchdog_init_timeout() so that
WDIOC_GETTIMEOUT and sysfs report the actual hardware period, matching
pcf8525_wdt_set_timeout()?

> +	pcf8525->wdd.min_hw_heartbeat_ms =3D PCF8525_WD_MIN_HW_HEARTBEAT_MS;

[Severity: Medium]
Can the watchdog ever be kept alive when configured with min_timeout (4
seconds) while min_hw_heartbeat_ms is also 4000 ms?

In pcf8525_watchdog_init(), min_timeout is pcf8525_watchdog_get_period(2,
250) =3D 4 seconds (4000 ms), and min_hw_heartbeat_ms is set to
PCF8525_WD_MIN_HW_HEARTBEAT_MS (4000 ms). When timeout is 4 seconds,
pcf8525_wdt_ping() writes WD_VAL =3D 2 (1 tick of the 1/4 Hz clock, at most
4000 ms). However, in drivers/watchdog/watchdog_dev.c, __watchdog_ping()
computes earliest_keepalive =3D wd_data->last_hw_keepalive + 4000 ms and
defers any keepalive ping arriving before 4000 ms have elapsed until after
the 4-second hardware countdown has already expired.

Should min_timeout be increased (for example to 8 seconds, WD_VAL =3D 3) if
min_hw_heartbeat_ms must remain 4000 ms?

> +	pcf8525->wdd.status =3D WATCHDOG_NOWAYOUT_INIT_STATUS;
> +
> +	watchdog_set_drvdata(&pcf8525->wdd, pcf8525);
> +	watchdog_stop_on_reboot(&pcf8525->wdd);
> +
> +	return devm_watchdog_register_device(dev, &pcf8525->wdd);
> +}

[Severity: Medium]
Should pcf8525_watchdog_init() also call
watchdog_stop_on_unregister(&pcf8525->wdd)?

Without WDOG_STOP_ON_UNREGISTER set, if the driver is unbound via sysfs
while the watchdog is active, or if devm_rtc_register_device() fails in
pcf8525_probe() after userspace has opened /dev/watchdog,
devm_watchdog_unregister_device() removes the watchdog device without
stopping the hardware countdown in PCF8525_REG_WD_VAL, leaving the system to
reset when the timer expires.

[ ... ]

> @@ -973,6 +1195,42 @@ static int pcf8525_unmask_irqs_inta(struct pcf8525 =
*pcf8525)
>  	return regmap_write(pcf8525->regmap, PCF8525_REG_INTA_MASK2, m2);
>  }
> =20
> +static int pcf8525_suspend(struct device *dev)
> +{
> +	struct pcf8525 *pcf8525 =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* Stop watchdog first: failure here must abort suspend. */
> +	if (IS_ENABLED(CONFIG_WATCHDOG_CORE) &&
> +	    device_property_read_bool(dev, "reset-source") &&
> +	    watchdog_active(&pcf8525->wdd)) {
> +		ret =3D pcf8525_wdt_stop(&pcf8525->wdd);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pcf8525_resume(struct device *dev)
> +{
> +	struct pcf8525 *pcf8525 =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* Ping watchdog first to avoid an imminent reset after resume. */
> +	if (IS_ENABLED(CONFIG_WATCHDOG_CORE) &&
> +	    device_property_read_bool(dev, "reset-source") &&
> +	    watchdog_active(&pcf8525->wdd)) {
> +		ret =3D pcf8525_wdt_ping(&pcf8525->wdd);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

[Severity: High]
Can a deferred keepalive ping from the watchdog core fire after
pcf8525_suspend() has stopped the hardware watchdog?

Because pcf8525_watchdog_init() sets min_hw_heartbeat_ms =3D 4000 ms, a
userspace keepalive ping within 4 seconds prior to system suspend causes
__watchdog_ping() in drivers/watchdog/watchdog_dev.c to arm wd_data->timer,
which queues wd_data->work (watchdog_ping_work) on the non-freezable
watchdog_kworker kthread.

Since pcf8525_watchdog_init() does not call
watchdog_stop_ping_on_suspend(&pcf8525->wdd), wd_data->timer and
wd_data->work are not canceled on suspend, and WDOG_ACTIVE remains set when
pcf8525_suspend() calls pcf8525_wdt_stop(). If wd_data->timer expires after
pcf8525_suspend() runs (for example during s2idle or before noirq suspend),
watchdog_ping_work() sees watchdog_active() is true and calls
__watchdog_ping() -> pcf8525_wdt_ping(), either re-enabling the hardware
watchdog while the system is asleep or issuing an I2C transfer after the
parent I2C adapter has suspended. In addition, pcf8525_resume() calls
pcf8525_wdt_ping() directly without updating wd_data->last_hw_keepalive or
serializing with wd_data->lock.

Could pcf8525_watchdog_init() call watchdog_stop_ping_on_suspend() (or use
watchdog_dev_suspend() and watchdog_dev_resume() in pcf8525_suspend() and
pcf8525_resume()) so the watchdog core cancels any pending ping timer/worker
on suspend and updates last_hw_keepalive on resume?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030110139.1929=
109-1-shivprakash.gupta@nxp.com?part=3D3
