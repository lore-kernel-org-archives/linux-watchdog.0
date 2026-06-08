Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1147D3BF684
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944827; cv=none; b=TC57LUab0hDSBZNfA1t6qilELdJNxYuweLDm//wgJrI55J60F/xDcG/rno94N4KKBasM6hPuog7RPApmFFmoVxN4eghhxpw8pl9rOjeZy+ncIs7Mpn45DAuBc2jtaPZcAS6N3xjU5nRi/W9KABa+y4b+Bg0uBYxnvOXkduFQRnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944827; c=relaxed/simple;
	bh=JhJiYHBQMlgqVMI+Byg96PgAXdUSZc6+MFD16ZcFtqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXI18/IM/5+Rbu3NEkNUmxdixGDIxnvSWe8yXWyaqU/qymBUgs+WeX+Nv3OpA3vKrj8LyWxSQPIvO4uXEv1uePyWu+o1x9lyK+gJEKbliqce0HZKcZYKO6TEvjhRdR5bImKBMnakJ45O8ah46qeYE+sMJzrTgAfVsJIq7VyAGlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rp7AqRvg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rp7AqRvg"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c168baac83so21690115ad.2
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 11:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780944825; x=1781549625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=adpIDBscFhAxzJ7fCV0yB9YyfcwaYNNFcmJcu4Yqx0o=;
        b=rp7AqRvgm7OBSepiQQcP/Y2Set/W6cvhf8iziOmF0kVwqf212mW86t+kjFHsmW+XBR
         vQTTAN1NV1C5sLy7r9zoEVgfuzGs9IpQMpd3mTaMvFK4dlLXEIKmE3drQRMd1cf8zx2T
         H0Nl+MDP0Lyx30pkGYAwbB2z/UbR1n1URljYh3hkO8PGzHPhn+4bi6PEWkoA0O5f5fyU
         HLtTKlIfe8zG6ZHzm/sAkhc6uZfYa/PROA4oymSclbCOAKAvZQzrqb7Zs9dsBv05/pSY
         Um/9fs6YCTa1mIE8td9zBtl3wazkSo1yhJ2zPrfNAKumsc0n2KMHqetvKXZx3iuA3oON
         8j2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780944825; x=1781549625;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adpIDBscFhAxzJ7fCV0yB9YyfcwaYNNFcmJcu4Yqx0o=;
        b=pi2qrQsL/w+l8PB5ltw2ktOGEEMOp4hnL4NqD6LNzmohDxsMdGF1sWI/kOXFazhcAG
         +2v0o8dgM8qD94y+JFinwvjHDxfqnXk95clsRt3kvjAcnhpS/N2eW2CkfLdJFB7+OMOd
         g1powuD/TWYjzb0yIoy2GwrECX46tQ6inR531h0iamUtCJ6zKcN5CZpU2M6H4ew3B/45
         kyuCIXtToPocT/GxxZTROtYEopYZLkf3R4gaAJlfsL0tHRX4vT8SjGuTCadDAO1+/e5b
         IHCKapGCf9pXTzCtrMf+KZsQpRz+laalw3EXAkGOM8CzARS9bXtaVdohwsUR6wTBzepe
         82UA==
X-Forwarded-Encrypted: i=1; AFNElJ93gDFMIx+wqm71eceqT5vLDNy8EwvrdY3pcGyoZbnEUINUtyjR6e7sYSg1b4BjV/PonUpNl0RV2hYNQnSvSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRPzNM7Z8rLtxho3PGfWIBQWyT6MlZBVLZPXIh6ypDD/iiFvKu
	e1I2PkumP2iqsgmsJ1aT7ATMhuW6GMztG9M7MEcgsGPGnphxC+xdQ5r1
X-Gm-Gg: Acq92OGSNGFbN+PmG3c86UkQewm3G2pCtbqXiWzRjqO0X4m7MZJfxsRRL1bLCflYOam
	jHyXF9jXlllgMRjbydhIbevDGdGZZlk9OiSrMY496jNqgc5Ios/YE8gMwo1W5VBfg2UxDYBfflV
	rI82rOWUP9k8Uq6dGKWWWm/wbJ1MBmSrFa2JlPY596Q9ISEEWSJnRrljUVPpB/0RaqQ2x0Ceqw3
	SVUWOWgfdKSI44hvQwSJYGj5D0K/AOW4EzQgwb4GBl47jyfn7H02GKvgJcNIvsryV6B72Gk/NVm
	M5qcGbm8yzmUI0vJLp7+GkOP8Z2YY2UMbq8olUrI+eNNqcJVMyb1LQVHjgNlIsjaJJxPrgsHC63
	RDr0MfmzmB6ZxlnzCiun7rjJyjs78ah8yo3xLapKa4hnrH0yPXnPpx4du4j8KUTpUxWvH0GrhI+
	lDIuk65w5xDvffg5K90mEC0Zw9gEKHpTjkpglQA+9b7KgCdnTPES0dZ+l89GZ+OjvqW1efDbi1F
	yR/SwBPfK8=
X-Received: by 2002:a17:902:d48e:b0:2c2:9a1e:6099 with SMTP id d9443c01a7336-2c29a1e63f3mr11148545ad.23.1780944825427;
        Mon, 08 Jun 2026 11:53:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649bde7sm191933075ad.72.2026.06.08.11.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 11:53:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fdbbce52-6831-4a2c-970c-ff0951483947@roeck-us.net>
Date: Mon, 8 Jun 2026 11:53:43 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] watchdog: improve comments & Documentation
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 linux-watchdog@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
References: <20260529212024.2119204-1-rdunlap@infradead.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260529212024.2119204-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/26 14:20, Randy Dunlap wrote:
> Add the missing devm_watchdog_register_device() to watchdog-kernel-api.rst.
> Convert some struct and function comments to kernel-doc format.
> Add some UAPI comments for quick reference.
> Correct some grammar and bulleted list format.
> 
> v2: modify comments in patch 3/5 per sashiko review
> 
> [PATCH v2 1/5] watchdog: add devm_watchdog_register_device() to watchdog-kernel-api
> [PATCH v2 2/5] watchdog: linux/watchdog.h: repair kernel-doc comments
> [PATCH v2 3/5] watchdog: uapi: add comments for what bit masks apply to
> [PATCH v2 4/5] watchdog: core: clean up some comments
> [PATCH v2 5/5] watchdog: dev: convert to kernel-doc comments
> 
>   Documentation/watchdog/watchdog-kernel-api.rst |    8 ++++
>   drivers/watchdog/watchdog_core.c               |   12 +++---
>   drivers/watchdog/watchdog_dev.c                |   30 +++++++--------
>   include/linux/watchdog.h                       |    8 +++-
>   include/uapi/linux/watchdog.h                  |    2 +
>   5 files changed, 37 insertions(+), 23 deletions(-)
> 
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-doc@vger.kernel.org

Series applied.

Thanks,
Guenter

