Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042FEB672
	for <linux-watchdog@vger.kernel.org>; Sat, 25 Jul 2026 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784990942; cv=none; b=XvqT43+sB1flBsYmnmFiOuyjqOBT9Wflo2XzlhUnS6n4JSDOvxuBFLc3HKOXfFbgz15A7sD3vwvWRJBmkpJEfIHOKxotHZGOVcpFwXnhqAoZ4WobaY9oyfmrHUSmMLdz4Fb3p0KEQ261liZQe1MSsH0Y1oWtp/doFpqwS2bsOsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784990942; c=relaxed/simple;
	bh=b7XPemv9qcxYBAhkFFmj1gLO/yvMiTaBfvsBpj8bE4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8DtDPyl4EzlwxH3yp0WJ9SgYlYyea6Q6Rs4lY5Yp2fq6p6nwXzeOUGl4mvmGu8LEwCOdOAYgxWVinf19gDO7ryWoy2h4P5tdy8dtj96/hWRZQ0o9kIM72H4mIU4Bka2VrBZIXTYF5K4cKpWW2SuT4wLASUYkUPWAJgRYPqGlGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOGa+J2f; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOGa+J2f"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dcbade417so1462806a91.1
        for <linux-watchdog@vger.kernel.org>; Sat, 25 Jul 2026 07:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784990939; x=1785595739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nyhRQ5eTFZhyRu5J+4Xf/fMeAruQvfv1oRfZpxmZg/I=;
        b=AOGa+J2fPmWWHnXIoP12OpVUtsiSdljOOFntHC2iBzBc3YXK80UEhQKA7V/1iZuvEf
         bciQQAI75M0haSh0a5NOKv1o4u8zl5rQHmiiry1hPLghg2bMwkfpMJyTzEHi/W4VgAuf
         4i+gqDIF66DHByK/Bcw4Bpsos1NcOYmLLtDfOExgYP3swZK84eXpMT8Nm2Tr2325T50b
         L9tyG0ePzX7QhjexY3KHRnW9fIIgMOfFUeKhR02/+mEflmoGUm8UEww90C5MOoSx32S8
         SbZg/1mXhmn6i+AV7etoaiI3KJRrIstzA1c2xd/m3+mj/3Gt8GVqHa+v6sxjLmOF7j90
         cQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784990939; x=1785595739;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nyhRQ5eTFZhyRu5J+4Xf/fMeAruQvfv1oRfZpxmZg/I=;
        b=chQ/GFAYC4KZ2s3nQd8//goxWVWn7nPnX60kb+lFE4HwYUFIHzxGs3V7bpwxd5HCyW
         BpGSZan6Lhmtu6aGGf45uOqdnFVcMn10OHgWH2zNREC7WQ5mrPh9+jSdPI+qwX1cZzn5
         E34m0jK8r+TQSgRLFpJGFp85XDHmWPndj17WW9Ie/4TriKbmlbWttyamhu16ePr6ZfLD
         9U/Ozx+v6RdvTaaTsUICcShZmbNpbhu6J+63yyfnxf22zAakpfkjRsyAZzjj8BRFepru
         FCj/qNc7h3Od5gmWDGX8wTFt3vG+fwXO0qxq4RMVPBBPYVAz8m9jgddK9PBJNlLS/Zm/
         3NgQ==
X-Gm-Message-State: AOJu0YycbMgihCg8JG7wYd4EFBQt8LNYxgGNQsZE8TU/S6MPRVxjTy6S
	Rauvlm1yjadp57SXDcvxEg3UrgvcDXNwXRopGtz7XQd9KuWkf3lXSVTMIkZV2w==
X-Gm-Gg: AR+sD11kRF4+sShnfL9KoYbI3FiXHITjQvYie5ceFVk56Rwk20BSQ2dnD1GbWW5C93U
	VwUFWehNN7NVFVZG+OMW4EAnWccDkeDvhSiPOj07vr/Cx8gwcoDYr2jlQVMmyJqSyrGBHqmeLZ0
	nEenTMLe0/j8B0jwI3H0oSseS4c8GEru3Sby3qjLrLWUQ7rWFEEbVwAh6+nkrBCiNcWD7sZ9bMH
	TQ7HIm9NZEh7fL9RNAh4e2DLyPF2f7q6o4X1DvgPj5tJcswmi5PGIeqGe43mbsKjN5v79IBR51s
	RBGm8LXJJVCo0xEeEYtFGoftU9VagJMX2baXvso1YBqzh7epozekKFvtW4o76x88SvJrzTaCzAG
	EV+7qccOKE4IKnbSEEBt1uxYLJkrfNlpM+6fBJwrmlkwD0EvD+DJpA8UlmLvIci99J1If0jKkjP
	lx1NApwSl+8jgmpWF8Fa/VM0QnWzmVXmocl1KBuvHAwEuIw7JYeGI=
