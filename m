Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFE9416122
	for <linux-watchdog@vger.kernel.org>; Tue,  7 Jul 2026 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430904; cv=none; b=G+OOh4Kz8NMTi+gZWTImCJK+oIn6f+rVuo1i5widH+HFcbMrWO/BLOOEycjc0ApUeFMGtucDRaNtTfHy/RBjJf1iUouh1LFmpqEP1B5uGT83srHK4N2lexuvdLVPQOAsOTJg5XPD8XMdpIly6f3wplzKsnkk6a2pqb4jSNzg96k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430904; c=relaxed/simple;
	bh=GUuiQOG9+dJw2/ug6wX0oPkSVHHlmeMWSyB3Vvap0b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMnOUesn29wxyJJQ2dpgrZVJtCYzYaU3FjYH6z6nc0VEeOTKV8Y7jNtAzQ6x8aciPGu8PnnfG/68BTjcaFIIEr8PaQvCQKUlLXBdsRpntCjEYyN8hT4MkuL61CzzTmqeWJQRngr60cBYr+i2+rVJvfsC3QwhX1MYCrAVSds7HvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2rdgeHV; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2rdgeHV"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8423f236418so2792313b3a.1
        for <linux-watchdog@vger.kernel.org>; Tue, 07 Jul 2026 06:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783430902; x=1784035702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y5vy5rWa1u4o3UJ3ZSFBIPvOs5MLOsGN3eJNyAvcgp0=;
        b=i2rdgeHVli/tNre43lQkp05mHGwUSAByNhvMRwBzpnuM51hX59SneOVHw+ofYnuKyR
         NYSASWb5wByXRB0q6UyI2OtVYe0LlZuP8rwVO5oCON4PJ7PVGrdMWH4U9sXxdCbTiJyS
         YjtzDrQZD7/DOs0XzwYeoh5fpXvOEvf3Qe49nGd+qrJoBvn/wKAlUwH9aQyIQKDYA1E3
         zonyJZnr5gbfr6xL8Po9UWza/D7TsXeZdUnAEm/4AWr2kBAon9Vhhn4qBwUtwCy9OdPb
         0RN2KakVSSgXxhrDeXBQTLvX2M5woaYHYRvJ9pHxglhVM8kZOD6MU7oO1vbLngfgxX9B
         vMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783430902; x=1784035702;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y5vy5rWa1u4o3UJ3ZSFBIPvOs5MLOsGN3eJNyAvcgp0=;
        b=HLTUDGw0WDgEX3dWSEyMYLnE/NhhZR932DBb7m3FFWdlrdQ6i6mp2ViC0j53g0XElJ
         IU+oUAreReg8p5d1RGAxVVnd4OYuueOEBj5fF2elLFFaAPxvhKywpueNKlJLiBdsWhY6
         5wSdrig55XQlI35nIKPGde7uoKB5YONI4iGvOpnO20n71dGWVdWyJhUFNlfGCu6klpLC
         yIh1Zze4Yeb0iO5jYqkcUpJeLEbNgyiTaZBQCMJjpkSYG03fOKLJjNs7lgqdrDYSpimB
         Vjna39w22d8emXutNw1xqCac9QilQQCLvzmTaLPTorSVfwHYfb865clKRN/tDfafBMB9
         gmHg==
X-Gm-Message-State: AOJu0YyxxASbMmLNeS/aM4cg09+PPT/ZxR79d1whVdUndA3a7bvyeuXX
	KefT6dMoiWmePnjK+Dydoh/4tTpGeHMKiFt58niNoZb9kwFZi6VO4Mev
X-Gm-Gg: AfdE7cnLM17K2m0p2l6siKG3UZY8ojGIwU6StmtnlbeDy8Rdh1s8MqBDW3wyRKT5NF3
	Y2hbR6Icnrjk5E4/sM6WRE2/W2ZG/UxNXW7xHznOFWIGElQXMc9h4vvnYj+G94j3q17XWFk52Lo
	sUXgADdMaCW6DHIAp3IwH9vNcWh44Yxq7rt97uZaD86aMfDGeBTKLhXjwk19Laiqky4NcYrVqy+
	5fmz+F8DrZ37/C2MPoSmNa2SUoeYCCVJp53tvBusa+VoC2J0heEunEyrGgOOq64rWiW9MAqnaa5
	vU6Nv0G64tzKFhLrj4UzUsPUkNK8eE/6BvVmSWblBFX6X9sE98RThlKJDRWAdgFO/9KTCyRga+N
	fvbOngaKMbqwyYXCJWa/PLPlzAvtTuxXPnNO+PmzX/TdSYmE9tse9JJea7jSCsGLyXtAflnwHg8
	5NjVJZzSIZeIlp/Fgh58+wsoIjawxIWqexk3tLlpoIqcYVpnWe3FO5ngSVV45syw==
