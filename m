Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D9C36EA8E
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 03:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778468452; cv=none; b=CHgjUpMO97WXfi3xqK+gyEacLnEWlrEYSFJtpgiOnmOgoSbh2ud5dxaRVNVNgD756G4Coz1bZlH0oEhvrhSI7Fi1jJlAs6zYcXuj7yi6kIrt78dre4CAn5lDBGmP0b6Wvlxxty9zdfQyf8ywQsLfxa8h+eWGL6h8daD5hN3qftU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778468452; c=relaxed/simple;
	bh=XbnnznwI5KDVLKriLYb0ojByf+BCa07+G4rzDa1f1/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S7L+wRqbonVSh//O/QWdNyjokfE5enOPerigQVGjl6/wVc+MVUKe+W6pITTkOl2iqqhoB/LZ3GwwnqriOhyjxZ+YW/2Fo+7+1z1W4ugsfbInsYoSzjYC+vDOXddQRsOMzry+kPvvqX0t6zU7ojm6vUd1j7FOW0RVpzKHMomOETY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=py8jpa5C; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="py8jpa5C"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12e332315a8so8417184c88.0
        for <linux-watchdog@vger.kernel.org>; Sun, 10 May 2026 20:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778468450; x=1779073250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/zYjOSAF0onUsf49R8b+dy+d3B9HKkEVhdV1Fac1Pis=;
        b=py8jpa5Ck97omhjXirA2PwEEHRIijl8skDv2uuX3m5qJd5izwIW9UU9gj7RSPZ2IqK
         StzE+rx2Niv3ns7LeR7J7QW/TuGDHeTe7LGEsQbmB7ytBNlVKZLRIYis4jHFpLrVSAfe
         og06kJf5LkM4zwYGkIRvSViiF8NmZZFd5XkVUapJt5Tze9EbWElyCoqcgmRsVkt6Os1P
         60rcIMlUOsUpC6n/md73I/Yw+CuJp094MgwCJQS1e4Sqn8o2p+iUWg2cuUjWV2a1H7RD
         lcdWNOV1s4GNUtLy6JLQdm6YRPk/lMOCgo1UWQWPxFaotefaD1vcV9yNnYhGQ5fIwghO
         ozNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778468450; x=1779073250;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zYjOSAF0onUsf49R8b+dy+d3B9HKkEVhdV1Fac1Pis=;
        b=R3y+fBNJ1rJgOr8V2h5W8x1zk4BiP9z+DsubwzkfgWCs50fuKSr2UeN32W74SPMcEU
         JouCSnMcWcaHEM9YDMZjzi2pv3+K3m8LfefVeEpMMN/T9boMUHHyKffGftCA46dJrr+m
         MuszHgZAF+4+CERTFBVPV6wVTcwt8co9eGs042xoLF1FkCGBBdePRpV2sOS/tvFZVnsl
         wobUN8HcUgrPkVn2m45M+LvNiqnpMkdfaQ3tyyxuRRX+PpRkIrXloFx0HYFJ7mV80kE5
         TRXef7VNLUpJB/YssNs8VsI0WbAGgQCD/V81ZK4N3bORv9Ob+zmrdfnI15v71ZZcaLkR
         fEVA==
X-Forwarded-Encrypted: i=1; AFNElJ+HzW9sL4b2oAFe6ec//na0RwihKKRw9l1XDV3jSyL74BGMnYzhgHSYEyXmVd5R5t9ao3asXlRlJ+J65iw53g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEBrJnKHg7POoqwUrK4YzT8PsD0d4Y3JGaiFxjFF4E9On3eimM
	Y6bZGkwv9SjtzSD1/XKe4eRFvcn40WrMR2dIYLQVDPZtvCH2V6QncZ1NBrEHvg==
