Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B096395AD1
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951617; cv=none; b=ej9fdKavQBY/BlZk6ijD2+67E8My89NONCTJdR/3SnWysvr7q/TRBHX7hH3ushuSBiuZ7PIxA0U7DmSBUTIWjHkSUC9YpRq5zSRi1Rzj9PIJWYXD1uxerNw17iotR9ntCaiucf4SJZ391Af0YvHVYBDQ4ifm2X41nAZpRjzf5mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951617; c=relaxed/simple;
	bh=bEaf8aULI2NAP1qJYjYDPWPraHqc26x3oOAbFZC6PlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VhDbFJgzWrX23+usYvuqeesXTm7ETvhyI+HEObf6c+58Rq0YD/wTZqqTymExIIjAhGVxpXoC7Z1fptOQkHNpPEhdceJemtHNMVjkpWcd1aWQOpc2G4RXrCH3imfqdzMXvyC6Zwx7pNRef8vU6/jLldBNf54Kw5UORe/zI/MMnsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpCy22CK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpCy22CK"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0bb4a94b8so39596165ad.2
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 13:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780951616; x=1781556416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CTHYF0gXwpZZGXcMBjy0ufqeX+RO5e+JUGgSSbuMdLs=;
        b=TpCy22CKvgGDLPdQAvowV6gsvQdEgCT6zRpVlvZwwXal4PQJO3rpATMZ2yWPdB7iB/
         dyMr92XPAKSS+9sE0yszpO/cFXfqdS/8Ig6seYXe/R7JXGv3t5RrefMCUekNt97K0nIT
         EAY1hUe1yFLWR39YNaV097d2EtTtInufvsfoEI+euwpmr+91rU+PBlxYhWaJ6t1UE85A
         xFfmF9ngzOl/AlUYbEvE5kNjUTyi5YQkXy/6RSwDr/KCtJF1O6t5YbbWOV0E3yTfDbJn
         M6rZLhBVnSLjoUGFdzxiu7kDFIHU+efwkwZVNONREzXTWD836jIA9lqIExzUtGrwP+Tf
         JsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780951616; x=1781556416;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTHYF0gXwpZZGXcMBjy0ufqeX+RO5e+JUGgSSbuMdLs=;
        b=jF+6Qmq6Hn71jq1u4Ub1jSRSaiGO70ANho6g9Q39hLGcZP96SkEjfTBE2V/IXLWXfp
         cQNWXxtnZkTU3hqhlhOym2hDpPyCYljNgjcUJ219Ln+JqlEhH2JMOJ/Ckbu8j5P5mFc9
         Ao1xXv0HBCOtL38XeU3KrN2hfC0P68zy6wvpf1A8pC5CEsYVPuDDMLdOSA/5FHiQxayz
         tKYoehMFz3OflTeh8MYgg0XvfWHsa4yCbsQhHgVWjsssCInoK2pDsICRiX6Hsw3TPw9F
         O5Mv16PKKSspb1kA+DC3EBK1QTYa6tGuyyB90/sfojlPbpQtZRXGdHchq4ZCXdl7yZjU
         xn6w==
X-Forwarded-Encrypted: i=1; AFNElJ9WOdggM4+RPI2FjKmZbSGwzNRefGxfIrkS3eaJynXjT9Rt55RuUZxxVCLzsosFtaN6GHIZohZNJnTR55DVrg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yws5LzAPdeK+juWjuJ8bWpf3/C18bavp6Hinx/rLBHfKpfcIJ/X
	qtuMpJZIUGMx7I8aGViNXu3LxdWaAUJ3N5dTZwlMeEYslx4y+EFAwiiV
X-Gm-Gg: Acq92OHptYIU7ff0bfcORwGhiPDEHFN7IIPfBbWUDH1dShnxNSIyDOB1+85pgkKJIks
	xY7GCyF9JW02AOrSYp5m1Ig1pTB/Jvv6xeoADXlEk0xooyxS4/e9tcVGBggaIf2HjuKpuAb3GiS
	lYBw2hluo9UZJ+1nW3SyOGqOTU0ycgLKlixJMVJBD50Nl5TNpU0TiJMkt1HAnlDoMPHRkNZweMY
	ky99o+osJeuVaSGOgiD4ZOzcd1it022HcJDqNjro8EaGuDIiWTbFnnSKp/g8y8+VybVKDhiSnsZ
	DthZHTt5HBJyrgs4oj+R0UjNXLs6Ooguxjl8sS/gJJmxKaenklS33GRI4NaEFWIbIy7W+d8zkpB
	vsu31TbqqK7G+myU4NA8ntWPJyH8MzS/UbNuHyBRIOuf7K8lXR4F+VuKSeF5jQiJQLNoqMCK0fw
	CFsPH9W4RUUHdSpyWiPFNKWJqduDGNWSc1z2Kn8C06kEiMK3QcsyPzB3qJXQSY3DziH93MPD/Vj
	1zJWKEAc1MFZF3hqCeM0w==
