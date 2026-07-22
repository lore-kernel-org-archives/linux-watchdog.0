Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CE347D936
	for <linux-watchdog@vger.kernel.org>; Wed, 22 Jul 2026 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710138; cv=none; b=jTI5w8RjT4VcgvTA15hlhfMf7PlzQ2Ge8raglXhlE11y0CyKOfeHsS78cxJD1Q3sAQqJFM/mZwhGRmb7Tb028j1pXCWVEsFvnbYrK6fS9CTyYpuM37ioXR/PZ4TmdkrvskL8wtsAokQr/ZefruJmerUogTvBPYALz8u9C+7hJOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710138; c=relaxed/simple;
	bh=+8VujnRYO1TEPu8OJyimJqf+k38XAWsLxdGpHDxx9zE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yxqz9CG66cDDwm7UHjnirsodxmLyyR6CCmKhHNDHSeiigThPzZgdHdG3MfpUhA+7b9G22Pke5lqLB7va7VByVs9BbChyI3FRsMfxx2DO/eC89K3+bi/VuW6i6pD+CAOf2CYsOmBENUV/OnTiXdCooVEEs/dwjkkH58S9cIJh8T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L84QyWhX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L84QyWhX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE711F000E9;
	Wed, 22 Jul 2026 08:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784710137;
	bh=wcNElBHoCECqmVBaMGlxngiAGltsIXhkKnsxAeWRG4k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L84QyWhX5cN2OuZHiByKOuBmsAIyFVGKTaycVpN/orADrZax5rJuNpppgGe/dPglh
	 XMgSUdG1RRKLYM+Q08VHw9DSLNiolQumHw4e2gdFvwMx+eoEMO895tgZ8URhJ6YDZA
	 jG9FBkmTp/NTsyRPMNO3D+JQyfWdS7JxbeP88EfNnwPdlTatsQ6fkfQncRZYh0QtqC
	 cQf9I3MXuSeJ6Tf2OgBBQ8xaka7kPNc6QwWioymSfg5Bws//z2ffELCMAyGXf36FmW
	 brjBSI6sL+at2Eyzi4XfilcGBtlST31Ve91+6JTKpeIX/XcC0DcXDEpweWpUj6ycJR
	 8VU5OtrY+qtkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/9] watchdog: sama5d4: Remove redundant dev_err()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260722084218.79073-9-panchuang@vivo.com>
References: <20260722084218.79073-1-panchuang@vivo.com>
 <20260722084218.79073-9-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 08:48:55 +0000
Message-Id: <20260722084856.CCE711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Probe order bug: shared interrupt is requested before drvdata is i=
nitialized, leading to a potential NULL pointer dereference in the interrup=
t handler.
--

--- Patch [8]: [PATCH 8/9] watchdog: sama5d4: Remove redundant dev_err() ---
commit 47cdf2034aad624309814a76e94fadcc6063281c
Author: Pan Chuang <panchuang@vivo.com>

watchdog: sama5d4: Remove redundant dev_err()

Since devm_request_irq() automatically logs detailed error messages on
failure, this commit removes the now-redundant driver-specific dev_err()
call from the probe path.

> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wd=
t.c
> index 704b786cc2ec6..ecdd9aeab79cc 100644
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c
> @@ -291,10 +291,8 @@ static int sama5d4_wdt_probe(struct platform_device =
*pdev)
>  		ret =3D devm_request_irq(dev, irq, sama5d4_wdt_irq_handler,
>  				       IRQF_SHARED | IRQF_IRQPOLL |
>  				       IRQF_NO_SUSPEND, pdev->name, pdev);

[Severity: High]
This is a pre-existing issue, but since IRQF_SHARED is used here, could the
interrupt fire immediately if another device on the same line triggers it, =
or
if there is a pending hardware interrupt?

If that happens, sama5d4_wdt_irq_handler() will be called with pdev as dev_=
id:

drivers/watchdog/sama5d4_wdt.c:sama5d4_wdt_irq_handler() {
	struct sama5d4_wdt *wdt =3D platform_get_drvdata(dev_id);
	...
	if (wdt->sam9x60_support)
	...
}

Because platform_set_drvdata() is called much later in sama5d4_wdt_probe(),
platform_get_drvdata(dev_id) will return a null pointer. Does this result in
a null pointer dereference during probe?

> -		if (ret) {
> -			dev_err(dev, "cannot register interrupt handler\n");
> +		if (ret)
>  			return ret;
> -		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722084218.7907=
3-1-panchuang@vivo.com?part=3D8
