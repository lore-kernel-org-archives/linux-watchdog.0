Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315401;
	b=NDsA1AiBh6w5uak29fGkfBFmeMpuyUOLrRFyTLvfYIKDcsTEIFNcsJCO2wV7GPkUifEy
	 QVMV4ftUS9sluYPtRMJ4uwHjkc+RCAW22HGONO1ZNmQ4ZY3HvA2neoACSsmkPuUq3I2cY
	 26RJhVkzDg+zqrdX7P0kt1gVtHCEFbHingonK4D4dEHJIQRr8FZlnPgfxSoAuFlMlOw3S
	 y1HP2OycXFMZtune/kQeSCh9/REFT8c3rBIe8ho0NRw+8OflINZAuMNZMiW2kEcGXYgDW
	 Cr4H0fj/4oZFs0LBNOccHTI3p7k+zrSffnnL/N1JbKJ6ycYilgxAP8/xuRPxBwfFf7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315401;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ncfDoIVLLF61PWsinjKGToOI+t5GyuriAvjcV92jIIU=;
	b=sAYTCKiDbSrCEZsakfK+czBZGSxhI+CYYc4NpFiK+dBpb32qXoi7/D7SQIqLWiNM1aXL
	 YsjWKWmJkQN6UB8qwqkcqwMFZk0MtO2duNHPNd2NdbTYcl8Pz7fX6zZu2UPks6jTkw/NP
	 blj4GvApi3bAAj0Lk7d24I9dm4IrMUHlCPmThEARyT5CPokNZOA/z/DiAt2s99C+KBb5z
	 CsJgXyL/zvgKXQSS7Z/2bh0Y8hqpshsSgcAtEfJ4Efv3Jitk48XWOse6/nsv4KA3Le5aK
	 I6NslVEP3EYkwGypl6NwV84i+Bez14db6baHtDJ7D+OHUqv2t5HP05l83KSs9fQc5Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S35dF7EJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A81D60A5BCA
	for <linux-watchdog@vger.kernel.org>; Tue, 10 Nov 2026 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S35dF7EJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA21D1F008A2;
	Tue, 10 Nov 2026 12:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315400;
	bh=ncfDoIVLLF61PWsinjKGToOI+t5GyuriAvjcV92jIIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S35dF7EJxQch0EiavaFw2k5lHzwKTPOWrZnX/USx0yWNj9L1VrZhwPSmEA4uD8MIg
	 VKfHErGtq0kBgLTPtZSpi8t6SDDQyG84H25faZB/gGSg/nfc0d9jKDdgSm0qreizSD
	 fqMca5dfP5i8CMwBeNQNlNX1vOullbxtIjkhLD9Lyw4uTHm7CyXfzHKPNb4eXhaoIe
	 FYyU53zbqKoAe+wMsW5PRNNf8NWcslNzxErBYOrkEQU+dw4UfNyTwKpCQyQymjPEdc
	 t3iPXFwdfOygluJffzwawEfjaP1sTnJ4Xx1ZglAQ7zXp6vinOOQUsM3Sm2eOzYAzlT
	 RD/6LI27FQDog==
Message-ID: <sashiko-outbox-207056@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] watchdog: tegra_wdt: Stop on Tegra20 VDE power off
Reply-To: sashiko-reviews@lists.linux.dev
To: "Artur Kowalski" <arturkow2000@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261110-t20-for-upstream-v1-6-5923449951fe@gmail.com>
References: <20261110-t20-for-upstream-v1-0-5923449951fe@gmail.com>
 <20261110-t20-for-upstream-v1-6-5923449951fe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 12:56:40 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] watchdog: tegra_wdt: refcount leak in
  tegra20_wdt_powergate_notify()
- [Medium] watchdog: tegra_wdt: stale WDOG_ACTIVE after
  tegra20_wdt_powergate_notify()
