Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7234C366567
	for <linux-watchdog@vger.kernel.org>; Sun, 26 Jul 2026 18:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785092208; cv=none; b=IANNxEwSotZpq8si2wBnEnGAiXQtnf2nY+7l+X0SkuHgPktfG8EEzV11z71/lns4xR0U78fy/S9P3nk82hCpnrdU2HgRNu6/LVSkMyqToad5NTKRGDHdRgC0ufBvssxRBkeCSFHOnyyaC1h0V5H8eebh3O7oaf2vs8aPDJ2czFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785092208; c=relaxed/simple;
	bh=hMevPyXV3ukJXvf5/OT6K+8oT88jbrCP79zYfXGXfQE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HjdKwIwMp45eJZjNemqXkXxMRl4X+dFkEpc6KALOntRLAgR/yRv2ulIxV9/cbCZY4/uMjOoHntPSFkXM/9BO0MUm1FyS81eC0B5efdiTIcCTOJiCBATNpmGFCgrBjqxdqkHgFPF9Eyj4YzXsmZUOdh5BtZS12yiCg6C6dNdUcMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0/WnZuq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0/WnZuq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2001F00A3A;
	Sun, 26 Jul 2026 18:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785092207;
	bh=M2U7Ku+xc2JBv/gNY89dvhEBHu5Ik7C2rHjXIGph3r8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h0/WnZuqXi2hY5erSHQ0RnNqYZg2UfYwY2Tx7baUcgQIXtpQ7n/XlFAToc/PaAf3Q
	 vszif/CZy6atJWEisH2hBpGSZiaE9rfKWlVLm0EA4unQ1YbwVxHa33D1k95Ty6/8oc
	 NWYeJ4yp4ijIonoJsGXvSUftMkQnuaai6/Rpumvjt3DmvtTr/0rprx0taBKnxm2uuF
	 TcNOXLxHKswrcLZfW0qTwCexwwc3+FzJoY48srQCLwk9udTwlQj5RvOwvphq4j5DFt
	 rcT1GwIrCJnT725b/sg+6XMpouZwqZ+QirE2jJxfi4DbbkCA+hESimR229a83UIgzw
	 1OkqCdeBVEV6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/8] watchdog: w83627hf_wdt: Report all
 initialization failures in probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Louvel" <paul.louvel@bootlin.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260726-w83627hf_wdt-improvements-v2-8-3645a2a6c022@bootlin.com>
References: <20260726-w83627hf_wdt-improvements-v2-0-3645a2a6c022@bootlin.com>
 <20260726-w83627hf_wdt-improvements-v2-8-3645a2a6c022@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 18:56:46 +0000
Message-Id: <20260726185646.DC2001F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unchecked dereferences of `id` and `pdata` in probe can lead to a =
kernel Oops.
--

--- Patch [8]: [PATCH v2 8/8] watchdog: w83627hf_wdt: Report all initializa=
tion failures in probe ---
commit 0129cf43f51e4968c683b359d971eaa0c48a6846
Author: Paul Louvel <paul.louvel@bootlin.com>

watchdog: w83627hf_wdt: Report all initialization failures in probe
   =20
The driver currently logs an error only if the chip initialization
fails. Extend the error reporting to all failure paths in probe to
improve diagnostics.

> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_=
wdt.c
> index 2957364485ebf..7b50865ae8248 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
> @@ -485,7 +485,8 @@ static int wdt_probe(struct platform_device *pdev)
> =20
>  	res =3D platform_get_resource(pdev, IORESOURCE_IO, 0);
>  	if (!res)
> -		return -ENXIO;
> +		return dev_err_probe(dev, -ENXIO,
> +				     "failed to get I/O resource\n");

[Severity: High]
Could the dereferences of id and pdata earlier in this function lead to a
kernel Oops?

If a user binds a device to this driver via sysfs (for example, using
driver_override or bind), platform_get_device_id(pdev) will return NULL
because the device ID does not match any entry in the driver's id_table.=20

This leads to a NULL pointer dereference when initializing chip:

wdt_probe()
    const struct platform_device_id *id =3D platform_get_device_id(pdev);
    ...
    enum chips chip =3D id->driver_data;

Additionally, binding a platform device this way leaves
pdev->dev.platform_data as NULL, causing a subsequent NULL pointer
dereference when accessing pdata:

wdt_probe()
    const struct wdt_pdata *pdata =3D pdev->dev.platform_data;
    ...
    data->siocfg_enter =3D pdata->siocfg_enter;

Since this can be triggered from userspace by a user with privileges to
write to sysfs, could this be used to panic the kernel?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726-w83627hf_w=
dt-improvements-v2-0-3645a2a6c022@bootlin.com?part=3D8
