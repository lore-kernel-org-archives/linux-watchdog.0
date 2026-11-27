Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769780;
	b=1TGF6EepnK0rlQpz2g2h/DpF2IeuJULtoAfhlSeWvCdte4NVyLnTdsSjXb78MX06g40h
	 k7UAipqzMXR/qekHbUN8OCpIFvPF7jVzyA95QbnYEqCBLnLVaC7xmnbzmshR/HAU/kmFq
	 oL/MR+3TXCd3V7nKCXEphXkgImy+5NavB4ejkUdnmfyh7GqzzxyVrsmj95f9N9+Lk9RT6
	 eOBw9Yz0j0c17DL5muOQo/5Mj33+kXMXkGp/wkRsZm8OlHlaONmJGNQPQAXJTTi6w/1qL
	 3fZDRYniGTkpGLOdRm23euN3GZ8a2TPclvfS/pjntTOi6pF1PrGrNuEp2H1syk+70uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769780;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=84YQ+92gZQQer+YFn82QrUAblUTgEf1FZaaFxzkgEeo=;
	b=gQ/kEb1mSH2vYYH93DWDR8JIIlZ/sTZIhkIH2fU0BI2/f+KlwO8IlSYXXjWu890NrvZE
	 4PCvIDL1K3+8P49INnVCFLzQ8QNmS4wenmuOav7HYffo741Av3T5PBf7R9DAwC5Fb3mNZ
	 vAdlWNaw6UXciBXUCKuofTAZqAz8n4bQS0Un0ICL2XAuphBTbnew9JmXreaPWSsln8djh
	 SW8UfrOcBH9n+HJBiVVpPMkZQhJdPDfoWTkfOdq+XrGkMCRTJZvbr8aFCKdG/gjGIToCo
	 Z3CdPz57Tna2BxAOTOtbTcZUofVXOoizlofulikjqZyZJUQNlo2GDhKQrOzfe3Hyirg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Aan/9AYA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F36606A332;
	Fri, 27 Nov 2026 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aan/9AYA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B871F000C1;
	Fri, 27 Nov 2026 08:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795769780;
	bh=84YQ+92gZQQer+YFn82QrUAblUTgEf1FZaaFxzkgEeo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Aan/9AYAm2oO0zVp0kjtJH8zuH9BwnyD5GJM3Lkd/zb1otCvbJsViezRvHCFR+7CY
	 hGZjVLOMZzFPiAZmdY7vb6WHSaJCp9qyUaXZWLIXBN35N23MJJ3YnDSUDpcTA9cpnK
	 IpYewfI8RZNaiarm51c0dZm2W+SrbiLYqpdZAyG3fGdfIZxIJSKEUULtWZBW6EaKKO
	 71UTFnClBaMTeaIG5p8e1QQtLdjIN9tgqGe5n8aLw2RVuBAPhVbxez8IyGRgFdJRP6
	 jqI19+ucL0L0vRs3dI4JcMlEmvECVXacH/S6LjBw/88MtzktHxSLORNuifyl/fR0jM
	 sv2XxOUriIwSQ==
Message-ID: <sashiko-outbox-236926@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/4] rtc: pcf8525: Add NXP PCF8525 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shiv Prakash Gupta" <shivprakash.gupta@nxp.com>, linux-rtc@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Cc: robh@kernel.org, conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261127083807.2844507-3-shivprakash.gupta@nxp.com>
References: <20261127083807.2844507-1-shivprakash.gupta@nxp.com>
 <20261127083807.2844507-3-shivprakash.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 08:56:19 +0000
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
- [Medium] rtc: pcf8525: premature and unmasked rtc_update_irq() in
  pcf8525_service_inta()
--

commit e9cdf26dadf9ecd9dd9b86e99bbe68880c22817f
Author: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>

rtc: pcf8525: Add NXP PCF8525 RTC driver

This commit adds an RTC driver for the NXP PCF8525 I2C real-time clock
with alarm, timestamp capture, aging offset, and backup switchover
support.

> diff --git a/drivers/rtc/rtc-pcf8525.c b/drivers/rtc/rtc-pcf8525.c
> new file mode 100644
> index 0000000000000..06ff14a1dbe14
> --- /dev/null
> +++ b/drivers/rtc/rtc-pcf8525.c
> @@ -0,0 +1,931 @@

[ ... ]

