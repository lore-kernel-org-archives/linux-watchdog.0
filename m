Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA27325726
	for <linux-watchdog@vger.kernel.org>; Sat, 25 Jul 2026 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784990691; cv=none; b=C0416qoVdaovjqznuHiLylUHCaAx32UsiMyZlpWS95VLkDavrBUGZebSCF2fZdXcALOuu2108AxCZpG+8XECk24HKhanUbEQY46iC04D09VOWS9ZOYMixuUkm4LGj0v4x00oTTTwRvZ7TacTaIqskgKA/lg/GqSvEiJLYBghVm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784990691; c=relaxed/simple;
	bh=Ec0ceqcpnhBqkDk1lYqP31lBY3EY8pQcDWFCmhJwRqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbA7/yIYfz+x+keze3shrWFXVJe7rxAwl30VFZkQKMy2IHcidKTI4Xo7q/qHHUNAMlt1Bq+b0CrdsKVEwWHbyL4dNX458Aey+eA7PStrOgprzcj8BwY14pZ/WVW0hwKeNHpONgtR+CP5YcfpA2kJruJ/NUIP0tOfbUorwF3Jr4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0Gt4vdj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0Gt4vdj"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cf452def93so19710135ad.1
        for <linux-watchdog@vger.kernel.org>; Sat, 25 Jul 2026 07:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784990689; x=1785595489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+lTOAeSD07OImuEb0EMligl2UkzxQJOQxIwbFnoKpyA=;
        b=d0Gt4vdj1n+Xh/aqg54SmD9vR8gz/CiitWqJSJtgQ9yL4nEl8csp4+FgqQHQM8srNx
         lix/ctvaGIap5r1rLc4ZrOgnWI/66Kcm2sZbClJH+mPif9pAcCWKZsZKompLru/sivwS
         ZWc6L7ADpjOjxmTLAZYQ03ifHWAjIwYvtcAZZ/GWfFDp/TbY890SEnSN0uDkFU4ue0r0
         A9aXJ80we2n0vL/KUJE6RhWPF5vTN3SWN8C80zKl8ArJhaOHgzeAwftgcLoVZGgLrZA4
         ZGkISohrRkhcVa1CIvrUlH1UxmkR5uHaZQJnOqRwrWix9gZzQszVW4pUcspU1Kdu07mB
         /0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784990689; x=1785595489;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+lTOAeSD07OImuEb0EMligl2UkzxQJOQxIwbFnoKpyA=;
        b=FCM53gN7qvXTmJtPgoBGg2J8+7mC/E5nta1hEcep5H0jwMVU97ta/ZeULAj/FtHeJU
         GmyFhsQ29BOU15zAHOlPY9B7isw3Q2oRMEYvGX2pGQLOKB/yPobHomhZEQwJVQg9Ulv3
         DIQPPOquOAc7vmL5nXghvuF+ykTP4aYsBH/7c3ValV0p9F8Vjufgh7n4SAUZIrE5JJt/
         AYo5U00qyK7X+HtmNYuyB8jJX7WaorGbnbDpryC4MUjka31rP/rYDkKjFCquNvY4YlvE
         OLb+G4hmh7mA7vpZAT2gXEDoWJqOkUlISgNG/jKqmuQakjMQ4rhnMbHW44W10JUNGK4v
         uOjg==
X-Gm-Message-State: AOJu0Yx7Owb3eHdxtLHSk5a3rQG8AH4+8tdqeUivNn1psLpiXuRlEWHI
	WeEeqMvfPu0aoD6zP3yI+WqMOvGERJcC+cBfXtJ5QEGqkSYOOXGfaf8z
X-Gm-Gg: AR+sD112uCgI/Z/4ZEen7/IITwvbCbKwj6bDla8jK4UOYjw/Wg8etiaYtGUz4vpbo4H
	7mvwoppumqn7VThqIXeKBtrHSRj/LX3sbKKODPTuwYKP0HmwtAdQO5G0O8diL8X7Svy8DLD1O8a
	zJnHGqul+VxfMdAUeDM9VlhXLEarTMx9hFzgTyB6H+U8mcL9eOnSOI6XhULzq1Zi3wCdoWeWjQS
	MsLaLA87X1gkxrzLdGTEnrDgHYiWx5YWyQKQmnr+HMkxuao60JFt1M5Jx8u6w7Q2w07Udih5PNN
	FRaZ942lyAo+khNt7XZeD0SVJaV4x7+Jx+KYHo18CwvQF/VbNzS8EFhE12JaL2K1lqwQRQn+sFG
	pa55xfbX9yxqO4tdrLdDoh82PeOMDzASCAEflpQ28MdO1XMUBMQiHqYdiWWsCJzRu4WKwxv3n1w
	oe5DDrYwcvFBwGgng387h7+WJA+3utekl3/qkPet39qbZwu9lJQAE=
