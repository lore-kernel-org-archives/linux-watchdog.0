Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F66B391E45
	for <linux-watchdog@vger.kernel.org>; Sat, 11 Apr 2026 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775934476; cv=none; b=jBWieIkIbsZ1Fa4oSOlcWF39usNmAfKKvuFEygN6aU+SosZUbQnHX0ZBqZKYtomWjBodvq5E7O7ITG3axm/jucGBvUXQIsylJ2TfSACRQOLx1GnAHVZR8L8mYrVzQvYu0Du9FCnmYG3Z1CF4BYASAebKWXXoQiMXnnqwss9HRKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775934476; c=relaxed/simple;
	bh=FaojIVbVyRuZuc3BEO5n0yyPzrVecLLpuijflNVTNgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qa3ZoicN1r/RQcx0fprXuKc8DLKUubwOsY/Rq+P6da6z3rIwWtf3oaRY85FmF84QLYaim1CTKADcJfrK6vwvmFG40Q1LDWTZI28kZw2WjIQCsSZeHaZCfPHlIQJtNv9YHSH2PiZ+PfLPPt0dk84+futT/90+ntBTpGipWydfi6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ku/aadc0; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku/aadc0"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c742d4df00cso1150530a12.1
        for <linux-watchdog@vger.kernel.org>; Sat, 11 Apr 2026 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775934475; x=1776539275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ajNoL0EmgPyfnSB7aVOY+xW7jpezw6jmyJlho75wVv8=;
        b=Ku/aadc0fKBEgUhdgfEQZ5Gq8SRks/JsHqpZWQI+GzjpB9TboWmRVN5CCXtzeyavvP
         BkGQgVdU78hlEeLZNRT63Osgh+SLDTyziYS7hNECEduArdCgfqdnvWmXC3zVoXX4t3WE
         IT8brE2tKAK60hHNsTlV6bBconsyHjNbIuVc8JD8t65oMmvyhTL5gCVCMkxl4BNmdECC
         D5mWMKiG6RqajLq7oBwJy8pXBtCGJRvkm1AYgAhAzJbKo4nkLzYEsQMSocIYv1rnX+o/
         g3M9mmN5SU3Aj3Cgham2drvCChQljxxcWhoh8c+3TDwQDv4sGsapJWh+S6LgNARovCMt
         25oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775934475; x=1776539275;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajNoL0EmgPyfnSB7aVOY+xW7jpezw6jmyJlho75wVv8=;
        b=eMqHdO5sQrncbCJ6UKi7Uia5HRpKnb+Nnfzotn2hFJGY7yz8PaQp1FLA5Rl2xuCzYv
         i022B7o1aLGGPEZgVuQjyDgAJiVUWzDVDws2Kho7V9kPUwYKX5bmlYXt0AvrcKE/0ZaL
         vI/iZO/UqMcjfC2d0skYcBbQz9kavg0DyX0zhoZJbidCGUAtx9Z/s5gMZkTbajJTKTak
         /3avh9xM0VCDvBoZT2XKgsopZwEdgAymoO1tmt5kaZvAwcn23Hv022mjM8cLcy6vXs/L
         RwNN3He1ymXd8XJUUBqKMFszPG0a8f3yqMdx23jq6NnIjnF+2ojaAh06/e52r2f3YgkI
         E+Og==
X-Forwarded-Encrypted: i=1; AJvYcCU9RK7SxhzZ+0zf3lGPnCc2XfUPQyu6IhZEoPJ1sbomIEJ8XZuk9hVS/SFOe5UyUZGzDxPImohB2Pp95ZJoyA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3PqvFB3KrfMLApCtqQ+zQpSJezzGkU3uRxANCwtrUy/k9H0Oo
	6AoK6HciSYG1StP+M7uFiQAkflV1Y/y7EqjPBaVOvxDdfsUMTFEPXnIT
