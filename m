Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECBD340A47
	for <linux-watchdog@vger.kernel.org>; Thu, 17 Sep 2026 00:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605387; cv=none; b=klCkuVzcvPcVWOPQE9TSVhHLAKBI2uM/4EO1Vs/fcVzHEkVCy8+9IThxdRcvWp8HnAaJWJ6T78CDo52fsZIVeeUBp7dZxt2qvzzy6hzew6u8f3T6rtHPQpfA8RpSVJEPniPKdQmIpwCgHz2aYpaBezeA1qZC3CHAP2GVjneaqsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605387; c=relaxed/simple;
	bh=FCECRq9D4qqF0tKAazCtYqzFGfnLu7T0TLZSuiVVzJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUioVpzSU3bOwUMU3EXbF1JYgoxFgK5CT4Kk4Xnq0DR00bLFpeu0huETqb0EtF58bOBH/udcExFh8nf2N6B3L8FPyU7yBWc+NmdXlDjptSb3Bbg/tZYg0ke6LC+LVXSsIskBuLhbL2wQEk3egwqOCSnwTc4rjvGC+0lxShjZTNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0rc2U3U; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0rc2U3U"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd5cef0so191835a91.0
        for <linux-watchdog@vger.kernel.org>; Wed, 16 Sep 2026 17:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789605381; x=1790210181; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vFcFQW9N9RmJfKtw/GZz+T0NhQrB+xWxUTMHniJZYIQ=;
        b=M0rc2U3U9W+ulXI7ZxMgL0xS9c5mk2yDzi3oZ8uJOTdwFTvb4K7yM0WPfmhRxb9nC5
         U7QVIOM31wEdYTmPODowPjq5UZlkJBkopWpelOxSKePbSgBTcEJ6dHv8NuneCE4vwXPX
         x6pg7Q0GpfBUejydxcz1BctDdX8Y4XYqn7uihqQf8jUkEmFGlI4S8e2XHovCtP3YfMcK
         gmaYHXCjigHTVunavga/KpC74gy9GzA7Bnmf5MujcjNgoXvW0v0i6U2seV/r8+lh7kx6
         C19f5y/M2VeGYSduf3QcCUhiV94ZNTw9+3YKDVJp+yTG1Gg8glfCOuhGISRVor/H5WI9
         LZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789605381; x=1790210181;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vFcFQW9N9RmJfKtw/GZz+T0NhQrB+xWxUTMHniJZYIQ=;
        b=bXVOF9iRWPnL0VA2TLbaGnBiwShY0shi+96NkH6092wPsY7ApNGC48Z81kLfP/BZiX
         IL6s/wDrZxHcagg8LgRjAU8owdfxvYDdaw97kPRpgW93+NUzSqeLKP5jO4ZTuXU9Wyic
         zuuKpI1lcvE70GtCz/QnlE/jNKSWrF+z4AJ1cI+CD6+tsLH1zEPqa/2uidlYpYEMSGiR
         0gaC6kg+HUDTOjpZLraRcyyBZqMUSSfttwOju6tqUIrQ6KOUCCn62eTKkBJ/9Uzjannp
         9kaAeFSv2Ql1F/EDpM4iDS9v4ngAcE/9TO+ykPhqFSj0QLsWldohN6BVQ/4Q1EzAx2ZJ
         OUxw==
X-Forwarded-Encrypted: i=1; AKwUvBx0qDAWqC3m6jay1W+u8iQQ3eFq1R4/j/T7iYTGO+vLRHcGSIJBiDxPVm3rmzn8H8qpxIdfUCkHRG6jT9BtZQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lo4Bq+fqQgC80ndNLEcbrRlqNv4SyMpIDn1dOIBnYqFJVQZ/VD
	39ydgsaaIgMeXYhWUrCtM009QNHRIasqrLDIPCsk34IaFRWj2tNJ+CW+sigAtTiN
