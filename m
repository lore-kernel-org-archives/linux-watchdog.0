Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D2E351C2D
	for <linux-watchdog@vger.kernel.org>; Fri, 24 Jul 2026 02:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784861649; cv=none; b=iLzsX0mYnyNStlCiNtTvItH+MAbLHsyuwhgT1MB7SXFt6ez6MctyQyXEZCVA0p1UbsVVYJdMYtdbF6vRwLjEmBsXYtzzDqSEslqHACTalPckiZ2uRvNfm1vYkTKLw9rTOL8gyKiJLXqreiqKDMv4kr40hHbaLC8WbMUTHCQMT8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784861649; c=relaxed/simple;
	bh=3YNhJa3B7BJ+5/hGFL9dz3h9OwH3cAo/rRkf4mBqYck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGkPycoN1aLlv4CBM368DPWjYWTBPidP2DTQPxHWM8nAVRCSEaSb6YjDUpQTZjqplZ2HpzWi35V7sesAi1HGa2/amEKLaaGDFy4OVs523k79kRUT6vB1aRmpI75pMG7TQe3iecrCrMx75ZNZca+z8SgV+gJKb2Ep7NJ3hWwytUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oYLBfK4X; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYLBfK4X"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-848761b5897so845189b3a.3
        for <linux-watchdog@vger.kernel.org>; Thu, 23 Jul 2026 19:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784861646; x=1785466446; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lPCe44TL9Lu4Q6XqOnCQ1df/GtP84+ufX9r8RseyaR4=;
        b=oYLBfK4XIgQhxAUYYOk/xS2wM5lD+EDj99dAz2vsWUcPuABexuBt6yR/e6BhHb3/wF
         4unqI0tGjwrmninMsbWdh+KDoDZp2y8NYy5e83OjNYeYnzjqycGxyoN3I/qmyK09382P
         fnk2aUD0s6VCVrt111JnQSdS8zyosCQ+/qOHeUJp1PFKDiQG0f/zlBHQhgoct2WjU3py
         SGibogHymnziE62mnm/yPSvCnDkpx7gylE+0w8DqlmCq77rs4G0uc5sA/0JFjT8QJuwa
         LTUZxe8ffDcvLcJXGz+qiKDYgqnOwM31TrXuqXeI+qTzV6QCOGeyIGTirD8BhReL2uo6
         TtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784861646; x=1785466446;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lPCe44TL9Lu4Q6XqOnCQ1df/GtP84+ufX9r8RseyaR4=;
        b=ARrs3IKyuDYCHKUqTR9vranUCHNX8TtC2RNulHPFOfo4Ua29MG74oURqbDBpO1xwdc
         3khCdxmX2Kx/MqxpBH0pCbXw7ct/df0XiQjvOkcNF56gWYbdYE1GVeiclhdvSINlWwOH
         zFwVmCvcQ++jEUVYGf6RHAF3A0uphWrA3e/nM732HKMU6WZaoGG28YSIi2CjH3eE0jhj
         ah8jd3j87/p+gl1X7umpjt/dzVasjPvPABvXnPrMOR8lDfL40a/WI+ni2xWe7c0fYfGq
         oDiMUOa2YwTuEkbk6n7yd6imEUCoVbUDcovJ4KGkmefdgjpg50zfEiVXU+DKYWdlHVSW
         acCQ==
X-Gm-Message-State: AOJu0YzG70LSnHKxFMIXKJhKnGl8eltdqQHLcbnp3n33a4e7F79DJyNY
	5SYAU8laUzs2CZ69P+QJfuJL7b4zbLehg/z1GMVB1jHemBTKMG9NR/MyO0rg7w==
