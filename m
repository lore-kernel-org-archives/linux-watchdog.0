Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2283943B4AA
	for <linux-watchdog@vger.kernel.org>; Tue,  4 Aug 2026 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832202; cv=none; b=iY/cXehf2XeL22OmyHPi2jootXwifczTjMdVlfHwd++WlvFbtXtk4Q5EiWdl29JfPOBQCPy3QiR5ukPxDFGjE/nnGs+Tzvmu92Yf0vDFLQpNUXN6nFgUh8+Woi3z+jUv4UdrqgpMVBmuNoaXWgYQqM/Gwa2VAC7B/XqxzdFfaDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832202; c=relaxed/simple;
	bh=8a7Bz3Wlks6VmUuy1QdCs07MrDDdazuF93jL7Wz6o6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2CO4C576bSH2OtWlQJNxuQtWyHBZO2wwyrBY0HM5Y6AVW8QbiKvcQVE3bMq83xxShtRrzaTKNMVDObx1ekHZi8wqQFm5ETDVEBn9oFNCwphkxXPim8w0u10amvkOR6Opr0R6e0OdK4Pu8CsCLe2Ku1Y/I/N/stUE532xlNpFzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkECgT51; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkECgT51"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8486672f03cso4827103b3a.0
        for <linux-watchdog@vger.kernel.org>; Tue, 04 Aug 2026 01:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785832198; x=1786436998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WegLssWBkCTfdMAfMFQf4uWctgk7OkqV1+UwWvmH+Mc=;
        b=WkECgT51v0QKJOMO0vp+rtJyr7ZiV12WK5afXiBMVQHLazv/s5ZrQVFgx48/vaOrjl
         nW5UoGcZ5SV59UfhNpH1fx1wyWCqLy1kpyPNICpFiVooYdSEChcyeoutlT9urdzyYwcN
         JxPYEMvlWJk7/KMhM/hH7FOSt5x0bSNUVBoWYv/K8x1h3DRr4mR/oEbSjq69XXKssAV7
         RLQvMG7LkqKDahLjOu0IEbISF3tDLUhQH0qKQnVn9oNkFYpZeRaZ7P4ipVwBVrnH+zn4
         EA6AyfQDo9RKDoeHKgkJrLm4M+QKle2AZdlTnLvOJRNKbLnENUyN+i0N0IKwYjoqFPOo
         ghcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785832198; x=1786436998;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WegLssWBkCTfdMAfMFQf4uWctgk7OkqV1+UwWvmH+Mc=;
        b=g454mfDzZFr5tu7/gwWFbNWBH3g5ft8tBtqaVbr1MQuN8e3j1TT+Vt3pFkD1ox7V4L
         ivA5SsOh3grqsKaImtZE769fVMSQdB+DgR5WexUSbKUwy3DcQ+IhHS5/kNb+Pp17Bbev
         iaQmKe4aB2KhaFjn/R8zjRNP+bvs1ADjzPI1LbiIQPEHxj/UPet10o9daW4FeT+Mn736
         maCSDewK1w4Y54MS7K9xMI3cejeI+tnwC/i1fdAyRbd/mkRSLlbiia1MR4cCeEKWX3Gm
         cBTxmg5pcqgFeDMENhDA2tdgGEJAVXNJARqQsRfU9o9+GYg8Amn16+jnDP5dIB60VV5h
         RnkQ==
X-Gm-Message-State: AOJu0Yw2MuXtHkRhG5j9P01paXpt735Dyvo2yxAPNRd/rM1lS4CXZfsG
	UHmMNyGb00s/OWR4/AiLczlcNd6hQQmKPjzJ3LOQhDpVj7/LJps5+3Pc
X-Gm-Gg: AR+sD12+SMhhpMxo4eu333Za5gktwcwz1fRMWT/zLWPqRws85mx3exU1zcg4G/PMdku
	+E5Z3b3JmpZo19mQgZ8a41sZT8Dkb2tdLyiB7g0UTWRrEHCFEe7szzGIUMF3kiViqo/qpOrq7od
	P7LHL5KqmyjhckPGDB/BG0bzB/8/LC5owzmISPLe16u7NHfpWmpnu++xXYN+7/WlE9XeYSwmi1t
	V8TK8GH+BuZAG6uLCW0/qgiQYyJ6VCnVgLy137PdE+yK1yXqwYuyzLWKF2YY6WeyhpBRpavIl6s
	PWA6BDx0Pu2jH7n4Ey4LMGrqcG18HiyBNApF2+jlgVOilXJ2JC6/+dtgn78lfAWkrEghv8qAZV1
	g/bfKZcDL9x6kOfHMO2c095zCx/+BIpTxPgqigwnKNn3nuSZz3jstXI4Ag/FaAn5F8pP4Vyh0nC
	XS7s1thlK7KWpXoJLWmsQxShtP2ydz6En3yHLZYGwdpNvCD/bJ4WyqvfkuR+qd051vDNBhLf/V+
	ZwZuStc8adHvIPYgsz1l3//ycWqKrRTiKY3c8pQL0IHsjY=
