Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D2A2AD16
	for <linux-watchdog@vger.kernel.org>; Sat, 25 Jul 2026 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784989814; cv=none; b=OySzXlT8I8fRrEb+abXmxFCnjQ7lvnf0gxf/1FtfUs9FFX+hx4ICToLUZ5VaGTIOst8vOzeQrUlMKXPzVnsqE+KSdRxZZlw52Kwa1Hx9qVSxU0XlgaQsjQ8AYxk9xNus7kCSaXX2QDd+oQJx0ohJCMTUdKGkEVyDs7zkUrXOBS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784989814; c=relaxed/simple;
	bh=XqjNgk1Rmeu0o6hz9pyvZO4y9YUjvc294Z2F82jh8Gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJPM0aAJg8LYB9mOy4RN5b6AjGMX3RIY8hAycFETQPYKIQ6olCmGAvZ/BYxYgvqlaFYtTRnW7ACYsY7+XUUkCVXVQaLLzo0bu+8kAPJYOgfELt180bv46LSKyAx0+1g/GqTahTDt5B4pVTFEnh1avDb6QUnsgiGWzSrU4lLtbc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o3ZDP+jN; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3ZDP+jN"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so1288692a91.0
        for <linux-watchdog@vger.kernel.org>; Sat, 25 Jul 2026 07:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784989811; x=1785594611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8h8dg2EfGa6XzFmZvzgFvfu+2U44UCmWssYckoMASx0=;
        b=o3ZDP+jNIrYGMBhwC7uCfVnCjyd4Ug8XQjyGpjcwLF5tzy1WkrkrDXJv84G4Rimw8G
         PMoxfu/cykWvVUbLYbNsD+PiFg2CRd8XjsAu/qc/E6PWnIOREkjFWfOK1fq1neah9Hxs
         UZiJ6JJoNnr1P8fexBKV1Re7N2CVyi4odcBDZiRQmc9XjROhb1MZt2xRT/fSE4JNgSKl
         by0KLA8wEDEpmAuYEL2ahSgY1SayJWTsFzOk/PXednERdFcqTSHH1e+phfqV/sLeeHMj
         /ybEdE8F+NUjah5sh2CbpSD8nEeswfSjNDVA8G+pQhWhjhOCqr+xptftynyuqBFygM8T
         Y0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784989811; x=1785594611;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8h8dg2EfGa6XzFmZvzgFvfu+2U44UCmWssYckoMASx0=;
        b=KanuFxmftEy42TawS9OY1WXNYySQ8UDSlq9kWkKbA8eqpPqffTbInbBX5YJrNiazQA
         dd2sLIb/7LvfMw4FD2mp68i4cSWqw6A8/4A6CqazX7zWpu9a5ErN5VCwAgtPVZv5td+d
         OxTdjn3TWB3/+v2XV0P9WSuHg53nXvDL0M91pKFcYBODOMPlv5p4POm9G0Dwk/Cwg9Nt
         vHOf2zrWlFcmUS70oFadGkRjsw/fVg/z6Xn2Hd7gU7YCjjYdzzBbLaZNraReoo6gSjfE
         g2SPRB/LVaBG4n0jwutoqRlu6huJZWF9xE3O8cRoRDAA8PyUi/00mfJ69Ws+8xE36GqC
         BhtA==
X-Gm-Message-State: AOJu0YycCI4dwH1sZJdDWxVN9Qotif7CouL2uVamnUqTNyT2KI3/iWWm
	pCXxZzHo3cJ1OYcJy+oDgdhST/4qGgkcmzXhWN2L287wcYwvgvJVvxLW
