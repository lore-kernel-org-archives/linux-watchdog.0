Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795341842;
	b=thu20/xkD2mXA1Ky/qcC8mc5Sq+KdTIUdbBRtdAsRlxtKyvQGSJxR2wIv9cl4WAIWzrw
	 TR7bcrkhNHsv6ycGsVXg1APqldAI3biylUtQuQTKBmU46WsdLxVNmF1w2eL9FmL+iO244
	 vqTvblD2vvHweFxkBLkyMkbzDPqbwoX88prLf2fY8yBiB8UmLWnNMwhhe9dM1NRDaF7l6
	 wz/DXlZYLeLTFld8BVufmdKBgRhVjm5+E+xglsbnxNhdibucaaOVCAR0l7DZNoAgwlrtu
	 3hrSRU4gR943m9jb++VzIlDM2aIJRjoCuVPbUKozw1Rch1siGKvKQLKK3MyL4yfx/PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795341842;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=V7XgMujmDFfqPIzCrzn9gOP6ailrhUCZJdYYYDTa498=;
	b=CeLrJ5i4vlqiPzGCKpzskbchEXSt/Wq0QbYtDbohi0e0ARtMoBBP/+gfcxnVevmRGOAI
	 stKkUSAYkRowTQvRQ0hzzn/NgBwRo/liBGiCuV/aiEYuv4LUE5aDH8ZJvHO8blovTgNz0
	 5ZjpUvkG8bSUv7LVZLBbT6LAc/8CsnyqTs/qglalYsb+JIOv5Pg3w+K1DUbGM9bIjt/Py
	 m5YPZ5tN5DtgJ+CG9YIsxpOI5SF0IA9t5KRGzCJUr8PCPTXDTMGEaJQDA0kepywXMAQuj
	 G6PtmuEzVdXH1pur0Z6NeNxNaaWFThsIgBbNYgDHAOD72Aee1kMcaiKbl/mcwzUudNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=vaNrB82k;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A6E606A32A
	for <linux-watchdog@vger.kernel.org>; Sun, 22 Nov 2026 10:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41A6E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=vaNrB82k
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id UwTHxskXgVK9UV4QOxoOTV; Sun, 22 Nov 2026 10:03:56 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id V4QNxqsJ4laNKV4QNxdGvI; Sun, 22 Nov 2026 10:03:55 +0000
X-Authority-Analysis: v=2.4 cv=UbpRSLSN c=1 sm=1 tr=0 ts=6b02be0b
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=4ONIEzdkpqhAoMONle8A:9 a=QEXdDO2ut3YA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=V7XgMujmDFfqPIzCrzn9gOP6ailrhUCZJdYYYDTa498=; b=vaNrB82k9Meh
	n3iK6tyKwijaFoJdIwKX1Gcr7fsh/yaC8sZWgzVaAgaU7a0OOk7y78byI5gfXAUF8pQXLnZiFvivK
	0kkxjawJU9ZbIfyVesKF7VqcNS1yB4RNPdODrzvzHkyCgFTHvpRgXIv5/PBeIK3RP9BoN+G0jdvSo
	B34im1mZGbl3TBgsxUJ9rxYf7PUISZ+cvrJZRb7mOfl0r73ByKF3fm0UJbJYafim2VxQlnPE8CGb7
	/mBJFijWBq+NTMzT78aTi8iPVY3/zcFonMxgyYXVzVXErLvuzZe9jt3M2oMn3g43lLhd7gc7xhZC/
	sCsAaq0Mz5/I27J4Nne8UQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:42002)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xV4QN-000000049r4-0RFW;
	Sun, 22 Nov 2026 15:33:55 +0530
Message-ID: <6d49b915-b9ea-432a-91a3-3743e43553bf@roeck-us.net>
Date: Sun, 22 Nov 2026 02:03:53 -0800
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
Subject: Re: [PATCH 2/4] watchdog: histb: Add HiSilicon STB watchdog driver
To: sashiko-reviews@lists.linux.dev, David Yang <mmyangfl@gmail.com>,
 linux-watchdog@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
References: <20261122065549.3265519-1-mmyangfl@gmail.com>
 <20261122065549.3265519-3-mmyangfl@gmail.com>
 <sashiko-outbox-227780@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <sashiko-outbox-227780@kernel.org>
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
X-Exim-ID: 1xV4QN-000000049r4-0RFW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:42002
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 4
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAIB/XNkAffumiTXMlPIxW3UR83BkItyhUiZV4dT/XS2NqqPSPS5+uXteNSOZ5FxwDQqsNTWcjxs6KSmraHG/hBGxDVXduKfwuT6X3nYMa15SQ4iHLCQ
 AtEs2obczW5cGqRekg+mUe85tJECOjNHSWsIA06OC545ytv39uImUOCmR/DTawugD9238LkGMNhRNBvvgwPZ2Yeao0I2m7PKMaZthbyULsEUnOKnvD/WZUR3

