Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17056371877
	for <linux-watchdog@vger.kernel.org>; Sat, 25 Jul 2026 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784976212; cv=none; b=FhxEhK+m6knUw5I0C2d8ftb+vMNkJwEogup8WwyQxyvnPtp1H+O8b+0+H8K9Ix6d2c2U2GxBei5sJo5y5BUHSwcK9Zm9eZbwqVS/bkSBXFybhP8I2qDz9M9U2yqsnuldXpEgSshPpg/hs8lgep8xXfgQ0rvhuET81DsPD3ida5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784976212; c=relaxed/simple;
	bh=q5ml57NOsH4zv/whdQb4hLBmNBPXr1Tl1SEGHq/Ml1E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OcSVZyCcbAkku6jcR0WnYSDehBz8LhXCbwpFQ43citGdv/bVOYmQuYa6sTRqH8prpuqlcNExO2sSVBrYN0ERhufx1FkPicYWKCZxIW1zTobVZKF/AHo6qtSquUVSJX70xllqTRvi69i7tgfN/KmF1Dilcvde5nfuYgB7Vn9fWFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DygqdXa8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DygqdXa8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA731F000E9;
	Sat, 25 Jul 2026 10:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784976210;
	bh=mLPBvmzd/Amxw+QWlHHHhYH76Wwir/hSw8lmfqlxis4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DygqdXa8CnVYtKHfsISSV6bTonGxy64E+3P/caraoa5HS2iNDffQq/meDrDQOX3Xh
	 MyuMAVmNQALxhKb2AoK6Ay0wXICSbQtMBKMi+P26oJaiis3pwPB/9Ls6AmuB3gGc4N
	 B74mTH0DAK44QXMsIIknutYoxXsEjI56qJKritslEeAFdimMJVA0doXMGlfWtfpHtD
	 MrwUAJtuEUp1q8Kh98T896UX/0AjuiPDgIromtW/3DfeGw5ta+wUL5qZH7Z0AE5INF
	 VNw1+VNoV3otk1O+4YQlJ2lHZ79Q98DCrHa2dRobJMh+atdUenNztlMWqqt4hIy5Py
	 M+ufA0CbjzZPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] watchdog: w83627hf_wdt: Add Super I/O configuration
 port as a platform device resource
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Louvel" <paul.louvel@bootlin.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260725-w83627hf_wdt-improvements-v1-5-4e9a1b4e8297@bootlin.com>
References: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
 <20260725-w83627hf_wdt-improvements-v1-5-4e9a1b4e8297@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 10:43:30 +0000
Message-Id: <20260725104330.7BA731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Uninitialized stack memory in `struct resource res` causes a kerne=
l panic during device registration.
- [High] Modeling the globally shared Super I/O configuration port as an ex=
clusive platform device resource breaks mutual exclusion (muxing) for other=
 drivers.
--

--- Patch [5]: [PATCH 5/9] watchdog: w83627hf_wdt: Add Super I/O configurat=
ion port as a platform device resource ---
commit da82fc7c463fccfdf1ba03b6c7b6e7de29a800a0
Author: Paul Louvel <paul.louvel@bootlin.com>

watchdog: w83627hf_wdt: Add Super I/O configuration port as a platform devi=
ce resource

This patch modifies the w83627hf watchdog driver to pass the Super I/O
configuration port as a platform device resource instead of using a global
variable. It updates the driver initialization to retrieve the base address
from the platform resource during probe.

> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_=
wdt.c
> index f5333c4321984..6363d571182fa 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
[ ... ]
> @@ -598,9 +601,14 @@ static int __init wdt_init(void)
>  	if (ret)
>  		return ret;
> =20
> -	wdt_pdev =3D platform_device_register_data(NULL, wdt_ids[chip].name,
> -						 PLATFORM_DEVID_NONE, &pdata,
> -						 sizeof(pdata));
> +	res.name =3D "Super I/O port";
> +	res.flags =3D IORESOURCE_IO;
> +	res.start =3D sioaddr;
> +	res.end =3D sioaddr + 1;

[Severity: High]
Is this struct resource fully initialized before being passed to
platform_device_register_resndata()?

Because it is allocated on the stack in wdt_init(), fields like parent,
sibling, and child will contain uninitialized stack data. When the resource
is copied during platform device registration, these uninitialized pointers
are preserved.

Later, when platform_device_add() is called, it checks the parent pointer.
If the stack garbage is non-zero, it skips the fallback to ioport_resource
and passes the garbage pointer to insert_resource(), which will cause a
kernel panic when traversing the resource tree.

Could this be fixed by zero-initializing the struct when it is declared?

> +
> +	wdt_pdev =3D platform_device_register_resndata(NULL, wdt_ids[chip].name,
> +						     PLATFORM_DEVID_NONE, &res,
> +						     1, &pdata, sizeof(pdata));

[Severity: High]
Will registering the Super I/O configuration port as a static platform devi=
ce
resource break the mutual exclusion for other drivers sharing this port?

The Super I/O configuration port is a globally shared resource, and drivers
like hwmon dynamically access it using request_muxed_region(). Registering
it statically here inserts it into the global I/O resource tree as belonging
to the watchdog device.

If another driver holds the muxed region and the watchdog module is
unloaded, release_resource() will forcefully remove the watchdog's resource
and orphan any children. This breaks the IORESOURCE_MUXED wait queue logic,
allowing a third driver to concurrently claim the region, potentially leadi=
ng
to hardware data corruption or a deadlock when the original driver fails to
release the region.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725-w83627hf_w=
dt-improvements-v1-0-4e9a1b4e8297@bootlin.com?part=3D5