X-Received: by 2002:a17:90b:1d52:b0:37d:ee77:78ac with SMTP id 98e67ed59e1d1-38f29528e07mr2629314a91.19.1784990939237;
        Sat, 25 Jul 2026 07:48:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d2eb01aa0sm20507787c88.3.2026.07.25.07.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2026 07:48:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e063aa8e-abb2-4142-b70c-1c3c1dba6ff1@roeck-us.net>
Date: Sat, 25 Jul 2026 07:48:57 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] watchdog: w83627hf_wdt: Convert to platform driver
 model
To: Paul Louvel <paul.louvel@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
 <20260725-w83627hf_wdt-improvements-v1-2-4e9a1b4e8297@bootlin.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260725-w83627hf_wdt-improvements-v1-2-4e9a1b4e8297@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/26 03:29, Paul Louvel wrote:
> Convert the driver to the Linux driver model with a platform driver /
> device.
> 
> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
> ---
>   drivers/watchdog/w83627hf_wdt.c | 131 ++++++++++++++++++++++++++--------------
>   1 file changed, 84 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
> index 1529a4e16820..993e65ce4447 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
> @@ -29,6 +29,7 @@
>   
>   #include <linux/bits.h>
>   #include <linux/module.h>
> +#include <linux/platform_device.h>
>   #include <linux/moduleparam.h>
>   #include <linux/types.h>
>   #include <linux/watchdog.h>
> @@ -129,6 +130,8 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
>   #define WDT_CTRL_RISING_EDGE_KBD_RESET	BIT(2)
>   #define WDT_CTRL_MINUTE_MODE		BIT(3)
>   
> +struct wdt_pdata {};
> +
>   static void superio_outb(int reg, int val)
>   {
>   	outb(reg, WDT_EFER);
> @@ -464,6 +467,37 @@ static int wdt_find(int addr)
>   	return ret;
>   }
>   
> +static int wdt_probe(struct platform_device *pdev)
> +{
> +	const struct platform_device_id *id = platform_get_device_id(pdev);
> +	enum chips chip = id->driver_data;
> +	int ret;
> +
> +	pr_info("WDT driver for %s Super I/O chip initialising\n", id->name);
> +

Please drop as noise.

> +	snprintf(wdt_info.identity, sizeof(wdt_info.identity), "%s Watchdog",
> +		 id->name);
> +
> +	watchdog_init_timeout(&wdt_dev, timeout, NULL);
> +	watchdog_set_nowayout(&wdt_dev, nowayout);
> +	watchdog_stop_on_reboot(&wdt_dev);
> +
> +	ret = w83627hf_init(&wdt_dev, chip);
> +	if (ret) {
> +		pr_err("failed to initialize watchdog (err=%d)\n", ret);
> +		return ret;

		return dev_err_probe(...);

> +	}
> +
> +	ret = devm_watchdog_register_device(&pdev->dev, &wdt_dev);
> +	if (ret)
> +		return ret;
> +
> +	pr_info("initialized. timeout=%d sec (nowayout=%d)\n", wdt_dev.timeout,
> +		nowayout);

	dev_info()

> +
> +	return ret;
> +}
> +
>   /*
>    * On some systems, the NCT6791D comes with a companion chip and the
>    * watchdog function is in this companion chip. We must use a different
> @@ -490,36 +524,49 @@ static const struct dmi_system_id wdt_dmi_table[] __initconst = {
>   	{}
>   };
>   
> +static const struct platform_device_id wdt_ids[] = {
> +	{ .name = "W83627HF", .driver_data = w83627hf },
> +	{ .name = "W83627S", .driver_data = w83627s },
> +	{ .name = "W83697HF", .driver_data = w83697hf },
> +	{ .name = "W83697UG", .driver_data = w83697ug },
> +	{ .name = "W83637HF", .driver_data = w83637hf },
> +	{ .name = "W83627THF", .driver_data = w83627thf },
> +	{ .name = "W83687THF", .driver_data = w83687thf },
> +	{ .name = "W83627EHF", .driver_data = w83627ehf },
> +	{ .name = "W83627DHG", .driver_data = w83627dhg },
> +	{ .name = "W83627UHG", .driver_data = w83627uhg },
> +	{ .name = "W83667HG", .driver_data = w83667hg },
> +	{ .name = "W83667DHG-P", .driver_data = w83627dhg_p },
> +	{ .name = "W83667HG-B", .driver_data = w83667hg_b },
> +	{ .name = "NCT6775", .driver_data = nct6775 },
> +	{ .name = "NCT6776", .driver_data = nct6776 },
> +	{ .name = "NCT6779", .driver_data = nct6779 },
> +	{ .name = "NCT6791", .driver_data = nct6791 },
> +	{ .name = "NCT6792", .driver_data = nct6792 },
> +	{ .name = "NCT6793", .driver_data = nct6793 },
> +	{ .name = "NCT6795", .driver_data = nct6795 },
> +	{ .name = "NCT6796", .driver_data = nct6796 },
> +	{ .name = "NCT6102", .driver_data = nct6102 },
> +	{ .name = "NCT6116", .driver_data = nct6116 },
> +	{ .name = "NCT6126", .driver_data = nct6126 },
> +	{},
> +};
> +
> +static struct platform_driver wdt_driver = {
> +	.probe          = wdt_probe,
> +	.id_table       = wdt_ids,
> +	.driver         = {
> +		.name   = KBUILD_MODNAME,
> +	},
> +};
> +
> +static struct platform_device *wdt_pdev;
> +
>   static int __init wdt_init(void)
>   {
> +	struct wdt_pdata pdata;
>   	int ret;
>   	int chip;
> -	static const char * const chip_name[] = {
> -		"W83627HF",
> -		"W83627S",
> -		"W83697HF",
> -		"W83697UG",
> -		"W83637HF",
> -		"W83627THF",
> -		"W83687THF",
> -		"W83627EHF",
> -		"W83627DHG",
> -		"W83627UHG",
> -		"W83667HG",
> -		"W83667DHG-P",
> -		"W83667HG-B",
> -		"NCT6775",
> -		"NCT6776",
> -		"NCT6779",
> -		"NCT6791",
> -		"NCT6792",
> -		"NCT6793",
> -		"NCT6795",
> -		"NCT6796",
> -		"NCT6102",
> -		"NCT6116",
> -		"NCT6126"
> -	};
>   
>   	/* Apply system-specific quirks */
>   	dmi_check_system(wdt_dmi_table);
> @@ -533,35 +580,25 @@ static int __init wdt_init(void)
>   			return chip;
>   	}
>   
> -	pr_info("WDT driver for %s Super I/O chip initialising\n",
> -		chip_name[chip]);
> -
> -	snprintf(wdt_info.identity, sizeof(wdt_info.identity), "%s Watchdog",
> -		 chip_name[chip]);
> -
> -	watchdog_init_timeout(&wdt_dev, timeout, NULL);
> -	watchdog_set_nowayout(&wdt_dev, nowayout);
> -	watchdog_stop_on_reboot(&wdt_dev);
> -
> -	ret = w83627hf_init(&wdt_dev, chip);
> -	if (ret) {
> -		pr_err("failed to initialize watchdog (err=%d)\n", ret);
> -		return ret;
> -	}
> -
> -	ret = watchdog_register_device(&wdt_dev);
> +	ret = platform_driver_register(&wdt_driver);
>   	if (ret)
>   		return ret;
>   
> -	pr_info("initialized. timeout=%d sec (nowayout=%d)\n",
> -		wdt_dev.timeout, nowayout);
> +	wdt_pdev = platform_device_register_data(NULL, wdt_ids[chip].name,
> +						 PLATFORM_DEVID_NONE, &pdata,
> +						 sizeof(pdata));
> +	if (IS_ERR(wdt_pdev)) {
> +		platform_driver_unregister(&wdt_driver);
> +		return PTR_ERR(wdt_pdev);
> +	}
>   
> -	return ret;
> +	return 0;
>   }
>   
>   static void __exit wdt_exit(void)
>   {
> -	watchdog_unregister_device(&wdt_dev);
> +	platform_device_unregister(wdt_pdev);
> +	platform_driver_unregister(&wdt_driver);
>   }
>   
>   module_init(wdt_init);
> 

