Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B533AAF66
	for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 21:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447882; cv=none; b=F7kVOQSwBAsgn2iVdgksbX6PVopW4BhhcAJbP2Zp9OPP4NK8kU0VDi6QUSO05Jid46kER82CXp5c2iGLZ/tMO4mCBK2ZUTdo48kcTIRud63ZchA0JWLBevN3F0Z8jCCpBmgou881dGx6hn2Ku40XfjzLkIEWYVAL/LIpIJUXL9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447882; c=relaxed/simple;
	bh=PF73uiWHAoEsnhEhwHptJSTqJdpce7iKYeEL6ZsaoXA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LQpocVfA7CJBAOibZgwMEcuCuWNjPfPiWKIIZzCkdhGGxlRB5EyvCYAHUSUag9GOCwT7+tNyb4FLUDQeLvDhAfwUvPBeeaE/uiLQbuvnHXa1ISKVZ9aZbNtJJXHthEUNLbkAzLiG3S4hWu6XnBXUCxfGRal0GJyVombgfHo7VMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1K+R68v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1K+R68v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7FE1F000E9;
	Thu, 30 Jul 2026 21:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785447881;
	bh=1dkAoK51vOD16HQVNg3soEpbNTnpp4UFgbI5TYrOtws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I1K+R68v38QZ+a0hhGrONDOQsPbNIy1GdRtGSmFSexJX8opE/OcCAxD2R7Z6+0+i/
	 y12Rug15xMpYFXTmzyIGaW1vi2eY04VkDXbldHNpS7J+G7yRJ04SoWA/WZZp8SrNiZ
	 uHHJNOrlMxdAHwwBJRhKKpWMjutiNoX3397rVmnDMLGxW221tiBC3+VVlF9DYxQBDX
	 Jha/8Yi8QT3J3BSUJFNy//l6X1es0ZacZex4QH6h/MZv2eCYS5ZaMMCA7KkN6XaBT9
	 TylLAfEfP/qi7+R79FggIoUk+N74WDrZ/s22uSRmuUUs1LwabpBN7uJ84AEw6kPKmj
	 V+jVv/POhVUfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] watchdog: qcom: Register pretimeout interrupt as
 NMI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mayank Rungta" <mrungta@google.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260730-qcom-wdt-nmi-series-v1-3-3aa86d162914@google.com>
References: <20260730-qcom-wdt-nmi-series-v1-0-3aa86d162914@google.com>
 <20260730-qcom-wdt-nmi-series-v1-3-3aa86d162914@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 21:44:40 +0000
Message-Id: <20260730214441.5B7FE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Potential Use-After-Free and NULL pointer dereference in NMI teard=
own during driver unbind or probe failure.
--

--- Patch [3]: [PATCH 3/3] watchdog: qcom: Register pretimeout interrupt as=
 NMI ---
commit 630edce3072ee30140f775e46b40445975b0d011
Author: Mayank Rungta <mrungta@google.com>

watchdog: qcom: Register pretimeout interrupt as NMI

Attempt to register the pretimeout interrupt as an NMI, falling back to a
standard IRQ if NMI registration fails. Explicitly arm and disarm the NMI
during start and stop operations, and register a devres action to free the
NMI on teardown.

> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index 49bd04841f0c8..19d8e91cff408 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c

[ ... ]

> +static void qcom_wdt_free_nmi(void *arg)
> +{
> +	struct qcom_wdt *wdt =3D arg;
> +
> +	qcom_wdt_disable_irq(wdt);
> +	free_nmi(wdt->irq, &wdt->wdd);

[Severity: High]
Is there a regression here that could cause a use-after-free during driver
unbind or probe failure?

Unlike free_irq(), free_nmi() does not synchronize with in-flight NMI handl=
ers
on other CPUs. It immediately clears desc->action and calls kfree() on the
struct irqaction.

If the pretimeout NMI triggers concurrently just before the interrupt is
masked, could the architecture NMI handler be executing and dereference the
freed irqaction?

kernel/irq/chip.c:handle_fasteoi_nmi() {
    ...
    res =3D action->handler(irq, action->dev_id);
    ...
}

Additionally, since subsequent devres unwinding frees the struct qcom_wdt,
could qcom_wdt_isr() also dereference the freed wdd pointer when calling
watchdog_notify_pretimeout(wdd)?

Could this be triggered by root via sysfs unbind, or naturally during a
hardware-induced pretimeout racing with a module unload, leading to a crash?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-qcom-wdt-n=
mi-series-v1-0-3aa86d162914@google.com?part=3D3
