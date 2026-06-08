Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80E53B27D8
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958127; cv=none; b=mcezLUOVo4xS4PEvZKZWUF3jyo0SiHiaPU3jst9XqDLWjHLlo3OWIpWLV8jo/EDx+AJB8QPw9yQcr5fi2amibw4pNLpd4OPWl99SSxlQh38XkDhFYrlcpkJiEIjqqJPwafcIMxnHeI4OHJTb/U3jOhOtY9N4G/CpCkR4cclTowk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958127; c=relaxed/simple;
	bh=MsoicAw6g+MUWVfhGn3r+J6ffrFHjPzUsQRAgq+1dos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dib4RtgrEwz7o3GEhLAYU/Zq1nRJcW6jyPbZnrpHlk/LD16USzhfWed2M0D6xxO5Nk0aSX8sIiRvIucuqHTH02KX4cX9TuuGS4gbSlGrNqvnTLOXPfi4j9nqPp1N/7CvevZvNU+MWuGZXe85XLv+a/n5hIoS9P3od00UnhiLZDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdDCboZD; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdDCboZD"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8423efad617so2656073b3a.0
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 15:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780958126; x=1781562926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=g3D88PzOddsT6UaoAh3azSKu29/ugzAUVSvz52SY6Gg=;
        b=VdDCboZDSGLyLkI4IxpJjSia76RyAspZ8abRbVy4F/O6Qvds+t2XTOVvIoHoHkh7nD
         Ot3PA9KiS7tBLbrPZnKDTlxt6l+sHUGgbnQip7y4YHIHuTIItPYlTleiCKon63s/EUgq
         hklb/M198VeXpfgfudtqqBSx0rJDqZ5F/R5ZAbVVUulvLIaVUgaGcwxVFY4EyrY0g+mO
         rKLy+zkPDYpstF8dIw8mNWEpWzixFJhGq8n2d8Iv1KwRTkplgOI3U8dTUb3YAMKlmGf3
         SoxNp8a82GEkfBdIeJnhP8qUYC0SFHQWE2fhB4ZPS4HW8wz1LWOvAfbYpvtmAP73f9QC
         N9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780958126; x=1781562926;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3D88PzOddsT6UaoAh3azSKu29/ugzAUVSvz52SY6Gg=;
        b=YuiCvx56xKrKhD8gDllZSMzHhIVh3zO7x1lVbMpkAebEH092Z7dgDbzIbYfklZ9TAk
         jh9We5EdIwBoFOUIaGA5iUManL0KeLz4X642zIViHR0TIp/SsrrwprTvDrJzo9pY7tEa
         gtPHvMa6LHVGBL5rD8wbN6J62kqE+s73QTrH56EcTgRJvrlPn+hMgcQpK+IwKr7MRyLN
         Tk0zdHPJ4W8kxDUgb59sArSIoLXe29yFJCcKOv5Q8QP5L76qMhjwhDvqDq/zzwYBlkAa
         XX310uu99fPS/W0e4EQZYuzv0JNKWjaSjhGPZl6QNiZC//abLF0fVhgFFR34BROCy0w4
         OaOw==
X-Forwarded-Encrypted: i=1; AFNElJ+fM4UKY9WCaXnLp+ffgahjXzpLam2zdAEOA3HYWv2akLIQSSaK/9SaGEYlk1+jfzskwH/w+U27TdH7ZIRxmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yww6PmLG1bcYyH0QsPQkPJCc6E7Gf2QZNK+2wCpSPPmB2zEBhvA
	YQzFMBfTacJr1mHuzFlmzaiJZ9pITNwN3p9+cLKsZb85fpmFhtsXxfFt
X-Gm-Gg: Acq92OHvQtZ2E45a5z+ZzuMCpxfgY3So66np51POyj8WNVHFi9ufABqR3G8bnSbQFgQ
	c+m0kiCBDEoIfOJCzBlUfAW/i19/4ac9O3E4ZNt+ZKZvy8amyMVFM05cNwAUsvb39uTpgjFu0wE
	HFT00ZqVFQUU3rV5dG+fkvBNQGu7epv66uQAOcoKqLgElCFJB+cyzyQJ9e7NiwnVd1Ci+nPeoyp
	t8q2lzXUWW0nxVuUPKO8NXPbrIjuYDU+Y693vGHgVY4MAEibatcNbqZXkU+jns5hmm0lhIOrXlq
	PMt4fjJjYw9XT8H+lBlryKyTfzbhkhptN6EciOjWEPxn9QiWRHLIIUS2cbd4FUqE8RDtD3hLTX8
	55D6LkVA+fK35oZ1nKP5UQis9slFdFdQQSjSbbEHADKM67DrEiTJ0OxmGgJtwYHjGbWm1pdWg1O
	7S5hG7tYJxmTWpV/vyM0FXKSq5OPV4PIFh1qUFQSQS/CtEIQ7XamtEacKZRCqLXLO74CHxeY0Kr
	UAJo/n1Y9o=
X-Received: by 2002:a05:6a00:9292:b0:842:688f:307f with SMTP id d2e1a72fcca58-842b0f51a52mr17791879b3a.28.1780958126098;
        Mon, 08 Jun 2026 15:35:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828836efsm18887679b3a.38.2026.06.08.15.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 15:35:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <db3d05e3-e7c6-46bb-9a56-e45970652f14@roeck-us.net>
Date: Mon, 8 Jun 2026 15:35:24 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/3] watchdog: sama5d4: fix shared IRQ and hardcoded
 timeout issues
To: Rosen Penev <rosenp@gmail.com>, linux-watchdog@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 "moderated list:ARM/Microchip (AT91) SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260608200933.18669-1-rosenp@gmail.com>
 <20260608200933.18669-2-rosenp@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260608200933.18669-2-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/8/26 13:09, Rosen Penev wrote:
> Fix three pre-existing issues in the sama5d4 watchdog driver:
> 
> 1. Unsafe IRQF_SHARED | IRQF_NO_SUSPEND combination: The watchdog
>     interrupt is a dedicated peripheral line, not shared with other
>     devices.
> 

Not addressed in this patch, and can not be addressed without testing
on real hardware. We'll have to leave that alone.

> 2. Unconditional IRQ_HANDLED on shared line: The handler returned
>     IRQ_HANDLED even when the status register indicated no watchdog
>     interrupt was pending.  Return IRQ_NONE in that case so the kernel
>     can properly detect spurious interrupts on the line.
> 
> 3. Hardcoded 16-second timeout: sama5d4_wdt_init() unconditionally
>     used WDT_DEFAULT_TIMEOUT (16s) for the hardware timeout, ignoring
>     any timeout configured via device tree (watchdog_init_timeout) or
>     userspace.  Pass wdd->timeout to sama5d4_wdt_init() so the
>     configured timeout is honored during probe and resume.
> 
While I think this is a real problem, changing the code would require
testing on real hardware. We'll have to leave this alone.

Please resubmit, only fixing issue 2). Please list the other problems as
explicitly not fixed in the summary e-mail.

This also applies to the new problem regarding AT91_WDT_WDDIS vs.
AT91_SAM9X60_WDDIS. If that is a real problem, it can only be fixed
by someone with access to hardware and with chip knowledge.

Besides that, I would suggest to re-order the patches.
Patch 3 (the null pointer fix) should be first, followed by this patch.
Patch 2 should be last.

Thanks,
Guenter

