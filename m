Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FBA49BD9C;
	Wed, 23 Sep 2026 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162762; cv=none; b=R9lYxmnVj/PFC6Hm1tJgLPhJFqe6oOY75ACPBtKOxPVrBScGsDFBmBPBmsyPQjr2YyEwTbyqMVvSH0Lg/IyXg1qQwnZshnGQOh4iR/pgF1EHRDIi0pybrDvDbKLkL/Jir23+PCUAudrtIr79AYwCd01aM5YwDkVB9lmQ+xpNLW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162762; c=relaxed/simple;
	bh=yc5o2xfyx097zCbZi65so1oDs9jIAFaxCbzBXPTMJ5s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=onO2teoOEcMVazNqd/d0+qhi3xwBn1lzXK0fhk/sUt96CD89nIztMfDbCLpQB9tQ7Whi8XMKB2OUnvwpKJaxv14EJMHxCXcSwHmnSUAkAVFljMZwrbrKLchnWG43V2y8uDl7Kquw1GnlfEtuBnabeH0GRwh8MdAdFXB/bRFYr/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9AOitMd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9AOitMd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988BB1F000FF;
	Wed, 23 Sep 2026 11:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790162754;
	bh=nhHIBcIs/+FLcLKEV+E2pd2W6SbsNrgjzpiJQdr9Gro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k9AOitMdkwUSWk7y82Kru6Jq11Wls/XnAmtZr89rYUYXIPiq6w5DUbV46jnFKuv9S
	 crJL0VXhYKw5b7sFjCEDKdBYTf+d7KhoZa1iFq3vpGG7mtfyzcsMsW2hEY7xDdxoLt
	 c5z1CFIS8OrjL6TL8TEBp4fX6QvbJOXr8Yki2M/IodTGZ0sj8Iy404lW9FBbqA7JJ0
	 JMZiWXfd6tflqK1rBPmgkeFSyiT6C2Dy3aw1Tz0HJv/5efsmBQJx/yOx1feQbsjJsW
	 KdE9RAxkGQLFwqy5zwhWu3ibXePFzX1egEU89lwVADEIU/Elx+mPKJ8PGcqqLhjVsR
	 EgxTJMhqz0A3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] watchdog: da9062: reset board on watchdog timeout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Primoz Fiser" <primoz.fiser@norik.com>
Cc: devicetree@vger.kernel.org, mfd@lists.linux.dev, lee@kernel.org, conor+dt@kernel.org, linux-watchdog@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, robh@kernel.org
In-Reply-To: <20260923111719.2032012-4-primoz.fiser@norik.com>
References: <20260923111719.2032012-1-primoz.fiser@norik.com>
 <20260923111719.2032012-4-primoz.fiser@norik.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 11:25:53 +0000
Message-Id: <20260923112553.988BB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] watchdog: da9062: ignored regmap_update_bits error during probe
--

commit bb521fc9765eec74ebb6a0d926ce1286dabd2490
Author: Andrej Picej <andrej.picej@norik.com>
watchdog: da9062: reset board on watchdog timeout

This commit introduces a method to change the watchdog timeout configuration
based on the "dlg,wdt-sd" DT binding in the da9062 watchdog driver. It allo=
ws
switching between SHUTDOWN mode and POWERDOWN mode on watchdog timeout. If
the DT binding is absent, it retains the default behavior.

> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
> index 426962547df16..2a9da83493b38 100644
> --- a/drivers/watchdog/da9062_wdt.c
> +++ b/drivers/watchdog/da9062_wdt.c
[ ... ]
> @@ -245,6 +248,30 @@ static int da9062_wdt_probe(struct platform_device *=
pdev)
[ ... ]
> +		ret =3D regmap_update_bits(wdt->hw->regmap,
> +						DA9062AA_CONFIG_I,
> +						DA9062AA_WATCHDOG_SD_MASK,
> +						mask);
> +
> +		if (ret)
> +			dev_err(dev, "failed to set wdt reset mode: %d\n",
> +				ret);
> +	}
> +
>  	return devm_watchdog_register_device(dev, &wdt->wdtdev);

[Severity: Medium]
Is the regmap_update_bits() error code intentionally ignored here?

When the device tree contains the "dlg,wdt-sd" property, da9062_wdt_probe()
attempts to update the DA9062AA_CONFIG_I register. If this transaction fails
(for example, returning -EIO due to a hardware fault), the failure is logged
via dev_err(), but the error code in 'ret' is then discarded because execut=
ion
falls through to devm_watchdog_register_device().

This could leave the watchdog in an incorrect reset mode that conflicts with
the explicit configuration requested by the device tree. Should the function
return 'ret' early upon failure, instead of continuing probe?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923111719.2032=
012-1-primoz.fiser@norik.com?part=3D3
