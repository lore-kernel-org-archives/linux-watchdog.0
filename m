Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7245D1397
	for <linux-watchdog@vger.kernel.org>; Sat, 29 Aug 2026 01:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787966152; cv=none; b=METoe65rSVCMHnH4RLbAOHApSM+cvfZvBO1QsgTAacXDTJYm2mv9cearX70f5xK+xQqxdNLWpCObaWdZ4UkmdsslL9p+ZZ6nJEqr6PsB/vJMI+T9UaddWiE9a+5ox+o1W9x7EhqMcoE2Xcb4ak8PQI5MPXZdvjvrdX3YQN0+fOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787966152; c=relaxed/simple;
	bh=f8f861kAuTKOpMCV5/cCc5FwWeZyfuVzYEaRMQjmDyA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f65BMrMMsZRwYX/EetCq7DZZimUSlRwXS0yJfY8mZe/x6/cj+T6JDB4g2tAzJv+VZTLzdK1E9PA1yRoSe/05o3g2bnffVvMeqgPR2STztGJwNRHg4iEHMj4AaoOlt/rjEdFR2M2X/pSYkJ2MWpQVtOsG5O/swaO9/3U4GWq91H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRJEI5np; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRJEI5np"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF091F000E9;
	Sat, 29 Aug 2026 01:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787966151;
	bh=BECNq0LbphHpyUZ21RGi+bWZ0/23cGX+UySZjxdGPiI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cRJEI5npbbLD7svgv8f5RFMgNHCltQW784Ttk8i3UURXXXujCPJdCWdoBxdnMMPhR
	 enTmTRWKjG8O+JqyuDNQF92Y/zq4bYdBD0WAz/ss6sMugdFMTts4uXSYM3GkrnKShX
	 6A4t7fh78QTDAjc82WDAhvE5qZE6hgDyutp8JgmWtAX94biB3jd3zrzJpLZzZ2bGdK
	 mNFDPdHEeJR1czwb6Fc45PQdQd3kxUjX2Um45FvVCoKAq+AOKDYyTrWiFyRQLDRWuz
	 DNDUdsYKyqO/Gl/xBFJiyyO9ahZ9J9HZM8JX1fQ+5+7BcuTNr3gEycMFMz9CSRakm7
	 isHtOYvbJpKgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] genirq: Export NMI APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mayank Rungta" <mrungta@google.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260828-qcom-wdt-nmi-series-v2-3-363979fe6b6b@google.com>
References: <20260828-qcom-wdt-nmi-series-v2-0-363979fe6b6b@google.com>
 <20260828-qcom-wdt-nmi-series-v2-3-363979fe6b6b@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 01:15:50 +0000
Message-Id: <20260829011550.ECF091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Exporting `free_nmi()` and `disable_nmi()` allows loadable modules=
 to manage NMIs, but these APIs fundamentally fail to synchronize with in-f=
light NMI handlers, introducing a race condition that leads to kernel panic=
s on module unload.

Pre-existing issues:
- [High] `__cleanup_nmi()` fails to acquire `desc->request_mutex` when tear=
ing down an NMI. This allows concurrent IRQ request/free operations to race=
, corrupting IRQ resource state and bypassing hardware resource allocation.
- [High] Concurrent NMI delivery during `free_nmi()` teardown leads to a NU=
LL pointer dereference in `handle_fasteoi_nmi()` because `desc->action` is =
cleared before `__synchronize_hardirq()` waits for in-flight NMIs.
- [Medium] `free_nmi()` ignores the provided `dev_id` parameter, bypassing =
ownership validation and allowing any module to inadvertently or maliciousl=
y unregister an NMI owned by another subsystem.
--

commit cf44d4cc82f985321cdf77cbbbd3469b85de0426
Author: Mayank Rungta <mrungta@google.com>

genirq: Export NMI APIs

This commit exports request_nmi(), free_nmi(), enable_nmi(),
disable_nmi_nosync(), and disable_nmi() with EXPORT_SYMBOL_GPL to allow
loadable kernel modules to register and manage NMIs.

> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 40013aa94481e..ded8cc33381cc 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c

[ ... ]