X-Received: by 2002:a05:6a00:c82:b0:84a:6540:3389 with SMTP id d2e1a72fcca58-84ee47f5779mr12177054b3a.10.1785832198241;
        Tue, 04 Aug 2026 01:29:58 -0700 (PDT)
Received: from [172.19.1.48] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe7da67sm4940625b3a.25.2026.08.04.01.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 01:29:57 -0700 (PDT)
Message-ID: <fdf0ff5e-3307-41f4-8c9c-362becf750fa@gmail.com>
Date: Tue, 4 Aug 2026 16:29:54 +0800
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] watchdog: Add Nuvoton MA35D1 watchdog driver
 support
To: sashiko-reviews@lists.linux.dev
Cc: linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
References: <20260804070351.1846165-1-zychennvt@gmail.com>
 <20260804070351.1846165-3-zychennvt@gmail.com>
 <20260804071552.E6BF01F000E9@smtp.kernel.org>
Content-Language: en-US
From: zychen <zychennvt@gmail.com>
In-Reply-To: <20260804071552.E6BF01F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



sashiko-bot@kernel.org 於 2026/8/4 下午 03:15 寫道:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Missing wait for hardware synchronization (`SYNC` bit) after writing to `REG_WDT_CTL` leads to dropped writes and hardware races.
Not applicable.
According to the MA35D1 TRM, hardware synchronization (SYNC bit) is only required when the WDTEN (Watchdog Enable) bit status is toggled.
Other control bit updates do not require waiting for SYNC."

> - [High] Read-modify-write operations on `REG_WDT_CTL` inadvertently clear Write-1-to-Clear (W1C) status flags.
Not applicable.
INTEN and WKEN are only enabled during PM suspend when watchdog wakeup is configured. During normal runtime, INTEN and WKEN are disabled, 
so IF and WKF remain 0. Therefore, read-modify-write operations during runtime will not inadvertently clear active flags.

> - [Medium] The interrupt handler unconditionally clears all flags and returns IRQ_HANDLED without verifying the interrupt source.
Not applicable.
The WDT interrupt line is dedicated (non-shared) and strictly utilized as a wakeup source during PM suspend.
Unconditionally clearing the flags upon interrupt entry ensures the wakeup/interrupt state is properly reset when exiting sleep.

