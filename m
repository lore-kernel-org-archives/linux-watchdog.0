Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793130894;
	b=XbcmwmHdqLDJ1NkmTuPePxZHKLJaVppe31qwsEeASqJIN4s05Y7pK6CQZeH49cGOi2Ro
	 I2YWEbnogcn7jHMyKKEOySS/RfMVzTFdaegSjCtfIr0D5CHlryV2aoAGp4uGiJycl8nkV
	 KqS0A3iAF2Tz+f2upUJipYNK2wmv86rl+NtBrI06ZwDyK+63Z10CIljNq2c61YeE2RlXx
	 0uQVI+omXYUna/8HvKflUj+qDv0kQWTc9ujtBgM8sn7+03xNAfvzwsR6QYFUW3yPtdZT7
	 ceRr0ROUB/xPmHA5r5oFjZXouCeFZIw98Kx1Tzcr0urYFN1SUiTaIzkgYaPqIHt0NrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130894;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=FVld1aBiYtmBTyeqFf3iiHOdygGd80PvBTMIQ+6iAcQ=;
	b=HQUjHVA/Me4o088zMtmy20UZBpaimqmCyNm3EShomUQdq0slI445xnCy9La7EWkUQPtg
	 xqtNBHAft3xeM7H3lqMnB2OeW2q5qPn0CllZsLle1joe8KZZN6AKP/sG4tNgGZaW3gkLj
	 0Pa3TbdDYHVWbquGSfx2lpIKuq5gLssjQAhuUwysE+seX+jg+/g8ekqCV67rSywAUcIhv
	 o5tOVSm+7N+sZtKVMlyQ4xixeP81GoYicnzHats7omAkoAMwJfnBFl8qKvN5e3ybC2YTQ
	 JjO8ppW32VGIRgNdqPaHWlz6Fc3zUYCcynOoDO3wCHg85ek+C0Kztke/jrqThNzNmhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=jerw67Ty;
	arc=none smtp.remote-ip=44.202.169.39
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F86606A31A
	for <linux-watchdog@vger.kernel.org>; Tue, 27 Oct 2026 19:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1F86606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=jerw67Ty
Received: from eig-obgw-6006b.ext.cloudfilter.net ([10.0.30.211])
	by cmsmtp with ESMTPS
	id LkvLx1Co6MylkLnFvxEHe3; Tue, 27 Oct 2026 19:54:47 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id LnFuxNHYb6hvPLnFuxeBSt; Tue, 27 Oct 2026 19:54:46 +0000
X-Authority-Analysis: v=2.4 cv=cqCbk04i c=1 sm=1 tr=0 ts=6ae10186
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KYGhMtosgZqaclhzuAAA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=FVld1aBiYtmBTyeqFf3iiHOdygGd80PvBTMIQ+6iAcQ=; b=jerw67TyDxoC
	lvur2EkiomKgCgFyFPCs3mvRPN61pffJ8rccN5znA5o66jBW6AU0q1Oz0j2hFQdlJUWLodeJg4FOq
	7LFGmKEGb2xg7U9KrIrnvXLinGvWlVp54lkX56lf/iWmEkX5KFsnlHmHS9SghBjvoYw6vNEkAsKse
	gOb2IJnWRv+k5HDmVAfV3HD3YYOtZlHpxt3pGoMHCLx63cU7+2xWR8JCXVYb0DhxUoWT+6WHTWQUI
	/kFqPgwJSRYHwKenmzMCzsxhfeB+EwvLPPSUuKmOlq+1M59GLbeHIqmXVUuWM+mMrFTXmq+MJqhus
	+ACn+5KHr3wV0SZv8rX1NA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:60960)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLnFu-00000002dL4-0GiG;
	Wed, 28 Oct 2026 01:24:46 +0530