> @@ -2110,6 +2113,7 @@ const void *free_nmi(unsigned int irq, void *dev_id)
> =20
>  	return __cleanup_nmi(irq, desc);
>  }
> +EXPORT_SYMBOL_GPL(free_nmi);

[Severity: High]
Is it safe to export free_nmi() and disable_nmi() given they can introduce
a race condition that leads to kernel panics on module unload?

When a module unloads, free_nmi() calls __cleanup_nmi(), which uses
__synchronize_hardirq() to wait for handlers on other CPUs to finish.
__synchronize_hardirq() checks the IRQD_IRQ_INPROGRESS flag:

kernel/irq/manage.c:__synchronize_hardirq() {
    ...
		while (irqd_irq_inprogress(&desc->irq_data))
			cpu_relax();
    ...
}

However, NMI handlers like handle_fasteoi_nmi() bypass standard IRQ locking
and never set IRQD_IRQ_INPROGRESS:

kernel/irq/chip.c:handle_fasteoi_nmi() {
    ...
	res =3D action->handler(irq, action->dev_id);
    ...
}

Consequently, __synchronize_hardirq() returns immediately. The module's text
segment could then be unmapped while the NMI handler is still executing,
leading to a page fault.

[Severity: High]
This is a pre-existing issue, but can concurrent NMI delivery during
free_nmi() teardown lead to a NULL pointer dereference in
handle_fasteoi_nmi()?

During free_nmi(), __cleanup_nmi() sets desc->action =3D NULL and drops
desc->lock before calling __synchronize_hardirq():

kernel/irq/manage.c:__cleanup_nmi() {
    ...
	desc->action =3D NULL;

	irq_settings_clr_disable_unlazy(desc);
	irq_shutdown(desc);
    ...
	/* Ensure all in-flight NMI handlers on other CPUs complete before freeing=
 action */
	__synchronize_hardirq(desc, true);
    ...
}

If an NMI fires concurrently, the dispatcher handle_fasteoi_nmi() executes
on another CPU without taking desc->lock. It reads desc->action and
unconditionally dereferences it without checking for NULL:

kernel/irq/chip.c:handle_fasteoi_nmi() {
    ...
	struct irqaction *action =3D desc->action;
    ...
	res =3D action->handler(irq, action->dev_id);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but it appears __cleanup_nmi()
fails to acquire desc->request_mutex when tearing down an NMI.=20

__cleanup_nmi() drops desc->lock and performs teardown (including
irq_release_resources()) without holding desc->request_mutex:

kernel/irq/manage.c:__cleanup_nmi() {
    ...
	irq_release_resources(desc);
    ...
}

Conversely, __setup_irq() relies exclusively on desc->request_mutex for
serialization. If __cleanup_nmi() runs concurrently with __setup_irq() (e.g.
during a rapid module reload or concurrent requests), they can race.
__setup_irq() may read a non-NULL desc->action and skip resource allocation:

kernel/irq/manage.c:__setup_irq() {
    ...
	if (!desc->action) {
		ret =3D irq_request_resources(desc);
    ...
}

Could this lead to bypassed hardware resource allocation or corrupted hardw=
are
state for IRQ resources?

[Severity: Medium]
This is a pre-existing issue, but I noticed free_nmi() ignores the provided
dev_id parameter.

The free_nmi() API accepts a dev_id parameter, but delegates to
__cleanup_nmi() which drops the token entirely:

kernel/irq/manage.c:free_nmi() {
    ...
	return __cleanup_nmi(irq, desc);
}

Inside __cleanup_nmi(), the action is unconditionally unlinked and torn
down without checking if its dev_id matches the caller's cookie:

kernel/irq/manage.c:__cleanup_nmi() {
    ...
	if (!WARN_ON(desc->action =3D=3D NULL)) {
		action =3D desc->action;
		irq_pm_remove_action(desc, action);
    ...
}

Unlike free_irq(), which verifies action->dev_id =3D=3D dev_id, this lacks
ownership validation. Could a buggy loadable module unilaterally destroy
another component's NMI by passing an incorrect IRQ number or a
NULL cookie to free_nmi()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-qcom-wdt-n=
mi-series-v2-0-363979fe6b6b@google.com?part=3D3
