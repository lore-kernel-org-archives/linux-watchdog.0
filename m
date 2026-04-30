Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0431639F175
	for <linux-watchdog@vger.kernel.org>; Thu, 30 Apr 2026 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777591312; cv=none; b=Wt783REBcvotVUqHWJoK0oFZs7r+iNFzKDtrZly/7nOCCORXr00yC0Sxuq6RSIRfuEPDZSA7bFe9ZtmhP08cuIc5Ml5t+YynFvsqlGDSniy6/ltHhtK70L48FvbGWMDUogRkMCfpZJA8WDQj2aF76WzsCW8jBY1pW4TF60wip7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777591312; c=relaxed/simple;
	bh=eGi370BjNE9CSKfEDaI7AioZMVPwUqSR1hq/ViSDNwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHeH1bDkn3YcyTa+BMhLmLMLDRARj4vbtIYHf5XlH9xfnPhwCFtF7t7pH+o9BH3LeQC8nr5O1tlwNnognst35NV5IhjxO7YGpUg9pJNyAHRJcqrH3P2lQhV3oHDLGjqNrF8dUIXA5itlipdIL6VL+7fHPIML1KUVAW8c4SoRUQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cf7upvls; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cf7upvls"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c796163fac5so849204a12.1
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Apr 2026 16:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777591310; x=1778196110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RcjWr0xT/STuAJ8HdgaiitT54QAca7R2l4fI83ncXKE=;
        b=cf7upvlsdMFoHr5zdFKwM7M0+3qN+n6DRq7lMheSeh/fA+dolRdROu/aJ18luuDD9+
         tBpcEa+vOZx+jb7gALkY13yKYipI4zt73JDfP0PBI7MA1ovBBCOFTwdvn8gSXDJ5cUoa
         TM9vQ76AjlXY4xw7+aQ6jfJp8QpyMfOIwuxF66xsfbZa9eZ43B/Ak0hJED7l3a1MHI9s
         VfD/87jt0bbrltEfG6rzao5Ebo10rVI75Ojf5Jyig+/lcF8tIY3f1tL4MJ7qmy/J8WoE
         usLaULMh23/T18lLWJMOL9NQBLn2FHpZU/qCcX+y0WT1OuzJ2SqwUxG0IoliFC1FQpBc
         Z4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777591310; x=1778196110;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcjWr0xT/STuAJ8HdgaiitT54QAca7R2l4fI83ncXKE=;
        b=pi3dTc5e/N98T5F/CDGXd202KDbCHb+jicF2A2X8Ho6fdw/UOF4E5JwVkYc2HqLREB
         3UWNvd5dhTkjScAL49fhcAx3h0cSozYhdgclzSFODDgeSTQRgGdU2HIpCDmPNyOE7Tpy
         tv21HvnRUSgcGsn4RPJkG5gY9K//0mSNni95qc22oJLjotG/3rjwi3/nZ1Ja6EHmdsUZ
         YROZbnaweQqdsLuZWvZyhVW83UQpmX6C9oFJ4AZrvqz1Ia4TyEvZrB+S/0KeVkB+ugMW
         DFSR7aPhh3ui9Z6qlUTfVSiZ/n7ZHyEsSSS5vaKvzumXsk2b1/etBMzOYkTGw9m0AiaD
         LffQ==
X-Forwarded-Encrypted: i=1; AFNElJ+QbRpm7y//5rVnt/jUFjCYrQUHl9hUDonQe9kOz3nTq9pxhNnM/y6DRlQKK4tQOOsqzzA3aT78KGnkK1PDlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YybzjZY5HoHbxv/RirafmPYMNecgsL2WSifDf34MA5BXNOsz9J+
	Cm0iAsIalGQ/I3uK22aoyLqJBc1kV52ynge8MuqTyK7bfIHKn1p0tNIC
