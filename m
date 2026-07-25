Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942692D8385
	for <linux-watchdog@vger.kernel.org>; Sat, 25 Jul 2026 10:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784976125; cv=none; b=mLvoSGa774vRloSqeO7ah6XCqZi/PVxBdqnQQkGzsncizcR4eBI4mm88nKffmcDejbX4PE7cRxuOjidoL+zgkvc68RvMWCItA+IEwou/S9i/rWEmMYpCzVbvRM1ChNi5T8jJIF/j11kfv8J5pNkTJNuAWof5Yj+LhNydD0nU1Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784976125; c=relaxed/simple;
	bh=BIs2MrstuXvMGIBLFRsHwMU69ZSOkss/dwc00qVpPe8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dnNQLSO2244Tt7sA033JkeLOfjWvV/iOsjqGnHU/HsyIj5nP1IMcEepPrGxI/SG4+6wp+YA81PHnLsK92f041kQT4MMCZO+II4CUfyOPT8Yp7xKu1rTJTuHcXp3zWU97HiMQe0s21b6mrVC+ZtpBu7qll/X8mrXYgwtarLSAoW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jL8PVqTm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jL8PVqTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAF21F000E9;
	Sat, 25 Jul 2026 10:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784976124;
	bh=Wbd/xwnk6nnAMY8vwfethFCvfGXEWeoqwZw5/cAKLPk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jL8PVqTmAC62vknk26kKCdq5NXwiOdt1lY5BoMVORjgn8ufZF119p2zktQ2b8cWj5
	 sYrkZypDbo6PI3kpryHzbVpaHyRNRWZu7OznUfrPCYi2YNs5VjZVTUYt5huoCyf/Fo
	 C7g2HibKWMtcaKl8zrJ3amqdZHoJFUCTdMx3Qqm05SllfEhoemHeFO0xcUR1/KvZ+m
	 teXACxEZPV2DRSYDAz5BO0W6vRD8Wf2tYEU7vGi83AWynC6x6x+Ms3Pjp7atNwdtu8
	 E4oEx1i6UFKsvRNOEy2jcp2DvnzvKqS4/519epAIljeed2p8cWjrzv2BZK8im+ndXa
	 IX2G85qiBgt0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] watchdog: w83627hf_wdt: Use private driver data
 structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Louvel" <paul.louvel@bootlin.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260725-w83627hf_wdt-improvements-v1-3-4e9a1b4e8297@bootlin.com>
References: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
 <20260725-w83627hf_wdt-improvements-v1-3-4e9a1b4e8297@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 10:42:03 +0000
Message-Id: <20260725104203.ECAF21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Possible NULL pointer dereference of `id` in `wdt_probe` if device=
 is matched via `driver_override`.
--

--- Patch [3]: [PATCH 3/9] watchdog: w83627hf_wdt: Use private driver data =
structure ---
commit a08865ae24d92d72840774e0d257ddcdf06b2ed4
Author: Paul Louvel <paul.louvel@bootlin.com>

watchdog: w83627hf_wdt: Use private driver data structure
   =20
Allocating a per-device data structure is a common practice in the Linux
driver model. Add one that will be used to store chip-specific register
offsets, and configuration.

> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_=
wdt.c
> index 993e65ce4447c..72e167f37885f 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
[ ... ]
> @@ -471,28 +464,44 @@ static int wdt_probe(struct platform_device *pdev)
>  {
>  	const struct platform_device_id *id =3D platform_get_device_id(pdev);
>  	enum chips chip =3D id->driver_data;
                          ^^^^^^^^^^^^^^^

[Severity: High]
Can platform_get_device_id() return NULL here?

If a user with root privileges writes the name of this driver ("w83627hf_wd=
t")
to the driver_override sysfs attribute of an arbitrary platform device and
forces it to bind, the device might not match any entry in the driver's
wdt_ids table.

In this case, platform_get_device_id() would return NULL, causing a NULL
pointer dereference when accessing id->driver_data.

Note that this issue appears to have been introduced when the driver was
converted to the platform driver model in patch 2 of this series.

[ ... ]
> +	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->info.options =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_M=
AGICCLOSE;
> +	snprintf(data->info.identity, sizeof(data->info.identity),
> +		 "%s Watchdog", id->name);
                                ^^^^^^^^

[Severity: High]
Does this also cause a NULL pointer dereference if id is NULL under the same
driver_override condition?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725-w83627hf_w=
dt-improvements-v1-0-4e9a1b4e8297@bootlin.com?part=3D3
