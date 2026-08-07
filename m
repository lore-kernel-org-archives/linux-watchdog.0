Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B4243C7D5
	for <linux-watchdog@vger.kernel.org>; Fri,  7 Aug 2026 05:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786080869; cv=none; b=JS2TjYGyiDOPymcHvdnx3/jF/LrtNJ4dFa5lXQtlRbxQ+Dad17SQzXWHoM/IVCbiHdgTKNMGYkzXVhyKc2HShk8kXAw2imJveuS769L3fsHXkRdIf7pdw3gDLeO/v/4A9nP+VoK2HxxEpXSklTNetd3zc1deG60zRJmEmfT26QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786080869; c=relaxed/simple;
	bh=U+1cvYLKLhwQlrOJDQVXIhS3ygcM9Ohp2tMSw+ydI9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kdz9+RYmrrw1RT3lPGMtilbFF5H0COBrAScUgp68lE8q1qWDxpUseqLKcaM5SgolvCqZNFX3hHZSpMIiQbfDgiufQc8783iYRX6M++6X4HYlimR2QAGvr+luvAyqxLRctVnuDWfQasqrnFyySEWdo8GMpvRzlLXl8ejbohpO+JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzeVY/9t; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzeVY/9t"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ceaf8a1265so44015595ad.2
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Aug 2026 22:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786080864; x=1786685664; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HBs3P2zso3dU/QxL+eeX0ta5hWsWkwiBmUnjPdkOhrw=;
        b=TzeVY/9to9PbZcmeOcqtmGbl1I/dIK7vzPW7l7nr9f9Hly9dq8n6OoBBOUrRkMyifY
         b/w/gHRAnwv3ZwYcoaE0VtiMqimmdizqwxyDZBDA4zhutHSdgPFUwWyHGYv6DhZiqbDW
         xOPcbCTBl7ECq9DPevGJRlpYTqiDdlsoV7pbD59GjeTsZhtHObwl4ks6sUMdB4+EVwrh
         mk8+uuDhYD5bjCKC3rEKGUD2LAwLldF5RzhvZC3a7p9U/5OLp109MxMN1qLW/S+w7YN9
         C+XrSssUj+h+lpU71EPekgcBJsMp5xleu2ZDe7gUTvXeYHJGEhEagaTbFlnLNrhCnOsE
         WwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786080864; x=1786685664;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HBs3P2zso3dU/QxL+eeX0ta5hWsWkwiBmUnjPdkOhrw=;
        b=mUcOISlsA4hiFOizkL3kqu6ZSp5XbGyOGH/61dSQ0a03+DiJLXrbGiSPiihu/vbvAh
         JymsvWiIyd+cBdAb/8KVmd1H1LSPQ4BxKq7gBo9aGBi/dDMNPon7TTIRqu16U6x/zsMT
         AifG0snFQ1NgbhyoivWLHdeF68HU7+C3Asq8va5YxHAml50q9xZgQXJZy+bDUZDJRxS0
         R2PK6zjqtV0RPLZ7BduGp7fj2jFfsb3rfrJ+TV9Ro3PWnRYJ1YG3wzYRlkeiaWrQzIYi
         dQdQWX0FW8+YH0eJguAOYao4gwF04vBJLMVwtEoQZGT6kbS0aIoiyd1XehWpb8cAUkk6
         fZPg==
X-Forwarded-Encrypted: i=1; AHgh+Rp9GnZ7k4ZDZRS90wpzY9hXYrn7Cl5FRE/NcQM15UYCuWzt+w8cmNM8X8mt/sJt0O1JwHG16nkdgHCuAYtLow==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMIV2Zpi0LjjKN9KsqfWCcOw35Prw4Pgvay3n9SOmhk9E0Mk7P
	KSds7wRCMogFlKrufFSjPuHDaYyfNX+67mFHikQgYjRAU7pS30ukd6hazRWCoQ==
