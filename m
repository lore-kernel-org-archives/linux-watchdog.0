Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869EC1862
	for <linux-watchdog@vger.kernel.org>; Sat, 23 May 2026 00:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779494532; cv=none; b=XwpOPDljZbAV03G9beq0GySwKDmBr6bZzFXmkBEbhlHpImrPjImul7WKZsLSZkCZDCyaWtDvvv+0HXv87C3y62zK1gUJi8FWM0MCugKcdbFVyM756zDpPvHLb99BTnO48bjEGndbMIYPOflAOr/Eq/OGu7O3PHY7C961jN+wNZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779494532; c=relaxed/simple;
	bh=ugMbOfcHOw0LscCwYPICdCq3OvREyAS96PJDDOs08yY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XrX6vApzmPQQ8D5aYvwLcS8wYKCuo1a+itBJzVqith+bDE7TI9G+xIBz130QuQxXSWMs2/svMztQQ123L8nRuImAPN3Aq8D0QQx54VBmD6H9GVk2UFRTJw9lRBFZBgj7ycroD92k2KBHba5LMuMkX6PdytWjnyVLWt7XTXyzxp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5TQXA84; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5TQXA84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B531F000E9;
	Sat, 23 May 2026 00:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779494531;
	bh=xq+KO7cfYLY8t0VGlyEW8Md77VCO/EEk2TVhOQFjTN4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O5TQXA84Utr0QVjuYgWbxPulsCJvjuGNvTP5uqrKpdSlt39WMBVFYDy6e/YFnKFbs
	 0a+fevXmK7uBb64Tu/F5GwEiJrwByUAUxlNXhyzds4YVJ0u7oaRdVNvSEUZrkjXK9e
	 /eApC8uF2OmUWr8wK5/kmiat/GRgMMt5xSVKfaaa2VLjQnEqqkhxrLD+6jFdfE1NtD
	 MccqUHspTFvXBafI8HJrokLdeL80r6Av/OV5AqoRe4lxl+vZFgOUzWjMeSXfYgml38
	 03e6L3Ay+QAnvsLKA1Q1mOu3zHP8gsF1L+VDOwdocwdHA/qejQivP73pWtp6QxmRlA
	 C68eMqL8nuPiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] watchdog: ath79: convert to watchdog_device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260522232553.44748-3-rosenp@gmail.com>
References: <20260522232553.44748-3-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 00:02:10 +0000
Message-Id: <20260523000211.08B531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The timeout value is no longer properly clamped to the hardware ma=
ximum, which can cause an integer overflow when computing timer ticks and l=
ead to premature system resets.
- [High] The `WDIOF_MAGICCLOSE` flag was incorrectly removed from the `watc=
hdog_info` options, silently disabling the magic close safety mechanism.
- [Medium] The `parent` field of the `watchdog_device` structure is not ini=
tialized, breaking sysfs topology and device tree alias resolution.
--

commit dcea60e57fc7eacb788b783d8fe1cc986ea83bb1
Author: Rosen Penev <rosenp@gmail.com>

watchdog: ath79: convert to watchdog_device

Converts from the legacy miscdevice/file_operations interface to the
watchdog_device framework, simplifying the driver and properly handling
EPROBE_DEFER.

> diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
> --- a/drivers/watchdog/ath79_wdt.c
> +++ b/drivers/watchdog/ath79_wdt.c

[ ... ]

>  static const struct watchdog_info ath79_wdt_info =3D {
> -	.options		=3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
> -				  WDIOF_MAGICCLOSE | WDIOF_CARDRESET,
> -	.firmware_version	=3D 0,
> -	.identity		=3D "ATH79 watchdog",
> +	.options =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_CARDRESET,
> +	.firmware_version =3D 0,
> +	.identity =3D "ATH79 watchdog",
>  };

[Severity: High]
Does the removal of WDIOF_MAGICCLOSE silently disable the magic close safety
mechanism?

The legacy driver explicitly supported magic close. Without this flag, the
watchdog core might assume magic close is unsupported and unconditionally s=
top
the watchdog when the file descriptor is closed.

If a userspace watchdog daemon crashes unexpectedly, the watchdog would be
disabled instead of resetting the system.

[ ... ]

>  static int ath79_wdt_probe(struct platform_device *pdev)
>  {

[ ... ]

> -	max_timeout =3D (0xfffffffful / wdt_freq);
> -	if (timeout < 1 || timeout > max_timeout) {
> -		timeout =3D max_timeout;
> -		dev_info(&pdev->dev,
> -			"timeout value must be 0 < timeout < %d, using %d\n",
> -			max_timeout, timeout);
> -	}
> -
> -	ctrl =3D ath79_wdt_rr(WDOG_REG_CTRL);
> -	boot_status =3D (ctrl & WDOG_CTRL_LAST_RESET) ? WDIOF_CARDRESET : 0;
> +	wdt->wdd.max_timeout =3D U32_MAX / wdt->freq;
> =20
> -	err =3D misc_register(&ath79_wdt_miscdev);
> -	if (err) {
> -		dev_err(&pdev->dev,
> -			"unable to register misc device, err=3D%d\n", err);
> -		return err;
> -	}
> +	ctrl =3D ath79_wdt_rr(wdt, WDOG_REG_CTRL);
> +	wdt->wdd.bootstatus =3D (ctrl & WDOG_CTRL_LAST_RESET) ? WDIOF_CARDRESET=
 : 0;
> =20
> -	return 0;
> -}
> +	wdt->wdd.info =3D &ath79_wdt_info;
> +	wdt->wdd.ops =3D &ath79_wdt_ops;

[Severity: Medium]
Is the parent field of the watchdog_device structure missing initialization?

Without setting wdt->wdd.parent =3D &pdev->dev, the sysfs class device migh=
t be
created at the root of sysfs instead of correctly nesting under the physical
platform device. This could break sysfs topology and device tree alias
resolution.

> +	wdt->wdd.min_timeout =3D 1;
> +	wdt->wdd.timeout =3D WDT_TIMEOUT;
> +	watchdog_init_timeout(&wdt->wdd, timeout, &pdev->dev);
> +	watchdog_set_nowayout(&wdt->wdd, nowayout);
> +	watchdog_stop_on_reboot(&wdt->wdd);

[Severity: High]
Can the timeout value overflow when computing timer ticks if max_timeout is
less than WDT_TIMEOUT?

The legacy driver explicitly clamped the timeout variable to max_timeout. In
this patch, if the system's WDT clock frequency is fast enough that
max_timeout is less than 15 seconds, watchdog_init_timeout() will fall back
to WDT_TIMEOUT (15) without clamping it.

Since the watchdog core doesn't validate the initial fallback timeout again=
st
max_timeout, starting the watchdog will execute wdt->freq * 15. This could
overflow a 32-bit integer and program the hardware timer with a small
residual value, causing premature system resets.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522232553.4474=
8-1-rosenp@gmail.com?part=3D2
