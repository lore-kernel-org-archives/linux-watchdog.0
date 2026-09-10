Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E3F3B3C0F;
	Thu, 10 Sep 2026 06:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021232; cv=none; b=Gy21VYJQk4xvLHFb0Rn8kTgO5mdc3NlpGOQPufnOIa2H86edQ+brrVHs/mSrTJQ4NjP1AUHZNRqV0Gpg1PPQyWJ8pfswv2leN4ibqyJfCKiwUFtkfbfrf3F2QCD3+LoY7UK7hl7bJ7A8DwsUyHZ78UXuasUwrTr/92+khM/PklU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021232; c=relaxed/simple;
	bh=6COYCb6K/ta7F8KU75M8uMgsuX5FTVMnxJFmHv9m/N0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uZ+Tx5+yNjMG5ImGxGnmep6TRujtqMAhh7qJ+fCoZNZSvNSePZJ99qPWHOWJMGoOBMXg7PhRWX+zpekZqc+1/5uMlZuMv9Uw9m4uovK4zC2VWMAi4OJoRirFhQm8t09uA7I0ZN74g+YyHOBgaCN9PHWd98XKkBF0cUp63NlCaws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrymQb6G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrymQb6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DDF1F000FF;
	Thu, 10 Sep 2026 06:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789021224;
	bh=shlJxtnCsoUG3GCdlFP+qjOr4I/LJYkEWNn/8DPRCAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TrymQb6GEV4bnot+r3QErDyErEAuwGtWwbRqbKWI6tTkJ/kRzeenju1hkcK15QnOS
	 G3uhWjL2OuY7Nk+Cj4xF4STbrJeI7hP5EdibTLiKLeonHagfjPdmLECAd1VpoNFIr5
	 thMz6wE0AU448TXBui/zenbSHtyTsGpWC2NEOHBnmQnKU1lJR2GlHZiPGGeNbk4cCE
	 1NP21Ar9DOxIwji3Xi1OTPJJOR2gwQPAZEF6tJwJl7pR/xittyrM4r1waiISuwPQ2T
	 VJy2zrTQRN3zD8/iboDn1mJC8kfilu5+OjJBmi7zRBuf3ccodVs65XTcdH0G9NHrO+
	 bYTfyyYzOzecQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] rtc: pcf8525: Add temperature sensor support via
 hwmon
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shiv Prakash Gupta" <shivprakash.gupta@nxp.com>
Cc: linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org
In-Reply-To: <20260910060912.2443551-5-shivprakash.gupta@nxp.com>
References: <20260910060912.2443551-1-shivprakash.gupta@nxp.com>
 <20260910060912.2443551-5-shivprakash.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 06:20:23 +0000
Message-Id: <20260910062023.E7DDF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The RTC driver registers a hardware monitoring device directly i=
nstead of using an auxiliary device driver, violating HWMON subsystem layer=
ing guidelines.
- [Medium] If hwmon device registration fails, the analog temperature senso=
r is left permanently enabled, causing unnecessary backup battery drain.
- [Medium] The analog temperature sensor is not disabled during system susp=
end, causing continuous backup battery drain.
--

commit 8de48a2b8b05df0e0fd29e3c00baaf40c4a06d38
Author: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
Date:   Thu Sep 10 06:09:12 2026 +0000

rtc: pcf8525: Add temperature sensor support via hwmon

This commit adds hardware monitoring support for the PCF8525 internal
temperature sensor. It registers the sensor via the hwmon interface to
expose temperature reading and update interval configuration.

> diff --git a/drivers/rtc/rtc-pcf8525.c b/drivers/rtc/rtc-pcf8525.c
> index c2eab983f1ff0..a2958eb3a5026 100644
> --- a/drivers/rtc/rtc-pcf8525.c
> +++ b/drivers/rtc/rtc-pcf8525.c

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
> +	/*
> +	 * Enable digital temperature readout first so that the hardware is
> +	 * ready before the sysfs attributes are exposed to userspace.  The
> +	 * previous order (register hwmon device first) left a window where
> +	 * a concurrent sysfs read would return invalid data, and left the
> +	 * device permanently broken if this step subsequently failed.
> +	 */
> +	ret =3D regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL5,
> +				 PCF8525_CTRL5_TEMP_RD_EN,
> +				 PCF8525_CTRL5_TEMP_RD_EN);

[Severity: Medium]
Once the temperature sensor is enabled here, it stays active for the lifeti=
me
of the device. Looking at pcf8525_suspend() in this file, it does not clear
the PCF8525_CTRL5_TEMP_RD_EN bit.

Does the analog temperature sensor need to be disabled during system suspend
to prevent continuous backup battery drain while the system is asleep?

> +	if (ret) {
> +		dev_warn(dev, "failed to enable temperature readout: %d\n", ret);
> +		return;
> +	}
> +
> +	/*
> +	 * Register a devm cleanup action to disable TEMP_RD_EN when the
> +	 * driver is unbound, preventing the analog sensor from draining
> +	 * the backup battery after driver removal.
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

[Severity: Medium]
According to the HWMON subsystem guidelines, shouldn't hardware monitoring
functionality for multi-function devices be implemented as an auxiliary dev=
ice
driver residing in drivers/hwmon/ instead of being registered directly from
drivers/rtc/?

> +	if (IS_ERR(hwmon_dev))
> +		dev_warn(dev, "failed to register HWMON device: %ld\n",
> +			 PTR_ERR(hwmon_dev));

[Severity: Medium]
If hwmon device registration fails here, it only logs a warning and returns.

Since the probe function ignores this failure and succeeds, the device rema=
ins
bound. Does this mean the devm cleanup action setup earlier will not execute
until device removal, leaving the analog temperature sensor permanently
enabled and unnecessarily draining the backup battery if hwmon registration
fails?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910060912.2443=
551-1-shivprakash.gupta@nxp.com?part=3D4
