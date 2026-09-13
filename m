Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933AD38F254
	for <linux-watchdog@vger.kernel.org>; Sun, 13 Sep 2026 04:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789273083; cv=none; b=GuYR1BS5QU9VNffqkZCkVecS2mqHVxIKZDLHuNuafRXfHSSP2oXN8ckk/h3GQhs/Xj9eu0lChA2A2h5lP0lNFUt0MkYzEFSk0TSZOD2xNDjulr+nfXJ58ssWECafKVvmpyZYAkqFN+/1W3Gbwtt/4X43ixBniEJev/gyTJkfFms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789273083; c=relaxed/simple;
	bh=e5v6M5yqTktG0YaS+EYOkTfB1lGv19l+X8VLtpnRl6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qa7bVbDWCZUKlKO+tG6TG7f/YYp+AhV0lMqGgfA+S7jHZnXxlof6YpxzkUb5corPAVxXtLwRmqytqfVL6sRtwsu7rnwzBeBH9TuUJwyjaT12cdCh3n2MavEGEX1UZJr0Ios7HlgnjTobxvzh7wgtT85AfT4BleftryyqD2IGDvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itlDl9Q/; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itlDl9Q/"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so1115040a91.0
        for <linux-watchdog@vger.kernel.org>; Sat, 12 Sep 2026 21:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789273081; x=1789877881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rxf311/eBJ/8T140hTt7JphIw/mqRr8QNJxhthUWUMk=;
        b=itlDl9Q/+u1vctmKVBEnw1TlW42ClOKd5XREsrjVlmVSsoDzh7pqhFjPRljqj+DKZD
         NMBlEIdwA4gkQhlhFw0/6pc1vYNOAhAIJFEMNjAt+RKCHlsh7m43wrOzZCLY3d0vmLcf
         1rGVGoxZ4RLe/9fQ+DryIjGNLhoxZjOGZwr7XIUrN/KfAzt2ruzATaT5L5MvYf3aumVi
         WdbSVrEOmqxm/KqBuH3r9laQnn5EMdC7JAGyM3EjH2kwfUqAvUbbx+R3liXu1DBWovNS
         hlTymI53pqODcBB6QLjBE1sZbrYgKFQsB1HXppRxxZgtQ0pv+3RIZFqlG1aK16dSL+dt
         dK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789273081; x=1789877881;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rxf311/eBJ/8T140hTt7JphIw/mqRr8QNJxhthUWUMk=;
        b=W6gqfAtAxPTeRQc12PuBzPBArlZuLFXhtphQPC3UKct8pq7/NDNCI362CdRp9B47EN
         GlZpDGmj7uOaPgNDmTDJX39Mn1bTW+ymSls6dgBw0HStM8cq9uhbu53tvs8OWro3xgES
         8BUet5b3EZ0eUJH85frnMsmw4VXH1dmZfohLIOBhSt+EezTnTwnEaxGZdU0Wqz4WLgXW
         t6IU6qftY7cOax0i4VMRFC8tq0RskDPoqpYlVTcIlAOohHIWqwiBu6mFt6lfM3aK9ZXE
         tdz+VJFRgJQRvt2DaeisW7Uim1BKM99GYgXSDGqJMF75al++gu7nV2yj1l+6m3stEmd9
         au5g==
X-Gm-Message-State: AFuF++nMEwWrGgDW+AGDehL5Ir4/W9DB6NuDukzQyAWhGd7+94fKWvHW
	Kvuz4bmRAYMP/XjJ5rNcatXlPPy4phnfxe61QUyos3g5oPeYSKSkxalY
