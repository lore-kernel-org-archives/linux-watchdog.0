Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437D1371877
	for <linux-watchdog@vger.kernel.org>; Sat, 25 Jul 2026 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784975797; cv=none; b=QdMs0t69yPkF0sqpSmCxhJ0tezut4e1YlRtN1QmTKo0z3JYsO2dL8QlewMydKf6WIlrcLVMsoHGxmO1SVu2orIauNubOU0VSJBOslzdeD4nwJ2ohcuO1kv1qqMbrKmDvd8x0bjrpRCRIYHkbgVqF5IrLTv8nT/qANeBGwkl8Cnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784975797; c=relaxed/simple;
	bh=eKpCPXoKCWe1VwHnFjAhrXDoVTxmuXGjubrGMNYewfQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WOO1NUFbpVtqxfe6GqIK4U11KE23vUs0LiVm3XxCEtODG1x/C8CCf3ABA6wnVL19X5NWMHehq061aQcHu7w22kCxqjpucUV7jfCqBskt9OWo/pIYKRNrkJ3Lwo6Vm0CnD8d8G5r/XI8UTqOrPTisPLnocQP0vDfuOfYftCC0NSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9WeDw43; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9WeDw43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14091F000E9;
	Sat, 25 Jul 2026 10:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784975795;
	bh=gL5fHBBaFWSKq0w6/pt81T6m/RTCmgsp446WW9QtLj4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H9WeDw43g0Ga8jzCeJJJKEkBLZng0lRgttXORo0BXOF7qc8gVaLIiENhraN9rp6M8
	 svlPvY82aA0gFzc2pwABYmXTlRI49pWbzCCBGyQPWXE7aHdiWCteozyeEOPbyBM+GO
	 twP2S/G0sHcvjypDuT+t+XIymez5MlqJv0/lXv+o+6kPEg6sAzf9/OaYBU8BBkkSBA
	 qKoZY2pF5RMGIGaqv5hOPG0Q3Oy1xiLYo5P8H0pmg1Hb1brY5azm1qRcclEZYxyLrq
	 MhJtqE1TP6ZpvV8uYkStfv1/El1zGxhre2JChC3MRlwfYVOATNEbfdOdTeGWaz1gkq
	 7OWAEg9NcRYvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/9] watchdog: w83627hf_wdt: Report all initialization
 failures in probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Louvel" <paul.louvel@bootlin.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260725-w83627hf_wdt-improvements-v1-8-4e9a1b4e8297@bootlin.com>
References: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
 <20260725-w83627hf_wdt-improvements-v1-8-4e9a1b4e8297@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 10:36:35 +0000
Message-Id: <20260725103635.B14091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Redundant and discouraged custom error logging on memory allocation=
 failure.
--

--- Patch [8]: [PATCH 8/9] watchdog: w83627hf_wdt: Report all initializatio=
n failures in probe ---
commit 2d2f57b98d7747ee2d5b243ffbdaf86d9f565235
Author: Paul Louvel <paul.louvel@bootlin.com>

watchdog: w83627hf_wdt: Report all initialization failures in probe

The driver currently logs an error only if the chip initialization
fails. Extend the error reporting to all failure paths in probe to
improve diagnostics.

> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_=
wdt.c
> index 90d41f21aa5e2..cf1a3fb3a6fd3 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
> @@ -479,12 +479,16 @@ static int wdt_probe(struct platform_device *pdev)
[ ... ]
>  	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> -	if (!data)
> -		return -ENOMEM;
> +	if (!data) {
> +		ret =3D -ENOMEM;
> +		goto fail;
> +	}

[Severity: Low]
Does this introduce redundant logging for memory allocation failures?

When devm_kzalloc() fails, the kernel's memory management subsystem already
dumps a highly visible warning and stack trace. Routing this failure path
to the fail label adds a custom pr_err() for the OOM condition.

Could we return -ENOMEM directly here instead of jumping to the fail label
to avoid redundant log spam?

[ ... ]
> +fail:
> +	pr_err("failed to initialize watchdog (err=3D%d)\n", ret);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725-w83627hf_w=
dt-improvements-v1-0-4e9a1b4e8297@bootlin.com?part=3D8
