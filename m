Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC003947B8
	for <linux-watchdog@vger.kernel.org>; Thu, 13 Aug 2026 05:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786597886; cv=none; b=mLGdDFdPDITtzRyaBvHmfaRukM7hi/0dnXLuvbMpQwnn1olVefCmLaCw2c+vcns4UgjOKIzD08EqjSOv4ifIbcrLJUsNHj+QhzqOv9B5VFFRjv9Mmcjlbl+O64iNCiXuOaQ4NHgyEYQc8ezczgJxv279umCf3rJnjCHA1gValhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786597886; c=relaxed/simple;
	bh=CqA3//MdbEwnAUFgVx6wURQ6RyNRQSCGMIg+OTBSQjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mc39GJuqjliiAnqYInO3URSYdtUfSZxxxHBImN4EmPI8L21PX8dQHZe1mEDOm63YdqA/tTLB3GcTaRhF34vYP413LLzmmX0gus4MMSvCkQzBIG1Mn48vMg7J8NY4xEBShpuuErSzHmXMze/87f2r09pqIJMRfPDWgGXdgDrhHhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTQwvj9N; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTQwvj9N"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so2335919a91.0
        for <linux-watchdog@vger.kernel.org>; Wed, 12 Aug 2026 22:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786597868; x=1787202668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hbgXz5++RlW5L6cDaDP8mafunaN5CoUMDCWXW8oXEmU=;
        b=LTQwvj9NiSkPjwKSgaYK2mFD4vmwGFm+OQSRjRewp89Ds/LqDfpEZALicD1vrOH9rp
         d+4AbmnGXpCwYbVtQ56RDe11zJalvDBlxtCF6ON79n0CKRl5YHRB38hQCyshPHzm85OS
         h4+z657Q11AcldpAF2lLRoJ3e62TtbmXxsVlzNjL2myfb5vjrZyOxmci7Fj6ET8H5+l5
         DQN3qexGBiW1qImHUMdbfzQ48PhHTTuLkTrKG+mm/55Vo7vpCN7tXYv9CiXj3pEz2RUm
         WW2hF+ZqWNtA1fjAiyFd7G5UQdHw3QpgHzjjd3WkAQq7Bl4saQ8UTonfIfABDRJZTKM/
         0atQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786597868; x=1787202668;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hbgXz5++RlW5L6cDaDP8mafunaN5CoUMDCWXW8oXEmU=;
        b=O3cL38AaJDYXkmtkdxH8CTk2W5IaleM1PPr8Uxb3jM7/NQT99iJSc6InDoqoTYHG/v
         MkQcck37b+1eUnwShxal2WR/1FW63XmP0MMxLQp790Gx5NyQdBWvWhCc5yv19STWusI0
         +kcQF44+ig6EZ0waB6es5WDBaooZHgJXBqueUMBjWeHldJnKcEbS8d3wYQKwXRd9Ewaq
         mBp6aPPBpsrG2nD8hI/C1q/y+6PSIZoLUqrC9BY6r2dkEvywiB5TGP0UT97nSFCj4TQP
         HoIbhPfre36jgDxXtVLNW5AJ0th5uCfezUWOImZ7U/itoCRgWurJ4DqxLlrxF7QkTzL5
         hudA==
X-Forwarded-Encrypted: i=1; AHgh+RoP8yyceiRnMQj0Q6podRoKLCgRChDjUkIniCm9szd5HaKmoRRDvzPF5/453af10HhNMzt/MuWkX2yJpXZcfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwM50ZWkIHhvt+hYJSJxNgVLx8F8KUQW/GIaZScp+nOxkZvyA9A
	YRiHZDLWg7A9SuF6fKnQjKGVSdgK9ivng5W2Dtd9b4yXUEwAWrGoAQYM
X-Gm-Gg: AR+sD11FAwcHTYdaKZsalwYwIX/gOrvBXQ1ddy8HNhgdHfVO/QjeJ+uBFEVq9pFTscr
	2d0EsTw1Yu11TyZ7BTD55Wq0iaP44MrqsFnlhYvu+E47L6cGuwat8HiX+ufqy+t4Qq3p4YgtOJz
	WIZ19laiOueUV9aJsVb/gMnTZmlQOr3YhK6gVwEr2ththJvy/Oej2H7PUfifuT1Yj38razdly8b
	czBomfZauvvJIggkxL8tXDuUDzwvTMhu/D0Ytn+8w1Uba3p4fv+puGC+MSt+UPHpibqFpoNUW7q
	RFsS7oGDdtfsBIk+q0YDME767W08SijltdhDDoh7OTjeiSJdT7QoqEdTojuhdv3oaCFMD85NYwB
	xm4TJUxf7G68mPkcm2R+pCfrarsrncwp4QgHYrbuE5JwRlE7jE3aCNnTckPUO3drpO8B7EMPO04
	0XQpcEjIGillzwulO9xIYhnLMDbRxzIoeZmsBrCRrNiLjv5orwZZaJIJkJdFtxs2+sh4z/xV8JU
	g==
