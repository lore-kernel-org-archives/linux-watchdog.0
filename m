Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122964;
	b=uTkamUAfaNeVllgG89B5xkpgpJOu6s8hHV/XywQOCNCmCxkbItGQ8JPkNzX2PcmP8vj0
	 gIX9/GVSZSKIt7VoyNwTV/INdrfI5/zpmAw8KVPan2uW7fjwP4eH5zVJoxOvJZeJM7mI1
	 80jU+ckPl6rfz8NeGq3HMbeIYQKKEkVsnXtHHy/j+aiYwE+XnwfNs1b5xF8PnxzKSpjF2
	 FSck1r40RMAxGLV370w7ylzK0djNLrRTt3c97rfT/fc1X0g+pllXJcnYuUhQrVz8y8IcI
	 7QhvA3NtWHf9nen2W8qDo2vLM87h32jOgpQt1ldpKRroRvp2CICc9/v1bAzL2i9jqQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122964;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vYA5BvGkfewtAozyS/VTvQ5yhDKXPbLK5gOJ6zwVUqs=;
	b=UyUzFOYEVtVZOoLtOBBZzdSLhTW4crdY+8thC6N24PcS5+RQbizENOYRaurq1iJTbxwZ
	 nonVethjAlUC8LoMzkC4Ccs9HToQZYqEV4hqznaiy6bVHSZ1XOASSn3Qx0LUE/mZCO8/K
	 NbuiljVZ+HkmkCP2wY4Anyuq88uweSgMCk194a4ssrlo3P0nT0MJHGyPxc/XoM+n2jZI3
	 VRbMmyA9axFchpaFK2+qWXBbBXmYuea1ggzPTFDsT3QPmeIOt9+Fcxr/X3EageGDooPIG
	 e49An1YGj1N09gpnsgiqRsozIFOcIXnIt/Hoz30ZMqvVUIPBgOtmdp2MddXr9me414A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CSD3SnKT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6610F606A333
	for <linux-watchdog@vger.kernel.org>; Thu, 19 Nov 2026 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CSD3SnKT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC821F000CA;
	Thu, 19 Nov 2026 21:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795122964;
	bh=vYA5BvGkfewtAozyS/VTvQ5yhDKXPbLK5gOJ6zwVUqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CSD3SnKTtVqQ9rwKGyTqb00xdN8wd59y0lw5KAw2D6M2nVXvBX60mvbF3TRDuQK7Y
	 nKE/WKFBqiODLBcPGHgLG3i/ayAy5IcKBc8jZU77b71rjqovEC5N1O6kPvkeu59pRh
	 rZsN1G4vLW1VriJ3rfVjX8mmpR0dIe5ZZSBuhBP4ocT7wR00g1kM0ku2Ak1JSALmNt
	 RezoJmSNtyujBtbfTEhHZOuKA0vKQFn3tfDJYhkgBgmeDBnHEpk09OWbCJsLxvHb5A
	 QsNwp2e0xQD+uvFamPwEow8aSr0C3hmiHYWgIHLXyz1ar9JDghx7wRlXfZrwv2EK8Y
	 JBQyYOAAvRDKw==
Message-ID: <sashiko-outbox-224085@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: intel_oc_wdt: Stop the watchdog during system
 sleep
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Menzel" <pmenzel@molgen.mpg.de>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261119210358.610521-1-pmenzel@molgen.mpg.de>
References: <20261119210358.610521-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 21:16:03 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] watchdog: intel_oc_wdt: timeout not restored in
  intel_oc_wdt_resume_noirq()
--

commit 4da4626fae8bd66b23127eb234a7132f8de0ce8a
Author: Paul Menzel <pmenzel@molgen.mpg.de>

watchdog: intel_oc_wdt: Stop the watchdog during system sleep

This commit adds noirq suspend and resume callbacks to stop the Intel OC
watchdog during system sleep and restart it on resume.

> diff --git a/drivers/watchdog/intel_oc_wdt.c b/drivers/watchdog/intel_oc_=
wdt.c
> index a78fe1e5f410b..6e32536fae4b9 100644
> --- a/drivers/watchdog/intel_oc_wdt.c
> +++ b/drivers/watchdog/intel_oc_wdt.c
[ ... ]
> @@ -212,6 +214,45 @@ static int intel_oc_wdt_probe(struct platform_device=
 *pdev)
>  	return devm_watchdog_register_device(dev, wdd);
>  }
> =20
> +/*
> + * Neither user space nor the watchdog core can ping the watchdog while =
the
> + * system sleeps, and in suspend-to-idle the counter keeps running, so s=
top the
> + * watchdog late in suspend and restart it early in resume. Check the ha=
rdware
> + * enable bit, as the watchdog may also have been started by the firmwar=
e.
> + */
> +static int intel_oc_wdt_suspend_noirq(struct device *dev)
> +{
> +	struct intel_oc_wdt *oc_wdt =3D dev_get_drvdata(dev);
> +
> +	oc_wdt->suspended =3D false;
> +
> +	if (oc_wdt->locked ||
> +	    !(inl(INTEL_OC_WDT_CTRL_REG(oc_wdt)) & INTEL_OC_WDT_EN))
> +		return 0;
> +
> +	intel_oc_wdt_stop(&oc_wdt->wdd);
> +	oc_wdt->suspended =3D true;
> +
> +	return 0;
> +}
> +
> +static int intel_oc_wdt_resume_noirq(struct device *dev)
> +{
> +	struct intel_oc_wdt *oc_wdt =3D dev_get_drvdata(dev);
> +
> +	if (!oc_wdt->suspended)
> +		return 0;
> +
> +	intel_oc_wdt_start(&oc_wdt->wdd);
> +	intel_oc_wdt_ping(&oc_wdt->wdd);
> +	oc_wdt->suspended =3D false;
> +
> +	return 0;
> +}

[Severity: Medium]
Should intel_oc_wdt_resume_noirq() also restore INTEL_OC_WDT_TOV via
intel_oc_wdt_set_timeout(&oc_wdt->wdd, oc_wdt->wdd.timeout)?

Across hibernation (or S3 if platform firmware resets the control
register), the hardware register loses any runtime timeout set via
WDIOC_SETTIMEOUT and reverts to the boot or probe default
(INTEL_OC_WDT_DEF_TOV, 60 seconds).  Because intel_oc_wdt_start() only
sets INTEL_OC_WDT_EN and intel_oc_wdt_ping() reloads from the current
INTEL_OC_WDT_TOV field, a userspace daemon configured with a longer
timeout and a matching ping interval can hit an unexpected watchdog reset
after resume.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119210358.6105=
21-1-pmenzel@molgen.mpg.de?part=3D1
