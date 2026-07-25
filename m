Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85543331EAF
	for <linux-watchdog@vger.kernel.org>; Sat, 25 Jul 2026 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784976292; cv=none; b=e27mxoqiV/hKtcebXuWSQ3Lz2YizrXJ1DInC/v6ALOsOaLtpFiQ5pYN998dI89HJjE/rux/DMeFMrDphugdMdi26cbuTXYivDSH+KqysLiG5b9rqjJ0YgjaLxeqoaNBWowA47ibJo+sM85MU3OU+DbIOKOY6H48NMCNFgLGnGss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784976292; c=relaxed/simple;
	bh=8xzPR9mumc8DWPjfOUM20XQOfVIKyTEAwBp4K4kGcz0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S40e+eIP/Vwe3jWmdSaaaY8Te9nNFluU0Oz/HBb7eGTVOeRy5LVayMotFrBWHaESbDnJtP6W3Aa4ldE/LFOnv1KSqErKcTHPWrKgR3uq1KYKpfsO2MkhcKiP8aqFagaRIITgHtAa9rcHOLvHl5BOZYia8C8DMpxy+wP6MiitEA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmB3ovqG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmB3ovqG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF7F1F000E9;
	Sat, 25 Jul 2026 10:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784976291;
	bh=NF6iJ6+mfTxf4jHH/pryxwi17kkWrgO7TG3fZFcqnyA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WmB3ovqGbOyd6tMM80PmUgZrmicXlCuoWMTVtnvYP7u6SF9v7EalSSqMQgOEsLEeD
	 2X0OGuSteC7Tr0arp3cmb1rHpigu8ty11U945kQl8Q0yawZXoZZCH/i/9OsDo8RDyn
	 zU0Hzx/3ksSszi0b8aVZjVD2KKADfmyerTliDf1Vg1E1gAnq2LQwF3DgheJdCpIR5V
	 ijVAaA7YXRzsOcfRVECoV4wZ5ofNaQU/SkouyZdtvDmm4yNM60tiPikttvt6coGucO
	 MEatBUEjNR6cJCdET4t/jukJibglCt5ZJiVKMIzWMv7EwrJaivWkoh2zKtnX8qEd9Y
	 0zvU1rbd3MdSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] watchdog: w83627hf_wdt: Store Super I/O unlocking
 sequence in platform data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Louvel" <paul.louvel@bootlin.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260725-w83627hf_wdt-improvements-v1-6-4e9a1b4e8297@bootlin.com>
References: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
 <20260725-w83627hf_wdt-improvements-v1-6-4e9a1b4e8297@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 10:44:50 +0000
Message-Id: <20260725104451.4AF7F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The local stack variable `struct resource res` is partially uninit=
ialized before being passed to `platform_device_register_resndata()`, leaki=
ng stack garbage and risking kernel panics.
- [High] Missing NULL check for `pdata` (`pdev->dev.platform_data`) in `wdt=
_probe` leads to an unconditional NULL pointer dereference.
- [High] Missing NULL check for `id` (`platform_get_device_id(pdev)`) in `w=
dt_probe` leads to a kernel panic.
--

--- Patch [6]: [PATCH 6/9] watchdog: w83627hf_wdt: Store Super I/O unlockin=
g sequence in platform data ---
commit a8ddfa0e2fa7007bc7d8b51099f9722c0113c5c5
Author: Paul Louvel <paul.louvel@bootlin.com>

watchdog: w83627hf_wdt: Store Super I/O unlocking sequence in platform data

This patch stores the Super I/O unlocking sequence in the platform data
instead of using global variables.

> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_=
wdt.c
> index 6363d571182fa..fed05fcf82bbf 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
[ ... ]
> @@ -441,13 +443,14 @@ static int wdt_find(int addr)
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
Is it possible for id to be NULL here? If this driver is bound to an
arbitrary device via the driver_override sysfs interface (which skips setti=
ng
pdev->id_entry), platform_get_device_id(pdev) will return NULL. Will this
cause a kernel panic when dereferencing id->driver_data?

>  	struct watchdog_device *wdd;
>  	struct w83627hf_data *data;
[ ... ]
> @@ -477,6 +480,8 @@ static int wdt_probe(struct platform_device *pdev)
>  	wdd->max_timeout =3D 255;
> =20
>  	data->sioaddr =3D res->start;
> +	data->siocfg_enter =3D pdata->siocfg_enter;
> +	data->siocfg_leave =3D pdata->siocfg_leave;

[Severity: High]
Could pdata be NULL at this point? If a local privileged user manually
triggers driver binding via sysfs on a dummy platform device that lacks
platform_data, pdev->dev.platform_data will be NULL. Dereferencing pdata
here would result in a NULL pointer dereference.

>  	data->reg.timeout =3D W83627HF_WDT_TIMEOUT;
>  	data->reg.control =3D W83627HF_WDT_CONTROL;
>  	data->reg.csr =3D W836X7HF_WDT_CSR;
[ ... ]
> @@ -579,20 +589,22 @@ static struct platform_device *wdt_pdev;
> =20
>  static int __init wdt_init(void)
>  {
> -	struct wdt_pdata pdata;
>  	struct resource res;

[Severity: High]
Does this code leave internal fields of the stack variable res uninitialize=
d?
Since res is declared on the stack without being zero-initialized, fields
like parent, sibling, and child may contain stack garbage.

Later, when res is passed to platform_device_register_resndata(), it uses
kmemdup() to copy this struct. During platform_device_add(), the kernel
iterates over resources and checks if (!r->parent). Since res.parent
contains non-NULL stack garbage, it bypasses the default assignment and
passes the garbage pointer to insert_resource(), which could result in a
page fault and kernel panic during module load.

>  	int sioaddr;
>  	int ret;
>  	int chip;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725-w83627hf_w=
dt-improvements-v1-0-4e9a1b4e8297@bootlin.com?part=3D6
