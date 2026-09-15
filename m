Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE58D3B95EC
	for <linux-watchdog@vger.kernel.org>; Tue, 15 Sep 2026 03:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789444177; cv=none; b=EbTmtqUhZkFt4qyDp7wkmaJK/ZM1PvjCuWCWXl8BZeTxcXATkGBp2StKJLVEPLu8SiOu8XNKbN4P8gQgQeav4uIZwrsf1BFpAp+UHsEhJey/QUU1Dj/Z/gyQzpgjwHQqY94xdEBD7kNvznG10Ed7s0BJM10k8aGuv4dAbF0t4Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789444177; c=relaxed/simple;
	bh=u0RxG1o/frbuNKiBAJ43W24jdU6vj1vR2na55l5hTRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKIh/KwrLpVmhxR4hcvxPOlXRgvX3SAyFXQiJ2wg+S7KU71FCby+eHW4xJYHhMtn9cLzbKHDVWJbUGgN+ScxC4rfpDKCmxVr0pozkndY8MF+AjWiYx2ptwcHDe284unALPKiVD22k/qksVjvNDLfC/5cXk/ZnIQX2JSrJz/O5W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qeSF8pbd; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qeSF8pbd"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-869ac301739so3415323b3a.1
        for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 20:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789444175; x=1790048975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dF7qeg6bjb/JK0D+0qkiv2VMJdXAYUryHJ+RVPDRMgI=;
        b=qeSF8pbdBgPZc7REzIPtAksDy3Bh9NnhAqiPz7ljNrxJp97yAeCkHJQNWcGFw2Umu/
         ArAyHXzZXGcAPOkDPXpEKBTI/uthOw9057EtL94g3eptu8tyHw7WERN1sNArmWTxTSuc
         QlkP6dolHzhT9KxwsZV9TKpWYatXeBX2fWZ659+hBR6YFL4krRLb+v1b3GjqlMpzi4dS
         Ohmm8SZEvDVd69y411DySQFQUQ9HS5qSw6tGHitvmLqXdCIT2cgonHpQrbkXmyk0stOQ
         8YboMhe8VpR891hWKnFRSvaHuM5EAHXgVU7bY26v3LBKH/lhCd3iIWjKRkpYxsTqpCRC
         tZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789444175; x=1790048975;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dF7qeg6bjb/JK0D+0qkiv2VMJdXAYUryHJ+RVPDRMgI=;
        b=g3nfyRtyAvmqvjTY5vFZcPdgXjwN3Hjb5kg84Bp2R+5KYJjZYHRZSDthfMyLGFtnfL
         /TwoJh+vp2iGxawzr4YzrvCrFPfkTqlDhV5NpdCjBit95/GpfDMxjxaBuEAcy5Wl4MFo
         Af3/K4/jVMmmbxsw62owq1Aaa1mOWys+qoaIBMoWhToDvZ3BEm/LT1CvuPSUXl0+7tAW
         FJCfKYWWOwukBtuwlYGE5j6Rxa07TuqvAC+YuBmTocS2IsDzWvwfxFkiAsG+JgRta2EG
         j1MM8L6W5vAdNcnPXm9U9pVo1dssOVcW1FS3vELKGIRT2p9qm7WFybdOB+aesnIpaiOC
         EwFA==
X-Gm-Message-State: AFuF++k8coKZ/ZB642s2RX9VR9lmbvurrhoOjtcawUKQMbszb/x8+b+k
	Tb+BHJU1OmlyM6yWuQQ9KT3H+ynjBugRyGPrmUycnn1CvoXckNb6ax/1
X-Gm-Gg: AYBFou3w7gwjjjM4n/wm2a2E6R8sICghjoDZA+gW9+lQaV7vT+IVh1giISbqVXcZGGG
	urXl3v+P8qDk0lAb9rq7Q18mrzk8Tuecbbq4l6O7pu5jK3HFk+VbLzjrlwrFx1F0ZD2+RYY6TMx
	qqhI6Tl5iwRXyT4A9fR+tLRAwNV641wBfgei0UNrBzOwnO9+Ghs+ZakIo5KBR93tQ2SPDZ/Trgb
	HkDkAwz7Cq6i0pZoD9hLt3UKkHfntiWPw5GjxEdehHseJoqOD+KXdTFBF01tvyd/k4c+gMQWBcw
	utd3LNfo9j6iqLNtKiCHRyAtyKOFHDf0m+2A6kZbul/U+MqIxv52oVZffoD5AkYccAzDn+lwDQB
	1XpYk/j63NfwcIXGWC5jxb/IFFnBcZSNqqYCoQY1meeMzQ4KvahY1FsXHfyLdYpb6f1HTfs3TOy
	cQutL+r612zDsxxoxcputZIOuPsNMsl3IPvVeWdU2t2iXlf5fypg9SJQZq8+fM40UmeWDF2MMAj
	t9EJFwFVRjz2eQqcTdNMOGOHd2fRxMEeV5cJk3R7Lt9tScd9s3dVh/pPhc=