X-Gm-Gg: AYBFou3XokoiLsFWEjS1eWUpPQYvwgF1j756L2Gmkjcyb0et9TaAhMUi0rBkMUUIjvR
	8Oi69baIwn+Ee6CkwoVd0MVY8lalFf84yjpwmMrULaPrS7ejiIoyGWkMoGS54mHgTQO418pZhcY
	CTSLXYapdDAc0aa0Ul78ieDh1J0rKQW70gS2mDoI37r5Q7fv1qiX/SWgtgC32/yPSxPi3exF2ns
	Mhe7sWQMGNJqofcYzOmL2ixHSV+GtBd0GCYcIMsG+hfNTX4hrWms4tH/NWYfBMUb8WgocQzPuxT
	vNpUwR9gSc6Liwy153xxN/SJqWCspHd+WuAGlzxCI11ji0vjBVaDz+2XIz4syFQngszk1d62ARn
	bkqC4IUiJ24OhGdJib1TklbS2FrCR73lvcA4ToaXbqbZMB/SvYMRAHffG6sxHLZE0mK/mKSt0Go
	fFROxC9i1b0zYdf3xncDq+xv2/bITEsIN02QEZsM1+SJ8UKvtjsyiBAi6MyaDc72hRX4DJteD8X
	05cAWFag0lX+e8lJgEQs/8CpFKM76tCTGcqoa9Y2JAr6wmw
X-Received: by 2002:a17:90b:4a03:b0:39d:84af:a0b3 with SMTP id 98e67ed59e1d1-39d9c3651damr19960732a91.18.1789273080666;
        Sat, 12 Sep 2026 21:18:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4fa50efsm19085670eec.28.2026.09.12.21.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2026 21:18:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <51ec34a3-555c-4866-a949-7ccbdcc1a6bb@roeck-us.net>
Date: Sat, 12 Sep 2026 21:17:59 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: sbsa_gwdt: stop the watchdog across the whole
 system-sleep transition
To: David Cemin <dcemin@nvidia.com>, Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20260912182107.1156221-1-dcemin@nvidia.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260912182107.1156221-1-dcemin@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/26 11:21, David Cemin wrote:
> The driver stops a running watchdog in its own device suspend callback
> and restarts it in its resume callback. That leaves the watchdog armed,
> with nobody refreshing it, for the entire early part of suspend entry:
> userspace freeze, kernel thread freeze, and every device suspend
> callback that runs before this device's own. The same window exists at
> the tail end of resume.
> 
> When the watchdog is already running when the driver binds (started by
> firmware, 10 s default timeout) and any device stalls its suspend
> callback past the timeout, the watchdog resets the system in the middle
> of suspend entry. On an arm64 laptop platform this fired on about 7% of
> suspend attempts in a randomized suspend stress run (9 resets in 124
> suspends, with the watchdog reset status set in the SoC's reset status
> register). Two elimination runs confirm the mechanism: the identical
> stress matrix with the watchdog stopped produced zero resets in 118
> suspends, and with the first version of this change (notifier plus the
> original device callbacks) applied, zero resets in 198 suspends across
> four runs, where the baseline rate predicts about 14. The version here
> keeps that mechanism, removes the device resume callback and adds the
> locking described below; it went through a further 120 suspends (60
> s2idle, 60 S3, randomized order, console recorded through every entry)
> with the watchdog armed from boot and zero resets.
> 
> Stop the watchdog from a PM notifier at the *_PREPARE events, before
> tasks are frozen and device callbacks run, and restart it at the
> PM_POST_* events, after everything has resumed. The driver state (armed,
> stopped for sleep) lives under a lock shared with the watchdog ops, so a
> userspace stop or magic close after thaw cannot race the restart, and a
> start requested while the transition is in progress is deferred until
> PM_POST_* instead of arming hardware nobody can refresh; the transition
> is recorded at *_PREPARE whether or not the watchdog was armed at that
> point, so a start between *_PREPARE and task freezing is deferred as
> well. The notifier is
> registered before anything can arm the watchdog and its failure fails
> the probe. A suspend-only device callback remains as the final guard for
> a device whose probe overlapped the *_PREPARE event; it has no resume
> counterpart, so nothing re-arms the watchdog during device resume,
> before PM_POST_SUSPEND. The initial hardware state is adopted under the
> same lock, so a firmware-started watchdog discovered by a probe that
> lost the race with *_PREPARE is stopped at once and armed again at
> PM_POST_*; the stop path is idempotent so the device callback remains
> an effective fallback whatever the ordering.
> 

Isn't this a problem that affects _all_ watchdog drivers ?

Thanks,
Guenter

