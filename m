Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6352364E84
	for <linux-watchdog@vger.kernel.org>; Sun, 28 Jun 2026 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782659541; cv=none; b=bZyNoC+ilkpoHFjoNmnhnoWIhWT4LS/cslpkscdObLlm+V8ulEAsytzCu1vKzMk1WsYtqdUQFVmG7LfaOkpQqVu2PCsr417CafSlXsz6bI9vyO4Qz2B4j5SbChKmjPrxI3uq9JcKPfB2nZwfGHN3p2hDOZ6FaOg42wRBEhPZyGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782659541; c=relaxed/simple;
	bh=2P/aUwtXPkyvmn4p6J87gCgO/v7UFz5QoiB5/07M8Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrEM/S8NrtG4jOAbQwD8Lu7y5yOs9aqT6Q6dfPpKciG92nHL2vzB4XDvANWxxC/NKQtBMsEofeTCkn3olVBgZd1Kr+uv0gf9qVxlXLPAGB5iQQ6C4CwVBEwf2IL6/uWRNV6jvnztlwYoV1PznmSULUxU+GmYyK91KXerKzjIU9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDic+KV8; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDic+KV8"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37fb434c547so803879a91.0
        for <linux-watchdog@vger.kernel.org>; Sun, 28 Jun 2026 08:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782659539; x=1783264339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RvUe9e7HlrQUYYe0kIx1JIDGEGNwplGbLQlZOabKyw4=;
        b=KDic+KV85Asl8WImGIz7UYkeGbtYidMJnl8zKPQWv5Y86SbaTKo2jjJFAYTK4M8RJ8
         TU5YLz+Z7mFZ9F0DwX8NaCpEJJ6MQ4nKRVf6haB4lZC/BJdzNKsWMsUfdGGcrCqNqDHA
         fGd4xmSPlsakQDFchc1FRqz8kTo3aNdZKL3Hoyf6WnxOGfQ7r0xaTNkVWdn8dp6Rh2gB
         UAi6SvoW1FDiqMbsaiaTiI/mSvns9uQDimIvSw0sdlNlXSxFxmg7DJgf+ocDUaY1IFau
         LZASvmjlZH9akzLUsnJJzd9ckEsE0J44xU3a2ePUkL6RxIMciJQ6xbPj9Zxpkt0UnZ/a
         fLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782659539; x=1783264339;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvUe9e7HlrQUYYe0kIx1JIDGEGNwplGbLQlZOabKyw4=;
        b=rZhrLUHlVD+NSGrVo+mwxbcyvGgrByKW4ygf9vLowKkjH/FGrof3xI6ZgIP722fbwU
         9ie0V5kUyYGV9AsAIk2WJH1TeOu8IRhcd9I1cKvjZux/ZfBKQyXUJDhelTpSyVbQKkM1
         Q+QaA5foR+D4/wxN00jz21pMP5BaX/+NllNOCgaIsROQI4Z4EhCoPxAqHJ7i0T5r0Xb7
         4gBElO2Ibw6rmF8DKRLZbjWUNovDNQjg6C2Nq4XBE3PKCNsiGjEaVPMnX6hhqQbjyfJb
         XQfx4+BHxcYfJYH3t/AWGuYfiGfAMKHEJcIqJkLicEqF8+EKa3Ns8Y3ir58LdNgtfVaf
         x4/A==
X-Gm-Message-State: AOJu0YzNz8QnisC8Vny/bsdu/eQ2IP8Cf8uFecyRd+FbrwBJUxgwf1dp
	k0+DP0U+twkJpZ6DBLILGYIMwVtSqL6RfLUTyig6wzU5yKVaN+a5BIX/Zs+wwQ==
