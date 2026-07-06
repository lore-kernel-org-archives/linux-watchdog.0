Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C84381E95
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354374; cv=none; b=NGM2GIjaihGdS9xBB4sdgBmuIJlvmiE/uo66f+I2H4fOucWaXryobYsmX5ghSEZOonf0SOQn9fcmNF7ubCi8ORXpNjkibSbAMYK0zLgobQYjfS53h14XMc9hYXnPbpziaKchfoaAPeYKh7AaXR4WeNLT4xRE5BKHZ01DUuQOvpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354374; c=relaxed/simple;
	bh=Npeg3cmxoXu2sGr1sxIasdlkRmLOZKvQWfzGozOJjwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aTpTve1jb7JdMQjHpia89rTHh+ptoXYWaXiIWcPpJddliZuxj70TPzmn6/kjNbGdVHZp2X3doXQtrBFMisSo/QQSTVUD4631T3V43l3QyZoKvcNkiDr8LD1lUAgMLSgCMbbzhZXjs21zfOCiuX/JvtijbayeLnts8tGMnGaisVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcZcHF5L; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcZcHF5L"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c88cc025f54so2106144a12.1
        for <linux-watchdog@vger.kernel.org>; Mon, 06 Jul 2026 09:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783354372; x=1783959172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Nc6xuVu7x5xIlwRDKJdB2OMK+PJct33UwNlXEKxeZwI=;
        b=RcZcHF5LMvQBmUrQm+JREdVEVfOncjO90uw2A/pdysljFmMNlezsw5As9C4hCDgHnL
         SnXa8bIs5oxj7H9UHQ6Fo75R0htUzs8rcq6GJZfpuIj5wKnUPhQeKUYDCZOfaDjahetL
         KogFzqZyKgXyshBszeWBK6rrUr1vIX8KgP6g4VBHFEM3nMY2Dg3td/aw1Jt0u2UG6CeT
         vi4ydz6CPFxZH+I9Oqz6cqAIoxpe6NMO/pl8qwsXACR6xSfAbrz4ahayxhORKy4zL7tA
         ZBtkurHhWL0IPgjAzducQF5lCYXkknLjdBYef2r05eNtrFKemqt5GlRdL3GOEsAYzyQr
         DJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783354372; x=1783959172;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nc6xuVu7x5xIlwRDKJdB2OMK+PJct33UwNlXEKxeZwI=;
        b=LR9PpCDM92OJ87hFISBn8hN8XqGkilc37RcjsvEKSR6vBZsrXT4nyyU4UHXy5WRTn4
         VD54M0jDEndC9B7rMCi8/s0VOd5cJaHZpi5WliiRC+5XrWJD08wtISrnB6gv2rdKN4Oo
         fnL24/Ps+NxCPJNDwsGsqkKIUQGFViZtAT0qy3ll0k8gTov24+pfK0B8f8l2j9JuqN2W
         gqZcEzf1MD/HYSvozAkzGg4eaF10E65f8MHixESKQRGlgLrwZH+936C9wnVbsh5RrgHb
         4kEm7D6/+Ic/emUv2HVZtEo8RupNDh/3/6bmqtTRnMIcHG7v+gBfty/Njc1GRilDFrzA
         bChQ==
X-Gm-Message-State: AOJu0YzJ9x104ORC3fSpu7G/05BWaYdWkQFk8S6dULB5T8dZLFDiDqI2
	sIaWos3NDcVdXp25CTaGjrMikbMcbtYL4+MDYQQcAeEwZug8p3/r5g+C
X-Gm-Gg: AfdE7cniPOpkvCspTT+VznCjxPsv9qxjFtKF7ox6QDfUeE/TC7WZAJtefMWM8sC/NDo
	5eBxqQ3L5Nf/+xTC7MwLgr8u/mFOYcu1Cck09//wYv3lpvNsJlEWOvEKsP52xzYwfws53hvMaK6
	V/cxRflpElQidKq0y5NMhCrbjWIZSbQJP0jdeOnIIsHXIKXjL85yPfDJvqKR+b5tJgpH/PgBB1b
	V1KGeM0h7DPumvICJmRKd0bc6y2bapcd7/I2P/WmLf59+H9y3mUyJ8PjAUyJa331AnakR83QrsC
	8GzSe880eKyUhnTAlZ8FJZGK1IGD/+F3fpsXFOv0NyJfBc9tvHAg58NgIgFVjk6ijEsTlybooh7
	b1lQzcVESqydObiJywSAlu/bKg1+T9v8+4BxPVgsybPoMMONiMnrNfd4JAkhsa5KfNW1wVfUf5S
	4oxZV71aEyT+dZSVeRLCowqPw7QFYlbgLexDT+Ywv0+nRDT6ruuQmIwk5V23FtiQ==
X-Received: by 2002:a05:6300:2203:b0:3b4:61f:1fec with SMTP id adf61e73a8af0-3c08ed6fb6amr1472180637.2.1783354371258;
        Mon, 06 Jul 2026 09:12:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e921d28d9sm6239956a12.24.2026.07.06.09.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 09:12:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5e441e3a-27ce-4f46-abf4-fd6246727cb6@roeck-us.net>
