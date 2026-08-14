Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C67248CD7B
	for <linux-watchdog@vger.kernel.org>; Fri, 14 Aug 2026 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786723720; cv=none; b=un3rfVhL1WhcoT+mtIRXClUIAwifn7BOMyGDibzyCsKScr2gryGEm4bzD8dlWyKQPgVG27gIPx1QK7YNZ6WtVDbYHdJmSamuZ0iew5Nofvxa11wPdsFVOyf5GGn2G4HpGvBx2BS7AcFJha6gvJtN2wEOJ58kaSATAFuyVfjfpi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786723720; c=relaxed/simple;
	bh=OvC+uCX22OxiCm/ADZIrl4k/Q2qjrp6B/VU/TsLraGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tf1fMVKvRNlKMd4JvRkBa47rmNT0732eK9CiRkmKkcxYOKZG9jzKN1MuLNht6j5BU/KDqcIXjYwQ2X/q/iDgngAn3w97GpF+KW5gEBQIhZ9jTJv+4Ier7/rX+DgQDUf2UbIbzUY/NWz/St/hmhJFRY0pyumC4DMwFun/hnObZI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbuXRXot; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbuXRXot"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49978908b35so10086385e9.0
        for <linux-watchdog@vger.kernel.org>; Fri, 14 Aug 2026 09:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786723708; x=1787328508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ZnefS8leD5EpLhfx/2yL2ejpM4dklOoHUq4vSAQtGU=;
        b=dbuXRXot/HKJArG0F0QwksTxblB1A8YetbG+JPqAjp7I8X3WkNNm/Zz9hIbqrF7aw3
         5k+YfjsUtRVCrij8euk+f+9D+59K09JS0El0OmQ47uHZBVtKMuttJezWdNcVig0qstn7
         QECB+TptQBVlTqxkq3/9vA+GHeEZk5EGmCCawDpR5u8/a1YIRvWFNC2wcg2SHk3Ity78
         AisVUaeWcb2CLGcNAwGqEpyFR42QvpyEFwhGorZZfSpKrvmNei0t+3j/ZRKx+ODRuMxc
         5Y+luwdrwyl0h+AF5tX+r1EMN36+6p6AI5VvQdDXGHIpwgE206DpdlInaVoP9sJcub2R
         iKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786723708; x=1787328508;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6ZnefS8leD5EpLhfx/2yL2ejpM4dklOoHUq4vSAQtGU=;
        b=GHpgwOhuUkIJyQvtkcnTuEHV7T5vvbhF2NNc1eBAs1b95Ay2tk+6guba3qTI/e4RqY
         SEb47bSo6Dn+1C8EGyK0iA8FawXN3KgAkfzj+pA1iw0RYNw/Bx0QtIR2m7kILVA3u4Vs
         jojO62X5PWofPa3yTG7ZtTTqh92fE9cVWYd5HoMMTL9cerreFMMEShiKuUsXNrGuf7wT
         to07hqGCQJsaWgt21h+tc8NfvmznjR+rB3Ps4HJSUtV4VuWsywts8tbwmqH1R21wMRb7
         y9Vu4e1zMBDdg4pMH3Os5RgMFvr7sEUC0VrM4zRH9UkFOJydEFSQ5xLE+gPrphc3S2re
         +b2Q==
X-Forwarded-Encrypted: i=1; AHgh+RrT8eqMNu+gARdHBcXmbnKHj4e1Wcqh6Wl9lNmivhOmlNjNsInzOLj4sDlVeo2XuKcvsq7ot02XeIiNKumT9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcV3bT3biM100YSJRf/oDdIKFbyN64UKF/seF8XfAMJIcb68YG
	ypTqYsS/MhLG+rqH8Zbgono9jvfJQLay8xNOBvGsbmNDGFThnleWEiRL
X-Gm-Gg: AR+sD12z7EaRxfqq0rcpofaS2NSuDdMSTJsIP6M5BOTVr+lQth8mky+D0Aobq+fICs4
	MC5ju6NqS5CyQlz74e/wmizNycXfM42FyOgOELaYdZjK64qjGZkkvVQw7tpIa0vUS3YAYSHS0PU
	aLn7NxShRaUz7x/QnQOwra2MvZi/2KEK/pIKYyWwPlcNrsqqMNjem7hhRZ9n6Fadf3OePJ2Tg1T
	am8qI5ZHmD85Rdc4lPoNGXW4wn11e1r/GuCYIPjfAYoAYgV86hWfQXfSzualOkDW+8VMnwN0xaP
	1w8GJDAjgHLBql5tnU109O63m8FTZW7FWlfYwH/xDCyhj3i8IVBFAYDvuftaABkHLESSz2Po9Hd
	bp9GZJubFkNwNI4ygxf4KywOpy4O5XrdBAOdEeOaNdZh8i6cGl+OfYpJ1A8pvfN1kJpWYDTRcYP
	BBE4D0GovU+MHvSPVHMCuf3ig51dfSfzVZYIOH1n5w/mmAHO1j2sF0nVmx8HNSgAusbOcIf9AxR
	/tzK0zSBk/lSreW3UsWgqy+1YRGu9co4usA6KdYtIU2/sSkN6+RdrSp
X-Received: by 2002:a05:600c:138a:b0:499:51cc:4e57 with SMTP id 5b1f17b1804b1-499878cf3b0mr74633095e9.0.1786723707410;
        Fri, 14 Aug 2026 09:08:27 -0700 (PDT)
Received: from [10.128.10.232] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c18cbsm8127896f8f.29.2026.08.14.09.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 09:08:26 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <e0775be9-9773-424e-9109-5b4b6b620e61@gmail.com>
Date: Fri, 14 Aug 2026 17:08:25 +0100
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] rtc: pcf8525: Add watchdog support
To: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>,
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: alexandre.belloni@bootlin.com, krzk+dt@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, linux@roeck-us.net, wim@linux-watchdog.org,
 vikash.bansal@nxp.com, priyanka.jain@nxp.com, lakshay.piplani@nxp.com
References: <20260807082855.3762394-1-shivprakash.gupta@nxp.com>
 <20260807082855.3762394-4-shivprakash.gupta@nxp.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260807082855.3762394-4-shivprakash.gupta@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shiv,

On 8/7/26 09:28, Shiv Prakash Gupta wrote:
> Add watchdog support for NXP PCF8525 real time clock(RTC) device
> 
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
> Signed-off-by: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
> ---
>  drivers/rtc/Kconfig       |   1 +
>  drivers/rtc/rtc-pcf8525.c | 245 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 244 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 3c22c7253aae..6c1c7b3d27b6 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -516,6 +516,7 @@ config RTC_DRV_PCF8523
>  config RTC_DRV_PCF8525
>          tristate "NXP PCF8525"
>          select REGMAP_I2C
> +	select WATCHDOG_CORE if WATCHDOG
>          help
Nitpick, sorry: this Kconfig file uses spaces for indentation, but your
addition uses a tab.

- Julian Braha
