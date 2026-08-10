Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539D73BA25F
	for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357698; cv=none; b=KmkNwFA/WpAkBbgIEurYWHU8ygrcvUA+qx2+1p2BSmIcOES9o7LADEO/cIrrJIEWaPSgeEZVnvZYeZcvDso2X0obpO9UdZUAwQLAoYyTDBeIF/oTZ5j1QYW4GuK+QOCWg6y2syOVRU1muNXRinos/tLOz4cgGS3aqqCXEDLkpvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357698; c=relaxed/simple;
	bh=5rlhIfKR87SPivTWSXB7lIFHoXvVdoHE7MiBWaTvJXw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mz34W1qTK6wmxBl/uJ9eoRuaX8KbR8CV0npm5qoDz065kO9CFg1Sq6WnVNHQJPTzz6MnVXv0Y2LsUMXIhRLV4LnO2xOpHeq6cmT8TdHqxKnfcSPbX61eVgAcQRMab4+FwT0yrDg/k5gF8np2ZqP3zLl7gvVSOK7mN53r36fRlsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyTdLWeI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyTdLWeI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3720F1F00A3D;
	Mon, 10 Aug 2026 10:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786357695;
	bh=eykf4pd85jym49ATKOudYgtlVdkJurj8juUTx9EVAyQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PyTdLWeI7KJVogv85m11TItmY2ftcBfuIObopftoBrbMCfSkOI4qAn55fSWEqBZ+W
	 3Mj/qQKRzba0sEBo4Duc/0dLb/d0326t8B2kCj5kmXPlI6OnPqbWjab/aFpc321jFh
	 iKtZaSIR+8swtTwIZ3QyGuIOXND3PgrvWeCDcoxdRhNyH3qBsQPvMX7gVWW3JZW4Pu
	 NlsQkMAqWT83oBegTy/dKMX1NrTuo/JfONdybyafvw72Nl7v+Wae/nk2p9BQP5oFnr
	 y/UCecOURPEinMSPS6Ff4XE2NytcnbNEgh5n5OgTYeiNhXnx4kFOV7LaSL2AVsytHw
	 +XCQa9R6xlvHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] watchdog: qcom: Propagate errors from optional IRQ
 lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: phucduc.bui@gmail.com
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260810102144.51663-1-phucduc.bui@gmail.com>
References: <20260810102144.51663-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 10:28:14 +0000
Message-Id: <20260810102815.3720F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing initialization of `wdt->wdd.info` when the optional pretim=
eout IRQ is absent but pretimeout is supported.
- [Low] Redundant sequential calls to `platform_get_irq_optional()`.
--

--- Patch [1]: [PATCH v2] watchdog: qcom: Propagate errors from optional IR=
Q lookup ---
commit bf01bac4df56d04f8ab925257d4dfcb55e1e6adf
Author: bui duc phuc <phucduc.bui@gmail.com>

watchdog: qcom: Propagate errors from optional IRQ lookup

This commit modifies the qcom watchdog driver to propagate errors returned
by platform_get_irq_optional(), rather than only checking for -EPROBE_DEFER.

Link: https://lore.kernel.org/all/20260807081652.38692-1-phucduc.bui@gmail.=
com/

> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index a425902b9f68d..5c16420751631 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -305,18 +305,20 @@ static int qcom_wdt_probe(struct platform_device *p=
dev)
> =20
>  	/* check if there is pretimeout support */
>  	irq =3D platform_get_irq_optional(pdev, 0);
> -	if (data->pretimeout && irq > 0) {
> +	if (data->pretimeout) {
> +		irq =3D platform_get_irq_optional(pdev, 0);

[Severity: Low]
This isn't a bug, but is the first call to platform_get_irq_optional() still
needed?

It appears that if data->pretimeout is true, the result is immediately=20
overwritten by the second call. If data->pretimeout is false, the irq value=
 is
ignored by the else branch.

> +		if (irq < 0 && irq !=3D -ENXIO)
> +			return irq;
> +		if (irq > 0) {
> +			ret =3D devm_request_irq(dev, irq, qcom_wdt_isr, 0,
> +					       "wdt_bark", &wdt->wdd);
> +			if (ret)
> +				return ret;
> +
> +			wdt->wdd.info =3D &qcom_wdt_pt_info;
> +			wdt->wdd.pretimeout =3D 1;
> +		}

[Severity: High]
Does this code leave wdt->wdd.info uninitialized if data->pretimeout is true
but the optional IRQ is missing?

If platform_get_irq_optional() returns -ENXIO, the if (irq > 0) branch is
skipped. Since this all occurs inside the if (data->pretimeout) branch, the
outer else block is bypassed.

Could this cause devm_watchdog_register_device() to later fail with -EINVAL
because wdd->info is NULL?

>  	} else {
> -		if (irq =3D=3D -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> -
>  		wdt->wdd.info =3D &qcom_wdt_info;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810102144.5166=
3-1-phucduc.bui@gmail.com?part=3D1
