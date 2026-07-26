Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411CA2571D7
	for <linux-watchdog@vger.kernel.org>; Sun, 26 Jul 2026 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785092106; cv=none; b=IsJbbxMOhG1a5cv2UoarpKxStN2SjX0f2twlTav+WuweUwWKOV7hQHbB7yY1B1kn9UWo96o5cNu1q4WYG7CdVIeWVriyAwrAhWAiZr30fQ4FYE5wsiampNmo6eSwjQrkGVCj4ar+w5D7lynZtxKy2Y7/T/BIj0Qb+zl1iw1IY6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785092106; c=relaxed/simple;
	bh=WS6jqmFkAoOYx6M1Q0M/tOEhubaSaJrEnrH//yEAjOM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VDm0zIlsy+gNHlE5Aox/xUO5IuaJby1a0+yL/bfu4DvVCRmHO1McRMNzabjMLA2trBQsA/+os4UTerIm8lJoJ0S7yXHU8wByxCgsBf/wN0OIagw9BbZw07icGQ583D6UYqNuZqv0YADcnNPSqVtOLfnU23m46sQ6CtanANEy3TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Thk7lxgm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Thk7lxgm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF34D1F000E9;
	Sun, 26 Jul 2026 18:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785092104;
	bh=CMfhfB45e4QuB+EDCzD13Ak4hndLI/eVi56yDtuexAM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Thk7lxgm9sMxwY5qQvUzPm3So8CUDAgOG4j6FnLiKxkzGR6BbeuCNMDixMHtv3dG9
	 eA4Ra4Yc6CqtUpeCTD6/rosY2gXDx+j+tndGEYqxE+zAN29FImiirjQ6zCU+wH91xX
	 P8FXWMKlCGDSfHWiJO8wtb4zdnYUDA7+Q+HJ8XBmxhHQZeork62RQzH38/3+Rffx7V
	 SJmmTg19Lbl8F6c1rGaYtBnTUek6F7lwJnXGwj39dagPAcyXaQGF6xOsg4YN6zpdxF
	 Sbf43L1qokFK1P3jOftsk6uKpKXl+LX8Yi2PH+tYnftcjWM6PpkAkr5qy6HqNSqjNo
	 QIAMTBoEd0++A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/8] watchdog: w83627hf_wdt: Store Super I/O
 unlocking sequence in platform data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Louvel" <paul.louvel@bootlin.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260726-w83627hf_wdt-improvements-v2-6-3645a2a6c022@bootlin.com>
References: <20260726-w83627hf_wdt-improvements-v2-0-3645a2a6c022@bootlin.com>
 <20260726-w83627hf_wdt-improvements-v2-6-3645a2a6c022@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 18:55:04 +0000
Message-Id: <20260726185504.AF34D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing NULL check for `platform_data` in `wdt_probe` leads to a k=
ernel panic.
- [High] Missing NULL check for `platform_get_device_id()` in `wdt_probe` l=
eads to a NULL pointer dereference.
--

--- Patch [6]: [PATCH v2 6/8] watchdog: w83627hf_wdt: Store Super I/O unloc=
king sequence in platform data ---
commit 60b05c387ecdfb14df4b8e624ec2e3f22d7a1aa6
Author: Paul Louvel <paul.louvel@bootlin.com>

watchdog: w83627hf_wdt: Store Super I/O unlocking sequence in platform data

This commit replaces the use of two global variables for the Super I/O=20
unlocking sequence. It instead stores the unlocking sequence in the=20
platform data.

> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_=
wdt.c
> index a067b8ea6b289..064a99db80efe 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c

[ ... ]

> @@ -439,13 +443,14 @@ static int wdt_find(int addr)
>  		pr_err("Unsupported chip ID: 0x%02x\n", val);
>  		break;
>  	}
> -	superio_exit(addr);
> +	superio_exit(addr, leave);
>  	return ret;
>  }
> =20
>  static int wdt_probe(struct platform_device *pdev)
>  {
>  	const struct platform_device_id *id =3D platform_get_device_id(pdev);
> +	const struct wdt_pdata *pdata =3D pdev->dev.platform_data;
>  	enum chips chip =3D id->driver_data;

[Severity: High]
Can platform_get_device_id() return NULL here if the driver is bound to a=20
device via sysfs driver_override or fallback name matching? If so, does=20
accessing id->driver_data cause a NULL pointer dereference?

>  	struct device *dev =3D &pdev->dev;
>  	struct watchdog_device *wdd;

[ ... ]

> @@ -476,6 +481,8 @@ static int wdt_probe(struct platform_device *pdev)
>  	wdd->max_timeout =3D 255;
> =20
>  	data->sioaddr =3D res->start;
> +	data->siocfg_enter =3D pdata->siocfg_enter;
> +	data->siocfg_leave =3D pdata->siocfg_leave;

[Severity: High]
What happens if the platform device is instantiated without platform data=20
and bound to this driver? Would pdev->dev.platform_data be NULL, leading=20
to a kernel panic when dereferencing pdata here?

>  	data->reg.timeout =3D W83627HF_WDT_TIMEOUT;
>  	data->reg.control =3D W83627HF_WDT_CONTROL;
>  	data->reg.csr =3D W836X7HF_WDT_CSR;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726-w83627hf_w=
dt-improvements-v2-0-3645a2a6c022@bootlin.com?part=3D6
