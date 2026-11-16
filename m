Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794861695;
	b=4WkCIQ/TQeBpwMRU0yzqycsDSNiIebLxTXQ1CK/Cz4EnFay2fq8JRN5WBzVLkvpMwE2i
	 FzM4l1ubjkGhUSAt8OxG4VRAoNtUTnT7kZFk2PF9UxDzdmURGoxE5PZDPkEU2Vw5KIY3i
	 0XHVYkiI9vzUKWqo5wKxK0TvD19G3gOa1PUNyqcKv1zOaUgMWHxFbJojQ84nLM6JC9OvK
	 7S6ON4OIYrS6v0oRsHoEfGciFP7VsHsl59kPt+V8tgPokz9Hmd2p30AviIDhkq0KVRMcw
	 qsXTy6oRFImPb1aC1wkfwLk69QG5mCxmgrsbbhTex1TuuXzD45kpiyL1BMy6VpP+g8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794861695;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=uxv+lZiQAbkUdZ5JbJ/wVeCHYdb5Chk5hE/dog/N6jE=;
	b=fLpU0hJp/tWEjcG7vFQCgNfVTCQ9IIMpTGsoZMfJvM59Y9zJt7qyemSm3qVKD5FbCRxD
	 7DQQhN0YXgdF9pctYFIpRnriz9BzPEV7z8fODPRnc5PXnj480KuWyF2EOKGL619I7ZqGB
	 MbaYKJP+//EVMX5B2yoiDDWf1IWFYpbIufzXf4t3LOsDyaLslW2ZjPYbdJW58YhNtybgE
	 hVDMPp9hL7GGlpa/RUwQiyw+jgRTNWK7/lHqyiFDyfQlFJxcxhLlf+9kA8Z8BruX5Qaay
	 knWTCzguGaBySUa3zHP7Vj52k9xAh3xwv9f9quXQNE3mb9nutGnyvqDWIdcnhBUxjMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=NXhixjEG;
	arc=none smtp.remote-ip=35.89.44.39
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7528F606A330
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Nov 2026 20:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7528F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=NXhixjEG
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id T03mxn77qyb4YT3WBxvARA; Mon, 16 Nov 2026 20:41:35 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id T3WAxNhJQSeuLT3WAxEqqX; Mon, 16 Nov 2026 20:41:34 +0000
X-Authority-Analysis: v=2.4 cv=NYvm13D4 c=1 sm=1 tr=0 ts=6afb6a7e
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=0SxRSwYGAAAA:8 a=iPr8kxmf2QuCKeiLX58A:9 a=QEXdDO2ut3YA:10
 a=evtWB9OUeeBtXImRToD_:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=uxv+lZiQAbkUdZ5JbJ/wVeCHYdb5Chk5hE/dog/N6jE=; b=NXhixjEGGCPG
	Wao0t6NKGtp5xd2Uis0CsXMJ2te+nLrm/PlDemhmwq5iipLjzhkWgtTX2g/KNR2rjHZCOOMUG1LLD
	dzCSRT0oKMqERUUWiCB6J0y707RlMkT5gKSOPKBjzauH76X+AkFdh7uoWLvY6y7Upb9AUhv+MJ0n2
	XzgSSJp79o4TR62zkxE53wOsNJAm6kYJaTlQ+eNZtYdrrhbyAI76TWzNn9eN4Nm98L83FmMWi4DAS
	zkM2ZxuGTCCWJ3H0bKlvYwnEoO3VUhH4rSKg+WBAkeUjKE4MDdZBP64uFe+HSjYh2n79mgsju2y3H
	M7dqsKMA+k5vbu6nFQBprw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:45976)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xT3W9-00000002LSm-4A9F;
	Tue, 17 Nov 2026 02:11:34 +0530
Message-ID: <69fd5b5f-8364-4c82-936f-56a69b216080@roeck-us.net>
Date: Mon, 16 Nov 2026 12:41:33 -0800
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
Subject: Re: [RFC PATCH v2 2/2] drivers/watchdog: Add RISC-V SBI watchdog
 driver
To: sashiko-reviews@lists.linux.dev, Prajwal N <prajwal.n@oss.qualcomm.com>
Cc: linux-watchdog@vger.kernel.org
References: <20261113121857.1640918-1-prajwal.n@oss.qualcomm.com>
 <20261113121857.1640918-3-prajwal.n@oss.qualcomm.com>
 <sashiko-outbox-212770@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <sashiko-outbox-212770@kernel.org>
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
X-Exim-ID: 1xT3W9-00000002LSm-4A9F
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:45976
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 16
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLLB4qjwArIUzfbktGKaiL1+XmP5Yq6LeWhYZkoK+mqBv0tQcCF1X3P2wJZr5W5T1c5aJBp6HlTkOAOx4Lym4SUk76SPbrsNw0yndZy/JWnti0Lw2ocL
 Y6GS5uFYYnqCcITzDmRtpE9iZDihT42JrK8gZdvzmG/gLafEcRF6ormu0RsH+T9G8sLP8c7HmMwpxEq37zKGYIZwT1l+cOxGYjpjWIkCYYkC9q86yCjHoGPO

On 11/13/26 04:35, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] watchdog: riscv_sbi_wdt: missing return on dev_err_probe() in
>    sbiwdt_probe()
> - [Medium] watchdog: riscv_sbi_wdt: missing select WATCHDOG_CORE in
>    Kconfig

Both issues will need to be fixed.

Regarding dev_err_probe(), if any of those are supposed to be ignored,
that will need to be explained. An error message would be inappropriate
in that case, and the message should be replaced with a warning or notice.