- [Medium] watchdog: tegra_wdt: race on WDOG_HW_RUNNING in
  tegra20_wdt_powergate_notify()
--

commit 7bc831b226455fa0dc8d2f0743ce747806275870
Author: Artur Kowalski <arturkow2000@gmail.com>

watchdog: tegra_wdt: Stop on Tegra20 VDE power off

This commit registers a Tegra PMC powergate notifier on Tegra20 to stop the
watchdog before the VDE partition is powered off and prevent it from being
started afterwards.

> diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
> index 7c2c21f90de52..d36310c50f782 100644
> --- a/drivers/watchdog/tegra_wdt.c
> +++ b/drivers/watchdog/tegra_wdt.c

[ ... ]

> @@ -256,6 +276,35 @@ static int tegra20_wdt_stop(struct watchdog_device *=
wdd)
>  	writel(0, wdt->tmr_regs + TIMER_PTV);
>  	writel(TIMER_PCR_INTR_CLR, wdt->tmr_regs + TIMER_PCR);
> +}
> +
> +static int tegra20_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct tegra_wdt *wdt =3D watchdog_get_drvdata(wdd);
> +	int ret =3D 0;
> +
> +	mutex_lock(&wdt->lock);
> +
> +	if (wdt->vde_off) {
> +		dev_warn(wdd->parent,
> +			 "not starting, a reset would hang with VDE powered off\n");
> +		ret =3D -EBUSY;
> +	} else {
> +		__tegra20_wdt_start(wdt);
> +	}
> +
> +	mutex_unlock(&wdt->lock);
> +
> +	return ret;
> +}

[Severity: Medium]
Can tegra20_wdt_powergate_notify() race with watchdog_open() ->
watchdog_start() on WDOG_HW_RUNNING and WDOG_ACTIVE?

tegra20_wdt_powergate_notify() serializes on wdt->lock, whereas
watchdog_open() and watchdog_start() inspect and update wdd->status under
wd_data->lock:

CPU0                                  CPU1
watchdog_open()
  watchdog_start()
    tegra20_wdt_start()
      mutex_lock(&wdt->lock)
      __tegra20_wdt_start(wdt)
      mutex_unlock(&wdt->lock)
                                      tegra20_wdt_powergate_notify()
                                        mutex_lock(&wdt->lock)
                                        wdt->vde_off =3D true
                                        __tegra20_wdt_stop(wdt)
                                        clear_bit(WDOG_HW_RUNNING, ...)
                                        mutex_unlock(&wdt->lock)
    set_bit(WDOG_ACTIVE, ...)
    set_bit(WDOG_HW_RUNNING, ...)  <-- set after watchdog was stopped

This leaves WDOG_ACTIVE and WDOG_HW_RUNNING set and allows open() to
succeed after the VDE partition was powered off and the hardware timer was
stopped.

If WDOG_HW_RUNNING was already set at boot, a similar race in
watchdog_open() either calls __watchdog_ping() -> tegra20_wdt_ping() (which
does not check wdt->vde_off and returns 0) or sees WDOG_HW_RUNNING cleared
before watchdog_start() and calls module_put() at out_mod without a
matching try_module_get() in watchdog_open().

