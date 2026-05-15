Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C47305665;
	Fri, 15 May 2026 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778878143; cv=none; b=g8+datzlUCBjJsrFDHclRXG5jhLm1e4uAd1kQFzqSlKSf0BEPBl7kD2mMYkwO9Zu+rf3kz7DZiiCq5ICc9qdFlgNT2wnY/5Uj18gfIGNlSsolmRC1LJd/pqNDPbJ7jtSP0oWQXNAqqm5NKOw6vP0GjQmQ/gTLiE/YRwE0Jy7/9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778878143; c=relaxed/simple;
	bh=setc2kaOn0Cc1QnUU45nw+/qSiTUFopM20iC/f5d25s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ORmjYZ1A6zUsTOSv157rsgU7xneCyoZEPei9hy98b2StjPeHyjIHSUedH29WynYlKr+rlcPWQqErAxHieEHYc+xsRRD91+yh1XDjG6ujoOh+a6eytQN9z/ENkc2eVKBRaD75ueDAJpzDmCvIjEcabwdTdkYNTRwkb6sASVJHWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Qa39o7wA; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Qa39o7wA"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E9C0C2725F;
	Fri, 15 May 2026 22:48:59 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qoATOATVLJ5e; Fri, 15 May 2026 22:48:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1778878139; bh=setc2kaOn0Cc1QnUU45nw+/qSiTUFopM20iC/f5d25s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qa39o7wABO9WKuDPvBLjttZ2d0GA4KfRRupoAycJovf4porJsEUSbFFr/7cnWBM9C
	 dLHRJvEFvQ9paPDXJb4TC68FDL3lbEMePWvWb7OpTVPLL8EgI6hJ+w8VFVI6ghgzgc
	 Ddzm1qWOtqGupJkHf2pYSHKJKrawdhfrwn15sU9lkFBB3bZv2iHwA69zs7VJ1qRVWl
	 wMsBG3xC0C0P+zNawgo28GZQiBff2eFoE5zUja/jUgVrVkJqBgfOYmsYCmHrtgh4AH
	 FESOhqV+8z7S0n5pryJI2bykdRvYJz68QHNdfPqZ0SArU/cPmNVyF7b14kttQGiNuf
	 7FwghjL/9xU6g==
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 15 May 2026 20:48:59 +0000
From: Rustam Adilov <adilov@disroot.org>
To: sashiko@lists.linux.dev
Cc: linux-watchdog@vger.kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, Sander
 Vanheule <sander@svanheule.net>
Subject: Re: [PATCH 1/3] watchdog: realtek-otto: Change to use regmap API
In-Reply-To: <20260509171602.6B74FC2BCB2@smtp.kernel.org>
References: <20260509163101.722793-2-adilov@disroot.org>
 <20260509171602.6B74FC2BCB2@smtp.kernel.org>
Message-ID: <1d8a4fa99fa1af9e41f255ec147a7571@disroot.org>
X-Sender: adilov@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2026-05-09 17:16, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Deadlock risk in the atomic restart handler due to regmap's internal spinlock.
> --
> 
> commit a520c8e2203154ba331a6ae28f00daec074e62ee
> Author: Rustam Adilov <adilov@disroot.org>
> 
> watchdog: realtek-otto: Change to use regmap API
> 
> This commit converts the realtek-otto watchdog driver to use the regmap API
> instead of direct mmio accesses. It replaces direct read/modify/write
> sequences with regmap functions and selects REGMAP_MMIO.
> 
>> diff --git a/drivers/watchdog/realtek_otto_wdt.c b/drivers/watchdog/realtek_otto_wdt.c
>> index 2c30ddd574c59..e5e9cb480f4f9 100644
>> --- a/drivers/watchdog/realtek_otto_wdt.c
>> +++ b/drivers/watchdog/realtek_otto_wdt.c
> [ ... ]
>> @@ -199,7 +189,7 @@ static int otto_wdt_restart(struct watchdog_device *wdev, unsigned long reboot_m
>>  
>>  	/* Configure for shortest timeout and wait for reset to occur */
>>  	v = FIELD_PREP(OTTO_WDT_CTRL_RST_MODE, reset_mode) | OTTO_WDT_CTRL_ENABLE;
>> -	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
>> +	regmap_write(ctrl->regmap, OTTO_WDT_REG_CTRL, v);
> 
> Could this regmap_write() cause a deadlock during system restart?
> 
> The restart handler is often called during system shutdown or kernel panic
> in an atomic context with local interrupts disabled. Since
> devm_regmap_init_mmio() configures the regmap to use a spinlock by default,
> if a panic occurs while another cpu holds the regmap lock (e.g., during
> a ping or timeout update) and that cpu is halted by smp_send_stop(), this
> regmap_write() could spin endlessly and prevent the system from rebooting.
> 
> Additionally, on preempt-rt kernels, the regmap spinlock becomes a sleepable
> rt_mutex, which could cause a sleeping in atomic context bug when acquired
> with interrupts disabled.
> 
>>  	mdelay(3 * otto_wdt_tick_ms(ctrl, 0));
>>

Hi Sander,

I hope it is alright if i CCd you for this as i am not an expert on watchdog stuff.
Wonna make sure this issue applies here before i proceed with the suggested solution
to add .disable_locking to regmap_config without understanding the consequences of it.

Best,
Rustam
