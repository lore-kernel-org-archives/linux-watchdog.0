Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358716;
	b=qyiIQn/zUDJREMilS1ZKpY5r0hIu3wjJ3G0pzR96mRvd6cTzuDL5c3jV1pKRAEGunEgd
	 ZUlMp45kr8QMDp8t1stNFxdCC/rBP9/YA8HwccOSfZeJHxHDWUyeWN8JDfcKrI0GWEMTR
	 ntb3TCFS26k6eRGZypwngSt6dvY+7r5vMrdSZcBLlPBijmKP5NmCiEGNpcbdOBhWp4m4Z
	 9Jme8GeY6ghb/FWDHcm1DwC99H6u63N+nTJoxnmjyeut3QzLA/n25EVxJuzSTfc+WnJfo
	 bbdXJ1Nz+8HbEevnzqdLWQ3yK4mbs5s266jWpQ1dYw/IDEJFR9IPLvv6P1BH+yIlq9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358716;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oXMbZ3pVdYvHHa3JOkotu83Y6g65TEPI0/Cr1onpmxY=;
	b=1eJ71zo6KWC6SvZJr46eqX6niLo9rJtP60mKcAv/D76G/Xzob6sGkWBudPCVhZ/q2c8p
	 GTtkZkOd4aTCPv5qoFjGIMA8sKLullKxDYH06UV5IEktMpRg+306rv0LXsYH/dGklgRWE
	 b8n4dHQkeBbLtEp4BVWmVgdx0KR9Ild2O6GaXKqb5X5idwy6vbRn0SrIysnLO6XdEwAoZ
	 4mWfxoF9PdkHn0wcMNrgNgE06++joAQZ9ADOnVnK+aI9LTp6oF0CsmkUa71j0AJnHScSh
	 74On6/U8kjPCu0Vwj9AKJURNt6hlA0En/Wz4TDADtoMJrmPhSxpqM+uGf8aEVJh3UzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lBiiFfE+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F825606A31F;
	Fri, 30 Oct 2026 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lBiiFfE+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7031F000C1;
	Fri, 30 Oct 2026 11:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793358716;
	bh=oXMbZ3pVdYvHHa3JOkotu83Y6g65TEPI0/Cr1onpmxY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lBiiFfE+qWET59YzVD/pC9ytP9cqHFLYISz/2mViQcTPRzlWdCPmRhhz1p66JG3iC
	 J77FR/w1YUI9MZ70oE1bjqe2Yv16Z44c90kYiaQJK6j99ibk14I2m4eFYjFTryNbaN
	 +7gSJfAD0NRMRNqOGO4RUmbV06Pif3oG8IrEUfNykVYzqGOAGidJ33gdbq1545VTw3
	 4E4e5qEEoxKMpJOl90RoVzbZeDQvylWOECmV0cqJK9+SAfSg9sk53IRJyJ/4XUSMnE
	 qGqxnQ2xeG2J1+RHmRahvj1ufcIITT4hCvrCN/YMoTPdCQ5tvKWEQvWxRl0KkAi3I/
	 2UgWDtm7YE6Qg==
Message-ID: <sashiko-outbox-190925@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] rtc: pcf8525: Add temperature sensor support via
 hwmon
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shiv Prakash Gupta" <shivprakash.gupta@nxp.com>, linux-rtc@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Cc: robh@kernel.org, conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261030110139.1929109-5-shivprakash.gupta@nxp.com>
References: <20261030110139.1929109-1-shivprakash.gupta@nxp.com>
 <20261030110139.1929109-5-shivprakash.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 11:11:55 +0000
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
- [Low] rtc: pcf8525: use devm_release_action() on hwmon error in pcf8525_h=
wmon_register()
--

commit 657bb5e33615f2ed31527354e958f8aeecac64a5
Author: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>

rtc: pcf8525: Add temperature sensor support via hwmon

This commit adds optional hwmon support for the PCF8525 on-chip temperature
sensor, exposing temperature readings and a configurable update interval.

> diff --git a/drivers/rtc/rtc-pcf8525.c b/drivers/rtc/rtc-pcf8525.c
> index f8fbc00bb464d..5cb984958f286 100644
> --- a/drivers/rtc/rtc-pcf8525.c
> +++ b/drivers/rtc/rtc-pcf8525.c
[ ... ]
> @@ -346,6 +349,217 @@ static int pcf8525_rtc_set_offset(struct device *de=
v, long offset)
[ ... ]
> +static void pcf8525_hwmon_register(struct device *dev,
> +				   struct pcf8525 *pcf8525)
> +{
> +	struct device *hwmon_dev;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_RTC_DRV_PCF8525_HWMON))
> +		return;
> +
> +	/* Enable the temperature readout before exposing hwmon attributes. */
> +	ret =3D regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL5,
> +				 PCF8525_CTRL5_TEMP_RD_EN,
> +				 PCF8525_CTRL5_TEMP_RD_EN);
> +	if (ret) {
> +		dev_warn(dev, "failed to enable temperature readout: %d\n", ret);
> +		return;
> +	}
> +
> +	/*
> +	 * Register a devm cleanup action to disable the digital
> +	 * temperature readout when the driver is unbound.
> +	 */
> +	if (devm_add_action_or_reset(dev, pcf8525_hwmon_disable_temp, pcf8525))=
 {
> +		dev_warn(dev, "failed to register HWMON cleanup action\n");
> +		return;
> +	}
> +
> +	/* Only expose sysfs attributes once the hardware is fully ready. */
> +	hwmon_dev =3D devm_hwmon_device_register_with_info(dev, "pcf8525",
> +							 pcf8525,
> +							 &pcf8525_hwmon_chip_info,
> +							 NULL);
> +	if (IS_ERR(hwmon_dev)) {
> +		dev_warn(dev, "failed to register HWMON device: %ld\n",
> +			 PTR_ERR(hwmon_dev));
> +		pcf8525_hwmon_disable_temp(pcf8525);
> +		return;
> +	}

[Severity: Low]
In pcf8525_hwmon_register() in drivers/rtc/rtc-pcf8525.c, if
devm_hwmon_device_register_with_info() fails after devm_add_action_or_reset=
()
has already registered pcf8525_hwmon_disable_temp() on dev, calling
pcf8525_hwmon_disable_temp(pcf8525) directly leaves the devres action queued
while pcf8525_probe() succeeds. When the device is later unbound, devres wi=
ll
invoke pcf8525_hwmon_disable_temp() a second time.

Should this error path call devm_release_action(dev,
pcf8525_hwmon_disable_temp, pcf8525) instead of calling
pcf8525_hwmon_disable_temp(pcf8525) directly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030110139.1929=
109-1-shivprakash.gupta@nxp.com?part=3D4