X-Received: by 2002:a17:903:1b0e:b0:2bf:dd8b:7cd with SMTP id d9443c01a7336-2c1e7e4bbacmr186796455ad.10.1780951615779;
        Mon, 08 Jun 2026 13:46:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f875casm193147965ad.22.2026.06.08.13.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 13:46:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <16765f92-e6f6-455d-8341-f6eecbe3529e@roeck-us.net>
Date: Mon, 8 Jun 2026 13:46:54 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] watchdog: starfive: runtime PM cleanup
To: William Theesfeld <william@theesfeld.net>,
 Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1780664848.git.william@theesfeld.net>
 <cover.1780666366.git.william@theesfeld.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <cover.1780666366.git.william@theesfeld.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/5/26 10:19, William Theesfeld wrote:
> This series addresses runtime PM correctness issues in the StarFive
> watchdog driver.  v3 fixes three issues that were raised against v2:
> 

I just realized that you are sending new versions of this series
as reply to previous versions. No surprise that I am having trouble
finding them. Please follow the guidance for submitting patches
and stop doing that.

Thanks,
Guenter

> Changes in v3:
> - 2/6 (pm_runtime_put_sync positive return): the v2 commit message
>    and code comment described the semantics of a "1" return as "the
>    device is still in use", which is wrong — that case is signalled
>    by -EAGAIN.  A positive return indicates a non-error condition such
>    as the device already being in the requested state.  Reword both
>    the commit message and the in-function comment to describe this
>    correctly.  No code change beyond that.
> 
> - 3/6 (probe error path restructure): the v2 patch left a path that
>    put the runtime PM usage counter twice.  When the success-path
>    pm_runtime_put_sync() (line ~513) returns an error, the function
>    jumps to err_unregister_wdt.  In v2 that label fell through to
>    err_put_pm, which called pm_runtime_put_sync() a second time on a
>    counter that had already been decremented by the first put.
>    Insert an explicit "goto err_pm_disable;" after the unregister so
>    the post-register error path skips the second put.
> 
> - 4/6 (system suspend/resume guard): the v2 patch added a
>    pm_runtime_status_suspended() check on the resume path but kept
>    the final restart predicate as watchdog_active().  For watchdogs
>    started via early_enable, the framework state is WDOG_HW_RUNNING
>    without WDOG_ACTIVE, so the existing predicate left the hardware
>    permanently stopped after a system suspend/resume cycle (the
>    matching suspend path had already stopped it).  Extend the
>    predicate to also accept watchdog_hw_running().
> 
> Patches 1, 5, and 6 are unchanged from v2.
> 
> Several pre-existing issues in adjacent code paths were flagged
> during v2 review (hardware access during driver unbind, possible
> races between device_shutdown() and the watchdog reboot notifier,
> SETTIMEOUT/GETTIMELEFT ioctls touching gated registers).  They are
> not addressed in this series; each is a separate logical change
> that deserves its own patch and its own justification.  Happy to
> follow up on any the maintainers want addressed first.
> 
> The whole series builds cleanly with CONFIG_STARFIVE_WATCHDOG=m on
> x86_64 defconfig.  Runtime testing would require StarFive JH7100 /
> JH7110 hardware and has not been performed.
> 
> William Theesfeld (6):
>    watchdog: starfive: balance PM refcount when start operation fails
>    watchdog: starfive: treat pm_runtime_put_sync() positive return as
>      success
>    watchdog: starfive: balance PM refcount and disable in probe error
>      paths
>    watchdog: starfive: guard system suspend/resume hardware access
>    watchdog: starfive: avoid PM refcount underflow in shutdown
>    watchdog: starfive: release early_enable PM refcount on remove
> 
>   drivers/watchdog/starfive-wdt.c | 109 ++++++++++++++++++++++++++------
>   1 file changed, 89 insertions(+), 20 deletions(-)
> 

