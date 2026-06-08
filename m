Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0221384244
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950060; cv=none; b=kvdWKfz9joSF4D3mi8Wl3nTCa0VwSv6rlPTebiDxAdelRvAubX1Ii1kU5SdI4X35GQISDsD8nu1LRzbWgctZzXU3XR19xvX82o4i3drRtmP1ZEMBVDndr7ZTrHDhbUmtjL4LH49vwAnLKRP/mCL1PDwDy6Fp6II3V+pLdPQ1WWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950060; c=relaxed/simple;
	bh=ib/wf9BH+Hatku435cfeMS/lPbWfAuC6/tbdBGb3Hfs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GfdPwHOc49jwo5Ep2/mTJEO5WB3HzCUXwpoSMlXcJ2Muf/zq92W2JyRJ4iukVhk0ybMLYfXaR13mDfN989ylxHd47xzXjwla0o4t0+0t0wX/gsw0qFRikBn8SXnAm+3qhIjgGKfuMPOHiL93TqtcKhJVT9Y9DpCxU4MvNJXXmUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrxWPDs3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrxWPDs3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E651F00893;
	Mon,  8 Jun 2026 20:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780950059;
	bh=i4ilGjkM4T9QlvklH/OhSJr8jlb7wSHqfw3IxxFBA88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LrxWPDs349u46oQ8YI9rYnsy8ixZ126/Uh1galnU9YB4aILTBvJ8ZvNZdGsHBernN
	 jah/C5KJNpqVfEu0ylRB82vrIoCzHxy2FZv/ptndeYKAk2I2FJU4Rln+zVv/nhfWJR
	 kfprltFTRl4479MeCxF00C2eNldiQyvQ/kDbagkRSldQts1VqiCh9ucfVXB21F+uzy
	 dCNrw1ZiRvRhUnh27xAOgFiM2ilcrdkSd38IK2vOmgd0LfkTSlPyA65VN/DBnPgvvO
	 DsGUtw4m0X/GEwS2zUwfHn6FUpRLzPblPUd4WYg1pg2Wbx1UEyBkDDQ+ZHkPYd5saK
	 k6Zyxeo58O5rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 3/3] watchdog: sama5d4: fix NULL deref in irq handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260608200933.18669-4-rosenp@gmail.com>
References: <20260608200933.18669-4-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:20:59 +0000
Message-Id: <20260608202059.B2E651F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The shared interrupt handler `sama5d4_wdt_irq_handler` uncondition=
ally returns `IRQ_HANDLED`, defeating the generic IRQ subsystem's spurious =
interrupt detection and potentially leading to a system lockup.
--

commit b6b6fa431a5a5f7d84f57281a56bc7bf32bb62cb
Author: Rosen Penev <rosenp@gmail.com>

watchdog: sama5d4: fix NULL deref in irq handler

This commit moves platform_set_drvdata() before devm_request_irq() to ensure
the interrupt handler can safely dereference the driver data. This prevents=
 a
possible NULL dereference if an interrupt on the shared System IRQ line fir=
es
early.

> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wd=
t.c
> index 704b786cc2ec6..dcf5b8ac9e0d2 100644
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c
> @@ -268,6 +268,7 @@ static int sama5d4_wdt_probe(struct platform_device *=
pdev)
>  						: AT91_WDT_WDDIS;
> =20
>  	watchdog_set_drvdata(wdd, wdt);
> +	platform_set_drvdata(pdev, wdt);

[Severity: High]
This is a pre-existing issue, but does sama5d4_wdt_irq_handler() defeat the
generic IRQ subsystem's spurious interrupt detection by unconditionally
returning IRQ_HANDLED?

The driver requests a shared interrupt line using the IRQF_SHARED flag. If
the status register check indicates the watchdog did not generate the
interrupt, the handler bypasses the emergency restart logic but still
returns IRQ_HANDLED:

drivers/watchdog/sama5d4_wdt.c:sama5d4_wdt_irq_handler() {
	...
	if (reg) {
		pr_crit("Atmel Watchdog Software Reset\n");
		emergency_restart();
		pr_crit("Reboot didn't succeed\n");
	}

	return IRQ_HANDLED;
}

Should this return IRQ_NONE when it did not service the interrupt to avoid
falsely claiming unhandled interrupts?

> =20
>  	regs =3D devm_platform_ioremap_resource(pdev, 0);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608200933.1866=
9-4-rosenp@gmail.com?part=3D1
