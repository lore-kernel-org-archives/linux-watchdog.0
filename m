Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC833D9026
	for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 22:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785452131; cv=none; b=AC/CMIzdgNv5I8zixZlzi9cB3R/U8KmrV/ZEF6O0MzCuUvFmNyHcmJMFulGbrrx/MBQ+e9NCETAvYsZbfCQz5L64IFYg7ZehChL0R7gBxNaIHEcyaCOwegSACL6SbnpuoC0LzFKE9W+RO+uE+bM/73R9juqPgkiDNw4ukohsIXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785452131; c=relaxed/simple;
	bh=JnHBnZJqMnAruKI0EV6KVHEf+ZLz1OA1FdQcaaHjlEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxjuaO6I40N5uEJxdKUxV5skbQfpECl2RxwhpgWD0+60Mm0zPnRG1Y7LcWcZAgGclE0uxHXtApfgz19V0DZiVQT3p1Po7FzbXxBATc0/fSUeJhhkHOfvD3PZZG947OsaYxxdN5v0PKMp8dusS0OFXZdXrNbmQ9uksDRoMVc3kOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rG8jhTRJ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rG8jhTRJ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cab973140bso3671665ad.3
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 15:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785452128; x=1786056928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rZJMc2oKGKKsdo81EEeZxLgwe/ZEUa/SJJOiMzrescI=;
        b=rG8jhTRJev1KWEfcu+bIIUUxMVA8nbZ8j+O1jgMnzG4irMBIT/gsNU9dG+oPdhGH6D
         cByuKO5Ey9FP7ke6hwkVCqSUz4nzBe8OFRT5nlrfXTfo79lGIW2EVmjYQNoYDN1jE54z
         rUahwoSb3Ewzb9EZJt6qWKZk98aCFuBuyF/Q0/+pvNGFKJjXwRDv2bzPdEcYd5nedrf6
         CXsDUux/bnIOo8XbgIYYK50J4G4XDLHxVoN4VlPf+NKrZA/17MNjoaimMD3U4ZLD1IzJ
         5kYqEtuiH+XXkJkOdlbleYg1P2SLLNiR/auxpjNMi6mJeVvH1Ch4QCjnFItPvxSVY/JN
         3tVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785452128; x=1786056928;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rZJMc2oKGKKsdo81EEeZxLgwe/ZEUa/SJJOiMzrescI=;
        b=d+d8v9ORM3MWbpS/Ze349TDDYYrpaT4tn/cPe3E0Ce6MuTM+beJBx1J4EfAUXR4xkj
         d/Pjnf78oXUi0LsKoS8uo6uHD9oQRXmAh/REfFuxyMZigYDMk7VBNOm7mZNUiVnMapu2
         Fsi4HgpYUdCB3LUmbHZfQPJ18ATUJ59nA6bYIIe+ZmKpDHqUss0g/kKxI7HiTs2qPzrh
         BWP/C7ikNFfmyD3OyxQ3Naoo/d2hORjLqtx1tymhWr3kSCVz0Ns2V+AQ74ah+mGN+LPn
         5+0z3/ExsSDJBcU3HDRY2op+Ohmq4CfD/Sh37Kk7ELVMg3LcMZlEwxUEqXIrB2EQgxdd
         e2Lg==
X-Forwarded-Encrypted: i=1; AHgh+Ro9aEu8QtfhOvdr6wSIppgALq5+QpJV2QE/FR46QrnY2gmh9AhPVE4HoM/Rjc7rlKfBdSK9H3Hj2mSOE2f3Ng==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAigKwt5iWbzriSX3LB8trPBLLS7wlH0TMEw2Qs4FEVQLUY628
	2fR3vWVnBmjakrj3x7DvTpmokkW6bmDP1K7MMGvmtvaGdvvvgQ/EkEPu
