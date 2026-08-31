Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB9E469842
	for <linux-watchdog@vger.kernel.org>; Mon, 31 Aug 2026 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189160; cv=none; b=OScOgCuaWLrFTuIVUcPauDcuyIT5KmSVB4OXCo9uL4LZ3NJmNESuUVpu9CdsjMk7GUHdgwFul5frZiJ+PxD1NUaL+DYE6ySco6Y2QID9iS+OHzjvd0YbK9UQnTcEASv2Zmx5l6izldiMw4ykH9sugk0jlY2aRQJSDdbXESYLtcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189160; c=relaxed/simple;
	bh=CBereRE7O9Gm9LpzczopH5PTL/YUYgl1kHHjMG06tpA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HzUaMsk8+j/Bhn2i675J0bJbXGz4D/nIjv9TIOnCSetTGsqCDZOMn0N57KSd9YLL94Lc072XW9fm76KMnnE0Nd9a/gjNeMiTxA8E6gYJngq4v5ZK+Cc6LXqfVOq3kLGSw0z2PagBNQbZQgbjWBsVWv04UQMk999hdOTsvX0sbJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUIxAoLF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUIxAoLF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93781F000E9;
	Mon, 31 Aug 2026 15:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788189159;
	bh=GKgLSOg3tZNJhUcwd0wrQi10DgH7f5EDoV1DeU/lMis=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eUIxAoLFeE7Ow+Ikl0M4ZeC89NxYJ0VGwOkvkWBLIkLaMzrJic/ZS8XGoAL63NVJn
	 r9S5Ewbx93TqifusIB7miV4Z3b8rJeoBUPjZIu1h2DKPqP03NbZhpUtNBmj2Ie7tcc
	 l/LihF28Zm9VPAHwZwzrBaceQhPq/YUbAvBNWVCoNPKUYOptLKkcdVp1XkBIfp1TAu
	 h7rKh9gctAgW+EqEEbGY4yQ4yALLLY9AdwGy6eNsqRrRZuI1MNS0/2I/ZqkIA2HLrF
	 S4TvCQUZlMxRfrzrmcC8K28RgtJfAhzlP29ZXpzu3nvKG87DC6jPBIQJlvLhuBsBVi
	 NXSqFmREb1iaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.12] watchdog: lenovo_se10_wdt: Add
 support for SE10 Gen 2 platform
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260831133314.4125787-255-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-255-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 15:12:38 +0000
Message-Id: <20260831151238.D93781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but if `platform_dev=
ice_add()` fails in `se10_create_platform_device()`, the global pointer `se=
10_pdev` is freed via `platform_device_put()` but is not set to NULL. This =
leads to a use-after-free and double-free during module exit.
--

commit c17067068789e49fda2c6ba80c40320fe7102b48
Author: Mark Pearson <mpearson-lenovo@squebb.ca>

watchdog: lenovo_se10_wdt: Add support for SE10 Gen 2 platform
   =20
The Lenovo SE10 Gen 2 platform uses a watchdog chip from the same family.
Watchdog functionality is the same, so this updates the driver with the new
chip ID. The Gen 2 MTMs are also added to enable support on the platform.
   =20
Link: https://lore.kernel.org/r/20260428124954.1193450-1-mpearson-lenovo@sq=
uebb.ca

> diff --git a/drivers/watchdog/lenovo_se10_wdt.c b/drivers/watchdog/lenovo=
_se10_wdt.c
> index cd0500e5080b4..99ff01af41243 100644
> --- a/drivers/watchdog/lenovo_se10_wdt.c
> +++ b/drivers/watchdog/lenovo_se10_wdt.c

[ ... ]

> @@ -280,6 +280,70 @@ static const struct dmi_system_id se10_dmi_table[] _=
_initconst =3D {
>  		},
>  		.callback =3D se10_create_platform_device,
>  	},
> +	{
> +		.ident =3D "LENOVO-SE10-G2",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "13LJ"),
> +		},
> +		.callback =3D se10_create_platform_device,
> +	},

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this callback
addition, I noticed a potential use-after-free and double-free in the module
teardown path.

If platform_device_add() fails in se10_create_platform_device(), the=20
global se10_pdev pointer is freed but left dangling:

drivers/watchdog/lenovo_se10_wdt.c:se10_create_platform_device() {
    ...
	err =3D platform_device_add(se10_pdev);
	if (err)
		platform_device_put(se10_pdev);
    ...
}

Because dmi_check_system() returns a positive match count even when the=20
callback returns an error, se10_wdt_init() will proceed to call=20
platform_driver_register() and successfully load the module.

When the module is later unloaded, se10_wdt_exit() checks if the dangling=20
pointer is non-NULL and calls platform_device_unregister() on it:

drivers/watchdog/lenovo_se10_wdt.c:se10_wdt_exit() {
    ...
	if (se10_pdev)
		platform_device_unregister(se10_pdev);
    ...
}

Should we set se10_pdev to NULL after calling platform_device_put() to=20
prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-255-sashal@kernel.org?part=3D1