X-Gm-Gg: AR+sD125EkSj6MBBOLMIL9nAo7U82j9i8yEYVWm4i+usFr2frmoPQWZJiNkf6eBKgHs
	UP/DHZivurQtLbbOS/A8cq0i5PKSKLEeHaBInbcY3NecNBYV5YfeT0lEfvH2DBWLXEjl7/NHinb
	CC38WJPULt91KfIKa1VYjDP4+ka9qEbxRTF6H4tz+TNeB0EPApRz9Xn8d1xf+ZB8hnyB/OvHePI
	TyaqBDSLwtyIf+MISEsqmcXIPnIFFzabXyYvZWZKRmqizCXgq2Rz+uD6bjDOQQZUnSMUZKM60Cr
	meONRp6UiRwfhjoqX/F1w1ppPjfh2qTmN1NvHkU5nL5UMn4kpgRkw+KyLA5JYiszB/FdaHyGrPH
	5wQzPhuZyvDH3361+ik/BLobv815bJqb8JnDZG9V+hd4gywCS2Xg7FPq4HERRsqrFndNwUtQV0e
	kJkgfxEj8eH4pd121P0u7lkzsmOmGlz0rw1dXBQDUwAm70FLwqtw==
X-Received: by 2002:a05:6a00:230a:b0:845:4928:8655 with SMTP id d2e1a72fcca58-84e2bb3733cmr6297375b3a.39.1784861645606;
        Thu, 23 Jul 2026 19:54:05 -0700 (PDT)
Received: from [172.19.1.48] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e1757852dsm3919741b3a.28.2026.07.23.19.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 19:54:05 -0700 (PDT)
Message-ID: <1c930200-11b1-451d-a7a7-170b42aa30fa@gmail.com>
Date: Fri, 24 Jul 2026 10:54:01 +0800
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

Hi Guenter,

Guenter Roeck 於 2026/7/23 下午 10:07 寫道:
> On 7/22/26 23:20, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 9 potential issue(s) to consider:
>> - [High] The `ma35d1_wdt->dev` pointer is never initialized, leading to NULL pointer dereferences in logging functions.
Fix in v2. Switched to using wdt_dev->parent and direct device pointers for logging functions.Remove redundant ma35d1_wdt->dev>> - [High] Read-modify-write operations on REG_WDT_CTL inadvertently clear W1C (write-one-to-clear) status flags.
Not real.The W1C flags (IF/WKF) are only utilized by PM callbacks during the suspend/resume window for wake-up event handling. During runtime, clearing these flags via RMW in set_timeout causes no functional side-effects. Furthermore, RSTF is already consumed and cleared during probe().>> - [High] Missing clock domain synchronization (`ma35d1_wdt_wait_sync`) after writes to `REG_WDT_CTL` can lead to dropped register writes.
Fix in v2.Add ma35d1_wdt_wait_sync() after writing WDTEN to REG_WDT_CTL in ma35d1_wdt_start().>> - [High] Driver overwrites `wdt_dev->timeout`, breaking the software heartbeat extension.
Fix in v2>> - [High] Missing cleanup for wake IRQ allocated by dev_pm_set_wake_irq(), leading to a memory leak and permanent device unbind/bind failures.
Fix in v2.switch to devm_pm_set_wake_irq() in v2.>> - [High] The driver fails to check if the watchdog was already enabled by the bootloader, causing unexpected system reboots during boot.
Fix in v2.Added a check to set WDOG_HW_RUNNING when necessary.>> - [Medium] Unsigned integer comparison against zero renders IRQ error handling dead code.
Fix in v2.Change the IRQ variable type to int in v2 to properly handle negative error codes.>> - [Medium] Integer overflow in `target_ticks` calculation triggers unexpected system resets for large timeouts.
Fix in v2.Add a check to skip calculation for large timeouts.>> - [Low] Unnecessary dependency: selects `MFD_SYSCON` without using it.
Fix in v2.remove select MFD_SYSCON.
> 
> Please fix or explain why the issues reported by Sashiko are not real.
> 
> Thanks,
> Guenter
> 
Regards,
Zi-Yu Chen