Date: Mon, 6 Jul 2026 09:12:49 -0700
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <DJRLRNRML483.3ZTW07FZBRFW@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/6/26 08:44, Paul Louvel wrote:
> On Mon Jul 6, 2026 at 4:22 PM CEST, Guenter Roeck wrote:
>> On 7/6/26 04:15, Paul Louvel wrote:
>>> On Mon Jul 6, 2026 at 12:40 PM CEST, sashiko-bot wrote:
>>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>>> - [High] Removing the manual hardware timeout refresh while still unconditionally switching the hardware timer base from minutes to seconds drastically truncates the remaining timeout if the BIOS originally configured it in minutes, risking unexpected system reboots.
>>>> --
>>>>
>>>> commit 0014048ec369e2a09098aa033aeb725449e2fd67
>>>> Author: Paul Louvel <paul.louvel@bootlin.com>
>>>>
>>>> watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for running chip on boot
>>>>
>>>> This patch updates the w83627hf watchdog driver to rely on the watchdog
>>>> core's WDOG_HW_RUNNING flag to keep a running watchdog alive during boot.
>>>> It replaces the previous behavior of manually issuing a single keepalive
>>>> during initialization.
>>>>
>>>>> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
>>>>> --- a/drivers/watchdog/w83627hf_wdt.c
>>>>> +++ b/drivers/watchdog/w83627hf_wdt.c
>>>> [ ... ]
>>>>> @@ -241,9 +241,8 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
>>>>>    			pr_warn("Stopping previously enabled watchdog until userland kicks in\n");
>>>>>    			superio_outb(cr_wdt_timeout, 0);
>>>>>    		} else {
>>>>> -			pr_info("Watchdog already running. Resetting timeout to %d sec\n",
>>>>> -				wdog->timeout);
>>>>> -			superio_outb(cr_wdt_timeout, wdog->timeout);
>>>>> +			pr_info("Watchdog already running.\n");
>>>>> +			set_bit(WDOG_HW_RUNNING, &wdog->status);
>>>>>    		}
>>>>>    	}
>>>>>    
>>>>
>>>> [Severity: High]
>>>> Does removing this explicit timeout reset create a risk of unexpected reboots?
>>>>
>>>> If the BIOS originally configured the watchdog with a timeout in minutes
>>>> (for example, a timeout of 5 minutes), the hardware counter cr_wdt_timeout
>>>> will hold the value 5.
>>>
>>> First of all, the driver does not support minute mode for now.
>>
>> The above feedback doesn't claim otherwise. The BIOS may still have configured
>> the timeout to 5 minutes.
>>
>>>
>>>>
>>>> Because this patch removes the explicit write of wdog->timeout (which is
>>>> typically 60) to cr_wdt_timeout, the counter retains the raw value 5.
>>>> Just after this block in w83627hf_init(), the driver unconditionally
>>>> switches the timebase to seconds:
>>>>
>>>> w83627hf_init() {
>>>>       ...
>>>>       /* set second mode & disable keyboard turning off watchdog */
>>>>       t = superio_inb(cr_wdt_control) & ~0x0C;
>>>>       superio_outb(cr_wdt_control, t);
>>>>       ...
>>>> }
>>>>
>>>> This immediately shrinks the remaining timeout from 5 minutes to 5 seconds.
>>>
>>> True, but in those 5 seconds, the watchdog core will kick the watchdog
>>> immediately. by calling start(), and thus refreshing the watchdog to 60 seconds.
>>
>> ... unless below.
>>
>>>
>>>>
>>>> If the watchdog core's kworker is delayed, or if the system is configured
> 
> 
> 
>>>> not to ping the watchdog before user space takes over, could this unusually
>>>> short timeout cause the system to reboot unexpectedly during early boot?
>>>
>>> Yes, but expected. If WATCHDOG is enabled, then WATCHDOG_HANDLE_BOOT_ENABLED is
>>> enabled by default unless explicitly disabled when configuring the kernel.
>>>
>>
>> It is still an unexpected and undocumented change in behavior. Previously
>> in that situation the watchdog timeout would happen much later and give
>> user space time to start the watchdog daemon. This is no longer the case.
> 
> Do you mean that, in the case WATCHDOG_HANDLE_BOOT_ENABLED is disabled, the
> driver now doesn't refresh the watchdog, this is unexpected ? I was relying on
> the fact that this entry is enabled by default.

It can be disabled with a configuration option, and with a module parameter.

> In this case, should the driver refresh the watchdog itself, and set the
> WDOG_HW_RUNNING bit (for the added feature that it does it repeatedly) ?
> Or document the fact that the driver will not refresh the watchdog if
> WATCHDOG_HANDLE_BOOT_ENABLED is disabled ?
> 

The difference is that the timeout used to be 60 seconds, or whatever the
default driver timeout is set to. If the BIOS enables the hardware timeout
and sets it to <n> minutes, your patch changes that to <n> seconds. That
is unexpected.

I see no reason to drop "superio_outb(cr_wdt_timeout, wdog->timeout);"
in your patch. Keeping it would retain existing behavior. Changing that
is unacceptable unless you provide a really good reason for it that I
currently can not see.

Thanks,
Guenter


	
