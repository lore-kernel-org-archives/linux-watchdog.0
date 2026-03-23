Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01834239E6C
	for <linux-watchdog@vger.kernel.org>; Mon, 23 Mar 2026 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277142; cv=none; b=smXkYi2D3FoC/8OUkjYSDfow2AetydU2F1qg9PiKHEd5zpiIvahwSffXtyskNoTTZGVKdsSB606/3Q2xxpLRHjpHKHNRQLWX/dwG/eelTC9TobHRMLS88pGUArBakcIEPfqHOiFihF6Zjx+onDGaEfCZ0cKYsTsHAhb1C7h5hoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277142; c=relaxed/simple;
	bh=Btw1c2HBNOjynBg9HMKRXHEjIeWm2xGVPfJB65Us2d8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmUnVdqk0w5TArHHind1z+AfM1fFjAnLBHt6hN2orHjQ9f4Ys+6m6lENo0c6YSk2SwA84Fc3N1XFrbuyAbiaao5aw0QGDEgtQeioypOuAwJ+8oHwYxMnOC4MVih7PvDbZFqDDVM0UdI4JrxR1/UtdhcOUX8eMQuZgby9oEyyR8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqfN0Rh7; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqfN0Rh7"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c0c955a481so3007643eec.1
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Mar 2026 07:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774277140; x=1774881940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=I+oWMSCKxMSzMwfiT72a6Og/7ntIqLA0/09brtyvtUs=;
        b=fqfN0Rh7Tb/VxDt08+L2oHEOl/thL5w89e5GssIa/BvSQEZFSWTeXng/1MZUy4pkBi
         G5RlLDQRSX0OUzfuM8KvBgnFsQB80I6O6F6LS1ppIDkngvsF1UiKZYmpT3SmeXHnBNCm
         PEPiNKj08J9PTEFlMIx4MiUtO93Ct+QyRmiaTWrxhKglxiH7TS01M+b64nzY2M6LW7CX
         pQ9Hhq4kMyrv0F/tSVCzYZ8voA0Cgp1KybD1nXgz55FNCwLDDJ6a/6Y7JMqvpsBrnkfS
         /LBHQrbUOWJozrHUQo1VMIFurfzKGEwvIbfDeO9ywedwhkDDRs0O6/Fou7GsJfmGPZu1
         fY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774277140; x=1774881940;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+oWMSCKxMSzMwfiT72a6Og/7ntIqLA0/09brtyvtUs=;
        b=dwVoDss0PrbyzF7WHeKD9pEk5NLepGqB/9jJ/sSLePY8R50s8RzP19mPKpHccR9ON+
         yQhFsGydBE8OrzVN2iScu1RVOoA44jnXqtraBj3QEtWnQhMmDIx5be3oa0raiiLvaGez
         int9ZlLyshBmR/ZHVaPkN1uPqEuA/kZtIKa/Ma87koUPwkVE0DgP628E6DEWlWckWWPM
         5LkIRgET5X2rXot6mBpyoVuFhgWfyzeErpQ+0k+OBYFaGbUKZ+6m2mjuhYbcPuk1nSeK
         /2x45/n/9JWzN1Wncs/DfOcBaTeRGk2deyC06Zg0kexl73/5zAlP2wlImCUnjd6gsbgv
         OQag==
X-Forwarded-Encrypted: i=1; AJvYcCUbVQI40wcgILL9agKoyVi8QXY8lnzeyLj8X5q/2VgcozpEc6E5gnMSTfAyz+xeavAOaWPAOiHS5b3ifjCWUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyW4kuxX88kaFQOykOcJM31mg9evxnGhzKxRWkeQ7PB8IOoP5z0
	mwRZDUjZU15DOuYwa15BaZpC2CTxrkzo5NAfz/3YsoEjeTFc2wq4pYG3
X-Gm-Gg: ATEYQzxtM2tEyIMy50YziRd9XfLO01hHNcbKZt0+IfOQXqXMn3tAIgnivA2GMPYUiuQ
	M/1L21R2LNn8jgP+3vGR5k5HsOk2zEg7STRHnR+PDsvAK/wmNp1ic3zkvZD2uDJ81PWm6YoN6Qg
	ppw4FQWvlTCKgabpDcJLQ18jb5+/7fvI2SiKawfqADWFUKCNUGzl/cNYNEpZePvot2VjHoNZF4R
	KkIq+HudE/vEHtRS5d/wh9OuRGBs5sOpa9LZFC0A1np6bprKvSgnLedxrA7GNqi5q1weEVvZEyJ
	ZMCYTsi4EQdU8IZs4F+9zWw+rz8i9Z+0+Dhs4EIulF5VKxBhmf4SGrAuKZnUk/3dOym/JKC7Og9
	6X6dEyqb//EG/uN2EA35pAxH4KFRbbhxGV2Hcue1s4gY8CpU+UPrrPE/M6nIaejxeIBIcagioa7
	R0Oa87PKsOsvp12IssQHf9MAmPHRPBOGwDgI5foTzQQ0NhXhhotbuid4icFuFDtHsiHm2Zm4uU
X-Received: by 2002:a05:7300:a883:b0:2c0:fec3:fcff with SMTP id 5a478bee46e88-2c109712ae0mr5271934eec.17.1774277140029;
        Mon, 23 Mar 2026 07:45:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b29d28csm15457195eec.19.2026.03.23.07.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 07:45:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <696f0e32-5deb-401c-9b98-830c6bfdeca6@roeck-us.net>
Date: Mon, 23 Mar 2026 07:45:38 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] dt-bindings: watchdog: Drop SMARC-sAM67 support
To: Michael Walle <mwalle@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>
References: <20260302122540.1377444-1-mwalle@kernel.org>
 <20260302122540.1377444-7-mwalle@kernel.org>
 <f124b200-09e3-4e73-a100-f47007732e8f@roeck-us.net>
 <DHA13HM1GIJW.1E7XCMY349JX7@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <DHA13HM1GIJW.1E7XCMY349JX7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/23/26 01:45, Michael Walle wrote:
> Hi,
> 
> On Mon Mar 2, 2026 at 4:01 PM CET, Guenter Roeck wrote:
>> On 3/2/26 04:24, Michael Walle wrote:
>>> I was just informed that this product is discontinued (without being
>>> ever released to the market). Pull the plug and let's not waste any more
>>> maintainers time and revert commit 354f31e9d2a3 ("dt-bindings: watchdog:
>>> Add SMARC-sAM67 support").
>>>
>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Everything expect this patch was picked up. Guenter, do you want to
> take it, or should it go through the TI SoC queue?
> 
> Thanks,
> -michael

I am fine with either approach. Wim handles all watchdog subsystem pull requests,
so we'll need his feedback.

Thanks,
Guenter

