Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C2818FC97
	for <linux-watchdog@vger.kernel.org>; Sun, 12 Apr 2026 00:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775952577; cv=none; b=LPUrFAlqYckowQPkjJCh2Q/+4S6680P3gjiY+UWzdyCd7DEov61+7/lJYobXYzwDXRvSjaPhy+2uGxqhIP6Bd946txKIMi0BmrcPWbCpR9XZHxexi3XuTZL7LTID4dwpbtZpnRipiL3MujFYVq+fjzUKWPHFNWUg+x8sG52SEvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775952577; c=relaxed/simple;
	bh=S3zBjySD2slZy8mnb+K+yj8qQo8cozvwD9hCVXVDCys=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ie+TLRhG6L6nALua46rlex2vC9vYyt4+bbk9F1aM0TADkhYjj0EicX5kUWw5SIZO+vNwOjJKcmZj7Bx3oD1yy/6KW9WcyE/yxVPHEpqYR6ggMfQp2/V4Z6JsbgWS9NB1QYsStDAOoHfzlggNl08xNOpIytkWTgOnuzKTqKaBtiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rYiJ2Z9G; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYiJ2Z9G"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ab232cc803so16091095ad.3
        for <linux-watchdog@vger.kernel.org>; Sat, 11 Apr 2026 17:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775952575; x=1776557375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=eu+YC8zYOACgeCUdH+pUjO0BlwjbU4g1BVKPHxfcxP4=;
        b=rYiJ2Z9G2ZZHp5d9D6QtlHMyjokYiYhn/oHvqx70hfX8RjVaHK1HtJg/dr1Ier8x7t
         jjKWbCrtzVkjxC6Gre8RjHeaIVRS7320M8emkrLE2m0IlLHWp7/6PVQEoi6faH2r76rs
         qTTOiwPc7FiJDH3bRUaf1+1TJVeReyNGmNQOMhOirQzuNutL3lVanmvtSOb9vRx4mdOp
         plPw41fh5Lxn9u0kxfNtBcdiKU/ZUX3+kFnkOhW33avXPQugZVGaww7cTLX5ENJsR3yZ
         UaO6i8vdzak3nsXL7p6+j6sgW7z26RAsQNqc6n4zEAeJc2kaIzlXsuneOrIASsV2/P1W
         IchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775952575; x=1776557375;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eu+YC8zYOACgeCUdH+pUjO0BlwjbU4g1BVKPHxfcxP4=;
        b=dmXwrn/pBsB5xRT3+nx9v0dc9DFy2ShqxGlDvKW0nhY3lW+v0AQW3VbWsd6cbqQ1mW
         HhR0ImFeqXr/466iK7lVx/TVrj5R70cKHOc4uu/N6IsgcX8wA/vq/FC/uCrosp8D0/7Q
         LWtBdps7dHyVAJ+sF4c1FPHeEc5P0dElXdA/uOOrKHMf9iSuOuoa9Ysn8U+zgSoSJe9W
         6+lokha2hY0Dz1a/X7bLDAnQruh793hlUvDfMk+ibWPfQVZxt0avBXElIywWRXfJpCfw
         MIwTQZkjTvYOv7uPVFvNb8m1pmXRigpINbBC51mSAq1nzI0xt6OqPLQb38h/agejChqL
         9rYw==
X-Forwarded-Encrypted: i=1; AFNElJ9KRaetvlY0tTD4IxAU0sBvvw3HqfjVndmCWr+8Vbk+SCOjZ/OBAxOiZZL5ooaGVRpZl2ehj+osCR6TgTQUzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk0qDGG6Bw0rCKfdwOMlXh30GrDhF7Gu9YzinoY9xpyH8p0gg+
	K7LDIULb6sRJaedfUN4qEYFkbFLZBSGcMEnwrsbxtd5yWjUQkaYJSRpZ
