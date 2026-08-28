Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9DD22D4E9
	for <linux-watchdog@vger.kernel.org>; Fri, 28 Aug 2026 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787934344; cv=none; b=BAlqARY4OutZeTwp+HbpOTvOhJBbTOA5AEXUDJp95GCfHiMDGYnt+N4bh7YNDnpnrV+FaNguHOecuUyFOqtf3VrVQpHr5DNtPFMJqr3tAZPMaX88IUp/VYWNwa1o6L8cL23A2nKV7WVHMurP424cSCrMXpTVvv2khNxv36A2KJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787934344; c=relaxed/simple;
	bh=09f/jbaHT65TBWsZIbAVF0zEJyHONzJyAS5D0fyVOP0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rcmYogr7uNkQzZTAVb15GerlRP0ZIXKlDqP/MzlM9X0foS53ZjAnbGtGhIcAqrSrbj+XzsHhuxgjnsvfyNZ/DHy6iINXQlrmh4ZFEheluTzabWTe6xhTrrV/mPC5G4f2LKygvR1+oJXjRd86zNeJ0Mr+aQ7lg8EUf5aifKKHXFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jK8j734d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jK8j734d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE6F1F000E9;
	Fri, 28 Aug 2026 16:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787934342;
	bh=o6yGj4D8XyPNeQU1g/R+hUbshZjRpbNkdKGDnSz/jNc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jK8j734dtckzz/4jkd7Y+T1chcGc0w/JqT4TLheiJro+4VdCV3v39klgSKSXLiyry
	 LtWdg1iGuOolUvIjpFiJvmhB5frWokwdNxgum3f/RYzHODAL+P8TAo5gepg0b8pl5v
	 qkYleRemxbB/ldybBwJp0kUplVRGpLVuAKMaxzh1u1Z+z95Y7YWDNz1fLcz80Z5j8d
	 GMno+31r4KOjdPcvl1ruPREwu2a1z0Gh6MKFJLU7iRGAP7H+LL0zy9YcQgx9wJbKkc
	 bmH3bVKUcU654b+ae39lKxGtUJKt5rMH0oM1Csubc7/KN5Ahr4CRtjKBkgpUfX2sxu
	 b06knBkBW78Zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/9] watchdog: msc313e: Fix spurious reset on suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tzung-Bi Shih" <tzungbi@kernel.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260828161348.13212-6-tzungbi@kernel.org>
References: <20260828161348.13212-1-tzungbi@kernel.org>
 <20260828161348.13212-6-tzungbi@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 16:25:41 +0000
Message-Id: <20260828162542.4BE6F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling `watchdog_stop_ping_on_suspend()` opts the driver into a b=
uggy watchdog core feature that leaks the PM notifier, causing a Use-After-=
Free upon device unbind or module unload.
--

commit f0550ce9d86164c3e7cb8c64fecb979c9936c149
Author: Tzung-Bi Shih <tzungbi@kernel.org>

watchdog: msc313e: Fix spurious reset on suspend
   =20
This commit addresses a spurious system reset on suspend when the watchdog
is started by the bootloader but not yet opened by userspace. It checks
both active and hardware running states, and stops the ping worker during
suspend.

> diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wd=
t.c
> index 86e72aea96855..9cfe059fd31a7 100644
> --- a/drivers/watchdog/msc313e_wdt.c
> +++ b/drivers/watchdog/msc313e_wdt.c
> @@ -157,6 +157,7 @@ static int msc313e_wdt_probe(struct platform_device *=
pdev)
>  	watchdog_init_timeout(&priv->wdev, timeout, dev);
>  	watchdog_stop_on_reboot(&priv->wdev);
>  	watchdog_stop_on_unregister(&priv->wdev);
> +	watchdog_stop_ping_on_suspend(&priv->wdev);

[Severity: High]
Does adding this call expose the driver to a use-after-free regression
during device unbind or module unload?

Calling watchdog_stop_ping_on_suspend() sets the WDOG_NO_PING_ON_SUSPEND
flag. The watchdog core sees this flag and registers wdd->pm_nb to the
global PM notifier chain.

However, the core unregistration path in __watchdog_unregister_device()
fails to detach the PM notifier:

drivers/watchdog/watchdog_core.c:__watchdog_unregister_device() {
    ...
    if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status))
        unregister_reboot_notifier(&wdd->reboot_nb);

    watchdog_dev_unregister(wdd);
    ida_free(&watchdog_ida, wdd->id);
    ...
}

When the driver is unbound (e.g. via sysfs) or the module is unloaded, the
driver's memory containing pm_nb is freed, leaving a dangling pointer in the
global PM notifier list. The next system suspend could then trigger a panic.

While the missing unregister logic is a pre-existing flaw in the watchdog
core, this patch newly exposes the msc313e_wdt driver to this issue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828161348.1321=
2-1-tzungbi@kernel.org?part=3D5
