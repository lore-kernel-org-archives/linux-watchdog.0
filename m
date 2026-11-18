Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016958;
	b=usqDnVkhCReaPtmh0WGSVswZizZDRUlLOegVzuTf3wdyhYxujdGwfjjzNVbtSCaUpdTs
	 rXAh51gudf7Y8OfSeCErhboUfkC/hFmL1seotbPHZcI1GkgqzrMVlLdvGdvnEdhLQ9pnX
	 NMk1y9yrJ7gszyC/7xs5HPKfKEz+ftxeHoa1qzD9Z9tUbnEG5DRSyQIQlNZU3lcOwYXXU
	 9SM2Bo240iZ/DOvahyL+V+ipaigQGBKtXmwQGXXSCHz1ZOGtMXpix4/Vl8G4Byj6BMM92
	 pfZsDxb15VlmzIFEerRJ3abtE9m2XUbewpS319e2gIcmAo+OmMCAdOO4Pw+KzAAXdLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016958;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=186NHY8FNC5sKojsxwMk3tTEqAwEEOZyr9zcCTsx6j4=;
	b=zsn+l5FSOs5W3X4UbjijLVnQ6hkOvextVaaviII4UmCDXaYECTE8C9jS9KhyU6/Zc6h5
	 v/1jCi/smrDjeLt/w7O4c5Xsp5aPc17O4VE3VJllJjQ06tAX5NL6QtBBtSf6V7XQDx4tw
	 bOFRoMhXbjTmcBNB5/0RO1YLtl3goV0tIBEhz6oHtAFv2x3dKB+0Yuyme+wBMK5D7RbD2
	 uDbMUuChgaLOT48OXez/9NKcdWFL16dU7zuY5EWtwg2iDbDlu6Y9RHyCwPRcCmd/ythkX
	 0/knhaRCHuWcxihlVO9fey9T+RMFRlunkL/P8QJ/XSTkxsk9db8TmXY6oTNaO/KzRkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=FgwfO2AW;
	arc=none smtp.remote-ip=44.202.169.37
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2B8606A335
	for <linux-watchdog@vger.kernel.org>; Wed, 18 Nov 2026 15:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F2B8606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=FgwfO2AW
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id TQHaxU2ZMV16IThuPxC6Z7; Wed, 18 Nov 2026 15:49:17 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id ThuNxPp9H0288ThuNx6dwW; Wed, 18 Nov 2026 15:49:15 +0000
X-Authority-Analysis: v=2.4 cv=a5Iw9VSF c=1 sm=1 tr=0 ts=6afdc8fc
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=zptxmDee5U2Xao3I_7oA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=186NHY8FNC5sKojsxwMk3tTEqAwEEOZyr9zcCTsx6j4=; b=FgwfO2AWOnHz
	3qU1/yrf2Thh2YDnUmGsaPQ4YupzN/rFKYtAiOIfsmUmto+AW2JskaBUXx27lhTy8jn17plCUBt8R
	4drltugkvl36V3P6k9o/4JNf4UJDblKWRqnSVx+I9GnDhmR+fiHF5zaeU3MOZHPM9Av5LwjJeMyW2
	x3JP0gX6xfkmbX6G1DTCJWFxnuMCfcHXERMlUirgaOpffYjkYvO6sBPQaeivtcCX8ZAC0XNFHuOBc
	dNSdmeVhx06Y0472/AXYEdWFMjAyUgCXgwti3Ye1WOgxIeCz2spVrPFbQKPOynv0qRBGjHSQcSSIh
	bo0YXauhbXZTbg2Q5/bf5Q==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:44114)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xThuM-00000000prg-3U0e;
	Wed, 18 Nov 2026 21:19:14 +0530
Message-ID: <71aafc99-b3c4-4d4c-b468-086dde709b71@roeck-us.net>
Date: Wed, 18 Nov 2026 07:49:13 -0800
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] watchdog: Add ARM TWD (MPCore private) watchdog driver
To: sashiko-reviews@lists.linux.dev, Fil Dunsky <filipp.dunsky@gmail.com>
Cc: linux-watchdog@vger.kernel.org
References: <20261118-arm-twd-wdt-v5-1-886265008e78@gmail.com>
 <sashiko-outbox-220535@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <sashiko-outbox-220535@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xThuM-00000000prg-3U0e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:44114
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 6
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGTnnZZ5F339duPosSXagdgUz8o0FeeYPlYianEoi7xjzL2NqpaBa1dAbRKLSDhYLQ83xOPZoDwUtzZCA8lDl/1sGqgh7xm0RcKvTRUKWcpezF3nSZN1
 m7OYXE9f9Ii28D54i3cK2a6VxKRuzTW1ANCSKpC+9/AJ+57F020MiZIabddkxzknNRSTzcdRMK0DVBD2u3Q3XircvQeed8nP3YcyRhRM/EOh6QamHMJXVJz3