Thanks,
Guenter

> --
> 
> commit 492be02d4c062c56b2b12bb8aae92692793bfd6b
> Author: Prajwal N <prajwal.n@oss.qualcomm.com>
> 
> drivers/watchdog: Add RISC-V SBI watchdog driver
> 
> This commit adds a watchdog driver for the RISC-V SBI watchdog extension
> with support for MSI-based pretimeout notifications.
> 
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index c884f86be4e37..164f4b426240e 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -2157,6 +2157,15 @@ config STARFIVE_WATCHDOG
>>   	  Say Y here to support the watchdog of StarFive JH7100 and JH7110
>>   	  SoC. This driver can also be built as a module if choose M.
>>   
>> +config RISCV_SBI_WATCHDOG
>> +	tristate "RISC-V SBI based Watchdog support"
>> +	depends on RISCV_SBI
>> +	default RISCV
>> +	help
>> +	  Say Y here to include support for a watchdog timer
>> +	  implemented by the Supervisor Binary Interface on RISCV platforms.
>> +	  Requires firmware support.
>> +
> 
> [Severity: Medium]
> Should RISCV_SBI_WATCHDOG select WATCHDOG_CORE?
> 
> sbiwdt_probe() calls devm_watchdog_register_device(), so enabling
> CONFIG_RISCV_SBI_WATCHDOG without CONFIG_WATCHDOG_CORE (or with
> CONFIG_RISCV_SBI_WATCHDOG=y and CONFIG_WATCHDOG_CORE=m) fails to link.
> 
>> diff --git a/drivers/watchdog/riscv_sbi_wdt.c b/drivers/watchdog/riscv_sbi_wdt.c
>> new file mode 100644
>> index 0000000000000..577756f152ce8
>> --- /dev/null
>> +++ b/drivers/watchdog/riscv_sbi_wdt.c
> 
> [ ... ]
> 
>> +static int sbiwdt_probe(struct platform_device *pdev)
>> +{
>> +	struct sbiwdt *wdt;
>> +	const struct imsic_global_config *imsic_global;
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
>> +
>> +	/* Initialiaze watchdog attributes */
>> +	rc = sbiwdt_init_attributes(wdt);
>> +	if (rc)
>> +		dev_err_probe(dev, rc, "Failed to read SBI watchdog attributes\n");
>> +
>> +	wdt->wdd.parent = dev;
>> +	wdt->wdd.info = &sbiwdt_info;
>> +	wdt->wdd.ops = &sbiwdt_ops;
>> +
>> +	watchdog_stop_on_unregister(&wdt->wdd);
>> +	watchdog_stop_on_reboot(&wdt->wdd);
>> +
>> +	/* Setup MSI if the capability is available */
>> +	if (wdt->attrs.wdt_capability & SBI_WATCHDOG_CAP_MSI_SUPPORT_MASK) {
>> +		imsic_global = imsic_get_global_config();
>> +		if (!imsic_global)
>> +			dev_err_probe(dev, -ENODEV, "IMSIC firmware node is unavailable\n");
>> +
>> +		msi_domain = irq_find_matching_fwnode(imsic_global->fwnode,
>> +							DOMAIN_BUS_PLATFORM_MSI);
>> +
>> +		if (!msi_domain)
>> +			dev_err_probe(dev, -ENODEV, "IMSIC platform MSI domain is unavailable\n");
>> +
>> +		dev_set_msi_domain(&pdev->dev, msi_domain);
>> +
>> +		/* MSI setup */
>> +		rc = platform_device_msi_init_and_alloc_irqs(dev, 1, sbiwdt_msi_write);
>> +		if (rc)
>> +			dev_err_probe(dev, rc, "Failed to allocate MSIs\n");
>> +
>> +		/* Register with devm the MSI cleanup callback */
>> +		rc = devm_add_action_or_reset(dev, sbiwdt_msi_free_irqs, dev);
>> +		if (rc)
>> +			return dev_err_probe(dev, rc, "Failed to add sbiwdt MSI cleanup\n");
>> +
>> +		/* Enable pretimeout only when the MSI is allocated */
>> +		wdt->wdd.info = &sbiwdt_pretimeout_info;
>> +
>> +		wdt->virq = msi_get_virq(dev, 0);
>> +		if (!wdt->virq)
>> +			dev_err_probe(dev, -ENODEV, "Failed to get MSI virtual IRQ\n");
>> +
>> +		rc = devm_request_irq(dev, wdt->virq,
>> +					sbiwdt_pretimeout_handler,
>> +					0, "sbiwdt-pretimeout", wdt);
>> +		if (rc)
>> +			dev_err_probe(dev, rc, "Failed to request pretimeout IRQ\n");
>> +	}
>> +
>> +	rc = devm_watchdog_register_device(dev, &wdt->wdd);
>> +	if (rc)
>> +		dev_err_probe(dev, rc, "Failed to register RISC-V SBI watchdog device\n");
>> +
>> +	dev_info(&pdev->dev, "RISC-V SBI Watchdog registered\n");
>> +
>> +	return 0;
>> +}
> 
> [Severity: High]
> Are seven of the eight dev_err_probe() calls in sbiwdt_probe() missing a
> return statement?
> 
> Without returning, a NULL imsic_global causes an immediate NULL pointer
> dereference at imsic_global->fwnode, and earlier or later failures allow
> sbiwdt_probe() to continue with uninitialized attributes, broken MSI/IRQ
> state, or a false 0 return that skips devres cleanup when
> devm_watchdog_register_device() fails.
> 