X-Gm-Gg: AeBDieuhoOhQLByCqE7P5aWw4eYloz0jB5wRiljQkU0m0LyBqF0d6jtRkL6jfVX+4wd
	naFEdMHkrVKbGfJ74E8gemvGe6Naa7ARieI9s4N7G3L6CyZqwnl/BSVb43z9QvvOHGgTidkCRYG
	FNga+kJGQVgDCIjkxVF6xbLIJIgNlv2byEiwLzJ2UXYmbEmAZI65dsP0T0e6i8eJcVWyEC5DDtU
	dg3y64lsw0DXJTEBs9SzirPY6fwKhF59LJbF1jmROrivEsW0V7Rgo1Wf7KJ5HQ05yIW2v/cEUP+
	KHlp8EvLT3f5cq6mppDqImlDBnDA9Eb6n4uMN8yDUj0sj8imT1LmeElFsVUjjF5+6NYEvUEcQT2
	3P88EOyy0I6eav1m2Dex428pDQZyjEuk+1keXrsjbOpm1XXvdgnOGopordygs+GRjZkp8n2kBHs
	vgKWNQMVKDjuYbVA5hDd69kOT7zUMt/rr9DtHhYtz4dMDW4jdpxEiow6ZhhYdjEbH4BInhxhkk
X-Received: by 2002:a05:6a20:1585:b0:39c:37:9e9 with SMTP id adf61e73a8af0-39fe440ebbfmr7546110637.5.1775934474573;
        Sat, 11 Apr 2026 12:07:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4df7f5sm8299024b3a.43.2026.04.11.12.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2026 12:07:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <33f18499-96d8-4b17-badf-4de957a29a20@roeck-us.net>
Date: Sat, 11 Apr 2026 12:07:52 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: Refactored watchdog old doc
To: Randy Dunlap <rdunlap@infradead.org>,
 Sunny Patel <nueralspacetech@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-watchdog@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3e25ae54-e62d-484e-8d90-4f7825705e4f@roeck-us.net>
 <20260411150922.20536-1-nueralspacetech@gmail.com>
 <303dcd9e-ca40-48b7-851e-6cd283cb96ad@infradead.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <303dcd9e-ca40-48b7-851e-6cd283cb96ad@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/26 10:22, Randy Dunlap wrote:
> 
> 
> On 4/11/26 8:09 AM, Sunny Patel wrote:
>> Mark WDIOC_GETTEMP and WDIOS_TEMPPANIC as deprecated since
>> neither is implemented by the watchdog core and both are only
>> present in a small number of legacy drivers.
>>
>> Add documentation for previously undocumented status bits
>> WDIOF_MAGICCLOSE and WDIOF_ALARMONLY in the options field.
>>
>> Add documentation for WDIOF_PRETIMEOUT and WDIOF_SETTIMEOUT
>> status bits describing their respective ioctls.
>>
>> Fix the following issues in existing documentation:
>>    - Remove version-specific reference to Linux 2.4.18 from
>>      the GETTIMEOUT ioctl description
>>    - Fix duplicate "was is" in printf format strings
>>    - Replace [FIXME] placeholder with proper descriptions for
>>      WDIOS_DISABLECARD, WDIOS_ENABLECARD and WDIOS_TEMPPANIC
>>
>> Signed-off-by: Sunny Patel <nueralspacetech@gmail.com>
>> ---
>>
>> Changes in v2:
>>    - Fixed typos: "tiemout" -> "timeout", "characted" -> "character"
>>    - Fixed "small number if legacy" -> "of legacy"
>>    - Fixed capitalization: "New Drivers" -> "New drivers", "USE" -> "Use"
>>    - Fixed spacing: "WDIOS_DISABLECARD,this" -> "WDIOS_DISABLECARD, this"
>>    - Fixed double spaces in two places
>>    - Added missing newline at end of file
>>    - Rewrote commit message
> 
> However, you failed to fix a malformed table warning that I reported here:
> https://lore.kernel.org/linux-doc/9e3403a0-4ec2-4fbe-a50f-53f939c1d841@infradead.org/
> 

On top of that, it should have been v3, not v2.

Guenter

> Documentation/watchdog/watchdog-api.rst:250: ERROR: Malformed table.
> Text in column margin in table line 2.
> 
> ================        ================================
> WDIOF_ALARMONLY     Not a reboot watchdog
> ================        ================================
> 
> 
> So I repeat, please test your patches.
> 
>>
>>   Documentation/watchdog/watchdog-api.rst | 59 +++++++++++++++++++++----
>>   1 file changed, 51 insertions(+), 8 deletions(-)

