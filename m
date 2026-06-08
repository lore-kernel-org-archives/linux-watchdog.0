Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283D42D5925
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 20:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952026; cv=none; b=pe7d/pwuwQhBRFiOs1oHDy5IcNgiEIoAWB6cLLt9FsAuIR3hXpkAtBlbP5utkM0VF9Hy9hDKmXet2IbssiE6UhitudHYc1RALhSSuqNliLs5FMb53gHi/jyeA8KeHyAcv1Xeel7t3lRu0/zR+L6egQmPp6stNqn85Uaq4MJJYTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952026; c=relaxed/simple;
	bh=uWhdQhxUb0ixKXQ5yf+uJ2fAkJuETjA+Vy0T9O7nh4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuQSw2p8Eyy6NLRHNsf4ooNlO+dx0M5PjGaCg/M1KY3WfnIfNvSY3+St/Emetokzu/vedBsYxt88t6bk8mYRJxRdOlYs34bTRCzHUS6TEcJmawBg7qMi4uGKFY0uU1sHoU+2IUCSQIs6oU9Pd7QkliS8kwm4+nFivXDcds2ajfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5g5eTY3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5g5eTY3"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-842307473b5so3184596b3a.2
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 13:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780952024; x=1781556824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9F45RQtgrxadjt5ZYNUGBRSHL4GrTavmF6k6G6dNnjY=;
        b=f5g5eTY3dkkd/nXjVv+pWljNUwTIBheXPHs8C1Impj1zD4J0GLjoeiXpD6zDcvJqtX
         x3k0Zd23Pak6uxRnq/xwjkO/AzipzSpQGgl2Cl8OT4vGQvTv7juIuYIUxHg2w801RGjr
         9tFQxFvJ/SAX7KneRuqY0eL0RQNFnjPDyYa0Amnvz0h/vcHqrobQhs4XMkFsLlWenRlP
         2U2lT0uxKtcB+C6CCrux70J7GLlEPY0xqqiCshy6riYTFH7d6S/Wi20WAMs4UavsRXAR
         rAhA2HMN8+6fAjih2NymPiNiRIrytCycoz9toG2nXX0DjBOrN4Sb0deCHvh5JzBpNr4l
         RXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780952024; x=1781556824;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9F45RQtgrxadjt5ZYNUGBRSHL4GrTavmF6k6G6dNnjY=;
        b=l9YL3S4VXtxby9IcXrCA3xO/6prAzgJb+TwH7fY33CP+2jIqSitdsmL+JtC04+A+8f
         TQHHhxaoWO4eOEZy7T9YQsQvPKVWQX1fyxSpKbd8HFc3aV4F4PXDVRQJim8j2xvOQRnt
         z6FitNYjt4+RwWFhRJEb0f/w6256cw8a4o8m6VIlBoVI7N66eJ/1EC4l0tjxxSUycKy+
         dob6ZoUKmRsFeZn1iHviTaG4GPKEIvbFUPgAZ4GDf8YMeeV5dpnAqx266oE3TsWZzVzS
         gGvQ/1s7Nxkdp1ykL08rM1mXa3oJD3wRnc2Cd/Yo2ntuUENFlDRsSmnm9odNonlCkxTn
         gXqA==
X-Forwarded-Encrypted: i=1; AFNElJ9Xr0gkStSBQMWIv5O8wSOD6r5aQhjtiYWkBdH7EYgFEE/MAoTItCYBkJ0nLegR1POhEEQwa/DStLc037s8WA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzN4HCw1hr8rWSv7/pR3UgDQ157f6uvc8cFPSAcjVSmEwNQbJz8
	PcwOT7bx7O0JYvi62M6OQ08UpeG0FhvEo8QgpygcWdZ0jmzWrIcGKfN3
X-Gm-Gg: Acq92OH4RmZN5kKC6ykn4THmCMXlfrYErfKaqClQk3jHE4Z+5mZJiURuYJTvirEdBva
	WqdXGMHF9wjZatrCyS9PlvoZNJaiN786PvWvWn9hCq3w97xtESnRusAWwLfd/7N/XK2G2h9v2Jx
	UzLdK5LWpUmDKng/gUuDxV2pKomfwLNy/JVIGsxWEIsMCOWYm+TYby4SNsUjMKTBd2Dd1xY3w+w
	udnz8tsBFRBBX1IlfzVw/5TriV7lBsiWQWHH59WGE+ujkzPgX0j6vmTg29XjypjGfVostsX9ZSW
	B1nGkaObPfPt0NJZh2DnpdHGD/6E6XznGJOYD6+qT6OJzDmEF7rjaRzUthYPM/Q8SsL/0IIwpXd
	7izU+RGKhv8ze0E2OkRR+880LlsKxY0kJgb7gCuKOYu5YL4kPKtFySqxAVqNXHYitANK2PMACM7
	4ztS/1K1DTtGsZTSwHec/waTRNMIOI3cP7H+N1vAZTnWDHl3AL69nFvAfoAk4FV1GmKtvORV984
	jsrr//pRxY=
X-Received: by 2002:a05:6a00:1c8f:b0:842:4af7:ab11 with SMTP id d2e1a72fcca58-842b0d5ee61mr18147987b3a.13.1780952024522;
        Mon, 08 Jun 2026 13:53:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828cf783sm19543499b3a.40.2026.06.08.13.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 13:53:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fc997f81-b7fc-4b8d-923e-0b2fe0e609e9@roeck-us.net>
Date: Mon, 8 Jun 2026 13:53:42 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] watchdog: sama5d4_wdt: Fix WDDIS handling for
 SAM9X60 and SAMA7G5
To: Balakrishnan.S@microchip.com, linux-watchdog@vger.kernel.org
Cc: wim@linux-watchdog.org, alexandre.belloni@bootlin.com,
 andrei.simion@microchip.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260302113310.133989-1-balakrishnan.s@microchip.com>
 <322c623a-0da8-4821-b0d9-ba2c96bf62ca@microchip.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <322c623a-0da8-4821-b0d9-ba2c96bf62ca@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 5/27/26 06:04, Balakrishnan.S@microchip.com wrote:
> Hi Wim,
> 
> Gentle ping — both patches have been reviewed. Could this be queued for
> the next cycle?
> 

Please check linux-next to determine if patches are queued for the next
commit window.

Thanks,
Guenter

> Thanks,
> Balakrishnan
> 
> On 02/03/26 5:03 pm, Balakrishnan Sambath wrote:
>> The sama5d4_wdt driver hardcodes AT91_WDT_WDDIS (bit 15) for WDDIS
>> detection, which is incorrect for SAM9X60 and SAMA7G5 that use bit 12
>> (AT91_SAM9X60_WDDIS). This series fixes the detection by introducing
>> a per-device wddis_mask and documents the bit position difference in
>> the header.
>>
>> Changes in v2:
>> - Reorder patches: fix first, documentation second
>> - Drop patch 3/3, not needed with wddis_mask approach
>> - Keep AT91_SAM9X60_* register names, drop _LEGACY/_MODERN naming
>> - Limit header changes to WDDIS comments and datasheet references
>>
>> Balakrishnan Sambath (2):
>>     watchdog: sama5d4_wdt: Fix WDDIS detection on SAM9X60 and SAMA7G5
>>     watchdog: at91sam9_wdt.h: Document WDDIS bit position per SoC family
>>
>>    drivers/watchdog/at91sam9_wdt.h |  6 +++--
>>    drivers/watchdog/sama5d4_wdt.c  | 48 +++++++++++++++------------------
>>    2 files changed, 25 insertions(+), 29 deletions(-)
>>
> 

