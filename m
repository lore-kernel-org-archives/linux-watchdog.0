Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3303ED3CF;
	Fri,  4 Sep 2026 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534678; cv=none; b=PtarvxeGLTOJ5IilooSs40U2+Hatvniacr8sCJLH3dlHpW/1x+xKCZSozAiYQMd5hXN2edGNQHD/xTQ3XwRtBQ27xyv/32uTsEzsjzF9Y5zYRmYwF9WAgGvUdec+a7XxJNEiTA2NlagcYFybU0zPYWegYt1bPv5SeCAwQMWnaj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534678; c=relaxed/simple;
	bh=8WXoHefCCOA8cyPmIt4SvEJFrte10UTxwMpUKQ1O5BM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XLYuJIDx5NUNG0XffwBTbPssWX74YOkAt3Zhu+O3Cs+nGc1xQrpiXCY7PTOx08Z2eqQxA5NQ3mR2ope8h3UgM2Ad7zsoYlFZtmBbCL0unc6tPzFg8fRc8lRRf3yqEKOxgM9PdKghlbB19TxzVIMc3zsU+xNDyfHCBl4Mnm3RNoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEJI7Z3+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEJI7Z3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B4A1F00A3E;
	Fri,  4 Sep 2026 15:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788534676;
	bh=ZTV0LaeA0CYHV/fZB/N3Mj/Fum8NrBkKL1TKPD6RsnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=UEJI7Z3+2SMo48IiUF7yIzKrDpYR4s3HiXCILHwXi4F39Ty4ufGZztKehJGbGGqjK
	 16YIaqFh/mdQ0//uTp35P6naTOJMZ5eTVoBkQnQTU9te2Bun/unFgdfzzARKnHysKL
	 nD+MFFFBkhB74pW9mr7/rAjrnVmnalbqFjaA5f/Xxi8m+I4xdgLDzBeDUsqiJwoEst
	 B1s0jz4LdSvxc/B3BxuZpBu5c2+XmbYSLprBjsuIUIXStHQTpVtDJCAGyxgZB/2ykG
	 Ehqs7W121+hmseSJU0Ma4L4aotxKzQRHXrC6malmGrXXOVRj0NBFzaejGLOu+LPCXB
	 ExotZVHOR54gw==
From: Thomas Gleixner <tglx@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Mayank Rungta <mrungta@google.com>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Radu Rendec
 <radu@rendec.net>, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, "Kirill A.
 Shutemov" <kas@kernel.org>, Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 1/5] genirq: Synchronize in-flight handlers during
 NMI teardown
In-Reply-To: <87wlt13zj1.wl-maz@kernel.org>
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
 <20260902-qcom-wdt-nmi-series-v3-1-f3999362a9ea@google.com>
 <87fqzp8jex.ffs@fw13> <87wlt13zj1.wl-maz@kernel.org>
Date: Fri, 04 Sep 2026 17:11:13 +0200
Message-ID: <87v78l6oha.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 04 2026 at 14:40, Marc Zyngier wrote:
> On Fri, 04 Sep 2026 10:17:42 +0100,
> Thomas Gleixner <tglx@kernel.org> wrote:
>> > +	/*
>> > +	 * Ensure all in-flight NMI handlers on other CPUs complete before
>> > +	 * clearing desc->action or tearing down NMI state.
>> > +	 */
>> > +	__synchronize_hardirq(desc, true);
>> 
>> NMIs are strictly per CPU interrupts. So how is this supposed to work
>> correctly when looking at irqchip_state(ACTIVE) ?
>> 
>> Marc?
>
> I have no idea what this is trying to achieve.
>
> This can only work for a global interrupt, not for a CPU-private
> interrupt, since in general you can't observe the state of the
> interrupt on another CPU.
>
> My guess is that the OP is trying to trigger an NMI using a global
> interrupt, which we never intended to be supported. That's not to say
> that it cannot be supported, but this patch seems to be breaking the
> core use case...

As I suspected.

The driver change is here:

   [1] https://lore.kernel.org/all/20260902-qcom-wdt-nmi-series-v3-5-f3999362a9ea@google.com/

>  @@ -311,10 +321,25 @@ static int qcom_wdt_probe(struct platform_device *pdev)
> 		 if (irq < 0 && irq != -ENXIO)
> 			 return irq;
> 		 if (irq > 0) {
>  -			ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
>  -					       "wdt_bark", &wdt->wdd);
>  -			if (ret)
>  -				return ret;
>  +			wdt->irq = irq;
>  +			irq_flags = IRQF_PERCPU | IRQF_NOBALANCING |
>  +				    IRQF_NO_AUTOEN | IRQF_NO_THREAD;
>  +
>  +			ret = request_nmi(irq, qcom_wdt_isr, irq_flags,
>  +					  "wdt_bark", &wdt->wdd);

Of course this is a regular global interrupt otherwise it couldn't be
requested normally. So this sets IRQF_PERCPU (it has to otherwise
request_nmi() would fail), but that looks like a hack to me.

