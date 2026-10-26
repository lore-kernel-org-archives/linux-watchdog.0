Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010973;
	b=QBPLsyC35LPeAFUhaE+6VLoGJ10uKoLNGHQd6hODhx/aUsGSouTvUrHE0sSgfhApp1iY
	 L06wHNj3fxhdD6DICu5QxI8npJEfHS4VOUe4QvUUGjuBdfzliJ/lRv+S/YuSl0PJ8UXpH
	 6yPIASVABsGyi1dh2cOTLchHAQhtdzyTFqkKdNcwzDctUSk1SA9HNQ379dyF/EAJaitcq
	 UqamCKVYNlHbhSCjGls3jZs4NZx6hqBynn3CP4g2bXYSe6n7bF0lCcVhTfMWZKr3FBQYF
	 ehLg+WvyjOpRie2CGwBTod5wY3EU3BztatkemTdaVH/3yyFtnQKjwF9khrnJYMXlPXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010973;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1mhzcflxquF8ObSwJmynSsabPfSs0R8YC+fiqPz1aZg=;
	b=RH7D9FhLgJCjn3Ur1jB2fcQBT5T53b3JEQz07gUO/4Jw498m7uIGHSQexUXaa2oGvSJs
	 8d57bvZkO5UG4Th8SEAhQl6aQHX1hHHCc5tnY3054kpP6GDYLC9eqhsAD3g4XxOGkXd+J
	 bTUJTZMs+/nzWLKZPi1svzXJQ8BcrsPzTEbwcDwbX5j2By0zE9rpcYh0J3sD47OHZH4mj
	 OFJNGc8LVJRfkWXgZDHCUomh4SKBrZteylLu/niVgJlH8HqdoTdydPsTbd4AHKsO3gBbv
	 c0MYfv8Kgae/r757fqezt3snSrnnv4dA4rX+RG09AQZHp4qejWazdA5Y+jl2O5eQmMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ilv4AZP1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DED2606A322;
	Mon, 26 Oct 2026 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ilv4AZP1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97121F01828;
	Mon, 26 Oct 2026 10:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793010973;
	bh=1mhzcflxquF8ObSwJmynSsabPfSs0R8YC+fiqPz1aZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ilv4AZP1bNj+x6S/DrRxzh/iop40+JbST5pmBPTECInKMpz8e9iyVBVIdckg6zrVL
	 CH1IOTX2bYWsozDMkAMOl+hazbP4QaXLU2Clg3ZnZAVIIH6Qs1EUJX2iJbLgxd25JC
	 7p6hxXZE8K29btQE94R/JSLFWNc3Ixcp54/HUkmyh/kbyHhlW8hKltz+PdIb5rgnnz
	 ZxerZvVRtQiS4neWAJ1kZwgHuz9ICNtg8sTnJFcdbGxa+egpzIqP26alP2fEf+f5hn
	 EG0dk4ZmqUS9Hin1XWXQTMQxiQQj4DDUqgi7gnAQHIKxZRxgOr+z6xx0FbtTyssSeP
	 f0HhQoeATOcvg==
Message-ID: <sashiko-outbox-184969@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/5] rtc: pcf85363: support reporting battery
 switch-over via RTC_VL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc: robh@kernel.org, conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261026094712.205214-2-lakshay.piplani@nxp.com>
References: <20261026094712.205214-1-lakshay.piplani@nxp.com>
 <20261026094712.205214-2-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:36:12 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] rtc: pcf85363: unacknowledged FLAGS_A1F holds INTA low in wakeup=
-only mode
--

commit 655ad6de5d4c27a6bb5b02bf6ca7a7a0b68d6b38
Author: Lakshay Piplani <lakshay.piplani@nxp.com>

rtc: pcf85363: support reporting battery switch-over via RTC_VL

This commit adds support for reporting and clearing the battery switch-over
flag (FLAGS_BSF) via the RTC_VL_READ and RTC_VL_CLR ioctls, introduces
pcf85363_clear_flags() for write-0-to-clear flag handling, and updates
pcf85363_probe() to selectively mask unused interrupt sources and clear
stale flags instead of zeroing CTRL_FLAGS.

> diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> index ccc7834e57599..00f37ffcca260 100644
> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c
[ ... ]
> @@ -435,17 +577,52 @@ static int pcf85363_probe(struct i2c_client *client)
> =20
>  	wakeup_source =3D device_property_read_bool(&client->dev,
>  						  "wakeup-source");
> -	if (client->irq > 0 || wakeup_source) {
> -		err =3D regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
> -		if (err)
> -			return dev_err_probe(&client->dev, err,
> -					     "failed to clear flags\n");
> =20
> -		err =3D regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
> +	/*
> +	 * Latch and clear any battery-switch event that occurred before
> +	 * probe (for example while the main supply was off) instead of
> +	 * blanket clearing CTRL_FLAGS, so the cached state is preserved.
> +	 */
> +	scoped_guard(mutex, &pcf85363->lock) {
> +		ret =3D pcf85363_collect_events(pcf85363);
> +		if (ret < 0)
> +			return dev_err_probe(&client->dev, ret,
> +					     "Failed to latch boot-time events\n");
> +	}
> +
> +	/*
> +	 * Battery-backed registers can retain stale state across a power cycle.
> +	 * A stale asserted flag would storm the level-triggered INTA line, so
> +	 * disable only the interrupt sources and Alarm2 enables this driver
> +	 * never services and clear their flags; leave the managed sources
> +	 * (A1IE, BSIE) and Alarm1 for their own paths to arm. WDIE is masked
> +	 * too so a bootloader-armed watchdog cannot storm INTA before the
> +	 * driver is ready to service it.
> +	 */
> +	ret =3D regmap_update_bits(pcf85363->regmap, CTRL_INTA_EN,
> +				 INT_WDIE | INT_A2IE | INT_OIE | INT_PIE | INT_ILP,
> +				 0);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to mask unused INTA sources\n");
> +
> +	ret =3D regmap_update_bits(pcf85363->regmap, DT_ALARM_EN,
> +				 ALRM_MIN_A2E | ALRM_HR_A2E | ALRM_DAY_A2E, 0);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to mask Alarm2 enables\n");
> +
> +	ret =3D pcf85363_clear_flags(pcf85363, FLAGS_A2F | FLAGS_PIF);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to clear stale flags\n");
> +
> +	if (client->irq > 0 || wakeup_source) {
> +		ret =3D regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
>  					 PIN_IO_INTAPM, PIN_IO_INTA_OUT);
> -		if (err)
> -			return dev_err_probe(&client->dev, err,
> -					     "failed to set interrupt pin mode\n");
> +		if (ret)
> +			return dev_err_probe(&client->dev, ret,
> +					     "Failed to configure INTA pin\n");
>  	}

[Severity: Medium]
On boards configured with wakeup-source where client->irq <=3D 0 (for examp=
le,
when INTA is wired to a PMIC or power-on circuit rather than a dedicated SoC
IRQ, or when devm_request_threaded_irq() fails and clears client->irq),
can leaving FLAGS_A1F uncleared in pcf85363_probe() keep the level-low INTA
pin permanently asserted after an alarm wakes or boots the system?

Previously, pcf85363_probe() cleared all flags in CTRL_FLAGS when
client->irq > 0 || wakeup_source, which acknowledged a boot-time FLAGS_A1F
event and released INTA.

With this change, pcf85363_probe() only clears FLAGS_BSF (via
pcf85363_collect_events()) and FLAGS_A2F | FLAGS_PIF, leaving INT_A1IE and
FLAGS_A1F asserted. When client->irq <=3D 0, pcf85363_rtc_handle_irq() is n=
ot
registered to clear FLAGS_A1F. In addition, devm_rtc_register_device() ->
rtc_initialize_alarm() -> __rtc_read_alarm() -> pcf85363_rtc_read_alarm()
reads alrm->enabled =3D 1 with tm_year =3D -1, which rolls the expired alarm
forward to the next year and enqueues rtc->aie_timer without touching the
hardware registers, leaving INTA driven low and causing wakealarm_store() to
return -EBUSY unless the alarm is explicitly disabled or overwritten.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026094712.2052=
14-1-lakshay.piplani@nxp.com?part=3D2
