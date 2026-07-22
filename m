Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C009E480DFE
	for <linux-watchdog@vger.kernel.org>; Wed, 22 Jul 2026 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710242; cv=none; b=K5BmFSwkpcFGvCJSFUjX8UwReqTizTrwlIC1nD9EwYwFJJkP7UgOgnBXyiB4wIwJX9M2JV5XzHMf10522cvFoXyyfYXO5U8ZEDyVSrZ25xoE6hnGAd6peSsF05itExMnLG5Lt/vlM3cK0Y6wpFOBPv0PYU2gBfySe17sk8vhOMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710242; c=relaxed/simple;
	bh=zHm7r1lOgDV7tuZeZsdmXzUPMfVYrzZpuxPcqGDWP80=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lGHjOqo8RYjSAtcjnf24LNkrtSy2kNrEOsmFeTVFXHQ/HjfMKdcAvEDXeGZRGSuQVu/sVNgbKLGmnuMAgXr1P4idRXiXU1C//ZxlyVCVoYMJgD7sX4VoF4+KPYVmcl7Wyluec9ms5a5C5AC5rnHZXADstQ1O/xmZ7bOEMwCaPNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7X3bfIt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7X3bfIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238781F000E9;
	Wed, 22 Jul 2026 08:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784710241;
	bh=iTin/ZB6XffJNULgzt/z6FKL2RUrd+1N0kHhFj3VVPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m7X3bfItKY8UH2IOgRPZRsJrHqkA1f/StWya4ZFEjXNzEw9b5YxQ/8rE0F3YAywtl
	 +FkrwNpIzNgtvco3ucqWGdeh/GxFmwFAXvlDbHJwjThJq9ccEDkui4w856dt4gra0o
	 6Jakxl00TUH0cMoJgV/2ZyjlIyrYLMGb32kOayvzEN6F7oLEoewpBpdo7BQVe+THJY
	 BQinJYPF2Dj4jv3RSLJafkf/1Vxa+MozAUkgDryoRvS2UaDlbCLebqdVbhhnNTdFRC
	 qJLCIZ2iKPrNZfWgmemCGwyRCx4fCRyrUhB964coOUkQy3Lzh3nRLbaD3oKFnsGqDa
	 8eO0qh279x6fQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] watchdog: orion: Remove redundant dev_err()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260722084218.79073-7-panchuang@vivo.com>
References: <20260722084218.79073-1-panchuang@vivo.com>
 <20260722084218.79073-7-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 08:50:40 +0000
Message-Id: <20260722085041.238781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The probe function silently ignores probe deferral and other error=
s from platform_get_irq_optional().
- [High] The driver incorrectly modifies a static global watchdog_info stru=
cture during device probe.
--

--- Patch [6]: [PATCH 6/9] watchdog: orion: Remove redundant dev_err() ---
commit 820e86c1dcc7da8eb296b1915c4c9eb8f9dc8666
Author: Pan Chuang <panchuang@vivo.com>

watchdog: orion: Remove redundant dev_err()

This commit removes redundant dev_err() messages in the driver, as
devm_request_irq() automatically logs errors on failure.

> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index 0e145f762f6f2..1802634cc7cda 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -613,10 +613,8 @@ static int orion_wdt_probe(struct platform_device *p=
dev)
>  		 */
>  		ret =3D devm_request_irq(&pdev->dev, irq, orion_wdt_irq, 0,
>  				       pdev->name, dev);

[Severity: High]
This isn't a bug introduced by this patch, but does orion_wdt_probe() silen=
tly
ignore probe deferrals when getting these interrupts?

Earlier in this function, the primary and secondary interrupts are fetched:

    irq =3D platform_get_irq_optional(pdev, 0);
    if (irq > 0) {

If the interrupt controller is not yet ready, platform_get_irq_optional()
returns -EPROBE_DEFER. Because of the if (irq > 0) check, we silently skip
the interrupts instead of propagating the error and deferring the probe. Th=
is
can cause the watchdog to permanently drop its interrupt-driven capabilitie=
s on
boot.

> -		if (ret < 0) {
> -			dev_err(&pdev->dev, "failed to request IRQ\n");
> +		if (ret < 0)
>  			goto disable_clk;
> -		}
>  	}
> =20
>  	/* Optional 2nd interrupt for pretimeout */
> @@ -625,10 +623,8 @@ static int orion_wdt_probe(struct platform_device *p=
dev)
>  		orion_wdt_info.options |=3D WDIOF_PRETIMEOUT;

[Severity: High]
This is a pre-existing issue, but does this permanently corrupt the static
global orion_wdt_info struct for the lifetime of the module?

If the driver successfully finds a pretimeout interrupt during probe, it
permanently modifies the shared static global orion_wdt_info structure by
setting WDIOF_PRETIMEOUT.

If the device is subsequently unbound and re-bound to a hardware configurat=
ion
without the interrupt, or if multiple SoC instances exist with differing
interrupt capabilities, the driver will inherit the corrupted global state =
and
falsely advertise the pretimeout feature to userspace.

>  		ret =3D devm_request_irq(&pdev->dev, irq, orion_wdt_pre_irq,
>  				       0, pdev->name, dev);
> -		if (ret < 0) {
> -			dev_err(&pdev->dev, "failed to request IRQ\n");
> +		if (ret < 0)
>  			goto disable_clk;
> -		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722084218.7907=
3-1-panchuang@vivo.com?part=3D6