Message-ID: <67c297cd-eda3-4a01-a2e8-fce6c8993728@roeck-us.net>
Date: Tue, 27 Oct 2026 12:54:45 -0700
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
Subject: Re: [RFC PATCH 2/2] drivers/watchdog: Add RISC-V SBI watchdog driver
To: sashiko-reviews@lists.linux.dev, Prajwal N <prajwal.n@oss.qualcomm.com>
Cc: linux-watchdog@vger.kernel.org
References: <20261002163758.2919372-1-prajwal.n@oss.qualcomm.com>
 <20261002163758.2919372-3-prajwal.n@oss.qualcomm.com>
 <20261003013318.E74021F0089A@smtp.kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20261003013318.E74021F0089A@smtp.kernel.org>
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
X-Exim-ID: 1xLnFu-00000002dL4-0GiG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:60960
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 8
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLjR1gdspVsm3E5yPK8lFVp/Yzg8INmWIJRni56vQKrZp8HkFqot49DK3o/ZynbNci9OWXPbKyvoACdCIRMyvV6PCMz0lHHDAAqfKeiOLQUqB2BtP4Lv
 ZktNCN9LXKI7E6BodpSyVYP13rdMgILnvdSiytzNj1MnN0Vk2C8V32+sMrPmcz8MynNHhM0tOPToR8GDhk9WqR3AVUtEQ2TdsxQ+6F45Rd2bP/21aQkUP+MO

On 10/2/26 18:33, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 9 potential issue(s) to consider:
> - [High] watchdog: riscv_sbi_wdt: Probe returns success on MSI virtual IRQ failure
> - [High] watchdog: riscv_sbi_wdt: Silent u32 overflow in timeout conversion allows premature resets
> - [High] watchdog: riscv_sbi_wdt: MSI interrupts leak and Use-After-Free on unbind
> - [Medium] watchdog: riscv_sbi_wdt: Missing wdt->dev and parent initializations
> - [Medium] watchdog: riscv_sbi_wdt: WDIOF_PRETIMEOUT exposed without hardware support
> - [Medium] watchdog: riscv_sbi_wdt: set_timeout fails to adjust pretimeout
> - [Low] watchdog: riscv_sbi_wdt: Build failure due to non-existent fwnode member
> - [Low] watchdog: riscv_sbi_wdt: Missing module_exit() prevents unloading
> - [Low] watchdog: riscv_sbi_wdt: Build failure on configs missing GENERIC_MSI_IRQ
> --
> 

Please address the reported issues or explain why they do not apply.

Thanks,
Guenter

