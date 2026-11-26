Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795678241;
	b=38Bbdft99gzS5MgHJeTLoV8sUHqshnF5tDEYkrsBbfmMlxSvFYTFhO3ez5uiDUwWMKHx
	 CkqbgQTb0GI4a6/Sx0BNUIgAz3y9H8PVXE+KmWTxcrt8C6k3ksr28gkJ5r0lI2nOj8NRt
	 OYzAz8xKUcgqUGkrNs6wYa/ND+F85QzOWcpMhFpzYOGTu4DKVZWMu6rWP7hKPnF7vXntd
	 W29vj4nscmKwokbaxkD+kMxiilBkHaJMW7QMC5+er9R08rVQ4o2ZDhUtch3VV2VIF6R/e
	 cohy1EXex2Uxi+LNom1YghXcE4DfIJtPZgm7ttjq8PwaaH/dhmU7BzkBK8E+qD3gMZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795678241;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xO6WyGa2eRIEDyJ/2WQsa8VZvDalp4Evwvz00NFfkoQ=;
	b=UA1G5AGg82zDomF8RMkXT2z7lA8U2JAYvTgwOcsVcOZtLfPZl4l07c3QDKD3mFGexVYQ
	 dcge4CHUvnae/8q98dR3OpsfEmo74vrdm4Bpg4du/AxgoLFEVdr/LMXOF+7rs7lmrsgew
	 zy+jbX2Te+CrpBxK4YNDICTwXqinjR7O283vqpf0keOJzTlZQJoxvWiR5wOREL3DzSGpO
	 u3guaRzVWtZI9uRPx5Xj2M59JUpmhuThJMv+j6W590p7i1MHWM8HLyxrTeozvN9Km5ZYP
	 LOMlnMxxKzsjM5fd7IDlHKlNnt1GKONhzZ3SNbf4YpOBdrAPJ6H5luPmIpaVnNL16MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OUO2anzo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849C9606A31C;
	Thu, 26 Nov 2026 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OUO2anzo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A192A1F000C6;
	Thu, 26 Nov 2026 07:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795678241;
	bh=xO6WyGa2eRIEDyJ/2WQsa8VZvDalp4Evwvz00NFfkoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OUO2anzoGCMzU1dS8mz7qTKe8B94A4ZnQtM5RkIW7IJgX9cTZr1deDA8tSeCorgaj
	 y1ibzrs+hes0e/WXH0uPqNoJGk6dxaDIXyOmv4Q8bxCUECO4WZnsCralfkiDC1LhvX
	 EKCzC+puUdCBzxaE/H/CVxt60WF0keYV+NBSfg0Q5uP7dQmvObw5pvF1Cx+MhG3ISr
	 6JOl8fwTfyy1R5dsemFfAiblb1AQ/YP2an/Fe+a5KOrkQ87ZwRwyXoscN0V0xOccs5
	 SzBPlPClzfhFnkuZQBBDfuF5AkxuvaFeAuDfQkrAtC71yXF42L4bj6GBcaQ7r8Ub3l
	 cEJS+VA4NoS6g==
Message-ID: <sashiko-outbox-234957@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/4] rtc: pcf8525: Add NXP PCF8525 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shiv Prakash Gupta" <shivprakash.gupta@nxp.com>, linux-rtc@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Cc: robh@kernel.org, conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261126071124.2383368-3-shivprakash.gupta@nxp.com>
References: <20261126071124.2383368-1-shivprakash.gupta@nxp.com>
 <20261126071124.2383368-3-shivprakash.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 07:30:40 +0000
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
- [Medium] rtc: pcf8525: devm_rtc_register_device() called before INTA
  setup in probe
--

commit ac013f157325db026a034ab7ceb349efee94dcf3
Author: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>

rtc: pcf8525: Add NXP PCF8525 RTC driver

This commit adds an I2C RTC driver for the NXP PCF8525 with calendar,
alarm, timestamp capture, crystal aging offset, and backup switchover
support.

> diff --git a/drivers/rtc/rtc-pcf8525.c b/drivers/rtc/rtc-pcf8525.c
> new file mode 100644
> index 0000000000000..2b23b17d6750c
> --- /dev/null
> +++ b/drivers/rtc/rtc-pcf8525.c
[ ... ]
> +static ssize_t timestamp0_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct pcf8525 *pcf8525 =3D dev_get_drvdata(dev->parent);
> +	unsigned int ctrl4;
> +	time64_t ts =3D 0;
> +	int ret;
> +
> +	guard(mutex)(&pcf8525->ts_mutex);
> +
> +	if (pcf8525->irq_enabled) {
> +		if (!pcf8525->ts_valid)
> +			return 0;
> +
> +		ts =3D pcf8525->ts;
> +	} else {
> +		ret =3D regmap_read(pcf8525->regmap, PCF8525_REG_CTRL4, &ctrl4);
> +		if (ret)
> +			return ret;
> +
> +		if (!(ctrl4 & PCF8525_CTRL4_TSF))
> +			return 0;
> +
> +		ret =3D pcf8525_ts_read(pcf8525, PCF8525_REG_TS1_SEC, &ts);
> +		if (ret)
> +			return ret =3D=3D -ENODATA ? 0 : ret;
> +	}
> +
> +	return sysfs_emit(buf, "%lld\n",
> +			  (long long)pcf8525_ts_apply_offset(pcf8525, ts));
> +}
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
[ ... ]
> +static int pcf8525_probe(struct i2c_client *client)
> +{
[ ... ]
> +	ret =3D devm_rtc_register_device(pcf8525->rtc);
> +	if (ret)
> +		return ret;
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
> +	return 0;
> +}

[Severity: Medium]
Should pcf8525_setup_inta() and pcf8525_setup_wakeup_only() run before
devm_rtc_register_device()?

Registering the RTC device first exposes the sysfs attributes and /dev/rtcX
before pending INTA flags are drained and before pcf8525->irq_enabled is
set:

CPU0                              CPU1
pcf8525_probe()
  devm_rtc_register_device()
  pcf8525_setup_inta()
    pcf8525_service_inta()
      pcf8525_handle_ts()
        lock(&pcf8525->ts_mutex)
        regmap_write(CTRL4, 0)
        pcf8525->ts_valid =3D true
        unlock(&pcf8525->ts_mutex)
                                  timestamp0_show()
                                    lock(&pcf8525->ts_mutex)
                                    if (pcf8525->irq_enabled) // false
                                    regmap_read(CTRL4, &ctrl4)
                                    !(ctrl4 & TSF) -> returns 0
    devm_request_threaded_irq()
    pcf8525->irq_enabled =3D true

Because pcf8525_handle_ts() clears PCF8525_CTRL4_TSF in hardware and caches
the timestamp in pcf8525->ts while pcf8525->irq_enabled is still false, a
concurrent reader of timestamp0 takes the polling branch, sees TSF cleared,
and returns 0 instead of the captured timestamp.

In the wakeup-only path, pcf8525_setup_wakeup_only() also clears
PCF8525_CTRL2_AF and unmasks INTA after devm_rtc_register_device() has
already read the alarm state, and on driver unbind devres masks INTA and
frees the IRQ before unregistering the RTC device while
pcf8525->irq_enabled remains true.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126071124.2383=
368-1-shivprakash.gupta@nxp.com?part=3D2
