Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731DB1397
	for <linux-watchdog@vger.kernel.org>; Sat, 29 Aug 2026 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787966146; cv=none; b=F/S8TRVAHp+zk5k+imxvXuhfU+QcknnroRm+bfXPX7UgdjKT6+iP3MDUcqbpIsFMHel2+Ubah2/af5qV5MmaTZ3Dv0uracl0I3kcsSWCtjfdjhv7xyaVC6gAviWWk3UBsHa9NAQSZTD+SGcIyoZoeHw/bySl8TsRMp6k+wbBpy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787966146; c=relaxed/simple;
	bh=ooWGfuAXj+snnkbHQI+PL4KuNk/GjckxWnvE9mTyWOk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JqsaMcyJP1A98coFc0r0yl7hevAR01SLJ+2S6zsLu4zNC7jaHMtmk7bVzm/6dC+1ecyEes6xgJ4OFotKs5oi584CFS8DC0HFN7KRO41gXEywr2W/lq8rKiCHYO5oawghlAWEsqKbV38dijy004vYn1EjSJ5aPei17DhmVGpA/HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9KZE1HO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9KZE1HO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3873A1F000E9;
	Sat, 29 Aug 2026 01:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787966145;
	bh=5Xqm6NLqNda+bd5PIziEXBflch65zZ2nq6HPfsP/ukU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W9KZE1HOHqFXsuEczOw0zDpiiZZrjbzB4ITPVK01z4riOPDaYcrSW3qcgH2eEUcb9
	 y/bAMCaN0nA9bLX5YLs150q7Gg/f0T+xYfh+8tunfxOIKjRSLB193frljiqDU+B2Fl
	 bX8dvPPtjP/8gbyJsN/UoBaiBagm0Jucc5XG75kW4WBXtUETBIXUAVkbTYsKckV9YJ
	 mfvEagQ02oJwhiWNtTnQqt8+Z4mnqnwc4DYHawY+ose+SCEQemkV1XENq+zKHRecYG
	 uNFXRve2OFlvl1rQ73eoECKaRepBe1na9kRHDsNbi5zV++3Zo8x2LVeSqn6ZXQT1i0
	 WLnrBMglbmLXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] watchdog: qcom: Register pretimeout interrupt as
 NMI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mayank Rungta" <mrungta@google.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260828-qcom-wdt-nmi-series-v2-5-363979fe6b6b@google.com>
References: <20260828-qcom-wdt-nmi-series-v2-0-363979fe6b6b@google.com>
 <20260828-qcom-wdt-nmi-series-v2-5-363979fe6b6b@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 01:15:44 +0000
Message-Id: <20260829011545.3873A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Calling WDIOC_SETTIMEOUT or WDIOC_SETPRETIMEOUT on an active wat=
chdog triggers an 'Unbalanced enable for IRQ' kernel warning.
- [Medium] Unbinding the driver or encountering a probe failure when the ha=
rdware watchdog is already running from the bootloader triggers a WARN_ON i=
n free_nmi().

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but setting the time=
out or pretimeout on a stopped watchdog unconditionally starts the hardware=
 watchdog without updating the core state, eventually leading to an unexpec=
ted system reboot.
--

commit 90c184f58c3a63ad67e01452209c8185a52db049
Author: Mayank Rungta <mrungta@google.com>

watchdog: qcom: Register pretimeout interrupt as NMI

When a system is completely unresponsive due to an interrupt storm or
deadlocked CPU cores with standard interrupts disabled, a standard
watchdog pretimeout bark interrupt will fail to execute, preventing the
pretimeout governor from capturing CPU backtraces before the hardware
reset bite.

This commit updates the driver to attempt requesting the pretimeout
interrupt as an NMI. It adds cleanup actions and handles enabling and
disabling the NMI during start and stop.

> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index 4eb1bf9790125..82eaf8786426f 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -52,6 +52,8 @@ struct qcom_wdt {
>  	unsigned long		rate;
>  	void __iomem		*base;
>  	const u32		*layout;
> +	int			irq;
> +	bool			is_nmi;
>  };
> =20
>  static void __iomem *wdt_addr(struct qcom_wdt *wdt, enum wdt_reg reg)

[ ... ]

> @@ -74,6 +76,28 @@ static irqreturn_t qcom_wdt_isr(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
> =20
> +static void qcom_wdt_enable_irq(struct qcom_wdt *wdt)
> +{
> +	if (wdt->is_nmi && wdt->irq > 0)
> +		enable_nmi(wdt->irq);
> +}
> +
> +static void qcom_wdt_disable_irq(struct qcom_wdt *wdt)
> +{
> +	if (wdt->is_nmi && wdt->irq > 0)
> +		disable_nmi(wdt->irq);
> +}
> +
> +static void qcom_wdt_free_nmi(void *arg)
> +{
> +	struct qcom_wdt *wdt =3D arg;
> +
> +	if (watchdog_active(&wdt->wdd))
> +		qcom_wdt_disable_irq(wdt);
> +
> +	free_nmi(wdt->irq, &wdt->wdd);
> +}

[Severity: Medium]
Will this fail to disable the NMI if the watchdog was started by the
bootloader?

If the hardware watchdog is already running from the bootloader,
qcom_wdt_probe() calls qcom_wdt_start(), which enables the NMI and sets the
WDOG_HW_RUNNING flag, but the WDOG_ACTIVE flag remains unset:

drivers/watchdog/qcom-wdt.c:qcom_wdt_probe() {
    ...
    if (qcom_wdt_is_running(&wdt->wdd)) {
        qcom_wdt_start(&wdt->wdd);
        set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
    }
    ...
}

If the driver is later unbound or fails probe, qcom_wdt_free_nmi() only
checks watchdog_active(), which evaluates WDOG_ACTIVE.

Because the disable step is skipped, will free_nmi() be called while the NMI
is still enabled, resulting in a WARN_ON stack trace during cleanup?

>  static int qcom_wdt_start(struct watchdog_device *wdd)
>  {
>  	struct qcom_wdt *wdt =3D to_qcom_wdt(wdd);
> @@ -84,6 +108,8 @@ static int qcom_wdt_start(struct watchdog_device *wdd)
>  	writel(bark * wdt->rate, wdt_addr(wdt, WDT_BARK_TIME));
>  	writel(wdd->timeout * wdt->rate, wdt_addr(wdt, WDT_BITE_TIME));
>  	writel(QCOM_WDT_ENABLE, wdt_addr(wdt, WDT_EN));
> +
> +	qcom_wdt_enable_irq(wdt);
>  	return 0;
>  }

[Severity: Medium]
Does this code trigger an unbalanced enable warning when the timeout is cha=
nged?

When a user application changes the timeout via ioctl(WDIOC_SETTIMEOUT), the
core watchdog subsystem invokes qcom_wdt_set_timeout(), which unconditional=
ly
calls qcom_wdt_start():

drivers/watchdog/qcom-wdt.c:qcom_wdt_set_timeout() {
    ...
    wdd->timeout =3D timeout;
    return qcom_wdt_start(wdd);
}

Because qcom_wdt_start() then blindly calls qcom_wdt_enable_irq() without
checking if the NMI is already enabled, will this trigger an 'Unbalanced
enable for IRQ' warning from the core IRQ subsystem?

[Severity: High]
This is a pre-existing issue, but does calling qcom_wdt_start() here
unconditionally start the hardware even if it was stopped by the user?

If a user application stops the watchdog and then sets the timeout,
qcom_wdt_set_timeout() blindly invokes qcom_wdt_start() as shown above.

This physically starts the hardware countdown without updating the core sta=
te.

Because the core state remains disabled, subsequent keepalive pings are
silently ignored by the core. Will this lead to an un-pinged hardware
watchdog that eventually unexpectedly reboots the system?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-qcom-wdt-n=
mi-series-v2-0-363979fe6b6b@google.com?part=3D5