X-Gm-Gg: AR+sD10u2bxrCw4Rc9Uc0dFHaNmguhng9uhBtHKTlUpy1N/qXg7u2YqLDV8ij/o4jTT
	XS6vEKYmRhw/sD3ub0h2cUcchkeKq5zZz8XF242g/+7FbCJFCgTEDPGlDhjsTrm6GROnz2oMWj3
	dxag16uIImlAM2bpRa09Uj4J1Iwwz5fypSpZ/C21xcptdHTypuZPyQS8577PbzElr9Wd3lbBCQi
	7oPcTmt4b+llqgzk+9zu1kXDzQ9WyQsv5B4oDM7Q/tqL0Y6BTlzO2j7FE3kRieXS0KUnxqTLC0l
	/s9UbgKTnU27WDM4I7xyf9P7A9M0uveJN38MnN8IqEvyF6dzVSZNZMATb7uoYdJBD6Yhq8d1jdF
	Ixa6aL3HOr1SmwywHPugWvHmpuulU6jtibmJtAukiADfrJWwpmirKIDKdsyvgKWqsBBCd0Okym7
	UgfKHDVPvQKLjf+nsQRVFM+OEWmOEOwI/GYVKq735uWvoikrDuoaM=
X-Received: by 2002:a17:90b:3812:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-38f293cf2d2mr2672761a91.6.1784989811520;
        Sat, 25 Jul 2026 07:30:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e585ae882sm1557173c88.6.2026.07.25.07.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2026 07:30:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <281bda77-e1ff-48c2-bb27-2706c735e361@roeck-us.net>
Date: Sat, 25 Jul 2026 07:30:10 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] watchdog: w83627hf_wdt: Use dev_* logging instead of
 pr_*
To: Paul Louvel <paul.louvel@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
 <20260725-w83627hf_wdt-improvements-v1-9-4e9a1b4e8297@bootlin.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260725-w83627hf_wdt-improvements-v1-9-4e9a1b4e8297@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/26 03:29, Paul Louvel wrote:
> The pr_* logging functions do not identify which device generated a
> message. Use dev_* logging functions instead.
> Since the device name is printed with this family of function, remove
> the duplicate name in the initialization message.
> 
> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>

Please combine this patch with the patch introducing the probe function,
and, as mentioned, do not use goto() and do not generate a message for
memory allocation failures.

Thanks,
Guenter
> ---
>   drivers/watchdog/w83627hf_wdt.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
> index cf1a3fb3a6fd..83c5d8b52b13 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
> @@ -471,12 +471,13 @@ static int wdt_probe(struct platform_device *pdev)
>   	const struct platform_device_id *id = platform_get_device_id(pdev);
>   	const struct wdt_pdata *pdata = pdev->dev.platform_data;
>   	enum chips chip = id->driver_data;
> +	struct device *dev = &pdev->dev;
>   	struct watchdog_device *wdd;
>   	struct w83627hf_data *data;
>   	struct resource *res;
>   	int ret;
>   
> -	pr_info("WDT driver for %s Super I/O chip initialising\n", id->name);
> +	dev_info(dev, "WDT driver initialising\n");
>   
>   	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
>   	if (!res) {
> @@ -533,11 +534,11 @@ static int wdt_probe(struct platform_device *pdev)
>   
>   	if (data->early_timer_val) {
>   		if (early_disable) {
> -			pr_warn("Stopping previously enabled watchdog until userland kicks in\n");
> +			dev_warn(dev, "Stopping previously enabled watchdog until userland kicks in\n");
>   			ret = wdt_stop(wdd);
>   		} else {
> -			pr_info("Watchdog already running. Resetting timeout to %d sec\n",
> -				wdd->timeout);
> +			dev_info(dev, "Watchdog already running. Resetting timeout to %d sec\n",
> +				 wdd->timeout);
>   			ret = wdt_start(wdd);
>   			set_bit(WDOG_HW_RUNNING, &wdd->status);
>   		}
> @@ -550,13 +551,12 @@ static int wdt_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto fail;
>   
> -	pr_info("initialized. timeout=%d sec (nowayout=%d)\n", wdd->timeout,
> -		nowayout);
> +	dev_info(dev, "initialized. timeout=%d sec (nowayout=%d)\n",
> +		 wdd->timeout, nowayout);
>   
>   	return 0;
>   fail:
> -	pr_err("failed to initialize watchdog (err=%d)\n", ret);
> -	return ret;
> +	return dev_err_probe(dev, ret, "failed to initialize watchdog\n");
>   }
>   
>   /*
> 