On 11/21/26 23:18, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issues to consider:
> - [High] watchdog: histb: stale counter reload in histb_wdt_arm() and
>    histb_wdt_ping()
> - [High] watchdog: histb: unclocked MMIO reads in
>    histb_wdt_get_timeleft() when stopped
> - [Medium] watchdog: histb: missing watchdog_stop_on_unregister() in
>    histb_wdt_probe()
> - [Medium] watchdog: histb: unchecked histb_wdt_start() error in
>    histb_wdt_resume()
> - [Medium] watchdog: histb: deadlock and invalid wait context in
>    histb_wdt_restart()
> --
> 
> commit 8f21fc6b65d49db93aa95ad107c510c4d4fadce6
> Author: David Yang <mmyangfl@gmail.com>
> 
> watchdog: histb: Add HiSilicon STB watchdog driver
> 
> This commit adds a platform watchdog driver for the watchdog controller
> integrated on HiSilicon STB SoCs.
> 
>> diff --git a/drivers/watchdog/histb_wdt.c b/drivers/watchdog/histb_wdt.c
>> new file mode 100644
>> index 0000000000000..1961981f1e5d7
>> --- /dev/null
>> +++ b/drivers/watchdog/histb_wdt.c
>> @@ -0,0 +1,287 @@
>> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>> +/*
>> + * HiSilicon STB Watchdog Driver
>> + *
>> + * The watchdog controller integrated on HiSilicon STB SoCs shares register
>> + * offsets with the ARM PrimeCell SP805, but differs in several critical
>> + * hardware behaviors:
>> + *   - The ID registers at 0xfe0..0xffc are unimplemented and read zero,
>> + *     requiring a platform device driver rather than AMBA probe;
>> + *   - Writing WDTLOCK freezes the counter instead of only blocking register
>> + *     writes, so the block must remain unlocked while running;
>> + *   - Writing WDTLOAD never reloads the running counter; only WDTINTCLR does;
> 
> [ ... ]
> 
>> +static void histb_wdt_arm(struct histb_wdt *wdt, u32 load)
>> +{
>> +	void __iomem *base = wdt->base;
>> +
>> +	spin_lock(&wdt->lock);
>> +	writel_relaxed(HISTB_WDT_UNLOCK_KEY, base + HISTB_WDT_LOCK);
>> +	writel_relaxed(0, base + HISTB_WDT_CONTROL);
>> +	writel_relaxed(HISTB_WDT_INT_MASK, base + HISTB_WDT_INTCLR);
>> +	writel_relaxed(load, base + HISTB_WDT_LOAD);
>> +	writel_relaxed(HISTB_WDT_INT_ENABLE | HISTB_WDT_RESET_ENABLE,
>> +		       base + HISTB_WDT_CONTROL);
>> +	readl_relaxed(base + HISTB_WDT_LOCK);
>> +	spin_unlock(&wdt->lock);
>> +}
> 
> [ ... ]
> 
>> +static int histb_wdt_ping(struct watchdog_device *wdd)
>> +{
>> +	struct histb_wdt *wdt = watchdog_get_drvdata(wdd);
>> +	void __iomem *base = wdt->base;
>> +
>> +	spin_lock(&wdt->lock);
>> +	writel_relaxed(HISTB_WDT_INT_MASK, base + HISTB_WDT_INTCLR);
>> +	writel_relaxed(wdt->load_val, base + HISTB_WDT_LOAD);
>> +	readl_relaxed(base + HISTB_WDT_LOCK);
>> +	spin_unlock(&wdt->lock);
>> +
>> +	return 0;
>> +}
> 
> [Severity: High]
> Should HISTB_WDT_LOAD be written before HISTB_WDT_INTCLR in
> histb_wdt_arm() and histb_wdt_ping()?
> 
> As noted in the file header comment, writing WDTLOAD does not reload the
> counter and only writing WDTINTCLR triggers the reload.  Writing
> HISTB_WDT_INTCLR first reloads the counter with whatever stale value was
> previously in HISTB_WDT_LOAD.  In particular, when histb_wdt_restart()
> calls histb_wdt_arm(wdt, 1), the counter reloads with the old timeout (or
> 0xffffffff if the watchdog was never started) instead of 1, so the system
> fails to reset during the 1 ms delay.
> 
> [ ... ]
> 
>> +static unsigned int histb_wdt_get_timeleft(struct watchdog_device *wdd)
>> +{
>> +	struct histb_wdt *wdt = watchdog_get_drvdata(wdd);
>> +	u64 value;
>> +
>> +	spin_lock(&wdt->lock);
>> +	value = readl_relaxed(wdt->base + HISTB_WDT_VALUE);
>> +	if (!(readl_relaxed(wdt->base + HISTB_WDT_RIS) & HISTB_WDT_INT_MASK))
>> +		value += (u64)wdt->load_val + 1;
>> +	spin_unlock(&wdt->lock);
>> +
>> +	return div_u64(value, wdt->rate);
>> +}
> 
> [Severity: High]
> Can histb_wdt_get_timeleft() read HISTB_WDT_VALUE and HISTB_WDT_RIS while
> wdt->clk is disabled?
> 
> wdt->clk is only prepared at probe time and is not enabled until
> histb_wdt_start() is called, and histb_wdt_stop() disables it again.  The
> watchdog core's timeleft sysfs attribute (and WDIOC_GETTIMELEFT ioctl)
> invokes wdd->ops->get_timeleft(wdd) without checking
> watchdog_active(wdd).  Reading /sys/class/watchdog/watchdogN/timeleft
> while the watchdog is stopped accesses the device registers with the
> clock gated, which can cause a synchronous external abort or bus hang.
> 

A generic fix for this problem is pending.

https://patchwork.kernel.org/project/linux-watchdog/patch/20261121052950.287506-1-nhat.tranminhk2@gmail.com/

Guenter

>> +static int
>> +histb_wdt_restart(struct watchdog_device *wdd, unsigned long mode, void *cmd)
>> +{
>> +	struct histb_wdt *wdt = watchdog_get_drvdata(wdd);
>> +
>> +	/*
>> +	 * For reset, we start the WDT clock and leave it running.
>> +	 * The clock was prepared at probe time; only clk_enable() is
>> +	 * safe in this atomic (restart notifier) context.
>> +	 */
>> +	clk_enable(wdt->clk);
>> +	histb_wdt_arm(wdt, 1);
>> +
>> +	mdelay(1);
>> +
>> +	return 0;
>> +}
> 
> [Severity: Medium]
> Can histb_wdt_restart() deadlock on wdt->lock via histb_wdt_arm()?
> 
> Normal callers acquire wdt->lock with plain spin_lock() while local
> interrupts remain enabled, whereas histb_wdt_restart() runs from the
> restart notifier chain after smp_send_stop() or from emergency_restart()
> in hardirq context:
> 
> CPU0                              CPU1
> histb_wdt_ping()
>    spin_lock(&wdt->lock)
>                                    machine_restart()
>                                      smp_send_stop()
>    <stop IPI halts CPU0>
>                                      do_kernel_restart()
>                                        histb_wdt_restart()
>                                          histb_wdt_arm()
>                                            spin_lock(&wdt->lock)
>                                              <-- spins forever
> 
> An emergency_restart() triggered from a hardirq on the same CPU while
> wdt->lock is held will likewise deadlock, and taking spinlock_t from
> hardirq context violates lockdep wait-context nesting on PREEMPT_RT.
> Programming the registers in histb_wdt_restart() through an unlocked
> helper avoids taking wdt->lock during restart.
> 
> [ ... ]
> 
>> +static int histb_wdt_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct histb_wdt *wdt;
>> +	int res;
>> +
>> +	wdt = devm_kzalloc_obj(dev, *wdt);
>> +	if (!wdt)
>> +		return -ENOMEM;
>> +
>> +	wdt->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(wdt->base))
>> +		return PTR_ERR(wdt->base);
>> +
>> +	/*
>> +	 * Keep the clock prepared for the lifetime of the driver:
>> +	 * .restart() runs in atomic context and may only call clk_enable().
>> +	 */
>> +	wdt->clk = devm_clk_get_optional_prepared(dev, NULL);
> 
> [ ... ]
> 
>> +	watchdog_stop_on_reboot(&wdt->wdd);
>> +	platform_set_drvdata(pdev, wdt);
>> +
>> +	res = devm_watchdog_register_device(dev, &wdt->wdd);
>> +	if (res)
>> +		return dev_err_probe(dev, res,
>> +				     "Failed to register watchdog device\n");
>> +
>> +	return 0;
>> +}
> 
> [Severity: Medium]
> Should histb_wdt_probe() also call watchdog_stop_on_unregister(&wdt->wdd)?
> 
> If the device is unbound while the watchdog is active,
> devm_watchdog_register_device() unregisters the watchdog without calling
> histb_wdt_stop().  That leaves the hardware counter running to reset the
> system and causes the devres cleanup for devm_clk_get_optional_prepared()
> to call clk_unprepare() while wdt->clk is still enabled, triggering a
> WARN in clk_core_unprepare().
> 
>> +static int __maybe_unused histb_wdt_suspend(struct device *dev)
>> +{
>> +	struct histb_wdt *wdt = dev_get_drvdata(dev);
>> +
>> +	if (watchdog_active(&wdt->wdd))
>> +		histb_wdt_stop(&wdt->wdd);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused histb_wdt_resume(struct device *dev)
>> +{
>> +	struct histb_wdt *wdt = dev_get_drvdata(dev);
>> +
>> +	if (watchdog_active(&wdt->wdd))
>> +		histb_wdt_start(&wdt->wdd);
>> +
>> +	return 0;
>> +}
> 
> [Severity: Medium]
> Should histb_wdt_resume() propagate the return value of histb_wdt_start()?
> 
> If clk_enable() fails in histb_wdt_start() during resume, discarding the
> error leaves WDOG_ACTIVE set while wdt->clk remains disabled.  Later
> watchdog callbacks will then access unclocked MMIO registers and
> histb_wdt_stop() will call clk_disable() on an already-disabled clock.
> 