X-Gm-Gg: AR+sD11FQmNLYKRVo0BUDhnqXvO2dyKlxg4So4Cb+roKNxiSDZtb5FBQ5huK6taQSeT
	rEgE3RyWvcOsU6uFn+nTGBntbEiFiUaC0OxHmevCNJjK8QHWhxw1p2P38bvts1XDhMa99pJhmp0
	/OptE/V9ICQYd0aYVkv2Q8Cwd5rWUH2AHlRKW7F1i3NkJ51TYxWDHUb8g3mL/tegAxwz21flfhG
	g8GCEYTw7n7lZAw4IW8dzty1jkLLV+VIIH3TdaEHxsU3UcSjKRXqkJVQJ6Dt5N/Hncw/UMiVyiR
	zr3zv8/XF0RApN+E2kvcVJDFXV2jHdLw6/Z4go83qtWYXbKCSqUxaWpsD/Kex7oH88KtJXlrevh
	N5+Kl6AXJ6n+Yu/bSMat6hyHVvJEsCiZx+jxDloqvcobSkqxyntt0K/Xe8zYJ84o/gSOahQ9Tgh
	Wn6t4odu9qit8PznGIegybJBnb/9dZnvPYqmDINHeXAOH+gtMzYHqQ6fnGke0VQHuwWNV8N7J/k
	bxoWIZwm88Iovg7120Iwd3u0UKXgt/5OulXqg==
X-Received: by 2002:a05:6a21:9985:b0:3c3:bbe6:95c9 with SMTP id adf61e73a8af0-3cb85e72ec2mr22578898637.16.1786080864616;
        Thu, 06 Aug 2026 22:34:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f35b0c3sm102504a12.15.2026.08.06.22.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 22:34:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8e5cb916-412d-41a9-8feb-0c051c9847d2@roeck-us.net>
Date: Thu, 6 Aug 2026 22:34:21 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] watchdog: pretimeout: Protect governor access with
 RCU for NMI safety
To: Doug Anderson <dianders@chromium.org>, mrungta@google.com
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Thomas Gleixner <tglx@kernel.org>, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 "Kirill A. Shutemov" <kas@kernel.org>
References: <20260730-qcom-wdt-nmi-series-v1-0-3aa86d162914@google.com>
 <20260730-qcom-wdt-nmi-series-v1-1-3aa86d162914@google.com>
 <CAD=FV=V_7RLjcAtKk5MHiABj1rA2CTkPw2UY2gJnVzH=3Gbp5Q@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAD=FV=V_7RLjcAtKk5MHiABj1rA2CTkPw2UY2gJnVzH=3Gbp5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/30/26 14:46, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jul 30, 2026 at 2:33 PM Mayank Rungta via B4 Relay
> <devnull+mrungta.google.com@kernel.org> wrote:
>>
>> From: Mayank Rungta <mrungta@google.com>
>>
>> Currently, watchdog_notify_pretimeout() acquires pretimeout_lock using
>> spin_lock_irqsave() to safely dereference wdd->gov before invoking the
>> pretimeout callback.
>>
>> On architectures supporting pseudo-NMIs (ARM64 GICv3), watchdog drivers
>> may register their pretimeout warning interrupt (bark) as an NMI.
>> Because spin_lock_irqsave() disables regular interrupts but leaves NMIs
>> unmasked, if a pretimeout NMI fires while pretimeout_lock is already
>> held by normal process context, attempting to re-acquire pretimeout_lock
>> triggers an unrecoverable deadlock.
>>
>> To make pretimeout notifications completely safe to execute from NMI,
>> convert read access to wdd->gov inside watchdog_notify_pretimeout() from
>> a spinlock to lockless RCU. Use rcu_assign_pointer() when modifying
>> wdd->gov and invoke synchronize_rcu() during governor unregister and
>> pretimeout unregister routines.
>>
>> Signed-off-by: Mayank Rungta <mrungta@google.com>
>> ---
>>   drivers/watchdog/watchdog_pretimeout.c | 47 +++++++++++++++++++---------------
>>   include/linux/watchdog.h               |  2 +-
>>   2 files changed, 27 insertions(+), 22 deletions(-)
> 
> I pre-reviewed this for Mayank. I'm not an RCU expert, but this looks
> right based on my understanding. My AI was also happy with it. ;-)
> 

Sashiko doesn't like it, claiming that some "const" are missing. And, indeed,
after applying it, I get:

drivers/watchdog/watchdog_pretimeout.c: In function ‘watchdog_pretimeout_governor_get’:
drivers/watchdog/watchdog_pretimeout.c:75:13: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
    75 |         gov = rcu_dereference(wdd->gov);
       |             ^
drivers/watchdog/watchdog_pretimeout.c: In function ‘watchdog_notify_pretimeout’:
drivers/watchdog/watchdog_pretimeout.c:110:13: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   110 |         gov = rcu_dereference(wdd->gov);
       |             ^

Please fix.

Thanks,
Guenter

