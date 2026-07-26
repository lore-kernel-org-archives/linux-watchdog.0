Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72B2288C0E
	for <linux-watchdog@vger.kernel.org>; Sun, 26 Jul 2026 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785092197; cv=none; b=ApRXTH2RxEO+h8AWX5XKF0uldpB+o2BNFayIFBj6s/O2rt9Vllf0DpN9IemsAyPmz0yJHTpaeERb92GaH+9HLpbssR8OJu/vaPAm4/r8WShaWPeo1j+n9ozVlESfOJzWYz6HJEvyLvLVwGOUl3hQBi4ziy6K6Vx3ushAbM63YHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785092197; c=relaxed/simple;
	bh=6kciT6XGqLa+4OF77cO/+x7mnnXjSBWDFBDcHk/CS1M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mZHQazm88gP2USH0z7912xIzOo+B1vLCsntfKMosaNMsO0B25r+3gg8t+9hrhPDIozHR96FSE14CPCbqiM3GFesGxGnaclYjpBe7XXMP8AHso9740BONEfuQQm15WJ55Awazpr9BAGu/8ievMWudKF1VI4JyNG/kcsieT441wgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSi0bIjR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSi0bIjR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D4C1F000E9;
	Sun, 26 Jul 2026 18:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785092196;
	bh=vyZACHpxlwhFsIxZX1AJpR+JexSQMe/exXmR2vMrVkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KSi0bIjRY8OMcIGcySzqPp3aIVbKspFfIV2z9TRRNmlrzKbKpEXTvgcDesW2qtSma
	 Mohfin7Ni56BvY/9yc58T2VQWs9M03GI06JKx9VnhdQUumuEq3oeqcUkUSLrLomo4k
	 kOQjQFz+MpsI1H1KE4s5ppdJ0b20W/XYGb2igs3FgqazroFwFpfZJqwk6K/L8iIDtO
	 hdB5wtIhApnK3/HhcomtwbYa6g4WT9ynu2BvOU8OxCNKqM/N1ZOf1zmmTlfp6TUfwT
	 YzaaE10P8bgcUimFavykxMaDrHMb2QEvvTiVxzvnKQ8mHIbEkk0BOYJxs9qBCDVx7+
	 EHnJBw9zaSnSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/8] watchdog: w83627hf_wdt: Add Super I/O
 configuration port as a platform device resource
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Louvel" <paul.louvel@bootlin.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260726-w83627hf_wdt-improvements-v2-5-3645a2a6c022@bootlin.com>
References: <20260726-w83627hf_wdt-improvements-v2-0-3645a2a6c022@bootlin.com>
 <20260726-w83627hf_wdt-improvements-v2-5-3645a2a6c022@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 18:56:35 +0000
Message-Id: <20260726185636.31D4C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Claiming the shared Super I/O configuration port as a static p=
latform device resource causes a Use-After-Free and breaks global mutual ex=
clusion upon module unload.
--

--- Patch [5]: [PATCH v2 5/8] watchdog: w83627hf_wdt: Add Super I/O configu=
ration port as a platform device resource ---
commit 7147d011852b779a7e376729ecb29c06b86e9282
Author: Paul Louvel <paul.louvel@bootlin.com>

watchdog: w83627hf_wdt: Add Super I/O configuration port as a platform devi=
ce resource

This commit changes the Super I/O configuration port address from a
global variable to a platform device resource. It uses
platform_device_register_resndata() to assign the IO resource during
module initialization.

> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_=
wdt.c
> index 69d4230d8f6cc..a067b8ea6b289 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
[ ... ]
> @@ -594,8 +597,14 @@ static int __init wdt_init(void)
>  	if (ret)
>  		return ret;
> =20
> -	wdt_pdev =3D platform_device_register_data(NULL, wdt_ids[chip].name,
> -						 PLATFORM_DEVID_NONE, NULL, 0);
> +	res.name =3D "Super I/O port";
> +	res.flags =3D IORESOURCE_IO;
> +	res.start =3D sioaddr;
> +	res.end =3D sioaddr + 1;
> +
> +	wdt_pdev =3D platform_device_register_resndata(NULL, wdt_ids[chip].name,
> +						     PLATFORM_DEVID_NONE, &res,
> +						     1, NULL, 0);

[Severity: Critical]
Does claiming the shared Super I/O configuration port as a static platform=
=20
device resource cause a use-after-free regression and break mutual exclusio=
n=20
on module unload?

If this port is registered as a non-busy I/O resource, it becomes a=20
container node in the global ioport_resource tree. When another driver=20
calls request_muxed_region() for the same port, it might sleep on=20
muxed_resource_wait while holding a parent pointer to this container node.

If the wdt module is unloaded while that thread is sleeping,=20
platform_device_del() unlinks the container node and=20
platform_device_release() frees its memory. When the sleeping thread=20
wakes up, will it dereference the freed parent pointer in=20
__request_resource()?

Additionally, it appears that unlinking the container node orphans any=20
active child reservations from the tree. Could this allow concurrent=20
hardware access to the shared Super I/O port?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726-w83627hf_w=
dt-improvements-v2-0-3645a2a6c022@bootlin.com?part=3D5
