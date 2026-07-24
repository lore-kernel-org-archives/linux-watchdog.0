Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6445434F255
	for <linux-watchdog@vger.kernel.org>; Fri, 24 Jul 2026 03:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862157; cv=none; b=kb7cXk0ZLNSj7H/LgDe6pFN2W1PHjp9Aq4ckFwJYg0JInehjlFxo57VEtDW43YoanEuSWA+gGNMmFpDDa+4c9Pisn32zsxhaOkoWy5gN598SyUog6mLCcbVF1JWktWgVY/mdPV3RlhD7aMZkQPYyMKB7tIfj88JlNuMdGll4otM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862157; c=relaxed/simple;
	bh=smtf8VNOiQMzPOx2DVjKWqX6awaP+z2c9Z6pSOrWk4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HowZoO+ukvkOc3iLV18C9/FpA+T6KvVoAbz1BlAB4LIKBZ6zRo/tnnUUDxE/BHMu3KzRiRfuewgZ1Flb4rkqkY9MQvrzUpImMKoM6nZQhrpBA4fYI3iBuUUAa1hHKwBOVm2eY/uGjGYLOJlAHUKIY1NqThcqvBDq6R0J4k7qAZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwQmDEbz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwQmDEbz"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caea3f742bso17210975ad.0
        for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 20:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784862156; x=1785466956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UhdrzuAFVWOLh5OB3PTlI2JCVV55wYF4HPgrAV9GcOo=;
        b=DwQmDEbz1U51Jp3Q2OLu/Z9gh0jQk2UzwHUubTMNUtL84CbZC5SluXR4vPqNf/Sbz8
         HzaIA83lw9yhQYQQiYYqeSnNG9zdUXQ6vpcFR9AGh2a3uVmBUIiW1mKRcDuXjFMzVMx6
         owcG+DrTYV5qic4u6PXX7oVUXbg/oRuGhnffgFVCBxLGj2aftq9rX5btngAiv+7H3zA/
         yo9oy8BB5Pm5/UvP1SF0uuHiCh3qV4G7nD0KlKe/3cMgGTqvlIgtxrOmtJOksZ566VQc
         i7x5U+XUU3fdVY9vhv6QS7wdEktR5WXj5gjqI1uvrXNXbXKFLdDFd/ILRvCQ4WVYrYni
         mBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784862156; x=1785466956;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UhdrzuAFVWOLh5OB3PTlI2JCVV55wYF4HPgrAV9GcOo=;
        b=GCBMhj23dAF3nlOSgXkA65ntDHBjoSBLP3SVHv/iHssObRoVnTC1NmOlGCB6yNoTuE
         6BfcHKGKYbVGY/dxPhl2xs5Sx/Q/stjjkwMRncjHOp1xT+sTPeN4mrQltqHj7mH5uEVz
         faDl+ukj+gHpmSzrtPzBUGAntfA8TXvidPpSWyb2wPrKYUa6ZmEbs7cyOij39asDV9S3
         oEagRhnaIMm7JS18IMtTY+IFKshP+srwBEaihOSlkW1RfxHwcEOQh+r0X6ex+kN0zIxL
         Tr8XFksmAPD2k1oSHifpAejCkeWjMJJo2B0nFH8bKDM+mP0FVgLUmFRXCYod5TM3/HAQ
         aKTg==
X-Gm-Message-State: AOJu0YxwCv76IJm1GR1KxGyCktZurxtgjEzJ3voWCR67HzoLcVpBX3yP
	Mq790uarWLDeC0bDeQoXvaPlwn5rOsMooFX0EGR9bK4FGvPxi6SMagk9
X-Gm-Gg: AR+sD11Ay3ad4X139gaj5LR8LxNNaCTO+rYJq7ioa3vLVYci4FZzY64ZxTxaTtC/Qqg
	gGgcC9Qnbmx2iCaPnpchYL0Gt8t8r/OjJpsX9Uy8zt8549ST4nIvgJNV2Nxnd7zpCyQEwBQJ5HW
	26HaaRfx9lewX+2Xb/ONOcbBED2kJpfjZr1I7JQ/jVKpQK/l8y0pF7jQasDSXSHgGNMBDl5b43F
	wVQzQ4yhSY7Hb0q4qQq3RvPkxM5AhDWCTDdeTw5KXogKnJVeHcLMJafwV6wRAKSifaZwj/2Pjqf
	kFDeJSErawq3xWXqdB9R+YHxk457hgXKl8MkvXkfqE9Gdfjkzdancrhbg//qe2eNhttvv/EH95I
	Llrj+nDdm39UcnF+u2LrALtlK+p7ZprPoYGFObTtYWB1yn2EaAeCVpcAjlxMqd7mIKmuLhJEebU
	DvwucdCTUSiFbubnV0+J3WN02qD34BzHjN6ZMtPG9/8uS0Pp9Wol76KxWWsjLs
