Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F00936F90C;
	Fri,  7 Aug 2026 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092489; cv=none; b=jpRO1gA0GS9eyF7WpY2iR6RPnB4B34ksckt9sA5dIpORGWHVpzqqDth6l+FA5ujxWzgQKjZRWldSc7OcKb12kKp4vM+qnGR1CMxlMqj6YQhuzuL+lUKFS45v4jZMLGtgnusKxI6y+o0uhEvn/Swuv3rtgpaFFTfZpGcPQtvdTH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092489; c=relaxed/simple;
	bh=uFvpqfmdeJLdg0olSWYlfI5CRikkWCpik7xUxScVdB8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sg0xYk6XdbN+M00bjNC+qMrok/dfAxVXtmxYV4dEEN9mIm429pZzo7QJcQAESgjDv18i5oA3gZfklwYlsBWw7gyCxoFQDe1jzJb9GaDsOa4MHJoXUH8SLR7U3sAXlc9aRkw7oKEKZx9tpDV2eyHjnzchygsJdx+VC2XH55zF7ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVdICjNc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVdICjNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458CF1F000E9;
	Fri,  7 Aug 2026 08:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786092485;
	bh=YHq7GJ0rbEnxt1snqFZ9uWSjmxMsre2HPEgm3axyDLM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QVdICjNcg9BjxpbLNv20LxsxMlnJ0yqM0xeW4nebhIllF3hq9oyT+AaKGqMZ+bCoQ
	 TdVWzEqmEyDBBOoJoH/ai0BYqrSz+yB+0Fn100kL72uMYcKSANENKgV9zCG8FDpu/g
	 mYqLAmwjWcbu0xlv3Rg44hR3aM4sQBV7ctTPZhxMoWfmuAUNmoRXT5n3HEn9enOCtG
	 KvwQNYwX3XIU+H8rlTxsKfJSgcU7b1zMXLo5JQm1UteHp0OVzjFvRxAmDUck5kdEVq
	 kqToqIESIYR5RA4178+j0iJNBx4lTtbKtC8AcJPhXE35UGs0o1m9QQ+C0b8Ac1ekXX
	 PgRL7SMHAddLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] rtc: pcf8525: Add temperature sensor support via
 hwmon
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shiv Prakash Gupta" <shivprakash.gupta@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260807082855.3762394-5-shivprakash.gupta@nxp.com>
References: <20260807082855.3762394-1-shivprakash.gupta@nxp.com>
 <20260807082855.3762394-5-shivprakash.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 08:48:04 +0000
Message-Id: <20260807084805.458CF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Subsystem Layering Violation: Registering hwmon functionality di=
rectly from the RTC driver.
- [Medium] Missing hardware state rollback when hwmon registration fails.
--

--- Patch [4]: [PATCH 4/4] rtc: pcf8525: Add temperature sensor support via=
 hwmon ---
commit 36335f5669e8a341626815565d14236fae935a84
Author: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>

rtc: pcf8525: Add temperature sensor support via hwmon
   =20
Register the PCF8525 internal temperature sensor through the hwmon
interface when CONFIG_RTC_DRV_PCF8525_HWMON is enabled.

> diff --git a/drivers/rtc/rtc-pcf8525.c b/drivers/rtc/rtc-pcf8525.c
> index 4ef648bdfc5b9..92bab3231ce7f 100644
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
> +	/* Enable only the digital readout; preserve TSIE, CL and XTL_TYP. */
> +	ret =3D regmap_update_bits(pcf8525->regmap, PCF8525_REG_CTRL5,
> +				 PCF8525_CTRL5_TEMP_RD_EN,
> +				 PCF8525_CTRL5_TEMP_RD_EN);
> +	if (ret) {
> +		dev_warn(dev, "failed to enable temperature readout: %d\n", ret);
> +		return;
> +	}
> +
> +	hwmon_dev =3D devm_hwmon_device_register_with_info(dev, "pcf8525",
> +							 pcf8525,
> +							 &pcf8525_hwmon_chip_info,
> +							 NULL);

[Severity: Medium]
Is it permitted to register the hwmon device directly from this RTC driver?

The hwmon subsystem guidelines specify that if the main functionality of a
device is not hardware monitoring, the hwmon features should be implemented
as an auxiliary device driver residing in drivers/hwmon/.

> +	if (IS_ERR(hwmon_dev))
> +		dev_warn(dev, "failed to register HWMON device: %ld\n",
> +			 PTR_ERR(hwmon_dev));

[Severity: Medium]
If devm_hwmon_device_register_with_info() fails, should the hardware state
be rolled back?

The code sets the PCF8525_CTRL5_TEMP_RD_EN bit in the register before
calling the registration function. If registration fails, the error path
logs a warning and returns, leaving the temperature sensor enabled in the
hardware. Could this cause unnecessary power consumption?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807082855.3762=
394-1-shivprakash.gupta@nxp.com?part=3D4