X-Received: by 2002:aa7:88ce:0:b0:847:8d2d:713c with SMTP id d2e1a72fcca58-84826e76a7amr4573614b3a.50.1783430901655;
        Tue, 07 Jul 2026 06:28:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d49614sm5467697b3a.35.2026.07.07.06.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 06:28:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <815d52b8-324f-4fa5-9470-d60f79546366@roeck-us.net>
Date: Tue, 7 Jul 2026 06:28:19 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for
 running chip on boot
To: Paul Louvel <paul.louvel@bootlin.com>, sashiko-reviews@lists.linux.dev
Cc: linux-watchdog@vger.kernel.org
References: <20260706-w83627hf_wdt-nct6126d-v3-0-fa5ad8d486bc@bootlin.com>
 <20260706-w83627hf_wdt-nct6126d-v3-2-fa5ad8d486bc@bootlin.com>
 <20260706104010.A345B1F000E9@smtp.kernel.org>
 <DJRG1B5OZRQF.3TGMTYKZF4XL8@bootlin.com>
 <f598a05b-5d91-484d-a637-e092950a6f47@roeck-us.net>
 <DJRLRNRML483.3ZTW07FZBRFW@bootlin.com>
 <5e441e3a-27ce-4f46-abf4-fd6246727cb6@roeck-us.net>
 <DJRTDK0H5R1Q.32FU59ADLZD6E@bootlin.com>
 <a20d8c37-0d46-489b-aa8c-af927a2c552c@roeck-us.net>
 <DJS68HQS83G4.38Z406G5WD8NQ@bootlin.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <DJS68HQS83G4.38Z406G5WD8NQ@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/7/26 00:47, Paul Louvel wrote:
