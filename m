Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEDF211466
	for <linux-watchdog@vger.kernel.org>; Sun, 11 Oct 2026 00:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791680302; cv=none; b=utG4lfoa2aqqi8ThybmISOV8jnH7U6DihWDhBPeIT3tYTM16Kxug/uOmQ3y88zvMrTrT04v89Fzp9+Cf2LZV3JubVoxkC7DwKYLVyESYhJyd9vZFKGTcBWofH5zw2KtsrzxwLDmcQ0+zK5C29BVR+ET0qblDg95FUFpUyMAJk+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791680302; c=relaxed/simple;
	bh=sGXV0xu6EotK+3rt33DjuYlVEHeaQ5bWJ6sLAZuDTOI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OAYuZlhvQm7OtKE+rf67XaX9nFgstzAfVL1EdzN2huNlPDggZcdcwxUYma/rlxcExHsYcyW0rIx3GCBHXbaErke0O2FlQ1aCn1MdltXKydudZPEaUfrGL1EdCiHuoG402h2uh4shp8Udc8bWIc4nbPNwdZnLW+ukuHYTV3GrOXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwDRJtO6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwDRJtO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6D91F000FF;
	Sun, 11 Oct 2026 00:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791680300;
	bh=yE+bXEqeqTCwSYEYsB7lAJLV49JB/hZyBuW4eizCv98=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kwDRJtO6L5YkAgpWAxRrJL0DAg+Km1vMr1wCGtFWWnQI5LMdU+hm4qUTASQMn4knH
	 81cuqOUFZftFkpPtg6J8kys5SRrAbweuo3UdhjoQP5LSu3zDyLf7gwOxofbpLCoDMz
	 8jkRADyR7LhqeuDgt6NVOs3eWQ1H79Ga7gxSIQny1241CD1uAc0RCGyf1IODGcd4S7
	 ip0MPCZDm3MMsMy757gsFDND+MMQsQ+TDRJM1gIKM9A9VsvniCsTK6ul7WWQhdNy7N
	 wZZcKPKYNIkTW0PNroh/ak1mw9LCB/tza/UslzGOA03eQP9Mr0WZ6cDXGmmV4rV/7B
	 ofA0sNxO93NWw==
Message-ID: <sashiko-outbox-166954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: mtk_wdt: Stop a running watchdog over system
 sleep even if not opened
Reply-To: sashiko-reviews@lists.linux.dev
To: zoan37 <agentzoan@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261011004322.1118027-1-agentzoan@gmail.com>
References: <20261011004322.1118027-1-agentzoan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 00:58:20 +0000
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] watchdog: mtk_wdt: background ping worker accesses suspended device
--

commit 86c1d5dc273343e1ae7c163f9a06c48451758c35
Author: zoan37 <agentzoan@gmail.com>

watchdog: mtk_wdt: Stop a running watchdog over system sleep even if not op=
ened

This commit updates mtk_wdt_suspend() and mtk_wdt_resume() to also stop and
restart the watchdog when it is running in hardware but hasn't been opened
by userspace yet.

> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 1630ab65d5932..ff72e0fb11541 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -572,7 +572,8 @@ static int mtk_wdt_suspend(struct device *dev)
>  {
>  	struct mtk_wdt_dev *mtk_wdt =3D dev_get_drvdata(dev);
> =20
> -	if (watchdog_active(&mtk_wdt->wdt_dev))
> +	if (watchdog_active(&mtk_wdt->wdt_dev) ||
> +	    watchdog_hw_running(&mtk_wdt->wdt_dev))
>  		mtk_wdt_stop(&mtk_wdt->wdt_dev);

[Severity: High]
Does stopping the hardware here leave the software ping worker in an
inconsistent state?

The watchdog core's PM notifier is only registered if the driver explicitly
opts-in by setting the WDOG_NO_PING_ON_SUSPEND flag:

drivers/watchdog/watchdog_core.c:___watchdog_register_device() {
...
	if (test_bit(WDOG_NO_PING_ON_SUSPEND, &wdd->status)) {
		wdd->pm_nb.notifier_call =3D watchdog_pm_notifier;
...
}

Because mtk_wdt doesn't set this flag, watchdog_dev_suspend() is never call=
ed
to cancel the hrtimer and kthread_work for the background ping worker:

drivers/watchdog/watchdog_dev.c:watchdog_dev_suspend() {
...
	hrtimer_cancel(&wd_data->timer);
	kthread_cancel_work_sync(&wd_data->work);
...
}

During sleep, the hrtimer can expire and be deferred. Upon wake-up, timekee=
ping
resumes in syscore_resume and the overdue hrtimer fires in hardirq context,
waking the watchdogd thread.

If watchdogd preempts the suspend thread and executes mtk_wdt_ping() before
mtk_wdt_resume() runs, it will attempt to access device registers:

drivers/watchdog/mtk_wdt.c:mtk_wdt_ping() {
...
	iowrite32(WDT_RST_RELOAD, wdt_base + WDT_RST);
...
}

If the device's bus clocks or power domains are gated during suspend, this
early MMIO access can trigger a fatal bus fault. Even if clocks are always-=
on,
this causes the worker to ping a watchdog that the driver explicitly stoppe=
d.

Should WDOG_NO_PING_ON_SUSPEND be set in the driver to ensure the watchdog =
core
cancels the ping worker during suspend?

> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011004322.1118=
027-1-agentzoan@gmail.com?part=3D1
