Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46543793A9
	for <linux-watchdog@vger.kernel.org>; Wed, 17 Jun 2026 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781725567; cv=none; b=qujBlgJY2xAQT2gv4q7bH9GCQMviFdKnSrRTZKiLOIOA/cE5H2oj10Mjq63XNgi4bcET/lREpfqq4wDECCL9QY9mpqxEr03DTcdMLsO8WQXaaLZMmwhupmvYLHHKFFQOnyseUd2PZH5VO9+D402Xj30tBWmS8AFf7h1q8a5CYNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781725567; c=relaxed/simple;
	bh=qTAaHajTqwY/XvqbDHGn0OIZob55KyKquLi7x0RMCGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GzflUG0EfBWTVzHR+3MjVsw6OtOtbU3snOQ+VP9BwnzA3MP6oLBUt/2ebYYajIMiYLEwlbiRSWpChE/XrmGthlD8VIR+Mjym7ThD5BK1zcS7rkxM3Tg1w7E1cgbcC38EnmoaNhFrTj6p/3G91vBAk/KiOJI0kK3fxa+k/XZnh7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVuA/Cex; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVuA/Cex"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-13807d2f898so209813c88.0
        for <linux-watchdog@vger.kernel.org>; Wed, 17 Jun 2026 12:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781725565; x=1782330365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jCIh60LRye+N284J4p7MbAH9a0i1PCeBDLVzI3j+pDY=;
        b=RVuA/CexYtvKD4Vg1WC4Xz+P3M0Eh3+LQvGRhW4l3m4LOvvx6T/5RbNxwcQM7ZQSBC
         xPnQjXy46ddMnPUEgNmxDuPgH0choK+ANLolmWStkuYpYJ4TR+7pFsuKJ0o2BNNq9vLb
         vZz9AAIjhFi7e9g+tUwgVfdn7Idn0HOlDp4QkGxEiHr2AFZC9s8qR4GnKb8mZ0NIC5tZ
         PT8sZ8y1O0dA0tN+rzp/X7TNf4V8tFTQEcILr7EozIqGqXBpRUz77l3HfsqmxKgShhKX
         bvkTUXqjj8oucYHKkUotYqm7ckL8py6QLwbg/9EujRaUiMT4n4xbp7fFtp5CvMp3r84U
         Gwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781725565; x=1782330365;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCIh60LRye+N284J4p7MbAH9a0i1PCeBDLVzI3j+pDY=;
        b=Kbup7FxfhHFRFw2ICfnuOEOhxccxCY+XC2oEXvAbvPlhIeMNK8xF6l7PQM2b9h+UUn
         XSAjUW+J5wZNm5IsLx/+YdvxgLNe7sJdcNROAEifJwJrCoYSc2CGPxRmmxNex0VyY0LM
         Umvn+oVwzgxGwECi7iit9+Up0CY+UihiQi5OZbGzl11Bigf0VK1HZt3HyjBBAB/Gsgem
         3MApXZmD59RSNQTW+aAfZpyXUlmTc7TZXtv4k0cXOFoJOxRCjnFU+07HBpAU69JTudSF
         TFBVh8qZ00/D0aXBxzVJA9hQHLbT49gs0Fueymibbg9OPlg8ZPaS2L/QWEPsIltRp27s
         6zZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xpQK5ajKOgaUcuyjk1JydTgE2SMo+J+/9BBVAj7kL7AkJWCycsE8Q6Hke6bfURr9LIKSs0xRgFg1P8RHp0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyugWelRptAxf6/L5hz7tEuW1WqX9RZx+oT8kB4x14ZdRWkNEpt
	V6l8/V5X4IGHIL5Rzk9521jTkAJKr/u9XPq0iEm6fZorgjmtBUFIhv9K
X-Gm-Gg: Acq92OHtFFl+GaZsN2mbsov1BegLuE851sNGhC6e8eCd5FC9K27s0aY+Rg0Wt7kn6WS
	mqkt71LMAl8EC+Uyd7UTlsHkW0Jjx1rv1Gb1qlA5wkhR3siY2uln8w78fgFK6WohY3s+WoRFkHU
	Y2e8Vjpjv2wCXcy/yWAqbxJOj2YrHGkEuAnxiAm8q+0fmRDSYPac7nrBLMezlntVdFrkqWwxsDF
	zda8aFnme1pdQxX2oE7O00G71M/zrAYP8k6ouAZMp0GbYGsqeA+t0NFCkZ4pIM3QRXmuB/TZN8h
	HOQA1G3DCTplp2k6scoSEFCi1fkdQBUao7U+3t1Uw35yF8Tq79icfEiu+7g9jqIFhBtLoiBLcKO
	avdKCJbAv4vGyaCzm0z6U+BUBV5ojRU9jaHELCtwMigfMOC0Lh2G/lXW4GWB/vnQAUDQalhQHrm
	SiEIvulGf4yQPuuUB5Uek+gaGxG4WnMHDFoZTNElXyHioMQtilF1kTH39rEcPrzjfHPw7l23q0
