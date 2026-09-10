Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02584343887;
	Thu, 10 Sep 2026 05:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789017571; cv=none; b=mtgg354TmIHfdxgLtoyrHGINxdTk0smU559wWQrIzGjkVrmd/DId+ju1cCgeg/1y9YWfpOuf6cgDdXGQOk7lcqwgaOQehFcTIhtcmcdVGATXuHYsr2znC8S9CVOy2Ja/pFcfv4++K1toJnzPz8rrDAn5s7ZgnwjNYrzJwfohE1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789017571; c=relaxed/simple;
	bh=sCIravbDLR4dRvfc0AnyNjajRmfkR8ffGY8bBza22m0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ExQbpSZsMKjJNG82G4iHss8VpxHlngK3AQqEZhB5NWcXvCePMqxSpL3cirLzt+Qeis8KQV09K5wPNHas2ZZBfCXJ4a0oxA7v+1oaEAj0Z7OQJfBSUl9YXgD6arBxwEXbtW3JA9Hqr6JbhraJvdyALFbcNE/eXOed3EadmmkgQYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbAlzTTm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbAlzTTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409D01F000FF;
	Thu, 10 Sep 2026 05:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789017569;
	bh=yjt/wM/Iti8exvVkW3P8C1tJl4czHm4nOQsXCqBz+lI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AbAlzTTm/LuRPzhqnB6XC8MN7yn8DSCkb95k1kweA4USR3ckM80iWMdgYAJQHYLEm
	 MFoHcY4FtflSEsQRHW8vAh1lxt2VKzaVzJlTzFeKdzJFSsFaDeSR0Kr1dxH627WfOS
	 prSG+A48f7YMF0jeJhnqImY0Ugh/Vt0PcXmZJIxQxTRZiH0z/OGkzfmQ5P2cGy+FBX
	 IDDC9SkGaU5+hX7b0bHq9z9hDHXWblSsfsqaWpeFGVS3OmqtOJGMJJKbw9qyN6cMqt
	 iLcE2w1JVozr8LhDeRTgYYX9hGnSZZIue4bjY4E15vbPujUgiy4zjOwPtR1otQxFBi
	 yZR9PAjE4Fakw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/5] rtc: pcf85363: add timestamp support with
 configurable timestamp mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260910050747.1901440-3-lakshay.piplani@nxp.com>
References: <20260910050747.1901440-1-lakshay.piplani@nxp.com>
 <20260910050747.1901440-3-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 05:19:28 +0000
Message-Id: <20260910051929.409D01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Ignored `dev_err_probe()` return value defeats probe deferral fo=
r the INTA interrupt line.
- [Medium] Unconditionally clearing `RTC_FEATURE_ALARM` when no IRQ is pres=
ent breaks wake-on-alarm functionality for boards that only configure a wak=
eup-source.
--

commit c4131e782120105d3473c8eca13fcfb2ec8f0bf1
Author: Lakshay Piplani <lakshay.piplani@nxp.com>

rtc: pcf85363: add timestamp support with configurable timestamp mode

This commit adds support for the timestamp capture registers on the
PCF85263/PCF85363 to latch the time on selected events. The capture source
is configured via device tree and exported through read-only sysfs attribut=
es,
along with other initialization cleanups.

> diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c
[ ... ]
> @@ -573,57 +819,75 @@ static int pcf85363_probe(struct i2c_client *client)
[ ... ]
> +		ret =3D devm_request_threaded_irq(dev, irq_a, NULL,
> +						pcf85363_rtc_handle_irq,
> +						irqflags | IRQF_ONESHOT,
> +						"pcf85363-inta", client);
> +
> +		if (ret) {
> +			dev_err_probe(dev, ret, "INTA IRQ request failed\n");
> +			irq_a =3D 0;
> +			clear_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
> +		} else {

[Severity: Medium]
Will ignoring the return value of dev_err_probe() in this block defeat
probe deferral?

If devm_request_threaded_irq() fails because the interrupt provider is not
yet ready, it returns -EPROBE_DEFER. By not propagating this error and
falling back to setting irq_a to 0, the driver permanently drops interrupt
support on affected boots instead of allowing the core to defer probing.

> +			u8 inta_en =3D INT_BSIE;
> +
> +			/*
> +			 * Enable the timestamp interrupt only when a capture
> +			 * mode is configured; always enable battery-switch.
> +			 */
> +			if (ts_mode_configured)
> +				inta_en |=3D INT_TSRIE;
> +
> +			ret =3D regmap_update_bits(pcf85363->regmap, CTRL_INTA_EN,
> +						 INT_BSIE | INT_TSRIE, inta_en);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "Failed to enable INTA sources\n");
>  		}
> -	}
> -
> -	if (client->irq > 0 || wakeup_source) {
> -		device_init_wakeup(&client->dev, true);
> -		set_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
>  	} else {
> +		/* Without an interrupt line the alarm cannot be delivered. */
>  		clear_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
>  	}

[Severity: Medium]
Does clearing RTC_FEATURE_ALARM unconditionally when there is no direct IRQ
break wake-on-alarm functionality?

If a system routes the RTC interrupt pin to an external PMIC to wake the
system and defines the device tree with a wakeup-source property but no
direct interrupts property, this logic clears the alarm feature bit. The
RTC core will reject alarm setup requests when this feature bit is cleared,
which seems like it could cause a functional regression for userspace tools
like rtcwake that rely on the wakeup-source capability.

> +	if (irq_a > 0 || wakeup_source)
> +		device_init_wakeup(dev, true);
> +
> +	dev_set_drvdata(&pcf85363->rtc->dev, pcf85363);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910050747.1901=
440-1-lakshay.piplani@nxp.com?part=3D3
