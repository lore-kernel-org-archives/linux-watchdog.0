Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDCD35DA49
	for <linux-watchdog@vger.kernel.org>; Wed,  1 Jul 2026 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782875591; cv=none; b=NfdpY7JbqYCR18LfjIFfWB2YEyrifXXLHCTHgC0772gAbQ4NFZ22Z8Sbsxu5ZQK0QAl0nf2w28JZLk2IFqbCkMGljBoJwNXfpcvzaKoGVrbfTzowl8Bu6/tSjeGq6HGVbeTqO8pvEfedzlaRBqevYJhLtfyCy8xQ2k7NAN3eWtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782875591; c=relaxed/simple;
	bh=78KcX6sVTHSUGtR+Tj0uKDkPcIiHq4tgI1RYJzN/N70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+lDgop7KOuQALnHTn8nk64XJzYV/o2rOc0C5BErxvUe2udllsarurgv3p4MyKqlIGvb1c/zmAw/9zwk/xieD5kG6WF8G9yhtD5/klJW2EtuYWKQ6yNoUB3ByLHltMEPqGkCIapOl3paH+q2bhi1dsQcMHyhWt10eHQaQRsGL8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZlmzV3k; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZlmzV3k"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8478cc93299so90674b3a.2
        for <linux-watchdog@vger.kernel.org>; Tue, 30 Jun 2026 20:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782875590; x=1783480390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=02lcch1XJzPGtEFokASt0zvEbJv97Te0AKq6EhMv3UQ=;
        b=BZlmzV3kLxKj/EcZPRg2tRh/64ARLZd1G/ilUGrb+Uc+U5IYO/Pnoa8giKmL/FOPx2
         rSVTwgCRWWRWEyEc95LoP0C9aeThOOg9ZTl4ra+F9sYqFpKQWOFVWd4xVqXupHWoyOvh
         AFxvZ9jTyKhJmRZClBRLSuw2P3lUnLmMVgeaqh9AwvneZMyPVUSgs5kR7uEUuQ1nkMhp
         jPhuTaLijmJd5vKCTnyBuQwFCICp+ophql0mqoPTKsYrJt4C9PcZj0dopZRk6dhRHIFj
         RcV/apWV8mYm0eh98v5871lPYwjvO+wRqW9nKdd0Te6fQ/HYMhNXRTTFcqdyPhY+BNCC
         TDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782875590; x=1783480390;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02lcch1XJzPGtEFokASt0zvEbJv97Te0AKq6EhMv3UQ=;
        b=hRo+B4oeN1/wOisKB7jsiEz3EszXwKhWTNk8lGI4EkH9bouDRvzl5qDWt1cT0oWs2B
         gHdinwVVCA0bQtaqCMXh66YhvYRmbqpXphKA2tg5G2UewOVS53SUZN5BFJerhd/c6NIk
         FEnkkDoGIS7gZlMuj8PGIUUAocNfyxg5yXmcBASGP8wRrtP14OHVDbGAPEklXdI2LaRW
         ZmZH/UXmq8CEKxxtQyVv3e1FBsFEYCpQpTDUAiti2IBFJjV7evuVx9xFPlthUhL8eGMu
         vL1FYg/7GO1/1B0oTyNljujH0AyOirku6QV/ZTCtEamw7TpuoTHeoGJCZP70OenT3tvt
         ZUwg==
X-Gm-Message-State: AOJu0YwewuGq6ZYzikhsceGr3sKOXrk8G/Z7J3mQhVpSLMwcO3pPvx2Q
	neEFwHoGxe8pKN9UxSFVKFDn9bc4EQGUCbjVKCssE5AFK4iEg65ZRF7THPg+NA==