X-Received: by 2002:a17:90b:17cf:b0:38e:6a30:4bbc with SMTP id 98e67ed59e1d1-3931e32f509mr2910539a91.21.1786597868370;
        Wed, 12 Aug 2026 22:11:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931cce8a3esm1866321a91.1.2026.08.12.22.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 22:11:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 12 Aug 2026 22:11:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Zexin Wang <ot_zexin.wang@mediatek.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	light.chen@mediatek.com, Fred-WY.Chen@mediatek.com,
	Yt.Hsieh@mediatek.com, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] watchdog: sbsa_gwdt: add early_enable module parameter
Message-ID: <a5e2f50f-4f3c-40aa-b881-fc730b9821cf@roeck-us.net>
References: <20260813034900.20235-1-ot_zexin.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813034900.20235-1-ot_zexin.wang@mediatek.com>

On Thu, Aug 13, 2026 at 11:48:56AM +0800, Zexin Wang wrote:
> On SBSA platforms using standard UEFI firmware (such as EDK II), the
> watchdog timer is often enabled during early boot stages but explicitly
> disabled by the firmware before handing over control to the OS (e.g.,
> during ExitBootServices). This is done to prevent unintended resets
> while the OS is loading, assuming the OS watchdog driver will take over.
> 
> However, this leaves a protection gap. If the system hangs between the
> firmware handover and the userspace watchdog daemon startup, the hardware
> watchdog will not fire to recover the system. For safety-critical systems
> that require continuous hardware watchdog protection from the earliest
> possible moment, this gap is problematic.
> 
> Add an 'early_enable' module parameter to allow the kernel driver to
> re-enable the watchdog immediately during probe if it was left disabled
> by the firmware. By setting the WDOG_HW_RUNNING status bit, the watchdog
> core is instructed that the hardware is active. As a result, the core's
> pre-userspace handler (controlled by 'handle_boot_enabled') will
> automatically issue periodic keepalives until userspace opens the device.
> 
> This bridges the protection gap seamlessly without requiring firmware
> modifications and without risking unintended resets during kernel boot.
> 
> The parameter defaults to false to preserve the traditional behavior.
> 
> Signed-off-by: Zexin Wang <ot_zexin.wang@mediatek.com>
> ---

Change log goes here.

>  .../watchdog/watchdog-parameters.rst          |  2 ++
>  drivers/watchdog/sbsa_gwdt.c                  | 23 +++++++++++++++++--
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/watchdog/watchdog-parameters.rst b/Documentation/watchdog/watchdog-parameters.rst
> index 502cb6adbeda..47867a621ada 100644
> --- a/Documentation/watchdog/watchdog-parameters.rst
> +++ b/Documentation/watchdog/watchdog-parameters.rst
> @@ -515,6 +515,8 @@ sbsa_gwdt:
>      nowayout:
>  	Watchdog cannot be stopped once started
>  	(default=kernel config parameter)
> +	early_enable:

As pointed out by Sashiko, bad alignment (tab instead of four spaces).

> +	Watchdog is started on module insertion (default=0)
>  
>  -------------------------------------------------
>  
> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> index e04d42cc7774..ed913be3d1cb 100644
> --- a/drivers/watchdog/sbsa_gwdt.c
> +++ b/drivers/watchdog/sbsa_gwdt.c
> @@ -122,6 +122,11 @@ MODULE_PARM_DESC(nowayout,
>  		 "Watchdog cannot be stopped once started (default="
>  		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>  
> +static bool early_enable;
> +module_param(early_enable, bool, 0);
> +MODULE_PARM_DESC(early_enable,
> +		 "Watchdog is started on module insertion (default=0)");
> +
>  /*
>   * Arm Base System Architecture 1.0 introduces watchdog v1 which
>   * increases the length watchdog offset register to 48 bits.
> @@ -296,6 +301,7 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
>  	struct sbsa_gwdt *gwdt;
>  	int ret, irq;
>  	u32 status;
> +	bool early_action;
>  
>  	gwdt = devm_kzalloc(dev, sizeof(*gwdt), GFP_KERNEL);
>  	if (!gwdt)
> @@ -386,14 +392,27 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
>  	 */
>  	sbsa_gwdt_set_timeout(wdd, wdd->timeout);
>  
> +	early_action = early_enable && !(status & SBSA_GWDT_WCS_EN);
> +	if (early_action) {
> +		sbsa_gwdt_start(wdd);
> +		set_bit(WDOG_HW_RUNNING, &wdd->status);
> +		dev_info(dev, "Watchdog early enabled.\n");

Unnecessary noise (it is also reported below).

> +	}
> +
>  	watchdog_stop_on_reboot(wdd);
>  	ret = devm_watchdog_register_device(dev, wdd);
> -	if (ret)
> +	if (ret) {
> +		dev_err(dev, "Failed to register watchdog: %d\n", ret);

Unrelated and unnecessary addition.

> +		if (early_action) {
> +			clear_bit(WDOG_HW_RUNNING, &wdd->status);

Pointless. The watchdog was not registered.

> +			sbsa_gwdt_stop(wdd);
> +		}
>  		return ret;
> +	}
>  
>  	dev_info(dev, "Initialized with %ds timeout @ %u Hz, action=%d.%s\n",
>  		 wdd->timeout, gwdt->clk, action,
> -		 status & SBSA_GWDT_WCS_EN ? " [enabled]" : "");
> +		 watchdog_hw_running(wdd) ? " [enabled]" : "");
>  
>  	return 0;
>  }