> commit 5a455815a87582fc7be391ea2d8512e1bd8d0b90
> Author: Prajwal N <prajwal.n@oss.qualcomm.com>
> 
> drivers/watchdog: Add RISC-V SBI watchdog driver
> 
> This commit adds support for the RISC-V SBI watchdog extension, integrating
> with the Linux watchdog framework. It configures and controls the watchdog
> via standard SBI calls and optionally supports pretimeout MSIs.
> 
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
> [ ... ]
>> +config RISCV_SBI_WATCHDOG
>> +	tristate "RISC-V SBI based Watchdog support"
>> +	depends on RISCV_SBI
> 
> [Severity: Low]
> Does this configuration need a dependency on CONFIG_GENERIC_MSI_IRQ?
> 
> Without it, the unconditional call to
> platform_device_msi_init_and_alloc_irqs() in probe will cause a build
> failure when that config is disabled.
> 
>> diff --git a/drivers/watchdog/riscv_sbi_wdt.c b/drivers/watchdog/riscv_sbi_wdt.c
>> new file mode 100644
>> --- /dev/null
>> +++ b/drivers/watchdog/riscv_sbi_wdt.c
> [ ... ]
>> +/* Convert second to microsecond */
>> +static inline u32 sec_to_usec(unsigned int sec)
>> +{
>> +	return (u32)(sec * 1000000ULL);
>> +}
> 
> [Severity: High]
> Can this silently overflow if a user with privileges configures a large
> timeout?
> 
> For example, setting a timeout greater than 4294 seconds overflows the u32
> calculation, causing the hardware to receive an extremely short timeout
> instead, potentially triggering an unexpected system reset.
> 
> [ ... ]
>> +/* Set the watchdog timeout value */
>> +static int sbiwdt_set_timeout(struct watchdog_device *wdd, unsigned int timeout)
>> +{
>> +	struct sbiwdt *wdt = watchdog_get_drvdata(wdd);
>> +	u32 period_usec;
>> +	int ret;
>> +
>> +	period_usec = sec_to_usec(timeout);
>> +
>> +	ret = sbiwdt_write_attribute(SBI_WDT_PERIOD, period_usec);
>> +	if (ret)
>> +		return ret;
>> +
>> +	wdt->attrs.wdt_period = period_usec;
>> +	wdt->wdd.timeout = timeout;
>> +
>> +	return 0;
>> +}
> 
> [Severity: Medium]
> Does this function need to adjust or validate against wdd->pretimeout?
> 
> If a user sets a new timeout that is smaller than the current pretimeout,
> the hardware could be left in an invalid state where the notification time
> is greater than the period time.
> 
> [ ... ]
>> +/* Get the watchdog timeleft before expiry */
>> +static unsigned int sbiwdt_get_timeleft(struct watchdog_device *wdd)
>> +{
>> +	struct sbiwdt *wdt = watchdog_get_drvdata(wdd);
>> +	unsigned int time_left_usec;
>> +	int ret;
>> +
>> +	ret = sbiwdt_read_attribute(SBI_WDT_TIME_LEFT, &time_left_usec);
>> +	if (ret) {
>> +		dev_err(wdt->dev, "Failed to read watchdog time left: %d\n", ret);
> 
> [Severity: Medium]
> Will this dereference an uninitialized wdt->dev pointer?
> 
> It appears wdt->dev is never assigned during probe, which would lead to
> obscured error logs displaying "(NULL device *)".
> 
>> +		return 0;
>> +	}
>> +
>> +	return usec_to_sec(time_left_usec);
>> +}
>> +
>> +static const struct watchdog_info sbiwdt_info = {
>> +	.options	=	WDIOF_SETTIMEOUT	|
>> +				WDIOF_KEEPALIVEPING	|
>> +				WDIOF_PRETIMEOUT	|
>> +				WDIOF_MAGICCLOSE,
> 
> [Severity: Medium]
> Should WDIOF_PRETIMEOUT only be advertised if the firmware actually
> supports MSI capabilities?
> 
> Statically advertising it means userspace could configure a pretimeout that
> will silently never trigger on platforms without MSI support.
> 
> [ ... ]
>> +/* Initialize the watchdog attributes */
>> +static int sbiwdt_init_attributes(struct sbiwdt *wdt)
>> +{
> [ ... ]
>> +	/* Initialize the watchdog timeout to default value */
>> +	timeout_usec = sec_to_usec(SBI_WDT_DEFAULT_TIMEOUT);
>> +	ret = sbiwdt_write_attribute(SBI_WDT_PERIOD, timeout_usec);
>> +	if (ret)
>> +		return ret;
>> +
>> +	wdt->attrs.wdt_period = timeout_usec;
>> +	wdt->wdd.timeout = SBI_WDT_DEFAULT_TIMEOUT;
> 
> [Severity: High]
> Should wdt->wdd.max_timeout be explicitly initialized here?
> 
> Without an upper bound set by the driver, the watchdog core defaults to no
> hardware limit, allowing large timeouts to be passed to sec_to_usec()
> which then truncates them via integer overflow.
> 
> [ ... ]
>> +static int sbiwdt_probe(struct platform_device *pdev)
>> +{
>> +	struct sbiwdt *wdt;
>> +	struct imsic_global_config *imsic_global;
>> +	struct irq_domain *msi_domain;
>> +	struct device *dev = &pdev->dev;
>> +	int rc;
>> +
>> +	/* Allocate memory for the global watchdog structure */
>> +	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>> +	if (!wdt)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, wdt);
>> +	watchdog_set_drvdata(&wdt->wdd, wdt);
> 
> [Severity: Medium]
> Are we missing assignments for wdt->dev and wdt->wdd.parent here?
> 
> Failing to set wdt->wdd.parent = dev breaks the sysfs hierarchy for the
> watchdog device, and missing wdt->dev = dev leads to the uninitialized
> pointer use observed in sbiwdt_get_timeleft().
> 
> [ ... ]
>> +	/* Setup MSI if the capability is available */
>> +	if (wdt->attrs.wdt_capability & SBI_WDT_CAP_MSI_SUPPORT_MASK) {
>> +		imsic_global = imsic_get_global_config();
>> +		if (!imsic_global) {
>> +			dev_err(dev, "IMSIC firmware node is unavailable\n");
>> +			return -ENODEV;
>> +		}
>> +
>> +		msi_domain = irq_find_matching_fwnode(imsic_global->fwnode,
>> +							DOMAIN_BUS_PLATFORM_MSI);
> 
> [Severity: Low]
> Does struct imsic_global_config actually have an fwnode member?
> 
> It appears this member does not exist in the upstream struct definition,
> which will cause an immediate build failure.
> 
>> +		if (!msi_domain) {
>> +			dev_err(dev, "IMSIC platform MSI domain is unavailable\n");
>> +			return -ENODEV;
>> +		}
>> +
>> +		dev_set_msi_domain(&pdev->dev, msi_domain);
>> +
>> +		/* MSI setup*/
>> +		rc = platform_device_msi_init_and_alloc_irqs(dev, 1, sbiwdt_msi_write);
> 
> [Severity: High]
> Are these MSI allocations ever cleaned up if subsequent probe steps fail?
> 
> Since this is not a device-managed function, error paths that return early
> will leak these interrupts.
> 
>> +		if (rc) {
>> +			dev_err(dev, "Failed to allocate MSIs\n");
>> +			return rc;
>> +		}
>> +
>> +		wdt->virq = msi_get_virq(dev, 0);
>> +		if (!wdt->virq) {
>> +			dev_err(dev, "Failed to get MSI virtual IRQ: %d\n", wdt->virq);
>> +			return wdt->virq;
>> +		}
> 
> [Severity: High]
> Will this return 0 (success) when it intends to return a failure?
> 
> msi_get_virq() returns 0 on failure. Returning wdt->virq here falsely
> signals a successful probe to the driver core, leaving the system silently
> unprotected since the watchdog never fully registers.
> 
> [ ... ]
>> +static struct platform_driver sbiwdt_driver = {
>> +	.probe  = sbiwdt_probe,
>> +	.driver = {
>> +			.name = DRV_NAME,
>> +	},
>> +};
> 
> [Severity: High]
> Does this driver need a .remove callback to properly free the MSIs?
> 
> Without one, unbinding the driver permanently leaks the interrupts. If a
> leaked MSI triggers later, it could execute sbiwdt_msi_write() causing a
> use-after-free on the released driver data.
> 
>> +
>> +static int __init sbiwdt_init(void)
>> +{
>> +	int ret;
>> +	struct platform_device *pdev;
>> +
>> +	/* Probe for SBI WDT extension */
>> +	if (sbi_spec_version < sbi_mk_version(3, 0) ||
>> +		sbi_probe_extension(SBI_EXT_WDT) <= 0) {
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret = platform_driver_register(&sbiwdt_driver);
>> +	if (ret)
>> +		return ret;
>> +
>> +	pdev = platform_device_register_simple(DRV_NAME, -1, NULL, 0);
>> +	if (IS_ERR(pdev)) {
>> +		platform_driver_unregister(&sbiwdt_driver);
>> +		return PTR_ERR(pdev);
>> +	}
>> +
>> +	return 0;
>> +}
>> +late_initcall(sbiwdt_init);
> 
> [Severity: Low]
> Should a symmetric module_exit() routine be provided here?
> 
> Since the driver is configured as tristate, omitting an exit function
> prevents it from ever being unloaded via rmmod.
> 