X-Gm-Gg: AfdE7cnySMKcWkeboBM818kTYII0AIrHVwJQvC6amoEbdm7E7oN4xzDZrMFIb6c+2/h
	AGPAsjk4kwCnO26TgSV5BXEO8g3LM+7mdivic7K9SeZF1Z/nf6CUs+s7kSGx+qqlhs1ZARP5DEo
	GqZG0cPtARFWYF+sp29r6hIniMeFGdiBYG8LP9H9bSsrXdI/uB2vwNzcCVIY7jbthqy07kmzB4g
	1Dil6Kkev0globlnlG1epE2eyERPnKciXSk3pX+scsL39dmfyVJPZAbZQ6VRC86gTZBy0Ug7nbZ
	S9kRBfKsSOpVq+pDXbaHBnMONI4RLJ9oYirIjj7dbgUsSpcIEWIfxtVh38rqzgxS9UPGQIhAer6
	Tvh0s2icoh7UUzdF3kosNWxTv1Py9rSDx2l5mxg2x/ofK8iBpLa2pgMJWh/8fpab3JKU63WmdP1
	OuK18GS+TAZ4pQ2KCZ3RLEVIe/tdg+tCYkHCynlylyEYfMGQHZ97bNU4P2urA0YQ==
X-Received: by 2002:a05:6a00:9501:b0:847:73f1:4ce8 with SMTP id d2e1a72fcca58-8479f26d790mr5096801b3a.46.1782875589792;
        Tue, 30 Jun 2026 20:13:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8479ff8c781sm3159047b3a.9.2026.06.30.20.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 20:13:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6808d211-57eb-4058-81fe-84fc07cd07cf@roeck-us.net>
Date: Tue, 30 Jun 2026 20:13:03 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iTCO_wdt: watchdog pretimeout panic after KVM guest
 suspend/resume
To: Evict7837 <Evict7837@proton.me>,
 "wim@linux-watchdog.org" <wim@linux-watchdog.org>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <odOoKUew64I3M0Rw7X5VzzgGB3eAx_dZ355qK2bC6cH7tfmBGLGLaq8C1idS0FO6e0iy-yyZhT91T1qisUuZfw9Ho8fa0nSiY4QBRh3oosk=@proton.me>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <odOoKUew64I3M0Rw7X5VzzgGB3eAx_dZ355qK2bC6cH7tfmBGLGLaq8C1idS0FO6e0iy-yyZhT91T1qisUuZfw9Ho8fa0nSiY4QBRh3oosk=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/30/26 19:46, Evict7837 wrote:
> `Hi,`
> 
> `I'd like to report a kernel panic in iTCO_wdt triggered reproducibly after`
> `suspending and resuming a KVM virtual machine host.`
> 
> `== Environment ==`
> 
> `Host:`
>    `OS:      Ubuntu 24.04.4 LTS`
>    `Kernel:  6.17.0-35-generic`
>    `CPU:     AMD Ryzen 7 6800H`
>    `QEMU:    8.2.2 (Debian 1:8.2.2+ds-0ubuntu1.17)`
>    `libvirt: 10.0.0`
> 
> `Guest:`
>    `OS:      Rocky Linux 10.2`
>    `Kernel:  6.12.0-211.26.1.el10_2.x86_64`

This is a pretty old kernel, and it is not an upstream kernel,
meaning it is unknown if any relevant downstream patches have been
applied.

>    `vCPU:    1`
>    `RAM:     1 GiB`
>    `Machine: Q35 + ICH9`
>    `Watchdog device exposed via libvirt XML:`
>      `<watchdog model="itco" action="reset"/>`
>    `Modules loaded: iTCO_wdt, iTCO_vendor_support`
> 
> `== Bug Description ==`
> 
> `After suspending the KVM host for >= 1 minute and resuming, the guest`
> `kernel panics with "watchdog pretimeout event". The panic is 100%`
> `reproducible with a suspend duration >= 1 minute. Shorter durations`
> `do not trigger the panic.`
> 
> `The bug is a regression: it does NOT occur with the Rocky Linux 10.1`

Both Rocky 10.1 and 10.2 are based on upstream Linux v6.12. Whatever
changed between 6.12.0-124.8.1 (which is supposedly the distribution
version number for Rocky 10.1) and 6.12.0-211.26.1 is only known to the
distribution vendor.

This report is not actionable. I would suggest to submit a bug with the
distribution vendor. Please check "Distribution kernels" at
https://www.kernel.org/category/releases.html for additional information.

Thanks,
Guenter