> Fixes: 57d2caaabfc7 ("Watchdog: introduce ARM SBSA watchdog driver")
> Signed-off-by: David Cemin <dcemin@nvidia.com>
> ---
>   drivers/watchdog/sbsa_gwdt.c | 191 +++++++++++++++++++++++++++++------
>   1 file changed, 159 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> index e04d42cc7774..399a8bcb3c6f 100644
> --- a/drivers/watchdog/sbsa_gwdt.c
> +++ b/drivers/watchdog/sbsa_gwdt.c
> @@ -46,6 +46,8 @@
>   #include <linux/module.h>
>   #include <linux/moduleparam.h>
>   #include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <linux/suspend.h>
>   #include <linux/uaccess.h>
>   #include <linux/watchdog.h>
>   #include <asm/arch_timer.h>
> @@ -87,6 +89,13 @@
>    *			indicate whether to adjust wdd->timeout to avoid a race with WS0
>    * @refresh_base:	Virtual address of the watchdog refresh frame
>    * @control_base:	Virtual address of the watchdog control frame
> + * @lock:		Serializes the watchdog ops against the system sleep hooks
> + * @hw_armed:		The watchdog is logically running (started by firmware,
> + *			or userspace); the hardware follows it except
> + *			while a system sleep transition is in progress
> + * @sleeping:		A system sleep transition is in progress: the hardware
> + *			stays stopped and hw_armed is applied at PM_POST_*
> + * @pm_nb:		PM notifier stopping the watchdog across system sleep
>    */
>   struct sbsa_gwdt {
>   	struct watchdog_device	wdd;
> @@ -95,6 +104,10 @@ struct sbsa_gwdt {
>   	bool			need_ws0_race_workaround;
>   	void __iomem		*refresh_base;
>   	void __iomem		*control_base;
> +	spinlock_t		lock; /* hw_armed, sleeping */
> +	bool			hw_armed;
> +	bool			sleeping;
> +	struct notifier_block	pm_nb;
>   };
>   
>   #define DEFAULT_TIMEOUT		10 /* seconds */
> @@ -244,12 +257,33 @@ static void sbsa_gwdt_get_version(struct watchdog_device *wdd)
>   		!action && (impl == SBSA_GWDT_IMPL_MEDIATEK);
>   }
>   
> +static void sbsa_gwdt_hw_start(struct sbsa_gwdt *gwdt)
> +{
> +	/* writing WCS will cause an explicit watchdog refresh */
> +	writel(SBSA_GWDT_WCS_EN, gwdt->control_base + SBSA_GWDT_WCS);
> +}
> +
> +static void sbsa_gwdt_hw_stop(struct sbsa_gwdt *gwdt)
> +{
> +	/* Simply write 0 to WCS to clean WCS_EN bit */
> +	writel(0, gwdt->control_base + SBSA_GWDT_WCS);
> +}
> +
>   static int sbsa_gwdt_start(struct watchdog_device *wdd)
>   {
>   	struct sbsa_gwdt *gwdt = watchdog_get_drvdata(wdd);
> +	unsigned long flags;
>   
> -	/* writing WCS will cause an explicit watchdog refresh */
> -	writel(SBSA_GWDT_WCS_EN, gwdt->control_base + SBSA_GWDT_WCS);
> +	spin_lock_irqsave(&gwdt->lock, flags);
> +	gwdt->hw_armed = true;
> +	/*
> +	 * While a system sleep transition is in progress nobody can refresh
> +	 * the watchdog: leave the hardware stopped and let the PM_POST_*
> +	 * notifier arm it once everything has resumed.
> +	 */
> +	if (!gwdt->sleeping)
> +		sbsa_gwdt_hw_start(gwdt);
> +	spin_unlock_irqrestore(&gwdt->lock, flags);
>   
>   	return 0;
>   }
> @@ -257,9 +291,12 @@ static int sbsa_gwdt_start(struct watchdog_device *wdd)
>   static int sbsa_gwdt_stop(struct watchdog_device *wdd)
>   {
>   	struct sbsa_gwdt *gwdt = watchdog_get_drvdata(wdd);
> +	unsigned long flags;
>   
> -	/* Simply write 0 to WCS to clean WCS_EN bit */
> -	writel(0, gwdt->control_base + SBSA_GWDT_WCS);
> +	spin_lock_irqsave(&gwdt->lock, flags);
> +	gwdt->hw_armed = false;
> +	sbsa_gwdt_hw_stop(gwdt);
> +	spin_unlock_irqrestore(&gwdt->lock, flags);
>   
>   	return 0;
>   }
> @@ -288,12 +325,101 @@ static const struct watchdog_ops sbsa_gwdt_ops = {
>   	.get_timeleft	= sbsa_gwdt_get_timeleft,
>   };
>   
> +/*
> + * Per-device suspend/resume callbacks alone would stop the watchdog only
> + * once this device itself is suspended, one of the last steps of suspend
> + * entry, and restart it during device resume, before tasks are thawed. A
> + * watchdog running from boot (started by firmware) would therefore be armed, with
> + * nobody refreshing it, through task freezing and every other device's
> + * suspend callback on the way down, and again from device resume until
> + * userspace runs on the way up; anything stalling past the timeout in
> + * either window resets the system.
> + *
> + * Own the transition from a PM notifier instead: stop at the *_PREPARE
> + * events, before anything is frozen, and restart at PM_POST_*, after
> + * everything has resumed. The driver state (hw_armed, sleeping) is kept
> + * under a lock shared with the watchdog ops so that a userspace stop or
> + * magic close after thaw cannot race the restart, and a start requested
> + * while the transition is in progress is deferred to PM_POST_*. The
> + * transition is recorded at *_PREPARE whether or not the watchdog was
> + * armed at that moment, so a start between *_PREPARE and task freezing
> + * is deferred as well instead of arming hardware nobody refreshes. A
> + * suspend-only device callback remains as the final guard for a device
> + * whose probe overlapped the *_PREPARE event; it has no resume
> + * counterpart, so nothing re-arms the hardware before PM_POST_*.
> + */
> +static void sbsa_gwdt_sleep_stop(struct sbsa_gwdt *gwdt)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&gwdt->lock, flags);
> +	/*
> +	 * Idempotent on purpose: the *_PREPARE notifier and the device
> +	 * suspend callback both land here, and a probe that adopted a
> +	 * firmware-armed watchdog after *_PREPARE relies on the second
> +	 * call actually stopping the hardware.
> +	 */
> +	gwdt->sleeping = true;
> +	if (gwdt->hw_armed)
> +		sbsa_gwdt_hw_stop(gwdt);
> +	spin_unlock_irqrestore(&gwdt->lock, flags);
> +}
> +
> +static void sbsa_gwdt_sleep_restart(struct sbsa_gwdt *gwdt)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&gwdt->lock, flags);
> +	if (gwdt->sleeping) {
> +		gwdt->sleeping = false;
> +		if (gwdt->hw_armed)
> +			sbsa_gwdt_hw_start(gwdt);
> +	}
> +	spin_unlock_irqrestore(&gwdt->lock, flags);
> +}
> +
> +static int sbsa_gwdt_pm_notify(struct notifier_block *nb, unsigned long mode,
> +			       void *data)
> +{
> +	struct sbsa_gwdt *gwdt = container_of(nb, struct sbsa_gwdt, pm_nb);
> +
> +	switch (mode) {
> +	case PM_SUSPEND_PREPARE:
> +	case PM_HIBERNATION_PREPARE:
> +	case PM_RESTORE_PREPARE:
> +		sbsa_gwdt_sleep_stop(gwdt);
> +		break;
> +	case PM_POST_SUSPEND:
> +	case PM_POST_HIBERNATION:
> +	case PM_POST_RESTORE:
> +		sbsa_gwdt_sleep_restart(gwdt);
> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static void sbsa_gwdt_unregister_pm_notifier(void *data)
> +{
> +	unregister_pm_notifier(data);
> +}
> +
> +static int sbsa_gwdt_suspend(struct device *dev)
> +{
> +	sbsa_gwdt_sleep_stop(dev_get_drvdata(dev));
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(sbsa_gwdt_pm_ops, sbsa_gwdt_suspend, NULL);
> +
>   static int sbsa_gwdt_probe(struct platform_device *pdev)
>   {
>   	void __iomem *rf_base, *cf_base;
>   	struct device *dev = &pdev->dev;
>   	struct watchdog_device *wdd;
>   	struct sbsa_gwdt *gwdt;
> +	unsigned long flags;
>   	int ret, irq;
>   	u32 status;
>   
> @@ -318,6 +444,21 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
>   	gwdt->clk = arch_timer_get_cntfrq();
>   	gwdt->refresh_base = rf_base;
>   	gwdt->control_base = cf_base;
> +	spin_lock_init(&gwdt->lock);
> +
> +	/*
> +	 * Register the sleep hook before anything can arm the watchdog, and
> +	 * treat its failure as fatal: without it a running watchdog would
> +	 * survive into system sleep with nobody refreshing it.
> +	 */
> +	gwdt->pm_nb.notifier_call = sbsa_gwdt_pm_notify;
> +	ret = register_pm_notifier(&gwdt->pm_nb);
> +	if (!ret)
> +		ret = devm_add_action_or_reset(dev,
> +					       sbsa_gwdt_unregister_pm_notifier,
> +					       &gwdt->pm_nb);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register PM notifier\n");
>   
>   	wdd = &gwdt->wdd;
>   	wdd->parent = dev;
> @@ -347,8 +488,20 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
>   		dev_warn(dev, "System reset by WDT.\n");
>   		wdd->bootstatus |= WDIOF_CARDRESET;
>   	}
> -	if (status & SBSA_GWDT_WCS_EN)
> +	if (status & SBSA_GWDT_WCS_EN) {
>   		set_bit(WDOG_HW_RUNNING, &wdd->status);
> +		/*
> +		 * Adopt the firmware-started watchdog under the lock: if a
> +		 * system sleep transition began between notifier registration
> +		 * and this point, keep the hardware stopped now and let
> +		 * PM_POST_* arm it, like any other start during the transition.
> +		 */
> +		spin_lock_irqsave(&gwdt->lock, flags);
> +		gwdt->hw_armed = true;
> +		if (gwdt->sleeping)
> +			sbsa_gwdt_hw_stop(gwdt);
> +		spin_unlock_irqrestore(&gwdt->lock, flags);
> +	}
>   
>   	if (action) {
>   		irq = platform_get_irq(pdev, 0);
> @@ -398,32 +551,6 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
>   	return 0;
>   }
>   
> -/* Disable watchdog if it is active during suspend */
> -static int __maybe_unused sbsa_gwdt_suspend(struct device *dev)
> -{
> -	struct sbsa_gwdt *gwdt = dev_get_drvdata(dev);
> -
> -	if (watchdog_hw_running(&gwdt->wdd))
> -		sbsa_gwdt_stop(&gwdt->wdd);
> -
> -	return 0;
> -}
> -
> -/* Enable watchdog if necessary */
> -static int __maybe_unused sbsa_gwdt_resume(struct device *dev)
> -{
> -	struct sbsa_gwdt *gwdt = dev_get_drvdata(dev);
> -
> -	if (watchdog_hw_running(&gwdt->wdd))
> -		sbsa_gwdt_start(&gwdt->wdd);
> -
> -	return 0;
> -}
> -
> -static const struct dev_pm_ops sbsa_gwdt_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(sbsa_gwdt_suspend, sbsa_gwdt_resume)
> -};
> -
>   static const struct of_device_id sbsa_gwdt_of_match[] = {
>   	{ .compatible = "arm,sbsa-gwdt", },
>   	{},
> @@ -439,7 +566,7 @@ MODULE_DEVICE_TABLE(platform, sbsa_gwdt_pdev_match);
>   static struct platform_driver sbsa_gwdt_driver = {
>   	.driver = {
>   		.name = DRV_NAME,
> -		.pm = &sbsa_gwdt_pm_ops,
> +		.pm = pm_sleep_ptr(&sbsa_gwdt_pm_ops),
>   		.of_match_table = sbsa_gwdt_of_match,
>   	},
>   	.probe = sbsa_gwdt_probe,
> 
> base-commit: 841e384b841a3d89c50b4b2d6c5bb6abab1a7e39

