Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126C93E3146
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Mar 2026 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356071; cv=none; b=ukLXfEql9IWDA556uUNZl1dpBMNLal1Hgzk5/nvx7uHOCu7eqxwucK940dZQngLvkIEAhTpAHQD1jErAzzOZJePryXQkAQo7g+zZ9Fp5LxgIke5znEBfNulTUqwLUKkbkp+5jlIDp7E/h5Z+WF7/8nNdAx5S3eSght31jJEdeic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356071; c=relaxed/simple;
	bh=bHsqkffR9nN5dimOIdRFPxaUCA87shbFhhQWaEGYRxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VjvA5SwVQV1qhE81dlKvV0RqpN8L3IjNG4IUmtsNJybkLZm0Kyo8BAaZGyI2OV9aA8TBBHtusHk2GjAGkBbIBrwzFrZuYx05dFge9mhI1bAijHjsA0awqabb6lfsQbwN3j8bz96ymVQrQo+Kep9a4xb4kvDrwaqPuoRBEBhMa7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzcLBl/Q; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzcLBl/Q"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c1092cc08cso290066eec.1
        for <linux-watchdog@vger.kernel.org>; Tue, 24 Mar 2026 05:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774356068; x=1774960868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OJeNQnZA7CoGP/YHWM8mHyQRW5SiQkbtHGkl1A3bBSQ=;
        b=IzcLBl/Q8ZAiUAS1JS8/KHSYRJ87p5DjLDyK09JnQISL8V95j4kKRMTARZ375gk4DX
         kT+89YWEjXt24Fd2iIGTTGy/MbIT84eLFDvTpPVCpdKnmHHO2sjVz7Ssk70otxbtGV7A
         mC3HCOdUPPni5kpxjT/sd0X4TDhAWT558ZyWTMnF0XPQTfmKSFtFnOqSFVv7O4oo4vxA
         P6qrY6BaXL9FQSLyoSFKX7miJ4Q6ZxPkqtDkEQHEXkLZir7sdsHIEau58aZBBhe/Xtut
         t3as9LAtBIybAfq9Iz9OZ8FmZ2+7Ju5bW0FBVxO4c8d8tYVvOHUtmwley9xve8w9xeGE
         F0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774356068; x=1774960868;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OJeNQnZA7CoGP/YHWM8mHyQRW5SiQkbtHGkl1A3bBSQ=;
        b=UQH6S1EvtGb+WwzssX03rSWrBXkA2NujzVzfi/nm3hH64e8U0k2fxrJEi9ZCYSG7/X
         C1G/XriR6HymCG7wAF3FFpeTKf84C/YW/9EVIvleMlPGN1ykaSyoCcowwhw/k/BVj7ej
         uuThpydHI3ZTT1XVVOO3kz6By4EMGWcIyiTCeXD2uaeeS/ekZgdyOphmfLzzOPn8AW3a
         b2iizc84YJzoKeGynRPOdEBr2ACD4nHb/gu8HN7zCu3cqO4PExCUjuLmjykz8FGikM5y
         F+XvjlKRDRHVG7bftfEBkR+eR4+CBUfjZzloTyfeMshh+fGKM2weZHcEwyrlGlf9KHN2
         7osA==
X-Forwarded-Encrypted: i=1; AJvYcCVTSl8fIttmEtOOv4Vq5eRVCdtS26zN7jBPOvVfj2HfvXCqPxlGdFYzshu2ExzjN9hWz2O2BR9RxltrE+pWwg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa/ZIgipiUbsMxyvWoYpnc6TE01TIgfclIuoGZkuvHfEDKSbFS
	PjUZVnPfUvdi8xkwKo3shrmHWw7gJIHcfm/0Rv8zHZ/lJM3IYtZNXv8W
X-Gm-Gg: ATEYQzwXGRExshzHtFLXWrEMdCgnMaJEY5A2tD43K29zGJQN2Nhj6ZnFiFmycC7axHF
	UU4B/UwqalQr5+aqoRIzS96KWMKjIWZ+PkBeNo9UUnaD7RV0cCCmCHmQZdJaEnqT+9v0NEfkDsI
	zmPvaABrO3oESRZH21+QxoUEpkn1bAV/lFnHyDwni1GwcrwrY5dLL7YB2oXn0j/FS8RVxLs8aoq
	5xdWGCQYEkH7trBTiASYaE6OgDGbLmtXW4Ug6GgDhPyYVs5quElr6E66L7EoTvcNu17cUw8LPlr
	mYbAvfdclw4CDU+ifLY4ewKNTXVATStIfq5b9HkQgDOe79CUY2Sx1ntbmf5T9HPC42TAGsOqEgp
	tO17+5Yyipx3bku8+3UIdWj8aHFsmry/OXknQt9deoQ6jRU1ePrCjwmTVueZ5Gpfv6EWogKLpEj
	S+EnjXGrqrxTpAtrWUHuGdcb8tFPGRw0IFpBHw85QelXSh8YtzUNzY4EcbApdCCYwFZNEl+kOv
X-Received: by 2002:a05:7300:8ca6:b0:2c1:778:d897 with SMTP id 5a478bee46e88-2c109752f8dmr7772833eec.21.1774356068254;
        Tue, 24 Mar 2026 05:41:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b31bef1sm19110428eec.26.2026.03.24.05.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 05:41:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6245c03f-6321-491c-8e9f-be66945ed1c5@roeck-us.net>
Date: Tue, 24 Mar 2026 05:41:05 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: watchdog: explain watchdog API options
To: Shubham Chakraborty <chakrabortyshubham66@gmail.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-watchdog@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260311121602.139967-1-chakrabortyshubham66@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260311121602.139967-1-chakrabortyshubham66@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/26 05:16, Shubham Chakraborty wrote:
> Replace FIXME comment with proper documentation for
> WDIOS_DISABLECARD, WDIOS_ENABLECARD, and WDIOS_TEMPPANIC
> options.
> 
> Signed-off-by: Shubham Chakraborty <chakrabortyshubham66@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Documentation/watchdog/watchdog-api.rst | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/watchdog/watchdog-api.rst b/Documentation/watchdog/watchdog-api.rst
> index 78e228c272cf..984f7362d5fb 100644
> --- a/Documentation/watchdog/watchdog-api.rst
> +++ b/Documentation/watchdog/watchdog-api.rst
> @@ -268,4 +268,13 @@ The following options are available:
>   	WDIOS_TEMPPANIC		Kernel panic on temperature trip
>   	=================	================================
>   
> -[FIXME -- better explanations]
> +The WDIOS_DISABLECARD option allows you to stop the watchdog timer via
> +software. Note that this will only work if the "nowayout" module parameter
> +(or CONFIG_WATCHDOG_NOWAYOUT) is not set.
> +
> +The WDIOS_ENABLECARD option turns on the watchdog timer.
> +
> +The WDIOS_TEMPPANIC option is used by some drivers (like the pcwd driver)
> +to trigger a system halt (typically a kernel panic or power off) when the
> +temperature trip point is reached. This ensures that the system is halted
> +immediately in case of an overheat condition.

