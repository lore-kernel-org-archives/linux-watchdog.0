Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861A91A6816
	for <linux-watchdog@vger.kernel.org>; Thu,  3 Sep 2026 02:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402351; cv=none; b=EuuIjmAMpBOEBI4cgFrZ/2rLqtDA/COO9QlQ2mzq3YCAwbyk21d+r50EgfX87VDOxDsfON9ej8PPhgZLxVWL+CPYRyql5VdB0LsdMPPJ7QVoI23F/LDlPGCtCtThreGW0dVTLgHnz0MEgwhPqDC5HZnUdigiKs4IKYyjVh0WDJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402351; c=relaxed/simple;
	bh=UeRIEtEulviy5/kdPfcdUVzqnMbPXYTrZwZtuVFDXcY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dHHTbv/Hmc/ZjHCpvuLDM4PevPfvBICgVD3rLgBKQZrGmYIm5BTQ+Z8AFFiZFJIMM9Q3KWEXRAlk4U2/Pdr9B/9N/5fs4ftO8Vwn0fBGzy2XhZt/QhLKJnvZkRGpRZi8PttYWS0jCDoOQtFcdGpImg2ebY3GcPFgC5Zq/wB3wc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fka6/BuV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fka6/BuV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A501F000E9;
	Thu,  3 Sep 2026 02:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788402348;
	bh=fcKAeM1tJ6RoZyJGkbwz1s9qRvu/661Ah8lGq5oySUk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fka6/BuVTk0N845iErrJKS5d8/ji532zKHi1uoi4eoTJrheUsaTwD7DTmx8eCjp5E
	 lUkgBwDa0HZzAEoSbi3T4oy11UTmoM+8PRSDgWsDIrBxigDmzedr17LZ0n9bwwncr8
	 Jfq0KL3ReK16jZAdC8GkApL33q4m6M6YShm4PaunV8dmDkQcVNCcUZOvCZ/gz5CmXH
	 IDanQulEmzYd4cIWarI2kWtZBiJo7CjNcALwu4wRRmzcZxmAPOMutQGrEE2fPB0u+/
	 RjBYB/7jvdov/ULmG8gzjjjRRD6aLI688OV6xp+r5/mtDRptlwBBvju8QN7RTJiaQu
	 g5HwqAw64fbeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] watchdog: qcom: Register pretimeout interrupt as
 NMI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mayank Rungta" <mrungta@google.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260902-qcom-wdt-nmi-series-v3-5-f3999362a9ea@google.com>
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
 <20260902-qcom-wdt-nmi-series-v3-5-f3999362a9ea@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 02:25:47 +0000
Message-Id: <20260903022548.06A501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Level-triggered bark interrupts will cause an infinite NMI storm a=
nd hard-lock the CPU.
--

commit 8f544329ecb4910dd7e00b39c0aabc3e32909823
Author: Mayank Rungta <mrungta@google.com>
Subject: watchdog: qcom: Register pretimeout interrupt as NMI

This commit modifies the qcom-wdt driver to attempt registering the watchdog
pretimeout bark interrupt as an NMI using request_nmi(). If NMI registration
is unsupported on the platform, it gracefully falls back to a standard
interrupt request.

> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index 4eb1bf9790125..2849dcb1f717c 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c

[ ... ]

> @@ -311,10 +321,25 @@ static int qcom_wdt_probe(struct platform_device *p=
dev)
>  		if (irq < 0 && irq !=3D -ENXIO)
>  			return irq;
>  		if (irq > 0) {
> -			ret =3D devm_request_irq(dev, irq, qcom_wdt_isr, 0,
> -					       "wdt_bark", &wdt->wdd);
> -			if (ret)
> -				return ret;
> +			wdt->irq =3D irq;
> +			irq_flags =3D IRQF_PERCPU | IRQF_NOBALANCING |
> +				    IRQF_NO_AUTOEN | IRQF_NO_THREAD;
> +
> +			ret =3D request_nmi(irq, qcom_wdt_isr, irq_flags,
> +					  "wdt_bark", &wdt->wdd);

[Severity: High]
Does requesting this interrupt as an NMI risk an infinite NMI storm on=20
platforms where the bark interrupt is level-triggered (e.g., QCS615 'talos',
QCM2290 'agatti', or 'shikra')?

Looking at qcom_wdt_isr(), the handler simply notifies the pretimeout and=20
returns without acknowledging or clearing the hardware interrupt line:

static irqreturn_t qcom_wdt_isr(int irq, void *arg)
{
	struct watchdog_device *wdd =3D arg;

	watchdog_notify_pretimeout(wdd);

	return IRQ_HANDLED;
}

Since NMI handlers bypass the generic IRQ spurious interrupt protection tha=
t=20
would normally mask an unhandled level-triggered interrupt, will this cause
an immediate re-trigger upon return and hard-lock the CPU when the=20
pretimeout is reached?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-qcom-wdt-n=
mi-series-v3-0-f3999362a9ea@google.com?part=3D5
