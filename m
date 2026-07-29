Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4276123BCED
	for <linux-watchdog@vger.kernel.org>; Wed, 29 Jul 2026 00:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785286249; cv=none; b=u5IOE3l0JFU+V9/HVTe9mJVhTsksjY1rTaAT5zsQlo7QydPIN47IfKSKpmlyZyHGpDJpYLl6UOa2XB4NjkTpLjBfYVazT2i46r2te53wqxEQtQEGujy3xJ+f4W52bDPSHGdnfIhreHUxMKeODB0myytljc5eF1xo7vgNcEDJnec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785286249; c=relaxed/simple;
	bh=qIlD9mEOqJjAyAfl/7xBqlw6j2Y/ZuH9RAaBSHIXlqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qSa+ahhWaCAJkYxYYY6/sl3pH7bdN2SeHCqfiMEkG4UxatR1mMldM40r7+ENq7C3WWRyoGLugRBXyNsZWZRTVx722eB94zru9KyIs7JrhPWQTJsSe/ZGFEUdSNs8Nju8XaSkxmITk6kVwJ3tLAOG/6Bvkf0tm6LVmoCrjbURJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5f6Ldnb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5f6Ldnb"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-848595b338cso520652b3a.0
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2026 17:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785286247; x=1785891047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UVZwS8jOvBUyjwgl3DDKvmTYA+QBde5QPL3dY7t7pMs=;
        b=i5f6Ldnb2WMZYMC5QxrGffH6fNvY2a21qjoYCkYEgwAyhp/WKwB+HJwkwQkF0k0FOr
         PtruWrFOyIIQZlkqZTIBSHV1cCOGETaCsruu/ysz4Y60oYwnNigRmy2tY1jkkhCHyawq
         udw/H5xASPPHnDX7zE6EkbTNIqIQqcj1Wr8TOSRNSAMkfFIq2w03km7HqH2hyLHMTkz5
         QMhbhf0hOtSLn12SNTEMEJoKn01D8knN9HKS8apGAkNE9XSGLR7JLz0nZVQCWT0EI5yE
         eNPaXbtt7tsPo7PRmBmw2a9PKPQosKOm/9D9VVFGXNFDmmfiVoJpoC3M4Plpr6h85vE8
         bjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785286247; x=1785891047;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UVZwS8jOvBUyjwgl3DDKvmTYA+QBde5QPL3dY7t7pMs=;
        b=eIvRMSI0Y+CiC3O3yUJ7Yt7mclr3zbVxffSpTV5nxwwNTuv30/76YIAEd0JzjT6jD5
         n+4dbf6oNFF5e7PiXqrCjYQITIpBDbF0KwR6abQ1Yjc2XubBNOlWXG9drWRZAH/bB1aM
         KOtoX9uHANtTlb2si+ea3gICEwcU74tcYGPD8jnIT2OxEWFRBC4Jt/Xkl7pbOU+VGHpS
         lLcKR+vPfkzir/Vhagd1CXuQnT45coXsKaWeQ2zPuj2gCPN5iE5+zokMF25Tbbm+JB5V
         g/SdCUpvstx+waNF5/kNHCLribXoGNqrErVAi8eNs7x1aItmLDPbNZTTk7/sqTS+3boV
         8G+w==
X-Forwarded-Encrypted: i=1; AHgh+RrMN/KO4OU4QHd2Rj70/odtV3CPGzoAc1XnL//xHyi1sysBJgKjbInpeBt43AzBzNpMud96ZGnTWe6C75Vv4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNrNuQy/sHIhpOrIdUhTSe8nT488Jxt2myu4binejedv+lx8Wi
	+Hx7EcD6YzFiyISEIP2AvdoO3nmGxL9zpVEXBnhlC3uwdHN4H9Gh0b5l
X-Gm-Gg: AR+sD13pyLtVy+nrbmaNhEhzq44FCA18nWx7x1Nz8WqZcg+SIoeCg9CTZ+hWW6RdPP4
	tNoytpJZzjUnkk2SQwlhwS7kI5paxMnA69yYsbbHmf/1iNabZgt6+u+qR5KvV4mcBczc6q5LJrU
	4S8QsB5sTTwu0nk2E1DC+591GwkF9jMcJV0zu0WDQScSypz0IEpy/WCZ3TqB75kXa7diugOa2QO
	yxCLFgSmkpvGwCQdw7XA8Nt24FV6J4VwDV18BNb8g4xm36r8HRj7iFheTX5KwcKgIwSix5toPnV
	K1s1fs+IZO0zQmHK6MRJzjJz0CRrKalH06xf4P5P0DhPL5mAzFjdQU2VxhWMQQakaHaS6ssFsld
	rjyM6vLE67B4/xnaGM5GvGZSBYSUgG831l5PWIueqsfUfuby4HpUfVzp70vzvQGfxLG04Fs2YJN
	WtQT8rgd6dXYa4wf1bfQ5kos64C242+N9UT8xxxBjgSpkvOWNG+Jt7UhTguGA/x4uKdDWpeGB3e
	pbql6CgzVYsGEgV1oKRhVbTQssd7JBb/a0NDNYNfOn77qE=
X-Received: by 2002:a05:6a00:32cf:b0:84e:1a34:2470 with SMTP id d2e1a72fcca58-84e9325c5e5mr5065072b3a.30.1785286247345;
        Tue, 28 Jul 2026 17:50:47 -0700 (PDT)
Received: from [172.19.1.48] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe2153csm565718b3a.3.2026.07.28.17.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 17:50:46 -0700 (PDT)
Message-ID: <8c59c12a-3725-4f36-9e30-cbe0e2ef95ae@gmail.com>
Date: Wed, 29 Jul 2026 08:50:42 +0800
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: watchdog: Add MA35D1 Watchdog binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jacky Huang <ychuang3@nuvoton.com>,
 Shan-Chun Hung <schung@nuvoton.com>, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260724091427.1689980-1-zychennvt@gmail.com>
 <20260724091427.1689980-2-zychennvt@gmail.com>
 <20260728-poetic-outstanding-salmon-6fabb3@quoll>
Content-Language: en-US
From: zychen <zychennvt@gmail.com>
In-Reply-To: <20260728-poetic-outstanding-salmon-6fabb3@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Krzysztof Kozlowski 於 2026/7/28 下午 07:47 寫道:
> On Fri, Jul 24, 2026 at 05:14:25PM +0800, Zi-Yu Chen wrote:
>> Add device tree binding documentation for the watchdog timer (WDT)
>> controller found on Nuvoton MA35D1 SoC.
>>
>> Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
> 
> A nit, subject: drop second/last, redundant "binding". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof, 

Thanks for the review and the Reviewed-by tag.
I'll drop the redundant "binding" from the subject in the next revision.

Thanks,
Zi-Yu Chen