X-Received: by 2002:a17:902:f789:b0:2c9:fc0d:165b with SMTP id d9443c01a7336-2cfd7196611mr44904805ad.23.1784990688835;
        Sat, 25 Jul 2026 07:44:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5cb670sm17089717eec.31.2026.07.25.07.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2026 07:44:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7bc9a093-e6a3-4263-af24-86b96ffc60fa@roeck-us.net>
Date: Sat, 25 Jul 2026 07:44:47 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] watchdog: w83627hf_wdt: Replace magic numbers with
 descriptive macros
To: Paul Louvel <paul.louvel@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
 <20260725-w83627hf_wdt-improvements-v1-1-4e9a1b4e8297@bootlin.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260725-w83627hf_wdt-improvements-v1-1-4e9a1b4e8297@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/26 03:29, Paul Louvel wrote:
> Raw hex values for Super I/O register addresses are difficult to understand
> without constantly consulting the datasheet. Use named macros instead.
> 

This is not the only change. The patch also introduces the use of BIT().

> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
> ---
>   drivers/watchdog/w83627hf_wdt.c | 43 ++++++++++++++++++++++++++---------------
>   1 file changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
> index db77599e43a0..1529a4e16820 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
> @@ -27,6 +27,7 @@
>   
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>   
> +#include <linux/bits.h>
>   #include <linux/module.h>
>   #include <linux/moduleparam.h>
>   #include <linux/types.h>
> @@ -71,6 +72,12 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
>    *	Kernel methods.
>    */
>   
> +#define SIO_REG_LDSEL		0x07	/* Logical device select */
> +#define SIO_REG_DEVID		0x20	/* Device ID (1 or 2 bytes) */
> +#define SIO_REG_ENABLE		0x30	/* Logical device enable */
> +#define SIO_REG_CONF_ADDR0	0x2E
> +#define SIO_REG_CONF_ADDR1	0x4E
> +
>   #define WDT_EFER (wdt_io+0)   /* Extended Function Enable Registers */
>   #define WDT_EFIR (wdt_io+0)   /* Extended Function Index Register
>   							(same as EFER) */
> @@ -115,9 +122,12 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
>   #define W836X7HF_WDT_CSR	0xf7
>   #define NCT6102D_WDT_CSR	0xf2
>   
> -#define WDT_CSR_STATUS		0x10
> -#define WDT_CSR_KBD		0x40
> -#define WDT_CSR_MOUSE		0x80
> +#define WDT_CSR_STATUS		BIT(4)
> +#define WDT_CSR_KBD_INT_RESET	BIT(6)
> +#define WDT_CSR_MOUSE_INT_RESET	BIT(7)
> +
> +#define WDT_CTRL_RISING_EDGE_KBD_RESET	BIT(2)
> +#define WDT_CTRL_MINUTE_MODE		BIT(3)
>   
>   static void superio_outb(int reg, int val)
>   {
> @@ -144,7 +154,7 @@ static int superio_enter(void)
>   
>   static void superio_select(int ld)
>   {
> -	superio_outb(0x07, ld);
> +	superio_outb(SIO_REG_LDSEL, ld);
>   }
>   
>   static void superio_exit(void)
> @@ -165,9 +175,9 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
>   	superio_select(W83627HF_LD_WDT);
>   
>   	/* set CR30 bit 0 to activate GPIO2 */
> -	t = superio_inb(0x30);
> +	t = superio_inb(SIO_REG_ENABLE);
>   	if (!(t & 0x01))
> -		superio_outb(0x30, t | 0x01);
> +		superio_outb(SIO_REG_ENABLE, t | 0x01);

Address 0x30 is always the enable register for a logical device (here: the watchdog
logical device plus for some of the chips some GPIO information). Bit 0 enables the
watchdog logical device.

Guenter

