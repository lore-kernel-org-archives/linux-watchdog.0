Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD45C377ED7
	for <linux-watchdog@vger.kernel.org>; Fri,  7 Aug 2026 08:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090624; cv=none; b=oxLYN4HDsxDB7E+JN0UrXtDrBCjdbKjVV4HhCYLwDAww6q6gGyeQWj6wNRFyoE5i6ZI0VDT1raFpb1dAyRT5xhRz7wzCBU3TD2D6G7S3PjDUubV0JTcJwe3W00oN/w7Gd3Dr9oB7IoW2uw6WFn9jLMVnOWhWdcyJjZ4MkbjQUE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090624; c=relaxed/simple;
	bh=7I3CChseo5wZarFF9yjsNAbBqEScSXqp38sOIHJtyXs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BMxcsUFRUcaq7M8n7FEK3qcCPbKf+zTRk0fMBOH3QYH4yTsUJgg9yC0lZTxslFBykwsp/3Xjei9I4p+aXxohXFn7KsNz6hJMyUijJj5/BFZHhz+G4CoFe4cYMh5Qzm0WNSLnQeenfx630NjHRGeEocoF2CPUGD+bpllRuv8jcaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1Xsb6jl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1Xsb6jl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D691F00A3A;
	Fri,  7 Aug 2026 08:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786090622;
	bh=POdiiqgDVpNFxUiBX5qjdXpQcwJ9g0ISkp4qgFinFXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q1Xsb6jlD8jF9KFwVv+Qb6rnRRB1buIBT5Gey9lu/8BmilyoxYSPExdwcQTVFtW0h
	 Qt90FihRM6qvlEpT3DeLMoeCazR4ifRFTf3Yxy42lKYfG0ICDXEL1imaTtHfzpS668
	 kDYpWZHcDcGJJAPKWC5IFV3X/hLOFyjgITTWcptCag+fz6ikOX5uFdpfOLCkTihXJs
	 kX7fr75ep2vfhFvjw+yXvNecEMtSBQYviKbk/wf0PlLdfAlk6jkqLRfTG6owYCiDaA
	 /p4PiF2l/6Tk7qFFZke6GeWDzdE/BuZCNnk8mmsGY6gjoCQNi+CONNT6B0HGiju038
	 J9NP5hHiRfVzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] watchdog: stm32_iwdg: Propagate errors from
 optional IRQ lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: phucduc.bui@gmail.com
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260807080447.35479-2-phucduc.bui@gmail.com>
References: <20260807080447.35479-1-phucduc.bui@gmail.com>
 <20260807080447.35479-2-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 08:17:01 +0000
Message-Id: <20260807081701.C3D691F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup of `dev_pm_set_wake_irq()` leads to a memory leak =
and causes subsequent probes to fail permanently with `-EEXIST`.
--

--- Patch [2]: [PATCH v2 2/2] watchdog: stm32_iwdg: Propagate errors from o=
ptional IRQ lookup ---
commit 2e08fbcd4cd54dae1e6ee4882052b35d6df14b51
Author: bui duc phuc <phucduc.bui@gmail.com>

watchdog: stm32_iwdg: Propagate errors from optional IRQ lookup

This commit updates the IRQ initialization in the stm32_iwdg watchdog
driver to properly propagate errors from platform_get_irq_optional(). It
ensures that errors such as -EPROBE_DEFER or -EINVAL are passed back to
the caller, rather than continuing the probe without an IRQ. The -ENXIO
return value is still treated as a missing optional IRQ and handled
gracefully.

Link v1: https://lore.kernel.org/all/20260806062812.26523-2-phucduc.bui@gma=
il.com/

> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
> index b356a272ff9a0..a8d2db2d3cf8b 100644
> --- a/drivers/watchdog/stm32_iwdg.c
> +++ b/drivers/watchdog/stm32_iwdg.c
> @@ -287,8 +287,11 @@ static int stm32_iwdg_irq_init(struct platform_devic=
e *pdev,
>  		return 0;
> =20
>  	irq =3D platform_get_irq_optional(pdev, 0);
> -	if (irq <=3D 0)
> +	if (irq < 0) {
> +		if (irq !=3D -ENXIO)
> +			return irq;
>  		return 0;
> +	}
> =20
>  	if (of_property_read_bool(np, "wakeup-source")) {
>  		ret =3D devm_device_init_wakeup(dev);

[Severity: High]
This is a pre-existing issue, but since we are adjusting the error handling
around IRQs here, is there a missing cleanup path for the wake IRQ?

A bit further down in stm32_iwdg_irq_init(), the code calls the unmanaged
dev_pm_set_wake_irq(dev, irq) function:

	if (of_property_read_bool(np, "wakeup-source")) {
		...
		ret =3D dev_pm_set_wake_irq(dev, irq);
		if (ret)
			return ret;
	}

	ret =3D devm_request_irq(dev, irq, stm32_iwdg_isr, ...);

If devm_request_irq() fails immediately after, or if a subsequent setup step
like stm32_iwdg_start() fails in stm32_iwdg_probe(), the wake IRQ remains
attached because dev_pm_set_wake_irq() does not automatically clean up on
failure or device unbind.

Could this cause the memory for the wake IRQ to leak and leave a dangling
pointer in dev->power.wakeirq? If a probe deferral or unbind occurs,
would the next probe attempt fail permanently with -EEXIST when
dev_pm_set_wake_irq() encounters the dangling pointer? Would using
devm_pm_set_wake_irq() here instead ensure proper lifecycle management?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807080447.3547=
9-1-phucduc.bui@gmail.com?part=3D2