X-Gm-Gg: AfdE7clRu2G6gMAVPK1cuMtDUwQhrBDZ5iaM0pQorp75t7xx1FMGCrHR+mXEJOnTTE1
	O9hd3P7F4mgmPsP58fqSerbuAPPBcgWN0LwpJFd9sYJDMf6uLPjcZdRfSz2lz+YixjJrdNzpucT
	Hk8noNjQgxErTY3+qNQTs9w37fAQCnn7HmFG51XsQxj5vCRA74LDAuONFcJRAbkmlUsaRpPtH2z
	r9HO4nXdZMKNvCk9lUtYutowzqbWB9F+hQQoVOfHnCj4CpYSI3ELT9nT2bROio08qYf8yavcWX2
	kPopJp6jpCiDzGgWDAZkKnlBg/oG4KoBT1tVW/7YH/Me8aLfgtbKUxsvlgyXqZj0StLH3J4kNXo
	JtC0acrZ95izQXIeKdw7OlIOCjlMGp3HO+EWvL2bLLPGrbms508gjZgPSsgAVOWHPg+DNiABct4
	DBj2a2AIW8d6NhfWbUsY2M+n7e9BJ5R14Gk/zsmy3A5eX1we4SZNmu3rSX6zx8Kg==
X-Received: by 2002:a17:90b:35cd:b0:37e:9e9:6ffc with SMTP id 98e67ed59e1d1-37e09e97428mr11060759a91.25.1782659538832;
        Sun, 28 Jun 2026 08:12:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37e1bd8309bsm4395098a91.9.2026.06.28.08.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 08:12:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <58920807-fbde-4a7e-b9bb-5a29be5ccced@roeck-us.net>
Date: Sun, 28 Jun 2026 08:12:17 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] watchdog: lenovo_se30g2_se60_wdt: Watchdog for Lenovo
 SE30G2 and SE60
To: sashiko-reviews@lists.linux.dev, Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-watchdog@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20260625174328.3339996-1-mpearson-lenovo@squebb.ca>
 <20260625175235.49B101F000E9@smtp.kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260625175235.49B101F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/26 10:52, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Incorrect error cleanup for a registered platform device leaves a zombified sysfs device.
> --
> 
> commit 728400a02a11a5d2e004ae6d02e2731670483271
> Author: Mark Pearson <mpearson-lenovo@squebb.ca>
> 
> watchdog: lenovo_se30g2_se60_wdt: Watchdog for Lenovo SE30G2 and SE60
> 
> This commit adds the watchdog driver implementation for Lenovo SE30G2 and
> SE60 platforms.
> 
>> diff --git a/drivers/watchdog/lenovo_se30g2_se60_wdt.c b/drivers/watchdog/lenovo_se30g2_se60_wdt.c
>> --- /dev/null
>> +++ b/drivers/watchdog/lenovo_se30g2_se60_wdt.c
> [ ... ]
>> +static int se_30g2_60_create_device(const struct dmi_system_id *id)
>> +{
>> +	int err;
>> +
>> +	se_30g2_60_pdev = platform_device_alloc("lenovo-se30g2-se60-wdt", -1);
>> +	if (!se_30g2_60_pdev)
>> +		return -ENOMEM;
>> +
>> +	err = platform_device_add(se_30g2_60_pdev);
>> +	if (err) {
>> +		platform_device_put(se_30g2_60_pdev);
>> +		se_30g2_60_pdev = NULL;
>> +	}
>> +
>> +	return err;
>> +}
> [ ... ]
>> +static int __init se_30g2_60_wdt_init(void)
>> +{
>> +	int err;
>> +
>> +	if (!dmi_check_system(se_30g2_60))
>> +		return -ENODEV;
>> +
>> +	err = platform_driver_register(&se_30g2_60_wdt_driver);
>> +	if (err && se_30g2_60_pdev) {
>> +		platform_device_put(se_30g2_60_pdev);
> 
> [Severity: Medium]
> Since the device was successfully added to the system bus via
> platform_device_add() in the DMI callback earlier, will calling
> platform_device_put() here just drop the allocation reference without
> removing the device from the sysfs hierarchy?
> 
> Should this error path use platform_device_unregister() instead to avoid
> leaving a zombie device on the bus that could cause collisions on a later
> module load?
> 
I don't understand this code either. The parallel platform_device_put()
on error in se_30g2_60_create_device() seems risky. Each of the Lenovo
drivers uses a different mechanism to register the driver and the device.
Why ? That just makes it more difficult to review the code.

Guenter