X-Gm-Gg: AYBFou01hqLJjPfRsK6ZDVOz+Ey2uSKBzF1AY+UdABZWuV8mzo3vAFH9MVsf9znjAzv
	Ob9ByfwH6Q7CO6jtWBnyLbI83EQY5eJMSdJCCdk5MEhtpwxWIoq+/LQ1tC6W+VHvpbpzJvHOLlb
	oIyf95yErXzKQzHBZsciDKQ6M+16ed2CpRV50kjzz42pHRtWhs1jCDRptPApzcF4qrPxOjNvA7q
	WRkxwCHE2SR3Ul6lzhAZItHSJsV/QQ0BidIvF7C69o3ygNZR1/dSRjKX+QlcEf7EESZLOWQZKhz
	dGOLdtLqUgxKD5gwpKWQL2V1jbdELqISySewxBCtHw60bHLfy4cpTrae1FbHWF/YEIN3QzcxCkd
	VcWxCJBvFI/SDhCcPWdO+CrGAYYMuXOvD5HcVJNUmgKG7vccFPRQAJkrZVymvnweH4Z1xsBcFuM
	7S63l6dj+6WmqMz1PR/RG74XrAWsoJx1H4QgS34sGaxSU3KaDX1jIwaQ1MWHGcmVxv+O+w0t3nY
	GzEiR9lahz6
X-Received: by 2002:a17:90b:1d44:b0:39e:1693:c3c1 with SMTP id 98e67ed59e1d1-39e1e4c8bb8mr10560916a91.17.1789605381435;
        Wed, 16 Sep 2026 17:36:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e360a6c8asm1974484a91.13.2026.09.16.17.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 17:36:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Sep 2026 17:36:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Li Jun <lijun01@kylinos.cn>
Cc: support.opensource@diasemi.com, wim@linux-watchdog.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: da906*: fix suspend/resume handling of
 HW_RUNNING watchdog
Message-ID: <b48a5140-1a70-4af1-9136-1eccc29331b2@roeck-us.net>
References: <20260914063707.607071-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260914063707.607071-1-lijun01@kylinos.cn>

On Mon, Sep 14, 2026 at 02:37:07PM +0800, Li Jun wrote:
> da906*_wdt_suspend() and da906*_wdt_resume() only check watchdog_active(),
> when the watchdog is left running by the driver sets
> WDOG_HW_RUNNING in da906*_wdt_probe() but userspace never opens the
> device, so WDOG_ACTIVE remains cleared, the wdt_disable() will not be
> executed in da906*_wdt_suspend. In this case, the suspend callback is
> a no-op and the watchdog keeps counting during system suspend,
> leading to an unexpected system reset.
> Check WDOG_HW_RUNNING and wdt->wdd，can fix this issue.
> 
> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ---
>  drivers/watchdog/da9062_wdt.c | 4 ++--
>  drivers/watchdog/da9063_wdt.c | 4 ++--

I applied the patch for da9062. Please send a separate patch
with the fix for da9063. Also please provide change logs to your
patches in the future.

Guenter

>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
> index 2b6946478527..3d7bf2f351db 100644
> --- a/drivers/watchdog/da9062_wdt.c
> +++ b/drivers/watchdog/da9062_wdt.c
> @@ -256,7 +256,7 @@ static int da9062_wdt_suspend(struct device *dev)
>  	if (!wdt->use_sw_pm)
>  		return 0;
>  
> -	if (watchdog_active(wdd))
> +	if (watchdog_active(wdd) || watchdog_hw_running(wdd))
>  		return da9062_wdt_stop(wdd);
>  
>  	return 0;
> @@ -270,7 +270,7 @@ static int da9062_wdt_resume(struct device *dev)
>  	if (!wdt->use_sw_pm)
>  		return 0;
>  
> -	if (watchdog_active(wdd))
> +	if (watchdog_active(wdd) || watchdog_hw_running(wdd))
>  		return da9062_wdt_start(wdd);
>  
>  	return 0;
> diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
> index 92e1b78ff481..3703110e82fc 100644
> --- a/drivers/watchdog/da9063_wdt.c
> +++ b/drivers/watchdog/da9063_wdt.c
> @@ -271,7 +271,7 @@ static int da9063_wdt_suspend(struct device *dev)
>  	if (!da9063->use_sw_pm)
>  		return 0;
>  
> -	if (watchdog_active(wdd))
> +	if (watchdog_active(wdd) || watchdog_hw_running(wdd))
>  		return da9063_wdt_stop(wdd);
>  
>  	return 0;
> @@ -285,7 +285,7 @@ static int da9063_wdt_resume(struct device *dev)
>  	if (!da9063->use_sw_pm)
>  		return 0;
>  
> -	if (watchdog_active(wdd))
> +	if (watchdog_active(wdd) || watchdog_hw_running(wdd))
>  		return da9063_wdt_start(wdd);
>  
>  	return 0;
