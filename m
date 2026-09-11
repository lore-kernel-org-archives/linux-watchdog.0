Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF58F2931FB;
	Fri, 11 Sep 2026 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118946; cv=none; b=MfwGpVAhVUaJcRx2l8calZfCTlcr2+HCuncobR5Azrc4ImXnZHPLvMeYFAgYsQZGe1tQQvkb9Wnv5l6fzG3gewmcR4LYD7XUUpm2Y35I40Ou0lkbQseX49fFgfGuAYTHPbfSII7k4atXR7/TELjO6FkMd5lxjkcgjglvRnnPdEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118946; c=relaxed/simple;
	bh=HDnniFNGEBprLrXxolTpXjOqWyvdIv/vZrvMopOmJmM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cEVr4RWfaMMq872efVV8xwmjT0boYfNFD9e+jeqJGcRcg1oAwHFQB1PjhDGxcM9nyhfAPB+sLN5QQGzqgSIgI08dVehSkqZJ7r9gauH2sTyWdrVO2b2pq/c389/+clTI5SbtdOriiIL7YI91lVxrL8HqF4yF5cvKNzeUyZgTHtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Msj8ddst; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Msj8ddst"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BA41F000FF;
	Fri, 11 Sep 2026 09:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789118944;
	bh=GCDZTFy6pHoFnLvAE5Qo6H2F8zOivpHjxp+Yh/ebyk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Msj8ddstPJ3ElY5A4SW0MFyt5M5mrFsd+GcrObiDFpymtqJg5i0cJDx6xzwOLnLBG
	 LUhbGEWjaU94EPr16HXjDaiJBafFvBs6mRqsvuYgta8fKQ8EP292D7lb5uRYxVDyCy
	 s5DNfgTb6ZNvoInjWQ+xEZnH0EvxaeZszGRDkHb4lqfsGgCKDqfU/pBkGNHYWpnmI2
	 4O2DcOmn2RSIcrbvr16h75qiv8Il5cYwf6+mA5fhdXzueDVArtm1db8zltedBGfwUw
	 b4ZGHihsahyLlj/1PMHXygkH4cbIyhnNW6xao7yV6W5islm0JOW8QEFrSSsh7lT8ad
	 wHqety2JI8bnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] watchdog: omap: Remove duplicate start() with
 early_init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Diogo Ivo" <diogo.ivo@bootlin.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260911-omap4-wdt_boot-v1-1-637d778a4a1e@bootlin.com>
References: <20260911-omap4-wdt_boot-v1-0-637d778a4a1e@bootlin.com>
 <20260911-omap4-wdt_boot-v1-1-637d778a4a1e@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:29:03 +0000
Message-Id: <20260911092903.97BA41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Asynchronous pm_runtime_put() is used immediately before pm_runtim=
e_disable() in the probe error path.
- [High] PM runtime usage count and active hardware leaked on watchdog regi=
stration failure.
- [High] Incorrect teardown order in omap_wdt_remove() exposes the device t=
o userspace accesses after runtime PM is disabled.
--

commit 569cfe0fa3feafe4258fc44d697167c767425987
Author: Diogo Ivo <diogo.ivo@bootlin.com>

watchdog: omap: Remove duplicate start() with early_init
   =20
Commit cd004d8299f1 ("watchdog: Fix OMAP watchdog early handling")
reworked the handling of the early_enable parameter and added an
explicit call to omap_wdt_start() in case that parameter is true,
but left the call that was previously there, which became duplicate.
   =20
Fix this by removing the unnecessary duplicate call.

> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index 95c7e44b7baac..f8a76df3c7882 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -285,9 +285,6 @@ static int omap_wdt_probe(struct platform_device *pde=
v)
>  		readl_relaxed(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
>  		wdev->wdog.timeout);
> =20
> -	if (early_enable)
> -		omap_wdt_start(&wdev->wdog);
> -
>  	pm_runtime_put(wdev->dev);
> =20
>  	return 0;

[Severity: High]
This isn't a bug introduced by this patch, but does the error path for
watchdog_register_device() in omap_wdt_probe() initiate an asynchronous PM =
put
just before disabling PM runtime entirely?

drivers/watchdog/omap_wdt.c:omap_wdt_probe() {
	...
	ret =3D watchdog_register_device(&wdev->wdog);
	if (ret) {
		pm_runtime_put(wdev->dev);
		pm_runtime_disable(wdev->dev);
		return ret;
	}
	...
}

The asynchronous idle/suspend work is cancelled by pm_runtime_disable(), wh=
ich
leaves the hardware in an incorrect power state.

Should this use pm_runtime_put_sync() instead to avoid this suspend
cancellation race condition?

[Severity: High]
This is a pre-existing issue, but does this same error path leak a PM runti=
me
usage count and leave active hardware running on watchdog registration fail=
ure?

The probe function starts the watchdog via omap_wdt_start() (which takes a =
PM
reference), but the error path only calls pm_runtime_put() once.

Does this fail to balance the second PM reference and leave the hardware ti=
mer
running without a registered device, which will inevitably lead to a system
reboot?

[Severity: High]
This is also a pre-existing issue, but does the teardown order in
omap_wdt_remove() expose the device to userspace accesses after runtime PM =
is
disabled?

drivers/watchdog/omap_wdt.c:omap_wdt_remove() {
	pm_runtime_disable(wdev->dev);
	watchdog_unregister_device(&wdev->wdog);
}

Concurrently, a userspace process with the watchdog open could trigger
omap_wdt_ping() or omap_wdt_start(). Because runtime PM is disabled,
pm_runtime_get_sync() fails to power on the hardware, but omap_wdt_start()
ignores the failure and proceeds to write to unclocked hardware registers
(OMAP_WATCHDOG_SPR).

Could this cause a kernel panic due to an imprecise external abort or bus f=
ault?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-omap4-wdt_=
boot-v1-0-637d778a4a1e@bootlin.com?part=3D1