> @@ -296,6 +350,45 @@ static const struct watchdog_ops tegra20_wdt_ops =3D=
 {
>  	.set_timeout =3D tegra20_wdt_set_timeout,
>  };
> =20
> +static int tegra20_wdt_powergate_notify(struct notifier_block *nb,
> +					unsigned long event, void *data)
> +{
> +	struct tegra_wdt *wdt =3D container_of(nb, struct tegra_wdt,
> +					     powergate_nb);
> +	unsigned int id =3D *(unsigned int *)data;
> +
> +	if (event !=3D TEGRA_PMC_POWERGATE_POWER_OFF ||
> +	    id !=3D TEGRA_POWERGATE_VDEC)
> +		return NOTIFY_DONE;
> +
> +	mutex_lock(&wdt->lock);
> +
> +	if (!wdt->vde_off) {
> +		wdt->vde_off =3D true;
> +		__tegra20_wdt_stop(wdt);
> +
> +		/*
> +		 * Stop the core's pings. If user space has the device open,
> +		 * its pings don't restart the watchdog either.
> +		 */
> +		clear_bit(WDOG_HW_RUNNING, &wdt->wdd.status);

[Severity: Medium]
Does clearing only WDOG_HW_RUNNING here leave WDOG_ACTIVE set when
/dev/watchdog is already open?

If user space later closes /dev/watchdog without the magic close character
(or with nowayout enabled), watchdog_release() leaves WDOG_ACTIVE set while
dropping the module and device references because WDOG_HW_RUNNING is false:

drivers/watchdog/watchdog_dev.c:watchdog_release() {
    ...
done:
	running =3D wdd && watchdog_hw_running(wdd);
	mutex_unlock(&wd_data->lock);
	if (!running) {
		module_put(wd_data->cdev.owner);
		put_device(&wd_data->dev);
	}
	return 0;
}

On a subsequent open(/dev/watchdog), watchdog_start() sees
watchdog_active(wdd) =3D=3D true and returns 0 immediately without calling
tegra20_wdt_start(), so opening the stopped watchdog succeeds instead of
failing with -EBUSY.  While the file remains open, WDIOC_SETTIMEOUT also
sees watchdog_active(wdd) in tegra20_wdt_set_timeout(), updates
wdd->timeout, and then fails with -EBUSY in tegra20_wdt_start().

> +
> +		dev_info(wdt->wdd.parent,
> +			 "VDE powered off, watchdog stopped\n");
> +	}
> +
> +	mutex_unlock(&wdt->lock);
> +
> +	return NOTIFY_OK;
> +}

[ ... ]

> @@ -326,18 +419,46 @@ static int tegra20_wdt_init(struct platform_device =
*pdev, struct tegra_wdt *wdt,
>  	/*
>  	 * The bootloader may leave the watchdog running. Take it over with
>  	 * our own timeout and timer 1, and let the core ping it until user
>  	 * space opens the device.
>  	 */
> -	if (readl(wdt->rst_source) & T20_RST_SOURCE_WDT_EN) {
> +	mutex_lock(&wdt->lock);
> +
> +	if (!wdt->vde_off &&
> +	    (readl(wdt->rst_source) & T20_RST_SOURCE_WDT_EN)) {
>  		dev_info(dev, "watchdog left running by the bootloader, taking it over=
 (timeout %u sec)\n",
>  			 wdt->wdd.timeout);
> -		tegra20_wdt_start(&wdt->wdd);
> +		__tegra20_wdt_start(wdt);
>  		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
>  	}

[Severity: Medium]
Does clearing WDOG_HW_RUNNING in tegra20_wdt_powergate_notify() leak the
module and wd_data->dev references acquired for a boot-enabled watchdog?

When WDOG_HW_RUNNING is set here before devm_watchdog_register_device(),
watchdog_cdev_register() takes a module reference and a device reference:

drivers/watchdog/watchdog_dev.c:watchdog_cdev_register() {
    ...
	if (watchdog_hw_running(wdd)) {
		__module_get(wdd->ops->owner);
		get_device(&wd_data->dev);
    ...
}

The watchdog core only drops those references after user space opens the
device while WDOG_HW_RUNNING is still set and later closes it with
WDOG_HW_RUNNING cleared.  If the VDE partition powers off before
/dev/watchdog is opened, tegra20_wdt_powergate_notify() clears
WDOG_HW_RUNNING and sets wdt->vde_off =3D true, so any later watchdog_open()
fails with -EBUSY in tegra20_wdt_start() and those references are never
released, preventing the module from being unloaded.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-t20-for-up=
stream-v1-0-5923449951fe@gmail.com?part=3D6