X-Received: by 2002:a05:6a00:f86:b0:869:9298:ba50 with SMTP id d2e1a72fcca58-86f804d0661mr11571247b3a.0.1789444174696;
        Mon, 14 Sep 2026 20:49:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b286c49d2sm5581925b3a.10.2026.09.14.20.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 20:49:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <13cec7fc-8b8d-4b43-867b-a88d67d32118@roeck-us.net>
Date: Mon, 14 Sep 2026 20:49:33 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] watchdog: starfive-wdt: fix PM reference leak in probe
 error path
To: Ivy Lopez <skunkolee@gmail.com>, xingyu.wu@starfivetech.com,
 ziv.xu@starfivetech.com, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260914165022.169877-1-skunkolee@gmail.com>
 <20260915032032.222665-1-skunkolee@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260915032032.222665-1-skunkolee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/26 20:20, Ivy Lopez wrote:
> pm_runtime_resume_and_get() increments the runtime PM usage counter
> and, via starfive_wdt_runtime_resume(), enables the clocks. If a
> later step in probe() fails (reset_init, clock rate check,
> watchdog_start, or watchdog_register_device), control reaches
> err_exit, which calls pm_runtime_disable() but never balances the
> earlier get, leaking the PM usage count.
> 
> Track whether a PM reference is currently held (pm_ref_held) and
> whether the clocks are currently enabled (clocks_on), and use them
> in err_exit to release exactly what was acquired:
> 
>   - if a PM reference is held, put it via pm_runtime_put_sync();
>     only fall back to a manual clock disable if the resulting
>     suspend transition did not actually run (put failure), since
>     the runtime_suspend callback already disables the clocks on a
>     successful put and a redundant call would double-disable them
>     and underflow the clock enable count.
>   - if no PM reference is held but the clocks were enabled directly
>     (runtime PM disabled case), disable them manually.
> 
> Also propagate this accounting to the existing pm_runtime_put_sync()
> call at the end of a successful probe: its usage-count decrement
> happens regardless of the call's return value, so pm_ref_held must
> be cleared immediately after calling it to avoid a second,
> unbalanced put_sync() call if a later step in that path fails and
> falls through to err_exit.
> 
> Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
> Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
> ---
> v2:
>   - Fix double clock-disable / clock-enable-count underflow when a
>     PM reference was already released via a successful
>     pm_runtime_put_sync() in err_exit
>   - Fix double pm_runtime_put_sync() / usage-count underflow when
>     falling through from the tail put failure to err_unregister_wdt
> 
>   drivers/watchdog/starfive-wdt.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
> index af55adc4a3c6..4ad587732bda 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c
> @@ -429,6 +429,8 @@ static int starfive_wdt_probe(struct platform_device *pdev)
>   {
>   	struct starfive_wdt *wdt;
>   	int ret;
> +	bool pm_ref_held = false;
> +	bool clocks_on = false;
>   
>   	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>   	if (!wdt)
> @@ -449,11 +451,14 @@ static int starfive_wdt_probe(struct platform_device *pdev)
>   		ret = pm_runtime_resume_and_get(&pdev->dev);
>   		if (ret < 0)
>   			return ret;
> +		pm_ref_held = true;
> +		clocks_on = true;
>   	} else {
>   		/* runtime PM is disabled but clocks need to be enabled */
>   		ret = starfive_wdt_enable_clock(wdt);
>   		if (ret)
>   			return ret;
> +		clocks_on = true;
>   	}
>   
>   	ret = starfive_wdt_reset_init(&pdev->dev);
> @@ -499,6 +504,9 @@ static int starfive_wdt_probe(struct platform_device *pdev)
>   	if (!early_enable) {
>   		if (pm_runtime_enabled(&pdev->dev)) {
>   			ret = pm_runtime_put_sync(&pdev->dev);
> +			pm_ref_held = false;
> +			if (ret == 0)
> +				clocks_on = false;
>   			if (ret)
>   				goto err_unregister_wdt;
>   		}
> @@ -509,7 +517,12 @@ static int starfive_wdt_probe(struct platform_device *pdev)
>   err_unregister_wdt:
>   	watchdog_unregister_device(&wdt->wdd);
>   err_exit:
> -	starfive_wdt_disable_clock(wdt);
> +	if (pm_ref_held) {
> +		if (pm_runtime_put_sync(&pdev->dev))

The return value from pm_runtime_put_sync() is almost never checked.
I wonder if checking it creates more trouble than it is worth.

Guenter

> +			starfive_wdt_disable_clock(wdt);
> +	} else if (clocks_on) {
> +		starfive_wdt_disable_clock(wdt);
> +	}
>   	pm_runtime_disable(&pdev->dev);
>   
>   	return ret;