> +static int pcf8525_service_inta(struct device *dev, struct pcf8525 *pcf8=
525,
> +				bool *handled)
> +{
> +	unsigned int ctrl2, ctrl4;
> +	int i, ret;
> +
> +	*handled =3D false;
> +
> +	/* Flags can be set again while INTA is low, so re-read until clean. */
> +	for (i =3D 0; i < PCF8525_IRQ_MAX_PASSES; i++) {
> +		ret =3D regmap_read(pcf8525->regmap, PCF8525_REG_CTRL2, &ctrl2);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regmap_read(pcf8525->regmap, PCF8525_REG_CTRL4, &ctrl4);
> +		if (ret)
> +			return ret;
> +
> +		if (!(ctrl2 & (PCF8525_CTRL2_AF | PCF8525_CTRL2_MSF)) &&
> +		    !(ctrl4 & PCF8525_CTRL4_TSF))
> +			return 0;
> +
> +		if (ctrl4 & PCF8525_CTRL4_TSF) {
> +			ret =3D pcf8525_handle_ts(dev, pcf8525);
> +			if (ret)
> +				return ret;
> +
> +			*handled =3D true;
> +		}
> +
> +		if (ctrl2 & PCF8525_CTRL2_AF) {
> +			ret =3D pcf8525_update_ctrl2(pcf8525, PCF8525_CTRL2_AF, 0);
> +			if (ret)
> +				return ret;
> +
> +			rtc_update_irq(pcf8525->rtc, 1, RTC_IRQF | RTC_AF);
> +			*handled =3D true;
> +		}

[ ... ]

> +static int pcf8525_setup_inta(struct i2c_client *client,
> +			      struct pcf8525 *pcf8525, int irq)
> +{
> +	struct device *dev =3D &client->dev;
> +	bool handled;
> +	int ret;
> +
> +	/* INTA is still masked, so drain all stale flags before enabling it. */
> +	ret =3D pcf8525_service_inta(dev, pcf8525, &handled);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to drain pending INTA\n");
> +
> +	ret =3D devm_request_threaded_irq(dev, irq, NULL, pcf8525_irq,
> +					IRQF_ONESHOT, dev_name(dev), dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to request INTA IRQ\n");
> +
> +	pcf8525->irq_enabled =3D true;
> +
> +	ret =3D devm_add_action_or_reset(dev, pcf8525_mask_inta, pcf8525);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D pcf8525_unmask_irqs_inta(pcf8525, true);
> +	if (ret)
> +		return ret;

[ ... ]

> +	/* Wakeup must be set up before registering so wakealarm is exposed. */
> +	if (irq > 0 && !(client->flags & I2C_CLIENT_WAKE)) {
> +		ret =3D devm_device_init_wakeup(dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (irq > 0) {
> +		ret =3D pcf8525_setup_inta(client, pcf8525, irq);
> +		if (ret)
> +			return ret;
> +	} else if (wakeup) {
> +		ret =3D pcf8525_setup_wakeup_only(dev, pcf8525);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D devm_rtc_register_device(pcf8525->rtc);

[Severity: Medium]
Can pcf8525_service_inta() call rtc_update_irq() during probe before
devm_rtc_register_device(), or when PCF8525_CTRL2_AIE is disabled?

In pcf8525_probe(), wakeup is enabled before pcf8525_setup_inta() runs.
If PCF8525_CTRL2_AF is already set when pcf8525_setup_inta() drains
pending flags, pcf8525_service_inta() calls rtc_update_irq(), which
calls pm_stay_awake(rtc->dev.parent) and queues rtc->irqwork
(rtc_timer_do_work()).  When PCF8525_SC_OSF is also set (such as after
power-on), rtc_timer_do_work() calls __rtc_read_time() ->
pcf8525_read_time(), gets -EINVAL, and returns early without calling
pm_relax(rtc->dev.parent), leaving the wakeup source active and blocking
system suspend.

When PCF8525_SC_OSF is clear, queuing rtc->irqwork and unmasking INTA in
pcf8525_setup_inta() before devm_rtc_register_device() races with
__devm_rtc_register_device():

CPU0                              kworker
pcf8525_probe()
  pcf8525_setup_inta()
    pcf8525_service_inta()
      rtc_update_irq()
        schedule_work(&rtc->irqwork)
                                  rtc_timer_do_work()
                                    /* timerqueue is still empty */
                                    rtc_alarm_disable(rtc)
  devm_rtc_register_device()
    rtc_device_get_offset()
    rtc_initialize_alarm()

rtc_timer_do_work() also reads rtc->offset_secs while
rtc_device_get_offset() initializes it without holding rtc->ops_lock,
and disables PCF8525_CTRL2_AIE in hardware before rtc_initialize_alarm()
imports an existing alarm into rtc->timerqueue.

In addition, pcf8525_alarm_irq_enable(dev, 0) only clears
PCF8525_CTRL2_AIE while leaving the per-field alarm enable bits active
in PCF8525_REG_ALM_SEC..YEAR, so the comparator still sets
PCF8525_CTRL2_AF on a match.  Because pcf8525_service_inta() does not
check PCF8525_CTRL2_AIE, a later timestamp interrupt (PCF8525_CTRL4_TSF)
on the shared INTA line triggers a spurious rtc_update_irq().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127083807.2844=
507-1-shivprakash.gupta@nxp.com?part=3D2