> --
> 
> --- Patch [2]: [PATCH v3 2/3] watchdog: Add Nuvoton MA35D1 watchdog driver support ---
> commit b3e6fc51e35611680a67e3e8fcf506e2ac5f75cb
> Author: Zi-Yu Chen <zychennvt@gmail.com>
> 
> watchdog: Add Nuvoton MA35D1 watchdog driver support
> 
> Add driver support for the Watchdog Timer (WDT) integrated in Nuvoton
> MA35D1 SoC. This driver provides standard watchdog functionality,
> including timeout configuration, ping, and system reset support via
> the watchdog framework.
> 
>> diff --git a/drivers/watchdog/ma35d1_wdt.c b/drivers/watchdog/ma35d1_wdt.c
>> new file mode 100644
>> index 0000000000000..119d58f338bf0
>> --- /dev/null
>> +++ b/drivers/watchdog/ma35d1_wdt.c
> 
> [ ... ]
> 
>> +static int ma35d1_wdt_set_timeout(struct watchdog_device *wdt_dev,
>> +				  unsigned int timeout)
>> +{
> 
> [ ... ]
> 
>> +	guard(spinlock_irqsave)(&ma35d1_wdt->lock);
>> +	val = readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
>> +	val &= ~TOUTSEL;
>> +	val |= FIELD_PREP(TOUTSEL, i);
>> +	writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);
> 
> [Severity: High]
> Does this read-modify-write of REG_WDT_CTL inadvertently clear W1C flags?
> 
> If bits like IF, WKF, and RSTF are write-1-to-clear, writing back a value
> that has them set will unintentionally clear pending interrupts, wakeups, or
> reset status. Should these W1C bits be masked out from val before it is
> written back?
> 
> Also, should there be a call to ma35d1_wdt_wait_sync() here?
> 
> When ma35d1_wdt_start() calls this function, it modifies REG_WDT_CTL, returns,
> and then immediately modifies REG_WDT_CTL again. Could this second write
> overlap with the clock domain synchronization of the first write and cause
> hardware races?
> 
>> +
>> +	ma35d1_wdt_ping(wdt_dev);
>> +	return 0;
>> +}
>> +
>> +static int ma35d1_wdt_start(struct watchdog_device *wdt_dev)
>> +{
>> +	struct ma35d1_wdt_dev *ma35d1_wdt = watchdog_get_drvdata(wdt_dev);
>> +	void __iomem *wdt_base = ma35d1_wdt->wdt_base;
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	ret = ma35d1_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	guard(spinlock_irqsave)(&ma35d1_wdt->lock);
>> +	val = readl_relaxed(wdt_base + REG_WDT_CTL);
>> +	val |= (WDTEN | RSTEN);
>> +
>> +	writel_relaxed(val, wdt_base + REG_WDT_CTL);
> 
> [Severity: High]
> This read-modify-write shares the same potential W1C flag clearing issue
> mentioned in ma35d1_wdt_set_timeout().
> 
>> +	ret = ma35d1_wdt_wait_sync(ma35d1_wdt);
>> +	if (ret) {
>> +		dev_err(wdt_dev->parent, "Wait for WDTEN SYNC timeout!\n");
>> +		return ret;
>> +	}
>> +
>> +	writel_relaxed(RESET_COUNTER, wdt_base + REG_WDT_RSTCNT);
>> +
>> +	return 0;
>> +}
> 
> [ ... ]
> 
>> +static irqreturn_t ma35d1_wdt_isr(int irq, void *dev_id)
>> +{
>> +	struct ma35d1_wdt_dev *ma35d1_wdt = dev_id;
>> +	unsigned int val;
>> +
>> +	/* Clear the flag if set */
>> +	guard(spinlock)(&ma35d1_wdt->lock);
>> +	val = readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
>> +	writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);
>> +
>> +	return IRQ_HANDLED;
>> +}
> 
> [Severity: Medium]
> Does this interrupt handler need to verify the interrupt source before
> returning IRQ_HANDLED?
> 
> As written, this unconditionally claims the interrupt, which bypasses the
> kernel's spurious interrupt detection if the interrupt was actually
> generated by another device sharing the line.
> 
> Additionally, would writing back the unmodified value of REG_WDT_CTL clear
> all W1C flags at once, including RSTF, which might destroy status
> information needed elsewhere?
> 
> [ ... ]
> 
>> +static int ma35d1_wdt_probe(struct platform_device *pdev)
>> +{
> 
> [ ... ]
> 
>> +	val = readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
>> +	if (val & RSTF) {
>> +		ma35d1_wdt->wdt_dev.bootstatus = WDIOF_CARDRESET;
>> +		writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);
>> +	}
> 
> [Severity: High]
> Does this write to clear RSTF also require a call to ma35d1_wdt_wait_sync()?
> 
> The code proceeds to call ma35d1_wdt_set_timeout() shortly after this, which
> will write to REG_WDT_CTL again. Could this lead to dropped writes or hardware
> races if the synchronization from this first write isn't complete?
> 
>> +
>> +	if (val & WDTEN)
>> +		set_bit(WDOG_HW_RUNNING, &ma35d1_wdt->wdt_dev.status);
>> +
>> +	watchdog_set_drvdata(&ma35d1_wdt->wdt_dev, ma35d1_wdt);
>> +	watchdog_set_nowayout(&ma35d1_wdt->wdt_dev, nowayout);
>> +	watchdog_init_timeout(&ma35d1_wdt->wdt_dev, timeout, &pdev->dev);
>> +
>> +	ma35d1_wdt_set_timeout(&ma35d1_wdt->wdt_dev,
>> +			       ma35d1_wdt->wdt_dev.timeout);
> 
> [ ... ]
> 
>> +static int ma35d1_wdt_suspend(struct device *dev)
>> +{
>> +	struct ma35d1_wdt_dev *ma35d1_wdt = dev_get_drvdata(dev);
>> +
>> +	if (watchdog_active(&ma35d1_wdt->wdt_dev) ||
>> +	    watchdog_hw_running(&ma35d1_wdt->wdt_dev)) {
>> +		u32 val;
>> +		int ret;
>> +
>> +		guard(spinlock_irqsave)(&ma35d1_wdt->lock);
>> +		val = readl_relaxed(ma35d1_wdt->wdt_base + REG_WDT_CTL);
>> +
>> +		if (device_may_wakeup(dev)) {
>> +			val &= ~RSTEN;
>> +			val |= (INTEN | WKEN);
>> +		} else {
>> +			val &= ~(WDTEN | RSTEN);
>> +		}
>> +		writel_relaxed(val, ma35d1_wdt->wdt_base + REG_WDT_CTL);
> 
> [Severity: High]
> This read-modify-write shares the same potential W1C flag clearing issue.
> 
> If a pending wakeup flag is set during the read, could it be inadvertently
> cleared right before the system sleeps?
> 
>> +		ret = ma35d1_wdt_wait_sync(ma35d1_wdt);
>> +		if (ret) {
>> +			dev_err(dev, "Wait for WDTEN SYNC timeout!\n");
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
> 

Regards,
Zi-Yu Chen
