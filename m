Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48952390223;
	Fri,  4 Sep 2026 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513467; cv=none; b=sCi+5jmiSXTBl7GOVfsiQd303Q/QVz9rz4xHuMTPbiXHbHWpNY4XaiM/cne+ahDClephJJdv4QC8lV6/7ToDIfsIcZq7XZfjqdOK8nl9xGXxvGD8sK5lf5XUHryBSUD0f9xem+HZyjZZqXwoZPYnYXtBFDK1Ac5Srlu0X/oqeEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513467; c=relaxed/simple;
	bh=vt6GmcCkfdHgkjJpi8vIYxhDUUCANUT1Ynpjh9sxv08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AocgH8c55y+we4G8+xZQoY+BwdAiapA7VAUKTWUHQd8V64I9RnNTKG5HK/RTwWdG3g8uPlUvTBTGQTG5jrWuEeSGF99TIpmBcgeD36QZNi28b+vOHRIvaQXtq2qFGuEButLM06N4BB9Ydx+nc5Pf2H4O6vLMGqzqIOE/7HuCXNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHxa0a8N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHxa0a8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7651F00A3D;
	Fri,  4 Sep 2026 09:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788513465;
	bh=5NnaIkZGWx6olJH36PRFVeoGws+ir3WaJfSx4YOTod4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=RHxa0a8NlcGY2zEHcSKgx36Qnwk/8lY2eTzii6Lq3H0YjuMJRjONDJQLxmwcp6n8d
	 uPR0+go6SaW46R0xgl2IKT0nrfejNAdxAfk5Uh4WEDz5L0V1l8BAve5zMa5wlZ68ps
	 t4D9F/js5cz6xxkuG0fP/7UdWAsHHAOfsLDmpg6cz/ddXK9e5JMIv73vj3mkWETRQD
	 W8tCk9YM9v7Aom/fv54zjLvOWZ1aZV1NaVSPdK19sPCF03OTuzFqPBmPzaNG9EZ4qB
	 zB9a0ubkJfOxzoOk+3LqgmxPwX3zk1qOr16yzMZCBmdRkjoxaUQgKLqP7DH9ilUhzt
	 gpQoDqw4qx1hQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Mayank Rungta <mrungta@google.com>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Radu Rendec
 <radu@rendec.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, "Kirill A. Shutemov" <kas@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, Mayank Rungta
 <mrungta@google.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3 1/5] genirq: Synchronize in-flight handlers during
 NMI teardown
In-Reply-To: <20260902-qcom-wdt-nmi-series-v3-1-f3999362a9ea@google.com>
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
 <20260902-qcom-wdt-nmi-series-v3-1-f3999362a9ea@google.com>
Date: Fri, 04 Sep 2026 11:17:42 +0200
Message-ID: <87fqzp8jex.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 02 2026 at 18:54, Mayank Rungta wrote:
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 2fbff2618a1e..a9973b61163a 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1379,6 +1379,14 @@ static bool irq_supports_nmi(struct irq_desc *desc)
>  	if (d->chip->irq_bus_lock || d->chip->irq_bus_sync_unlock)
>  		return false;
>  
> +	/*
> +	 * NMIs cannot set IRQD_IRQ_INPROGRESS because they cannot acquire
> +	 * spinlocks. Synchronous disable and teardown require querying the
> +	 * hardware state via ->irq_get_irqchip_state().
> +	 */
> +	if (!d->chip->irq_get_irqchip_state)
> +		return false;
> +
>  	return d->chip->flags & IRQCHIP_SUPPORTS_NMI;
>  }
>  
> @@ -2034,11 +2042,20 @@ static const void *__cleanup_nmi(unsigned int irq, struct irq_desc *desc)
>  	struct irqaction *action = NULL;
>  	const char *devname = NULL;
>  
> +	guard(mutex)(&desc->request_mutex);
> +
>  	scoped_guard(raw_spinlock_irqsave, &desc->lock) {
> -		irq_nmi_teardown(desc);
> +		irq_settings_clr_disable_unlazy(desc);
> +		irq_shutdown(desc);
> +	}
>  
> -		desc->istate &= ~IRQS_NMI;
> +	/*
> +	 * Ensure all in-flight NMI handlers on other CPUs complete before
> +	 * clearing desc->action or tearing down NMI state.
> +	 */
> +	__synchronize_hardirq(desc, true);

NMIs are strictly per CPU interrupts. So how is this supposed to work
correctly when looking at irqchip_state(ACTIVE) ?

Marc?