Hi,

On 11/18/26 01:12, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issues to consider:
> - [Medium] watchdog: arm_twd_wdt: race in twd_wdt_set_timeout() causes
>    immediate reset
> - [Medium] watchdog: arm_twd_wdt: twd_wdt_probe() arms watchdog before
>    cleanup setup
> - [Medium] watchdog: arm_twd_wdt: keepalive reset and active ping worker
>    on suspend
> - [Medium] watchdog: arm_twd_wdt: missing barrier between keepalive and
>    armed state
> - [Low] watchdog: arm_twd_wdt: use of obsolete __MODULE_STRING() macro
> --
> 

The reported issues all seem real to me. Please fix, or explain why
they are false positives.

Thanks,
Guenter

> commit 2b76b6ecd425333171034f709700b36407dec65d
> Author: Fil Dunsky <filipp.dunsky@gmail.com>
> 
> watchdog: Add ARM TWD (MPCore private) watchdog driver
> 
> This commit adds a watchdog driver for the ARM11 MPCore, Cortex-A5 and
> Cortex-A9 private (TWD) watchdog, using CPU0's watchdog as the system
> watchdog and registering a restart handler.
> 
>> diff --git a/drivers/watchdog/arm_twd_wdt.c b/drivers/watchdog/arm_twd_wdt.c
>> new file mode 100644
>> index 0000000000000..068b6483a8ac3
>> --- /dev/null
>> +++ b/drivers/watchdog/arm_twd_wdt.c
>> @@ -0,0 +1,465 @@
> 
> [ ... ]
> 
>> +static bool nowayout = WATCHDOG_NOWAYOUT;
>> +module_param(nowayout, bool, 0);
>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> 
> [Severity: Low]
> __MODULE_STRING() is marked obsolete in include/linux/module.h, and commit
> b152ca999c5f ("watchdog: Replace __MODULE_STRING() with __stringify()")
> removed all other uses in drivers/watchdog/.  Could this include
> <linux/stringify.h> and use __stringify(WATCHDOG_NOWAYOUT) instead?
> 
> [ ... ]
> 
>> +static u32 twd_wdt_ticks(struct twd_wdt *wdt)
>> +{
>> +	s64 expires = atomic64_read(&wdt->keepalive) +
>> +		      (s64)wdt->wdd.timeout * NSEC_PER_SEC;
>> +	s64 left = expires - ktime_get_ns();
>> +	u64 ticks;
>> +
>> +	if (left <= 0)
>> +		return 1;
>> +
>> +	ticks = mul_u64_u64_div_u64(READ_ONCE(wdt->rate), left,
>> +				    (u64)NSEC_PER_SEC * (TWD_WDT_PRESCALE + 1));
>> +
>> +	return clamp_t(u64, ticks, 1, U32_MAX);
>> +}
> 
> [ ... ]
> 
>> +static void twd_wdt_set_armed(struct twd_wdt *wdt, bool armed)
>> +{
>> +	guard(mutex)(&wdt->lock);
>> +
>> +	atomic64_set(&wdt->keepalive, ktime_get_ns());
>> +	WRITE_ONCE(wdt->armed, armed);
>> +	twd_wdt_call(wdt, armed ? twd_wdt_cpu_start : twd_wdt_cpu_stop);
>> +}
> 
> [Severity: Medium]
> Can CPU0 in twd_wdt_cpu_pm_notify() observe wdt->armed == true before the
> new wdt->keepalive value and trigger an immediate reset?
> 
> On 32-bit ARM, atomic64_set() and atomic64_read() are relaxed and include
> no memory barriers.  If twd_wdt_start() runs on CPU1 while CPU0 is exiting
> a power-down idle state with interrupts disabled, the IPI from
> twd_wdt_call() waits until CPU0 re-enables interrupts:
> 
> CPU1                              CPU0 (IRQs disabled)
> twd_wdt_start()                   cpu_pm_exit()
>    twd_wdt_set_armed(..., true)      twd_wdt_cpu_pm_notify()
>      atomic64_set(&wdt->keepalive,     if (READ_ONCE(wdt->armed) && ...)
>                   now)                   twd_wdt_cpu_start()
>      WRITE_ONCE(wdt->armed, true)          twd_wdt_ticks()
>      twd_wdt_call(...)                       atomic64_read(&wdt->keepalive)
>                                                --> sees 0 or stale timestamp
>                                              left <= 0 -> returns 1
>                                            writel(1, TWD_WDT_LOAD)  <-- reset
> 
> Pairing smp_store_release(&wdt->armed, armed) in twd_wdt_set_armed() with
> smp_load_acquire(&wdt->armed) in twd_wdt_cpu_pm_notify() would order the
> keepalive store before wdt->armed becomes visible.
> 
> [ ... ]
> 
>> +static int twd_wdt_set_timeout(struct watchdog_device *wdd, unsigned int t)
>> +{
>> +	wdd->timeout = t;
>> +	if (watchdog_active(wdd) || watchdog_hw_running(wdd))
>> +		twd_wdt_ping(wdd);
>> +
>> +	return 0;
>> +}
> 
> [Severity: Medium]
> Can decreasing wdd->timeout in twd_wdt_set_timeout() reset the board
> immediately if a clock rate change or CPU0 idle exit happens before
> twd_wdt_ping() updates wdt->keepalive?
> 
> watchdog_set_timeout() holds wd_data->lock, not wdt->lock.  When userspace
> reduces the timeout (for example from 60s to 30s when 35s have elapsed
> since the last keepalive), wdd->timeout is updated before twd_wdt_ping()
> acquires wdt->lock and refreshes wdt->keepalive:
> 
> CPU0                              CPU1
> twd_wdt_clk_notify()              twd_wdt_set_timeout(wdd, 30)
>    guard(mutex)(&wdt->lock)          wdd->timeout = 30;
>                                      twd_wdt_ping()
>                                        guard(mutex)(&wdt->lock)  [blocks]
>    twd_wdt_call(...,
>                 twd_wdt_cpu_ping)
>      twd_wdt_ticks()
>        expires = old_keepalive + 30s
>        left = -5s <= 0 -> returns 1
>      writel(1, TWD_WDT_LOAD)  <-- immediate reset
> 
> In addition, watchdog_ioctl() for WDIOC_SETTIMEOUT in
> drivers/watchdog/watchdog_dev.c already calls watchdog_ping(wdd) right
> after watchdog_set_timeout(), so calling twd_wdt_ping() here sends a
> redundant IPI to CPU0 on every WDIOC_SETTIMEOUT ioctl.
> 
> [ ... ]
> 
>> +	if (wdt->running) {
>> +		/* Left running by the bootloader: take it over without a stop */
>> +		dev_info(dev, "running, taking over\n");
>> +		twd_wdt_start(&wdt->wdd);
>> +		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
>> +	}
>> +
>> +	wdt->pm_nb.notifier_call = twd_wdt_cpu_pm_notify;
>> +	ret = cpu_pm_register_notifier(&wdt->pm_nb);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = devm_add_action_or_reset(dev, twd_wdt_remove_pm_notifier, wdt);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = devm_add_action_or_reset(dev, twd_wdt_disable, wdt);
>> +	if (ret)
>> +		return ret;
> 
> [Severity: Medium]
> If cpu_pm_register_notifier() or the first devm_add_action_or_reset()
> fails when wdt->running is true, does twd_wdt_probe() return with the
> reprogrammed watchdog still armed and its clock disabled by devres?
> 
> twd_wdt_start() reprograms the hardware counter to wdd.timeout (default
> 30s, which may be much shorter than the bootloader's timeout) before the
> twd_wdt_disable cleanup action and CPU PM notifier are registered.
> Registering the CPU PM notifier and twd_wdt_disable action before taking
> over the running watchdog would avoid leaving it armed on error or losing
> its state if CPU0 enters idle during probe.
> 
> [ ... ]
> 
>> +/* The watchdog loses its state in suspend, set it up again at resume */
>> +static int twd_wdt_suspend(struct device *dev)
>> +{
>> +	struct twd_wdt *wdt = dev_get_drvdata(dev);
>> +
>> +	wdt->resume_armed = wdt->armed;
>> +	if (wdt->resume_armed)
>> +		twd_wdt_stop(&wdt->wdd);
>> +
>> +	return 0;
>> +}
>> +
>> +static int twd_wdt_resume(struct device *dev)
>> +{
>> +	struct twd_wdt *wdt = dev_get_drvdata(dev);
>> +
>> +	if (wdt->resume_armed)
>> +		twd_wdt_start(&wdt->wdd);
>> +
>> +	return 0;
>> +}
> 
> [Severity: Medium]
> Does calling twd_wdt_stop() and twd_wdt_start() across suspend and resume
> reset wdt->keepalive to ktime_get_ns(), contrary to the commit message?
> 
> The commit message notes that on resume from suspend the time of the last
> keepalive is kept and the watchdog is loaded with the time left from it so
> the timeout is not extended.  However, twd_wdt_stop() and twd_wdt_start()
> both call twd_wdt_set_armed(), which overwrites wdt->keepalive with
> ktime_get_ns() and reloads a full timeout on resume.
> 
> Also, twd_wdt_probe() does not call watchdog_stop_ping_on_suspend(), and
> twd_wdt_suspend() reads wdt->armed without wdt->lock while leaving
> WDOG_HW_RUNNING set, so watchdog_ping_work() can run after
> twd_wdt_suspend() and write TWD_WDT_LOAD while the device is suspended.
> 