> On Mon Jul 6, 2026 at 11:48 PM CEST, Guenter Roeck wrote:
>> On 7/6/26 14:42, Paul Louvel wrote:
>>> On Mon Jul 6, 2026 at 6:12 PM CEST, Guenter Roeck wrote:
>>>> On 7/6/26 08:44, Paul Louvel wrote:
>>>>> On Mon Jul 6, 2026 at 4:22 PM CEST, Guenter Roeck wrote:
>>>>>> On 7/6/26 04:15, Paul Louvel wrote:
>>>>>>> On Mon Jul 6, 2026 at 12:40 PM CEST, sashiko-bot wrote:
>>>>>>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>>>>>>> - [High] Removing the manual hardware timeout refresh while still unconditionally switching the hardware timer base from minutes to seconds drastically truncates the remaining timeout if the BIOS originally configured it in minutes, risking unexpected system reboots.
>>>>>>>> --
>>>>>>>>
>>>>>>>> commit 0014048ec369e2a09098aa033aeb725449e2fd67
>>>>>>>> Author: Paul Louvel <paul.louvel@bootlin.com>
>>>>>>>>
>>>>>>>> watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for running chip on boot
>>>>>>>>
>>>>>>>> This patch updates the w83627hf watchdog driver to rely on the watchdog
>>>>>>>> core's WDOG_HW_RUNNING flag to keep a running watchdog alive during boot.
>>>>>>>> It replaces the previous behavior of manually issuing a single keepalive
>>>>>>>> during initialization.
>>>>>>>>
>>>>>>>>> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
>>>>>>>>> --- a/drivers/watchdog/w83627hf_wdt.c
>>>>>>>>> +++ b/drivers/watchdog/w83627hf_wdt.c
>>>>>>>> [ ... ]
>>>>>>>>> @@ -241,9 +241,8 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
>>>>>>>>>      			pr_warn("Stopping previously enabled watchdog until userland kicks in\n");
>>>>>>>>>      			superio_outb(cr_wdt_timeout, 0);
>>>>>>>>>      		} else {
>>>>>>>>> -			pr_info("Watchdog already running. Resetting timeout to %d sec\n",
>>>>>>>>> -				wdog->timeout);
>>>>>>>>> -			superio_outb(cr_wdt_timeout, wdog->timeout);
>>>>>>>>> +			pr_info("Watchdog already running.\n");
>>>>>>>>> +			set_bit(WDOG_HW_RUNNING, &wdog->status);
>>>>>>>>>      		}
>>>>>>>>>      	}
>>>>>>>>>      
>>>>>>>>
>>>>>>>> [Severity: High]
>>>>>>>> Does removing this explicit timeout reset create a risk of unexpected reboots?
>>>>>>>>
>>>>>>>> If the BIOS originally configured the watchdog with a timeout in minutes
>>>>>>>> (for example, a timeout of 5 minutes), the hardware counter cr_wdt_timeout
>>>>>>>> will hold the value 5.
>>>>>>>
>>>>>>> First of all, the driver does not support minute mode for now.
>>>>>>
>>>>>> The above feedback doesn't claim otherwise. The BIOS may still have configured
>>>>>> the timeout to 5 minutes.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Because this patch removes the explicit write of wdog->timeout (which is
>>>>>>>> typically 60) to cr_wdt_timeout, the counter retains the raw value 5.
>>>>>>>> Just after this block in w83627hf_init(), the driver unconditionally
>>>>>>>> switches the timebase to seconds:
>>>>>>>>
>>>>>>>> w83627hf_init() {
>>>>>>>>         ...
>>>>>>>>         /* set second mode & disable keyboard turning off watchdog */
>>>>>>>>         t = superio_inb(cr_wdt_control) & ~0x0C;
>>>>>>>>         superio_outb(cr_wdt_control, t);
>>>>>>>>         ...
>>>>>>>> }
>>>>>>>>
>>>>>>>> This immediately shrinks the remaining timeout from 5 minutes to 5 seconds.
>>>>>>>
>>>>>>> True, but in those 5 seconds, the watchdog core will kick the watchdog
>>>>>>> immediately. by calling start(), and thus refreshing the watchdog to 60 seconds.
>>>>>>
>>>>>> ... unless below.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> If the watchdog core's kworker is delayed, or if the system is configured
>>>>>
>>>>>
>>>>>
>>>>>>>> not to ping the watchdog before user space takes over, could this unusually
>>>>>>>> short timeout cause the system to reboot unexpectedly during early boot?
>>>>>>>
>>>>>>> Yes, but expected. If WATCHDOG is enabled, then WATCHDOG_HANDLE_BOOT_ENABLED is
>>>>>>> enabled by default unless explicitly disabled when configuring the kernel.
>>>>>>>
>>>>>>
>>>>>> It is still an unexpected and undocumented change in behavior. Previously
>>>>>> in that situation the watchdog timeout would happen much later and give
>>>>>> user space time to start the watchdog daemon. This is no longer the case.
>>>>>
>>>>> Do you mean that, in the case WATCHDOG_HANDLE_BOOT_ENABLED is disabled, the
>>>>> driver now doesn't refresh the watchdog, this is unexpected ? I was relying on
>>>>> the fact that this entry is enabled by default.
>>>>
>>>> It can be disabled with a configuration option, and with a module parameter.
>>>>
>>>>> In this case, should the driver refresh the watchdog itself, and set the
>>>>> WDOG_HW_RUNNING bit (for the added feature that it does it repeatedly) ?
>>>>> Or document the fact that the driver will not refresh the watchdog if
>>>>> WATCHDOG_HANDLE_BOOT_ENABLED is disabled ?
>>>>>
>>>>
>>>> The difference is that the timeout used to be 60 seconds, or whatever the
>>>> default driver timeout is set to. If the BIOS enables the hardware timeout
>>>> and sets it to <n> minutes, your patch changes that to <n> seconds. That
>>>> is unexpected.
>>>
>>> The default driver timeout is set to 60 seconds. I do not understand your point.
>>> If the BIOS enables the hardware timeout and sets it to <n> minutes, without my
>>> patch, the driver would still refresh the watchdog to <n> seconds (60 actually),
>>> with "superio_outb(cr_wdt_timeout, wdog->timeout);". It forces second mode in
>>> the control register anyway, and the driver has no way to know the previously
>>> set timeout.
>>> The only difference I see is that it does it immediately and does not rely on
>>> the core to do it. It also do it only code.
>>> Maybe I do not see something here.
>>>
>>
>> Please provide the data path showing how the watchdog core sets the timeout
>> to 60 seconds if WATCHDOG_HANDLE_BOOT_ENABLED is not enabled.
> 
> If WATCHDOG_HANDLE_BOOT_ENABLED is not enabled, then I understand the issue.
> Would an additional check at compile time be sufficient ?
> 
> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
> index 27ef1cce3a14..c6d470be62a8 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
> @@ -242,7 +242,11 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
>                          superio_outb(cr_wdt_timeout, 0);
>                  } else {
>                          pr_info("Watchdog already running.\n");
> +#ifdef CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED
>                          set_bit(WDOG_HW_RUNNING, &wdog->status);
> +#else
> +                       superio_outb(cr_wdt_timeout, wdog->timeout);
> +#endif
>                  }
>          }
> 
No, because "handle boot enabled" can be disabled with a module parameter.

Why do you insist to dropping superio_outb() instead of just keeping it ?

Guenter