X-Received: by 2002:a17:90b:3d43:b0:389:8f6c:4d58 with SMTP id 98e67ed59e1d1-38ec6618585mr6340998a91.34.1784862155701;
        Thu, 23 Jul 2026 20:02:35 -0700 (PDT)
Received: from [172.19.1.48] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03b0f591sm731078a91.7.2026.07.23.20.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 20:02:35 -0700 (PDT)
Message-ID: <041218b1-4d7f-4fbe-ba0d-5d97bf0df6b5@gmail.com>
Date: Fri, 24 Jul 2026 11:02:32 +0800
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] watchdog: Add Nuvoton MA35D1 watchdog driver support
To: Guenter Roeck <linux@roeck-us.net>, sashiko-reviews@lists.linux.dev
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, robh@kernel.org
References: <20260723060755.1596858-1-zychennvt@gmail.com>
 <20260723060755.1596858-3-zychennvt@gmail.com>
 <20260723062030.B20F41F000E9@smtp.kernel.org>
 <a04cc256-4c60-4e92-b196-47aeed1d5453@roeck-us.net>
Content-Language: en-US
From: zychen <zychennvt@gmail.com>
In-Reply-To: <a04cc256-4c60-4e92-b196-47aeed1d5453@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Apologies for the broken formatting in my previous email due to a mail client configuration issue. Resending with proper inline formatting:

Guenter Roeck 於 2026/7/23 下午 10:07 寫道:
> On 7/22/26 23:20, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 9 potential issue(s) to consider:
>> - [High] The `ma35d1_wdt->dev` pointer is never initialized, leading to NULL pointer dereferences in logging functions.

Fix in v2. Switched to using wdt_dev->parent and direct device pointers for logging functions.Remove redundant ma35d1_wdt->dev.

>> - [High] Read-modify-write operations on REG_WDT_CTL inadvertently clear W1C (write-one-to-clear) status flags.

Not real.The W1C flags (IF/WKF) are only utilized by PM callbacks during the suspend/resume window for wake-up event handling. During runtime, clearing these flags via RMW in set_timeout causes no functional side-effects. Furthermore, RSTF is already consumed and cleared during probe().

>> - [High] Missing clock domain synchronization (`ma35d1_wdt_wait_sync`) after writes to `REG_WDT_CTL` can lead to dropped register writes.

Fix in v2.Add ma35d1_wdt_wait_sync() after writing WDTEN to REG_WDT_CTL in ma35d1_wdt_start().

>> - [High] Driver overwrites `wdt_dev->timeout`, breaking the software heartbeat extension.

Fix in v2

>> - [High] Missing cleanup for wake IRQ allocated by dev_pm_set_wake_irq(), leading to a memory leak and permanent device unbind/bind failures.

Fix in v2.switch to devm_pm_set_wake_irq() in v2.

>> - [High] The driver fails to check if the watchdog was already enabled by the bootloader, causing unexpected system reboots during boot.

Fix in v2.Added a check to set WDOG_HW_RUNNING when necessary.

>> - [Medium] Unsigned integer comparison against zero renders IRQ error handling dead code.

Fix in v2.Change the IRQ variable type to int in v2 to properly handle negative error codes.

>> - [Medium] Integer overflow in `target_ticks` calculation triggers unexpected system resets for large timeouts.

Fix in v2.Add a check to skip calculation for large timeouts.

>> - [Low] Unnecessary dependency: selects `MFD_SYSCON` without using it.

Fix in v2.remove select MFD_SYSCON.

> 
> Please fix or explain why the issues reported by Sashiko are not real.
> 
> Thanks,
> Guenter
> 

Regards,
Zi-Yu Chen
