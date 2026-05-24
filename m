Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB2063B9
	for <linux-watchdog@vger.kernel.org>; Sun, 24 May 2026 03:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779592306; cv=none; b=NmH/HgNPkS2vf3DkF7jWm36wvyxSerw3qls6hna/83FB+bdlszxFNdkY/YgxXiKZ+Vi1f1HwDs0QTkcQBIO6jW90YzsOUTSkJwq12itS4zLnkR+cKTYOdPIy+Vy1pWOYiKZlR3KXFiLl3Goq5mNEf34AtYKPCtqBBY3k5zzHt3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779592306; c=relaxed/simple;
	bh=g5nqmGS3Hz8fASnD/iAVv5o6UJqN1wDmeVrUtOTd6o8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DqgEOY5WfCjAZtcGb01se0sFlQQjJLxEheEOMlSzY9Yt06uxYRJZL0+ddQIhYbr1iHqK1ZyRhFEm+pj/9JogJH4/k6vEaO2rCbELywpLsZFCRovvnqIrnZhw4bAwDRFIuEtzh3mm1YBBC+ppdV4gc5WXqz9EOvcGJrNzF23TK7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLpUOww7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLpUOww7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858CF1F000E9;
	Sun, 24 May 2026 03:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779592304;
	bh=pw6ROSEyyHBG9C0elFeN1SWoLEajNmfu7zn/GiXAK4I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dLpUOww7Y7CBUKsENzcisab0T+lMHrY4VaHG/GmBHG48FsvoXfcpfZRu94XZBH174
	 EzAnuj+fGtCE+tDUp3Dbo7iZ23Rc3yzxB9SEuMkTVfLhzSR4lzgnC+DYPTkMvuO9Vf
	 L24wmbUxjrMfEfQw4Kq9EZ74sx2K2lbTDIJtmRfKxMndmA/G24XPUWsPocKwOs5snH
	 zqpfhA1Jg+M/Ri/fFOoxsg5xGv3xgrVlGFu/5juwGMBTCafz24M4myNj+lIsiq9ZMC
	 5WZqYKKJliWuITwQjotMA0YzUTmWbD+zjKCWI/sBsXCaYC6CUbdxullZOU76M46gKU
	 mbFZZiRtxHWlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: core: assign parent with devm registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260524022332.179202-1-rosenp@gmail.com>
References: <20260524022332.179202-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 03:11:44 +0000
Message-Id: <20260524031144.858CF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Modifying the caller-provided `struct watchdog_device` by implicit=
ly setting `wdd->parent =3D dev` causes a dangling pointer and use-after-fr=
ee vulnerability for drivers using statically or globally allocated watchdo=
g devices.
--

commit cdc03b5b413f4bd1a9d27c7f13f33dd6b209e2ba
Author: Rosen Penev <rosenp@gmail.com>

watchdog: core: assign parent with devm registration

This commit modifies devm_watchdog_register_device() to automatically assign
the devres device as the parent of the watchdog_device if one was not
explicitly provided. This aims to reduce boilerplate in drivers using devre=
s.

> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog=
_core.c
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -440,6 +440,13 @@ int devm_watchdog_register_device(struct device *dev,
>  	if (!rcwdd)
>  		return -ENOMEM;
> =20
> +	/*
> +	 * We are passing the devres device here so if the user did not pass
> +	 * another parent, it's this one.
> +	 */
> +	if (!wdd->parent)
> +		wdd->parent =3D dev;

[Severity: High]
If a driver passes a statically allocated struct watchdog_device (such as
pic32-wdt or pic32-dmt) and does not explicitly initialize the parent field,
the first probe will modify the global structure to point to the newly
allocated struct device.

If the platform device is subsequently removed (for example, via a device t=
ree
overlay removal), the struct device is freed, but the global wdd->parent
pointer remains dirty and points to the freed memory.

Upon a subsequent re-probe, the if (!wdd->parent) check evaluates to false,
skipping the update.

Could this cause a use-after-free when the core passes the stale, freed
pointer to watchdog_register_device() and eventually
device_create_with_groups() during sysfs node creation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524022332.1792=
02-1-rosenp@gmail.com?part=3D1