X-Received: by 2002:a05:7022:fc07:b0:137:ea00:3f49 with SMTP id a92af1059eb24-1398f6cb641mr2356917c88.35.1781725564958;
        Wed, 17 Jun 2026 12:46:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb8f8b2sm24167978eec.27.2026.06.17.12.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 12:46:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <13836c1e-8f38-4cd3-aa7f-da7c9caf15d5@roeck-us.net>
Date: Wed, 17 Jun 2026 12:46:02 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: watchdog: mediatek: Add MT8127
To: zkh1@proton.me, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-watchdog@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260617-mt8127-amazon-ford-basic-v2-0-6859e29e72a8@proton.me>
 <20260617-mt8127-amazon-ford-basic-v2-1-6859e29e72a8@proton.me>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAmgrMyQFCSbODQkACgkQyx8mb86fmYGcWRAA
 oRwrk7V8fULqnGGpBIjp7pvR187Yzx+lhMGUHuM5H56TFEqeVwCMLWB2x1YRolYbY4MEFlQg
 VUFcfeW0OknSr1s6wtrtQm0gdkolM8OcCL9ptTHOg1mmXa4YpW8QJiL0AVtbpE9BroeWGl9v
 2TGILPm9mVp+GmMQgkNeCS7Jonq5f5pDUGumAMguWzMFEg+Imt9wr2YA7aGen7KPSqJeQPpj
 onPKhu7O/KJKkuC50ylxizHzmGx+IUSmOZxN950pZUFvVZH9CwhAAl+NYUtcF5ry/uSYG2U7
 DCvpzqOryJRemKN63qt1bjF6cltsXwxjKOw6CvdjJYA3n6xCWLuJ6yk6CAy1Ukh545NhgBAs
 rGGVkl6TUBi0ixL3EF3RWLa9IMDcHN32r7OBhw6vbul8HqyTFZWY2ksTvlTl+qG3zV6AJuzT
 WdXmbcKN+TdhO5XlxVlbZoCm7ViBj1+PvIFQZCnLAhqSd/DJlhaq8fFXx1dCUPgQDcD+wo65
 qulV/NijfU8bzFfEPgYP/3LP+BSAyFs33y/mdP8kbMxSCjnLEhimQMrSSo/To1Gxp5C97fw5
 3m1CaMILGKCmfI1B8iA8zd8ib7t1Rg0qCwcAnvsM36SkrID32GfFbv873bNskJCHAISK3Xkz
 qo7IYZmjk/IJGbsiGzxUhvicwkgKE9r7a1rOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAmgrMyQFCSbODQkACgkQyx8mb86fmYHlgg/9
 H5JeDmB4jsreE9Bn621wZk7NMzxy9STxiVKSh8Mq4pb+IDu1RU2iLyetCY1TiJlcxnE362kj
 njrfAdqyPteHM+LU59NtEbGwrfcXdQoh4XdMuPA5ADetPLma3YiRa3VsVkLwpnR7ilgwQw6u
 dycEaOxQ7LUXCs0JaGVVP25Z2hMkHBwx6BlW6EZLNgzGI2rswSZ7SKcsBd1IRHVf0miwIFYy
 j/UEfAFNW+tbtKPNn3xZTLs3quQN7GdYLh+J0XxITpBZaFOpwEKV+VS36pSLnNl0T5wm0E/y
 scPJ0OVY7ly5Vm1nnoH4licaU5Y1nSkFR/j2douI5P7Cj687WuNMC6CcFd6j72kRfxklOqXw
 zvy+2NEcXyziiLXp84130yxAKXfluax9sZhhrhKT6VrD45S6N3HxJpXQ/RY/EX35neH2/F7B
 RgSloce2+zWfpELyS1qRkCUTt1tlGV2p+y2BPfXzrHn2vxvbhEn1QpQ6t+85FKN8YEhJEygJ
 F0WaMvQMNrk9UAUziVcUkLU52NS9SXqpVg8vgrO0JKx97IXFPcNh0DWsSj/0Y8HO/RDkGXYn
 FDMj7fZSPKyPQPmEHg+W/KzxSSfdgWIHF2QaQ0b2q1wOSec4Rti52ohmNSY+KNIW/zODhugJ
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260617-mt8127-amazon-ford-basic-v2-1-6859e29e72a8@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/26 06:36, Zakariya Hadrami via B4 Relay wrote:
> From: Zakariya Hadrami <zkh1@proton.me>
> 
> Add entry for MT8127 SoC's watchdog which is compatible with MT6589's
> one.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Zakariya Hadrami <zkh1@proton.me>

I don't know if I am supposed to pick up this patch. I assume it will
be picked up with the rest of the series, so

Acked-by: Guenter Roeck <linux@roeck-us.net>

for that.

Guenter

> ---
>   Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> index 953629cb9558..e6e4546da0aa 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -40,6 +40,7 @@ properties:
>                 - mediatek,mt7622-wdt
>                 - mediatek,mt7623-wdt
>                 - mediatek,mt7629-wdt
> +              - mediatek,mt8127-wdt
>                 - mediatek,mt8173-wdt
>                 - mediatek,mt8188-wdt
>                 - mediatek,mt8189-wdt
> 

