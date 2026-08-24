Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAE63EC805;
	Mon, 24 Aug 2026 07:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555070; cv=none; b=PUmyDxbyeVn1H5m+l3tjQwu3Rrx9CNlFPYs2Vm0JpZJA+R9Up64zJqgkDqygrp/DZnpu5ImEZ2vZcwRCJtZfsObcRkcbQAeAoD3bjikoSNwKmjFqKz1HppNX7oFo9BTUXAjolW843KMoWvXKUO+WeOpXHCJic0+kJ2+LwHgRQHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555070; c=relaxed/simple;
	bh=1BeKazjcTmPXtuKjRZS2aWbfxFtHnjtYWBO9DHjMqGI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PUdIRiY24O0c6tF+RHI3/mSowvsM2qVYgvNo4oiMjR9rSNwxi7LtO0gFO3dyt3WWd10oRh8O/R90bAxqTZ+1XCJOSboD587kBFHmmlxt1Sn9ByUso/+nIrIoOcl+WoZTJ8Ut20V82hX5VIpaebObZh2LyAo/YXfXA6zWd6N2t6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhrjhnQz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhrjhnQz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E7F1F000E9;
	Mon, 24 Aug 2026 07:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787555068;
	bh=8d+rqTNG1VKlTEluR0WWoGykX/Zv0pJFynawgFeVoCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VhrjhnQzfTJ+j4YU6B7LrFHyj/sLgciWY8NsOGIDyr0iUHhRXJD4tS1orNl+TT1RW
	 yPSqFXWF0evGibIItkDYeiIOqdbQAToX4LXl97P6nOGtNE7uiOsmodho3mnE5uj4vU
	 WerEq6F31vQag2BYXGjjBNo3oqA+UM+TGRe8/C522jGH1BPNVn7YBWooh9mIkp5SGM
	 /aKXST7IoZkXilkprRpPhGNMVrVeuTA4SzQpJuqx5ScAdTtaafNpQsfjZfgeJtQOdP
	 6dGnuUFHNfzXg80T/tKNnr2x9u1J3CtK1VVEdMTjtfqJiz8L9jZY93LGPPXNxgWaeT
	 03h9BaIpc7XEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] rtc: pcf8525: Add temperature sensor support via
 hwmon
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shiv Prakash Gupta" <shivprakash.gupta@nxp.com>
Cc: linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260824065531.693701-5-shivprakash.gupta@nxp.com>
References: <20260824065531.693701-1-shivprakash.gupta@nxp.com>
 <20260824065531.693701-5-shivprakash.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 07:04:27 +0000
Message-Id: <20260824070428.57E7F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The hwmon interface is exposed to userspace before the hardware is=
 configured, and remains permanently exposed in a broken state if hardware =
configuration fails.
- [Medium] Hardware monitoring functionality is implemented and registered =
directly from the RTC driver instead of using an auxiliary device, violatin=
g HWMON subsystem layering guidelines.
- [Medium] The PCF8525_CTRL5_TEMP_RD_EN bit is enabled during probe but is =
never disabled when the driver is removed or unbound.
--

--- Patch [4]: [PATCH v2 4/4] rtc: pcf8525: Add temperature sensor support =
via hwmon ---
commit 78a53fcd5265022e4a59c395bbca42f812fe19b7
Author: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>

rtc: pcf8525: Add temperature sensor support via hwmon

Register the PCF8525 internal temperature sensor through the hwmon
interface when CONFIG_RTC_DRV_PCF8525_HWMON is enabled.

Exposes temp1_input (millidegrees Celsius, read-only) and
update_interval (milliseconds, read/write).

> diff --git a/drivers/rtc/rtc-pcf8525.c b/drivers/rtc/rtc-pcf8525.c
> index 415615ea0a406..4b8ac0c6fb23e 100644
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
> +	 * Register the hwmon device first.  Only enable the hardware
> +	 * temperature readout afterwards so that the device is not left
> +	 * enabled if registration fails.
> +	 */
> +	hwmon_dev =3D devm_hwmon_device_register_with_info(dev, "pcf8525",
> +							 pcf8525,
> +							 &pcf8525_hwmon_chip_info,
> +							 NULL);

[Severity: Medium]
Should this hardware monitoring functionality be implemented as an auxiliary
device driver residing in drivers/hwmon/ instead?

According to the hwmon subsystem guidelines, if a chip's primary function is
not hardware monitoring, its hwmon functionality should be implemented as an
auxiliary device, rather than registering directly from another subsystem l=
ike
drivers/rtc/.

> +	if (IS_ERR(hwmon_dev)) {
> +		dev_warn(dev, "failed to register HWMON device: %ld\n",
> +			 PTR_ERR(hwmon_dev));
> +		return;
> +	}
> +
> +	/* Enable digital readout; preserve TSIE, CL and XTL_TYP. */
> +	ret =3D regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL5,
> +				 PCF8525_CTRL5_TEMP_RD_EN,
> +				 PCF8525_CTRL5_TEMP_RD_EN);

[Severity: High]
Does registering the hwmon device before configuring the hardware expose a
broken interface to userspace?

If userspace reads the sysfs attributes immediately after
devm_hwmon_device_register_with_info() completes but before this
regmap_update_bits() call, it might read invalid data.=20

Also, if this regmap_update_bits() fails, the hwmon device is left
registered but permanently broken since there's no rollback of the hwmon
registration.

[Severity: Medium]
Does this code leak the hardware state when the driver is unbound?

The PCF8525_CTRL5_TEMP_RD_EN bit is enabled here, but there doesn't appear
to be a corresponding devm_add_action_or_reset() or similar cleanup to
disable it upon driver removal.

Leaving internal analog sensors active on an RTC can cause excessive
power drain from the backup battery when the driver is unloaded.

> +	if (ret)
> +		dev_warn(dev, "failed to enable temperature readout: %d\n", ret);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824065531.6937=
01-1-shivprakash.gupta@nxp.com?part=3D4
