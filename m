Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2113033EC
	for <linux-watchdog@vger.kernel.org>; Sun, 23 Aug 2026 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787496306; cv=none; b=e4U4QE3ndd89Zz8Zclj2sVkFL4wsHpZdhh3hn+eyjH/SPLZxz8L6RV2iKVavZZ5VMUouTnHKnzPwbTxNT5k3sVBe2HfhWaSc+0Z9U+GrYO9xoc1ypEzifD3SJFalvq36LSYUxz7zOUJirxPJMVvcxTW74xVNqLBVnS4ss8mGm4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787496306; c=relaxed/simple;
	bh=Q9grbewjI2bHqRq0WFY2KkekTnr5m0BW8iqJjbuU7dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z3Tq5ZJSWCQQY5e0UTms5s7kFD8G33Vs6IysYnFoXPJy5Wlq2i04KFu58J7Yxago1DSGcF7rwCde8yctFeFU+140o9UJ65MQ0FYxxfXW2VW0OWI1w5vQE4QcXDXLfyxeoXo3oqNXTM+1aZS4wscRy3pAoNfi4VzPUDxqAv3t4Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMCij/zV; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMCij/zV"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so1867401a91.0
        for <linux-watchdog@vger.kernel.org>; Sun, 23 Aug 2026 07:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787496302; x=1788101102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3LxvjPQ9thuAIhnz+M7tTQ4ZGvuLlf16JxkPOMx6gBw=;
        b=LMCij/zVbSrEkL1MMn3/8Uxl0d6cf5cypq2/7q46Q+VIlEaLW5j3QWnrjCVYQLFEyM
         e76o0ACgpbhcajKXAVSKj6gmTFjBUspb1T7DFOZAKDWJ2t19swRC0TyLn6wpJe6LFSMm
         Z68Djpk+vsqd1+uKHIJquzT5YXkxm5xXx53QA/yzXyWb8kRVTiOowH+Ek2/HpKBE2c+X
         6uxurwAb6XiZe9CMTe/bNR6+OA8wDG3h/L1FRCBquWHAS2/H9MpHDCEi2rU3BOw6+Bb0
         tBdA90GPo7u5jrmDXA5DN3FCCfSvtu7Y3heGSzGuGpKB5zrPvK6as5INdkfOu6H9s6yg
         ZvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787496302; x=1788101102;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3LxvjPQ9thuAIhnz+M7tTQ4ZGvuLlf16JxkPOMx6gBw=;
        b=N5S3bBsClZGDAh+OAIX1deDA/2X16/+YyCjoqYem7+4Yj6Ttco6vMaNSs76ZoUl097
         96rTnzHzC7jJ2WMUb6wJs6617/MtzKg1ol6y8R9q23ZBOTO0WKz/MqjlHftSUGLR3kpR
         vXdGsT4IoaZjN0rVQXBwEBsp/3GkO+/T8SvYT5TnA0uSJZZJI64H2lymL56/T6BwO4/X
         mF2RW6AzDAcTfyplqPEPpMc2PfdDiQ6wMICj6YHLTIKI4M1zOnRn/3iETuCHTU+qjFFI
         ykIPel1+IzMH1/FZx01bMpZIifqkNdtngVaIhh+/fX1GWoaubqTb59eDUCbsXoteLkkx
         Vgbw==
X-Forwarded-Encrypted: i=1; AHgh+RpiTI/8MWoSOmNKvSizWg6sraCW3BmguFx1bUMk6PunyOopovoLXlqcwjOpe/r1IRywEqd7UakWGwbujxLgcQ==@vger.kernel.org
X-Gm-Message-State: AFuF++njkELxmnH3lqD+gR4NhzR0sPlKEulfybUWrijlNSKroMNt/1S3
	5VWqDlLLPtD120MdY46OexxZ7r206HLNAUdkOyuk1Wh0506oxbO38k5+
X-Gm-Gg: AR+sD10PpzXRWsvgP7Nb7qjDXKEO37lv0SFcZXrefo2cD6HqnOS1bEkp8bgBYu1mPpa
	4Ijzt8acGW9+qLFisWbyUzI0xRH6J6jnpbNxynrsmXreuA0ZbmcrxkcBq6o/PY+p5bRNoH7G4wO
	4u3YYeL++Mvhj7IiWgB71OvGPGYHtgzwcr51qzOChBXU+mZ0L2xvIuSG16tnoOiSFjnOnDUjo0Z
	Nwq9WqIU1jaci8jR8oSvDvf7HOc5VfoqkuYTLzgr8U/AobkX3GAAoRXzJyoZdi/TXo0hBq2Uxo7
	U92iVv1pEwae33YAFBvhUzN8TlkmakOV47za0j4PqqUJiEQnNCQmQMrbK7ultv0cG2DtiR/5/gk
	N2zhjzlHXyZVkbH2Vxh9wgRQDt7lQpubUnLnnEvcj4rQyJ0WlHwdocsZfCsw1zSlA7nUg03+C+R
	aBe5bNPK0LoHnss+W0t/pAjG9ET0lfMFQK9lw9P0pX0etF3Bfw5/tRe8CRweK82Cvu2L9SHsiAn
	WMCRuDp/ooHWAJBbINcTBV+xmeZ1gGJyS6JHg==
X-Received: by 2002:a17:90b:19d1:b0:395:c3f7:2895 with SMTP id 98e67ed59e1d1-395c3f728ffmr17306017a91.7.1787496302467;
        Sun, 23 Aug 2026 07:45:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14186183c0esm26932701c88.12.2026.08.23.07.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 07:45:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <82574e59-9b84-4219-9764-a51c5eeafd55@roeck-us.net>
Date: Sun, 23 Aug 2026 07:45:00 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: starfive: fix runtime PM usage counter leak in
 pm_start
To: manushprajwal <manushprajwal555@gmail.com>, xingyu.wu@starfivetech.com,
 ziv.xu@starfivetech.com
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org
References: <20260823112225.1107-1-manushprajwal555@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260823112225.1107-1-manushprajwal555@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/26 04:22, manushprajwal wrote:
> starfive_wdt_pm_start() calls pm_runtime_get_sync() and returns its
> error code directly on failure. Per Documentation/power/runtime_pm.rst,
> pm_runtime_get_sync() does not drop the usage counter on error, so the
> caller is expected to release the reference itself. The early return
> here skips that, leaking a runtime PM usage count on wdd->parent on
> every failed resume, which prevents the device from being suspended
> correctly afterwards.
> 
> Fix it by calling pm_runtime_put_noidle() before returning, mirroring
> the same balance the counterpart starfive_wdt_pm_stop() already
> maintains with pm_runtime_put_sync().
> 
> Signed-off-by: manushprajwal <manushprajwal555@gmail.com>
> ---
>   drivers/watchdog/starfive-wdt.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
> index af55adc4a..ecb704b2e 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c
> @@ -373,8 +373,10 @@ static int starfive_wdt_pm_start(struct watchdog_device *wdd)
>   	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
>   	int ret = pm_runtime_get_sync(wdd->parent);
>   
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(wdd->parent);
>   		return ret;
> +	}
>   
>   	return starfive_wdt_start(wdt);
>   }

As Sashiko points out, there is still a runtime PM leak if starfive_wdt_start()
fails (plus all the other issues in the driver, but those can be fixed with
separate patches).

Thanks,
Guenter