X-Gm-Gg: AR+sD10B/eQ7yVGWzUKdN0nfg+Ejc0M0wxGsHpZVP1ZCl06NzyARn5LiDEakmU7/hkj
	vxJNdlXwX8JAbg+LctUdJV1st/A53YtKhqhNKsj8NzLUKxeA0kdTkvCF3sl9h4v79Ntxjduo7YT
	VROz9kLUhalamEZXbutnT7bHV+dOwFo22cS/IJJwdklHgAgduv/RBUbe7tV/kqDRBvlPteKuzw6
	aS/7wUmRFPi3ieLEyYd7svxpi+j89ZpD/DERl50u4E+rswLQXVvpjEHvWNuEluqz5ELIpxBVjLJ
	PhSzs4bWBnjg/r+dSEQZsOCELK5wS6ZfNYy4G/1XC9oJgagbEj1YwTW0eibILfGVHRUgIQOzDzM
	GGWwFDoY3Uq0pgq3nW1u3L5I7xVlLuF98BHcb4fMb16EhsEHS8ej/3lW17SouPmbEFZ6PH1m7Cp
	fUV2+OmcT1jtf/QsJlQbEmdj9KmI8OjsaY4EqcCbsXKwFhos5zH6P6mbe+zaGyd2+DW62+LJ2sd
	fiD2vQWZUUztGgQyZ62cetIpbcloMNmNWnE7g==
X-Received: by 2002:a17:902:e845:b0:2cc:c9cb:371c with SMTP id d9443c01a7336-2d035cd7591mr41764995ad.40.1785452128027;
        Thu, 30 Jul 2026 15:55:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504927a7bsm27220284eec.0.2026.07.30.15.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 15:55:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <eddc90dc-3223-4356-9e9b-350af904b144@roeck-us.net>
Date: Thu, 30 Jul 2026 15:55:26 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] genirq: Export NMI APIs
To: Doug Anderson <dianders@chromium.org>, mrungta@google.com
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Thomas Gleixner <tglx@kernel.org>, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 "Kirill A. Shutemov" <kas@kernel.org>
References: <20260730-qcom-wdt-nmi-series-v1-0-3aa86d162914@google.com>
 <20260730-qcom-wdt-nmi-series-v1-2-3aa86d162914@google.com>
 <CAD=FV=V+nrmtK6FJ2G+LGnvxkLEWMR+2A253-gQ2smxf9LoEWg@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAD=FV=V+nrmtK6FJ2G+LGnvxkLEWMR+2A253-gQ2smxf9LoEWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/30/26 14:49, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jul 30, 2026 at 2:33 PM Mayank Rungta via B4 Relay
> <devnull+mrungta.google.com@kernel.org> wrote:
>>
>> From: Mayank Rungta <mrungta@google.com>
>>
>> Currently, request_nmi(), free_nmi(), enable_nmi() and disable_nmi_nosync()
>> are restricted to built-in kernel code because they are not exported to
>> loadable modules.
>>
>> Export these APIs to allow loadable modules to register and manage NMIs.
>> This allows watchdog drivers configured as loadable modules to register
>> their bark interrupt as an NMI.
>>
>> Signed-off-by: Mayank Rungta <mrungta@google.com>
>> ---
>>   kernel/irq/manage.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
>> index 2fbff2618a1e..fb0b8da32f4c 100644
>> --- a/kernel/irq/manage.c
>> +++ b/kernel/irq/manage.c
>> @@ -766,6 +766,7 @@ void disable_nmi_nosync(unsigned int irq)
>>   {
>>          disable_irq_nosync(irq);
>>   }
>> +EXPORT_SYMBOL_GPL(disable_nmi_nosync);
>>
>>   void __enable_irq(struct irq_desc *desc)
>>   {
>> @@ -833,6 +834,7 @@ void enable_nmi(unsigned int irq)
>>   {
>>          enable_irq(irq);
>>   }
>> +EXPORT_SYMBOL_GPL(enable_nmi);
>>
>>   static int set_irq_wake_real(unsigned int irq, unsigned int on)
>>   {
>> @@ -2080,6 +2082,7 @@ const void *free_nmi(unsigned int irq, void *dev_id)
>>
>>          return __cleanup_nmi(irq, desc);
>>   }
>> +EXPORT_SYMBOL_GPL(free_nmi);
>>
>>   /**
>>    * request_threaded_irq - allocate an interrupt line
>> @@ -2342,6 +2345,7 @@ int request_nmi(unsigned int irq, irq_handler_t handler,
>>
>>          return retval;
>>   }
>> +EXPORT_SYMBOL_GPL(request_nmi);
> 
> This seems reasonable to me. One thought I had was that we could
> possibly get by with fewer exported symbols by changing
> disable_nmi_nosync() and enable_nmi() to "static inline" functions in
> the header file. That being said, what Mayank has here feels slightly
> better to me.
> 

I don't claim to understand the NMI APIs used, but Sashiko's feedback
seems real to me. Someone who knows that code will need to confirm that
there are no unexpected pitfalls.

Thanks,
Guenter