X-Gm-Gg: AeBDietQ5w8F8snRuWJ0jkx1+bk7T9cjOHG/nUFSobVv5VHZ+ErQXrxucDqewgB+Qln
	swr+5PtAb6V8tOVuWbb8D3tOlU4XF5RofDlc1Fb7BfvkVhcCTXJLhRajMlRBpIEFkMZmawhq1yN
	dHoccUWqh8A/FsAyjsZ6R+BFzRKPthhtMahxttm5jJy76Ft3FwJGVYxekj/7kPe0QTLkvx83OTM
	/sysMU+Jcoh7zdJJNLvpPFdin0bjtqPq5CKvuBvze4DjyAm78SVtZRZBQdbJOf/MBj3TfQEog+J
	Lmh3uuePkfnGnxTJFKjf+H/4rceRjH5fqt6/mBTG+9RhHn+6ICtjB37YmpAaZCbTf4d6jzjICc1
	FwJuJ3TOEAIYcnnm1y66PsgkbCKGr3huxr/eQ0Uo3VHw0yVDhMO8lZWjqD+IfU62HWG2EDgtxZq
	hlJhTsiTcYZ59RpwXoDMb5I+rW9pUk9r+rHsv5PHjI7qzlbo1LN/frM7uhk0t4JRTcNCYywp3km
	TEuvVrBt7o=
X-Received: by 2002:a05:6a00:4407:b0:82c:6aee:b21a with SMTP id d2e1a72fcca58-8351a5d8da5mr544471b3a.45.1777591310442;
        Thu, 30 Apr 2026 16:21:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b5b921sm809805b3a.54.2026.04.30.16.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 16:21:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7a5971b2-e067-40cb-8d15-aaf1926af3c3@roeck-us.net>
Date: Thu, 30 Apr 2026 16:21:48 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] docs: watchdog: general cleaning and corrections
To: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260228010402.2389343-1-rdunlap@infradead.org>
 <875x7cddye.fsf@trenco.lwn.net>
 <3de4c724-39bf-47f9-bf43-49552bc60a3a@infradead.org>
 <8161ef45-be1a-41e2-a22b-a12d6b9df666@infradead.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <8161ef45-be1a-41e2-a22b-a12d6b9df666@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/26 15:14, Randy Dunlap wrote:
> Hi Wim,
> 
> On 3/22/26 5:54 PM, Randy Dunlap wrote:
>>
>>
>> On 3/3/26 9:23 AM, Jonathan Corbet wrote:
>>> Randy Dunlap <rdunlap@infradead.org> writes:
>>>
>>>> Fix some obvious issues in the watchdog documentation files.
>>>> I didn't try to fix every little niggling mistake.
>>>>
>>>>   [PATCH 1/5] docs: watchdog: mlx-wdt: small fixes
>>>>   [PATCH 2/5] docs: watchdog: pcwd: fix typo and driver info.
>>>>   [PATCH 3/5] docs: watchdog-api: general cleaning
>>>>   [PATCH 4/5] docs: watchdog-kernel-api: general cleanups
>>>>   [PATCH 5/5] docs: watchdog-parameters: add missing watchdog_core parameters
>>>>
>>>>   Documentation/watchdog/mlx-wdt.rst             |    4 -
>>>>   Documentation/watchdog/pcwd-watchdog.rst       |   19 +++++--
>>>>   Documentation/watchdog/watchdog-api.rst        |   38 +++++++--------
>>>>   Documentation/watchdog/watchdog-kernel-api.rst |   20 +++++--
>>>>   Documentation/watchdog/watchdog-parameters.rst |   11 +++-
>>>>   5 files changed, 58 insertions(+), 34 deletions(-)
>>>
>>> Wim, do you want to pick these up, or should I take them through the
>>> docs tree?
>>
>> Wim, are you active?  Can you reply and/or merge these?
> 
> What's happening with these 5 patches?
> 

It looks like Wim did not send a pull request for watchdog this time around/
Wim, are you still active, or should I send pull requests going forward ?

Thanks,
Guenter