X-Gm-Gg: Acq92OHwdLvKion1QrekhroXQBBV+GsCfNzurdvD6X0w96QzmkFnHvwcdewUVgId5cb
	3qgJuftWMZ++skmahf1W7uA29VYUgNn+VDOJOLfQyaioBCHjM8QDZQiQ5WQ+9bYGZ1j5Ua9azHe
	8sOIp7+U3uZJeAthgSoDU94tZkt5oPbpCa997uo26ywkim7tY28Hn0eaOndu6DmU02kRaszAfxT
	4P2tDAR3Or38STPkgD9KVH8jVxBL8VYSy/4CpxisZ4gwmy8WlNpsRZZUguqDTBWpBSp2ZY6HP4P
	YwPFr4TQgefgrQtAvDBAqLZaLzo/8EEe2WCTUVd4ciCNFmMlup4mlHUa9doU5FxSUXAOuQJNy48
	j2gBJjKkCTXZ7QTdsGxLUY+2piYlbVYXUwJiM017KCOMWWp4UA8sNF+FxZurhCFa9gIrImGO0vW
	TuSP6x2qZ6Qcg4keS88wauVwjjBE2jcJhcljH1ebq+bwG8xiKJhZYqe01MqpwFK/VpsT5MR2rZ
X-Received: by 2002:a05:7022:6629:b0:128:cf5c:5362 with SMTP id a92af1059eb24-132a79ef2c6mr4367220c88.12.1778468449972;
        Sun, 10 May 2026 20:00:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327821fc59sm14029834c88.7.2026.05.10.20.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 20:00:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5acea672-0550-478e-8f49-e5e43c72d7e2@roeck-us.net>
Date: Sun, 10 May 2026 20:00:47 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: wdt_pci: Fix shared IRQ storm and complete
 system lockup
To: w15303746062 <w15303746062@163.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>
References: <20260509121655.275311-1-w15303746062@163.com>
 <f182256d-0623-4c9b-a18a-acca8457bb08@roeck-us.net>
 <1fc8bb5a.1346.19e14a548fb.Coremail.w15303746062@163.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <1fc8bb5a.1346.19e14a548fb.Coremail.w15303746062@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/10/26 18:27, w15303746062 wrote:
> 
> 
> 
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> 
> Hi Guenter,
> 
> Thank you for your prompt response and review.
> 
> To answer your questions directly and transparently:
> 
> 1. Is this an actual observed problem?
> Yes, it is a real, observed problem. However, it was observed in a virtualized fuzzing environment (QEMU + Syzkaller) rather than on physical legacy hardware.
> 
> 2. How was it triggered?
> In our QEMU setup, PCI IRQ lines are heavily shared. The fuzzer loaded the `wdt_pci` driver while simultaneously fuzzing other devices on the same shared IRQ line (e.g., the i2c-i801 controller). When the other device triggered a heavy interrupt load, `wdtpci_interrupt()` caught them. Since it bypassed the IRQ ownership check, it blindly claimed the interrupts and caused a massive printk storm (spamming "wdt_pci: Reset in 5ms" and "status 114").
> 
> This overwhelmed the CPU in hard IRQ context, defeated the spurious IRQ detector, and resulted in a 145-second Hung Task panic. Here is a brief snippet of the observed log:
> 
> [  375.485491] wdt_pci: Reset in 5ms
> [  375.487467] wdt_pci: status 114
> [  375.489171] wdt_pci: Reset in 5ms
> ...
> [  375.484244] systemd-journald[4771]: /dev/kmsg buffer overrun, some messages lost.
> [  519.189528] INFO: task syz.2.507 blocked for more than 145 seconds.
> 
> 3. Did I confirm the register bit?
> Yes, the assertion that `WDC_SR_IRQ` is active low relies directly on the hardware definition documented in the driver's own source code at line 66:
> `#define WDC_SR_IRQ      128 /* Active low */ /* X   X   X  */`
> 
> I completely understand your perspective. This is legacy hardware from the 1990s, and it is extremely unlikely to be used in production today. My intention was solely to report a reproducible Local DoS vector found by the fuzzer, as `IRQF_SHARED` handlers are strictly required to verify their interrupt source.
> 
> If you feel that patching this outdated driver adds unnecessary churn and consumes maintainers' time, please feel free to drop this patch. Alternatively, if the hardware is truly obsolete, perhaps the driver should be marked as BROKEN or removed entirely. I leave that entirely to your expert judgment.
> 

I don't see that watchdog supported in qemu. Is this a downstream version
of qemu, or am I missing something ?

Thanks,
Guenter

