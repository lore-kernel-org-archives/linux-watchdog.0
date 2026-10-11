Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743A71FC110
	for <linux-watchdog@vger.kernel.org>; Sun, 11 Oct 2026 01:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791682168; cv=none; b=APXd+ZI0E9GsDp0bjj3sULOA4Dgkoaf0ez+OvZCTUl3yQ+20mZsjNxJHXw3D45/JHisvymfny/W3ERoTjJd405F+YC3WwpYHpnNCBdgkh5dE2yW4Gl5MYW4WC+9mcLmM+kmVeH6Ui3+iTVd/S+eQ7/Lxry3ajEXqjgC5ID0TT3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791682168; c=relaxed/simple;
	bh=M3kkbY8bM8r0SFq/7SIHcUOnrYRHke0O7CRJZdwcGiM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Wx9iVrE9/3dB+xMLKpaH9HJ5Tw/+xGsvPIEPDqmhG0ezKf+lynuPwaM89p8GBcEduzW9cOMjOhA3aRy5+SQQiDz3+8hy1MEEra5AJiN+2ZkHFpT8aNLNjzYLHtaPDaczLs3U1bYypytW6CwLb72t6PCFKT5jL0qA1psMJM85zaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8yDj1Uv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8yDj1Uv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE221F000FF;
	Sun, 11 Oct 2026 01:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791682167;
	bh=MqVDWILyGpDbNa23Q7NdG41NZfr8ZL5Bjxzhe68B8wI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A8yDj1Uvn+ojfaK7Uj2uccfILYp/9us5rxk3jO0VyjFyKe4c5Pxl5mGeUkLRRLeSN
	 LYcLIfa4yvEW6w6Hh9ca+4diU3TwJvd4HnbWPgIUFOk3rOZLUPKpAHn2SbX9ffpjLf
	 YkrTDRlcM2zwi3BPmRAnHBTpWHZt+eRZ31WGQdFCwyKkruyhmt1bny8HqqL8SH5I3P
	 K+oz4UyBW+COc+alAQYO6Nw1lh7Wv5TFLrAIgNbUOLVqNGy4wlnNdWRgSvC4aPmh1w
	 P/047ATfSJe99ieC+AKqRJv+kaeLSPcAhG3PX30N+qyHiilI6ivzoMcDkUeO5K8c0G
	 ShySqPIRpc3vQ==
Message-ID: <sashiko-outbox-166960@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] watchdog: mtk_wdt: Stop a running watchdog over
 system sleep even if not opened
Reply-To: sashiko-reviews@lists.linux.dev
To: zoan37 <agentzoan@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261011011536.1139162-1-agentzoan@gmail.com>
References: <20261011011536.1139162-1-agentzoan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 01:29:26 +0000
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] watchdog: system reset during suspend_freeze_processes() due to pr=
ematurely stopped ping worker
--

commit 49206fab5f9c9b345c52cba7a65df971c5a0d992
Author: zoan37 <agentzoan@gmail.com>
Subject: watchdog: mtk_wdt: Stop a running watchdog over system sleep even =
if not opened

This patch modifies the MTK watchdog driver to stop and restart a watchdog
that was left running by the bootloader across system sleep. It also uses
watchdog_stop_ping_on_suspend() to prevent the core's ping worker from
feeding the watchdog during suspend.

Link: https://lore.kernel.org/all/20261011004322.1118027-1-agentzoan@gmail.=
com/

> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 1630ab65d5932..3c493a470b37a 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -543,6 +543,7 @@ static int mtk_wdt_probe(struct platform_device *pdev)
>  	mtk_wdt_init(&mtk_wdt->wdt_dev);
> =20
>  	watchdog_stop_on_reboot(&mtk_wdt->wdt_dev);
> +	watchdog_stop_ping_on_suspend(&mtk_wdt->wdt_dev);

[Severity: High]
Could stopping the ping worker at PM_SUSPEND_PREPARE cause a premature
system reset during process freezing?

By opting in with watchdog_stop_ping_on_suspend(), the core's PM notifier
handles PM_SUSPEND_PREPARE by completely canceling the background ping work=
er:

drivers/watchdog/watchdog_dev.c:watchdog_dev_suspend() {
    ...
    if (test_bit(WDOG_NO_PING_ON_SUSPEND, &wdd->status)) {
        ...
        kthread_cancel_work_sync(&wd_data->work);
    }
}

Immediately following the PM_SUSPEND_PREPARE notifiers, the suspend core
freezes user-space processes:

kernel/power/suspend.c:suspend_prepare() {
    ...
    error =3D suspend_freeze_processes();
}

Because freezing tasks and syncing filesystems can routinely block for
several seconds, if the hardware watchdog is initialized with a short
timeout (e.g., 2 seconds via a module parameter), could the hardware
timer expire and hard-reset the board before the device's actual suspend
callback (mtk_wdt_suspend) is ever reached?

Prior to this patch, the unfreezable watchdog_kworker would continue to
feed the hardware during this variable freezing delay.

>  	err =3D devm_watchdog_register_device(dev, &mtk_wdt->wdt_dev);
>  	if (unlikely(err))
>  		return err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011011536.1139=
162-1-agentzoan@gmail.com?part=3D1
