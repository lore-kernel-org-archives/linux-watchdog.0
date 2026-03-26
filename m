Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9AC32AAA0
	for <linux-watchdog@vger.kernel.org>; Thu, 26 Mar 2026 04:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774501020; cv=none; b=IO7cJzDCrrVvhjIgJae7dsbrwke030YAGb6+HLNf+Jtb2MqYl6EWjU8vWbC+NzLOvtN7Dyd5I84A83qJP20dYUPiq8/ahrNdxSbRkvOORbGRTnGNO/DNkl3hsq47I6T/PUya8IE/J8Fpay4Y7wQOwyK4QxvGDO+7OVgUmyz/8M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774501020; c=relaxed/simple;
	bh=3liW3TTczHbCWW6xyzTaD5p7Ee26sA2HpZbUQqz+dhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MOrpQH8hkGqWosrufjkmYcS+bUWi7SUMn5AgZR5OTfIdaiPUH0RqRixRLAYBqW31hzAwaXXPX1vVX9MdaWHMe7fjeH3vi9VsQD7vTFlGC40AmZx63LCD7ENP7DeCymOK79kd31IZ0GHNwu5t3i/ZxEriasnHkOFiek3bb0yYc0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvadGilw; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvadGilw"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c0ecaae7dfso1010948eec.1
        for <linux-watchdog@vger.kernel.org>; Wed, 25 Mar 2026 21:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774501018; x=1775105818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mdrREemxYfCx5YD4EhfvcYVTWQ7/gTjv0x5FHQxyZYY=;
        b=hvadGilwxeAZ8KncV/Kxc2pAyJEp9aKdsvxL/2LA8/z4olz+Zhl68DZ2DIKf14zWdo
         1zFJBV5QADndhKRi+3u2eD2ms5MOth2sb+fgWF6LZKtsPKut1U+GB/QyfuS9ap8FIn4u
         1IOZULtRtfOdYD2sm2TpCleshV1W4lxCjkDrfNvwgQ90AzEKV+EV/kBnpckT4bO+fpA5
         EO/B0O5o+9JwOpo8C6KdOP0/ynlh9Ze0tJXHJ0PKCEvq4AJiEygAXSYICzvt4wnP+Y+n
         fee9WwPcHW1cDLbeaPqLNrbCALkstCJGEkaFrotIGzk6SNPtyHGedsVIk/pqlEwMIUk9
         zcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774501018; x=1775105818;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdrREemxYfCx5YD4EhfvcYVTWQ7/gTjv0x5FHQxyZYY=;
        b=XIQDEr72PH2J/KpmHbjlqKZlGDfBlp0eatfpgR9o6Tw7uEul06AnvmCWomWTgsn6Gv
         uD/i1YH+u+DUUMvYOzQbX+Busegfhtfhjts/ezfPfdyooOlkObYIdwStgrvjXcflGpev
         BStQM50PgAz5/dsBn/eK6FeZ6CJ+mXIEwfi6QIL+jv44EIqlZvQMQNMKtYkuDL+rtTV3
         y08miF6gAP7GJNFGv0AnT4w6yX2J1KSeiKAF3JCKLQpa4uZWXlGnFXkCDHC+fYtnlOn/
         MNpGknSIM/1JF+Nyxmn7wha66wwI18xnJUCiEe3QpQKY6VsJgXdZuPHRG2zv258G/Kwg
         QtbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcVVHeGvuBQtv4H4SLMjcZeKfKs87iwmxxW315dA23UGI4smp+if865aTtXqM5e4XoSBRfl1haT6t5LWSxFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnVnfwC3Z8Uj9gr/Rr1xBDNm7C3c1H/1ABN9ydEz3fKNV+C3bg
	XBsJwsrEKDPRUfxRjCx7NwvxOsMEwtFJf+qT4MHnCnIMAI6QnyEXEhbp
X-Gm-Gg: ATEYQzzA1tyiTWaEtWw/HwOhRtUkLr5abCH66rHnVQ5/jYUDpulTlCz9rfQJI6mnfxH
	pSCW+SmwnTktFLMO2520YbIE6AcUYtwLYTsfmD0dQH/2vN8uuhBZYe6oORxD8KyO6AIoPfC/QYW
	PkwnM5Uq0s61LaXfV2TgM7kwI7S/LGJdOu/D5eeE6jhZfNcycHOA2ha0+DQeOsyQXH9ptIODzN7
	FYjBRrZuANzzENUCGPjglyC5wdsX+QSfLkiuRjnky8Qgs50zYto+Y+1rjCIlgHT07UiudMySSrZ
	ZD+TTgrAR7B13XzR5JseH49D87t/H7VTp1gZEzGDODIT7wTsVxicyvBYT7pFrsVDZBQezuddQ9l
	oKxhXUdaNvT0Qo15fuRoKbzeSIZH8OwYKaDDoQUld/jb0lM5Xqh6p8cJndb1i5/vcBhkiwVRSSL
	T5ArdvXyDEcL5X1C3kTamqrS6SZE9CvDzyrVcZ4EOnxb2OhmtJ938mtWY1g/Eeu2wHLkH8iMFw
X-Received: by 2002:a05:7300:430e:b0:2be:9989:331e with SMTP id 5a478bee46e88-2c15d2805admr3224190eec.2.1774501018257;
        Wed, 25 Mar 2026 21:56:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16edc0458sm1635295eec.21.2026.03.25.21.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 21:56:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <478e7388-f91e-4e26-bc47-eef4ec5b1c1f@roeck-us.net>
Date: Wed, 25 Mar 2026 21:56:55 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Add support for AAEON SRG-IMX8P MCU
To: "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?= <jeremie.dautheribes@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Lee Jones <lee@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260324-dev-b4-aaeon-mcu-driver-v4-0-afb011df4794@bootlin.com>
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
In-Reply-To: <20260324-dev-b4-aaeon-mcu-driver-v4-0-afb011df4794@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/24/26 12:24, Thomas Perrot (Schneider Electric) wrote:
> This patch series introduces support for the AAEON SRG-IMX8P embedded
> controller (MCU). The MCU is connected via I2C and provides GPIO and
> watchdog functionality for the SRG-IMX8P board.
> 
> The series includes:
> - Device tree binding for the MFD driver
> - MFD driver that serves as the core driver for the MCU
> - GPIO driver implementing the GPIO functionality
> - Watchdog driver for system monitoring
> - MAINTAINERS entry for the new drivers
> 
> The drivers follow the standard Linux kernel subsystem patterns, with
> the MFD driver registering the sub-devices (GPIO and watchdog) which
> are then handled by their respective subsystem drivers.
> 
> Signed-off-by: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>

Sashiko reports a number of issues with this series.

https://sashiko.dev/#/patchset/20260324-dev-b4-aaeon-mcu-driver-v4-0-afb011df4794%40bootlin.com

I can not comment on the non-watchdog concerns, even though the ones I looked at
seem to be valid. However, please address the watchdog subsystem related comments.
If functionality such as CONFIG_WATCHDOG_NOWAYOUT is explicitly not supported,
please add the rationale as comment into the driver.

Thanks,
Guenter

