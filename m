Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD953B2FEB
	for <linux-watchdog@vger.kernel.org>; Mon, 23 Mar 2026 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276801; cv=none; b=KWRjINHZMLNLlVvRXaYomyWm9UAAlbO4J5mGcF5XDOmWSx1kiQzWRcYeuJikWIz83wXC2nzG7MZIfMHf+rUAo2h+WGpyQWuTDqPEAJ7e1nHPYDYgpAljnpdnB8i2AoZlUfmUTMv+gG+QaYWJOBvIZsujdBmttu3XKwFgM2C2xQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276801; c=relaxed/simple;
	bh=EAwm+c1X7ZW/YNOmEbkj0Wp7Rn/37OgDD2SHac629fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4UNKnP2M6TlQnmKnYN+Pe7PvmF/aGL0TAzPLqQbrtUJe3ypknqv2U2MFik/xg5AzB07QR3ZrjqijGxttru1CBuChxJ92rd+Jjb9vvaME1FI7BmiRXqfnuP/xzuvi8uJlD4WnwyFnXM6jUfFgtSrG8vllu6HjvFpFz9WDNTIEoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+VUPX0z; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+VUPX0z"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c10a2e2cd1so2605517eec.0
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Mar 2026 07:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774276799; x=1774881599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EhW+sTQ5uMV9NtstQcULn/1RJKb4QfjPVj8KfV9dWtI=;
        b=F+VUPX0zIWES0e03km0EE5DPeIzAAh6TRVW4MFdyqfZdtH7REuUOghWiloGP2HtZoE
         Fdee+LZC8VBsQmMCrWcIuyXw40UJNRMAkMnGJaJ1jlXaAbZSrVCBOIg1/iR2MUCbAlrJ
         g6ZO933wEUXe/5CVR3KURWterOFwVjWoxmZImL7ZdgKgHMoO5urYfF7B38vvj+2zryzP
         t/oGfJMjjLlE+BgojaS5rlqCBmjdU1vGpLVAZ0MdZN0hrf2MA1tlsifH/sLha6Y/vQkB
         60PzdfYEyeMKxKX4V+1XfE4bxlS5ilDDaqTklr6/vy2/IsjPaJlYk/rqwdUYj58XgxLO
         UE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774276799; x=1774881599;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhW+sTQ5uMV9NtstQcULn/1RJKb4QfjPVj8KfV9dWtI=;
        b=d74IzuiDPSLehTMxs4ES7J8j+WmxfrEXh7YdlTBZHKh9VxkFfzWfWpchke4ORG+w8U
         Q9KyXhUNttUSHQ79nbbTUYQCn89nFy6HAsH0OFpU0fg5faHz+UmAPI3VUO7l2/79TCn0
         PEb+ArTAL4U4WIKAZnILR+i9jqJvG8GaUE1OvQRm+MI1bd1f3Q/lGVoXSnFOYYWPEx6q
         CWYosm11xc2SVZaLJbaLHyx62KfRiDqPNPJaVKFwKOO30Qh0UrjkFhm2jxqXzVwrPqTA
         YjUmTiLGBFDxBjPjOap9ugeXRXJZQ/PfKzLMcGoznsq5DOiCZWPyCp3lnB+QQlR82pUD
         1+gA==
X-Gm-Message-State: AOJu0Yw4tHmDhwVC2dcXYqv1in37yZAL0ln97NUo4U0TxSV4g23hQeC8
	vJaBjlG5/yFUmnK1qM/Z2Pi7TkeI1ZmQZUKwqUUxdFi5dMg9IY18Xwv7
X-Gm-Gg: ATEYQzxHIEe8QwAblVQwksva1sn+vPlOVESWnymKynwMGe3O5ayEyB9aMF5PA68dqxw
	IJnLgGxq4naaTt7ncT5sDtgT5AkJ5Cz2aM+gXtWKCHCtAiQ456UA2fIoG+9/MbeQSatye3ep1DS
	t2V/M0Q3Xglb/aVrkfIc76T41DkWWKfMbm/3sEyMCzOcfPx16v4kQU1rBD58jxAH6SgHTJZT/CO
	gQLaBzUzrn4un1EFPX82ki94kY55XHIKzBbp5kaNNkTZxuG8LAmpZ87QBb+GANkFMlnZBLAQpf/
	dQPNtFxtPag4nYZuGmw89aEG75GLXvp4NZ9DVg8/GrYYkGDdaHjMFsMvmAf9ed7yKDS5+XL/ikR
	HxH2GmPZcffHVPTnaSoDfS+ZI6wu7+Nnwe9rPGONMRv5mhlf1qHMruPgufJiWLQn+u8jTGMbEfO
	gpwoN26cCbnKGumpv4UZn07xcKQSQY/5LDhN0W39kSXWrxQvYrF13wnxH0LqR/wMOwhqcLPYW2
X-Received: by 2002:a05:7300:724f:b0:2c1:7ca:ceba with SMTP id 5a478bee46e88-2c10975e943mr5928025eec.23.1774276799305;
        Mon, 23 Mar 2026 07:39:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2e6c30sm12159488eec.25.2026.03.23.07.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 07:39:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dae4644d-ab3b-4b67-9a80-921a9c915dd9@roeck-us.net>
Date: Mon, 23 Mar 2026 07:39:57 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] watchdog: gpio_wdt: add ACPI support
To: Flavio Suligoi <f.suligoi@asem.it>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260323125204.164785-1-f.suligoi@asem.it>
 <20260323125204.164785-2-f.suligoi@asem.it>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260323125204.164785-2-f.suligoi@asem.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/23/26 05:52, Flavio Suligoi wrote:
> The gpio_wdt device driver uses the device property APIs, so it is
> firmware agnostic. For this reason we can now add the ACPI support in
> Kconfig.
> In this way it can be used seamlessly in ACPI and DT systems.
> 
> For example, a typical GPIO watchdog device configuration, in an ACPI
> SSDT table, could be:
> 
> Device (WDOG) {
>      Name (_HID, "WDOG0001")
>      Name (_CID, "PRP0001")
>      Name (_UID, One)
>      Name (_CRS, ResourceTemplate () {
>          GpioIo (Exclusive, PullNone, 0, 0, IoRestrictionOutputOnly,
>                  "\\_SB.GPI0", 0, ResourceConsumer, ,) { 3 }
>      })
>      Method (_STA, 0, NotSerialized) {
>          Return (0x0F)
>      }
>      Name (_DSD, Package (2)
>      {
>          ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>          Package (5)
>          {
>              Package () { "compatible", Package() { "linux,wdt-gpio" } },
>              Package () { "hw_algo", "toggle" },
>              Package () { "gpios", Package () { ^WDOG, 0, 0, 0 } },
>              Package () { "hw_margin_ms", 2000 },
>              Package () { "always-running", 1 },
>          },
>      })
> }
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index dc78729ba2a5..966489fe8c8d 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -250,7 +250,7 @@ config DA9062_WATCHDOG
>   
>   config GPIO_WATCHDOG
>   	tristate "Watchdog device controlled through GPIO-line"
> -	depends on OF_GPIO
> +	depends on (ACPI && GPIOLIB) || OF_GPIO
>   	select WATCHDOG_CORE
>   	help
>   	  If you say yes here you get support for watchdog device