X-Gm-Gg: AeBDieuiTLV3jvmyxjZ0CmcqjP1l0Aztm6kCaCnJNbUsbnz9yq+G1aP9pzoOKjeyK40
	F0ufAhwOia0HZBwG7kfdYG5SQTm+NUULrvf6f/owu9fZuJwOFrbQEE1nJAW5aykfWwvPEGauiIz
	MQpLBUfmzgTGfCMUg5DyOtNHgjICAmHHLRIUEcpF0OMBWs4Ba1gBk38MaOvDGV3SHBa9j4L0fNA
	Y0BBiVxRnYGpkAYC5u5CkFjeO01c5lX+J185dmvFn0EQYkMKEdPQ7QV328ahHI9vfdD9VdtLUUZ
	o/MfBtfbrSh1UAWPm+/WLQXccVbG46NR9g+yroemmIbtog+wMcy2esXLNJ0xEPTrRvX+xJoq57h
	z9ngo1v0uPoJFuI1Z+Tvs/dxkHfv/mV/sfmmNFzLsLZ4yMM+OWc8zSBeA5NJEpDxm6eFdn6aOLD
	cJc3RRF/b4CG5ZFo+BcRpdOr1dSNXzkIPzxOjhkoUaVgCcHqfScRoiopWDIQqtKwBrXEvsRvxD
X-Received: by 2002:a17:903:1ae8:b0:2b2:497e:3f60 with SMTP id d9443c01a7336-2b2d5a6d679mr90114095ad.33.1775952575331;
        Sat, 11 Apr 2026 17:09:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4daed20sm68773495ad.4.2026.04.11.17.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2026 17:09:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <aeb4da9c-db28-4345-833f-db299b05e31e@roeck-us.net>
Date: Sat, 11 Apr 2026 17:09:33 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: Refactored watchdog old doc
From: Guenter Roeck <linux@roeck-us.net>
To: Randy Dunlap <rdunlap@infradead.org>,
 Sunny Patel <nueralspacetech@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-watchdog@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3e25ae54-e62d-484e-8d90-4f7825705e4f@roeck-us.net>
 <20260411150922.20536-1-nueralspacetech@gmail.com>
 <303dcd9e-ca40-48b7-851e-6cd283cb96ad@infradead.org>
 <33f18499-96d8-4b17-badf-4de957a29a20@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <33f18499-96d8-4b17-badf-4de957a29a20@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/11/26 12:07, Guenter Roeck wrote:
> On 4/11/26 10:22, Randy Dunlap wrote:
>>
>>
>> On 4/11/26 8:09 AM, Sunny Patel wrote:
>>> Mark WDIOC_GETTEMP and WDIOS_TEMPPANIC as deprecated since
>>> neither is implemented by the watchdog core and both are only
>>> present in a small number of legacy drivers.
>>>
>>> Add documentation for previously undocumented status bits
>>> WDIOF_MAGICCLOSE and WDIOF_ALARMONLY in the options field.
>>>
>>> Add documentation for WDIOF_PRETIMEOUT and WDIOF_SETTIMEOUT
>>> status bits describing their respective ioctls.
>>>
>>> Fix the following issues in existing documentation:
>>>    - Remove version-specific reference to Linux 2.4.18 from
>>>      the GETTIMEOUT ioctl description
>>>    - Fix duplicate "was is" in printf format strings
>>>    - Replace [FIXME] placeholder with proper descriptions for
>>>      WDIOS_DISABLECARD, WDIOS_ENABLECARD and WDIOS_TEMPPANIC
>>>
>>> Signed-off-by: Sunny Patel <nueralspacetech@gmail.com>
>>> ---
>>>
>>> Changes in v2:
>>>    - Fixed typos: "tiemout" -> "timeout", "characted" -> "character"
>>>    - Fixed "small number if legacy" -> "of legacy"
>>>    - Fixed capitalization: "New Drivers" -> "New drivers", "USE" -> "Use"
>>>    - Fixed spacing: "WDIOS_DISABLECARD,this" -> "WDIOS_DISABLECARD, this"
>>>    - Fixed double spaces in two places
>>>    - Added missing newline at end of file
>>>    - Rewrote commit message
>>
>> However, you failed to fix a malformed table warning that I reported here:
>> https://lore.kernel.org/linux-doc/9e3403a0-4ec2-4fbe-a50f-53f939c1d841@infradead.org/
>>
> 
> On top of that, it should have been v3, not v2.
> 

On top of that, again, it was sent as response to the previous patch.

There is also some Sashiko feedback:

https://sashiko.dev/#/patchset/20260411150922.20536-1-nueralspacetech%40gmail.com

Guenter

