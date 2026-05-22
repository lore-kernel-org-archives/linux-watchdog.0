Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA217346FB3
	for <linux-watchdog@vger.kernel.org>; Fri, 22 May 2026 23:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779493443; cv=none; b=AuJvo4t15VtsghrMatxm+Xt7QDkndafhJjyO0I7iUQmcx5ZFNBZxdnp4jsTt4Rs5wCCEc6F4lLzDyUNI9mbmtJXqzcuNBAKQmpnwm43yC5pz4BXI44RKdN0jiBC6yvgGQHiiS2FTIOdDvjlGLbrkdXI23VSaU9A9uWgMNEnWXGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779493443; c=relaxed/simple;
	bh=q4SvFZU4FuJSDlfTQI3SJ7O/uL8cjwpxfGQQUGfphv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P8aHlROFlEvwTc7qdfErH19OilAlB/9ApczIvSOjftMraN+JAM+/NmQAr6tujxvL8aSAldh6ua6TwRRrwm8JpRvXugCKK3g+Bnm7NixQZmGhn1wiCHPUqi+m5AFRz9AU6SZa7jjcqGoLnTfH3pHfvLf9ZPHCafwFbTxiqQsDiH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHMfvM84; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHMfvM84"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-135e88b8e55so2526609c88.0
        for <linux-watchdog@vger.kernel.org>; Fri, 22 May 2026 16:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779493441; x=1780098241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vXL3D0+dMa2UOOeAgGRhlD8/4KWumO8zjBDfLZKAFeU=;
        b=cHMfvM84tlZF7JgeaN2xJLQyP5tDQ6G7aKiW6KLZKpPBaKBAKlfc1fabqOpfdIE8kf
         uAYxTxIzykJux+RfhFTud2uXt+RgKUxmYSKkm3EYWnbYmIkGJS267R71VXa888m80B8U
         ROBMHlV84tiJDzufu7kip5DRy//cP69U5ES5xDLv4pQjqYnU9awTcCqZPeylxwYaovJM
         V1/4RE7dZ1TCVAR3DOUczYKNfvTyoR8ajhEundEL1LQ7G5VtrQei9XnO/cLcnYvJ8KDH
         VR/mo2Bf5HLZfiI/GwepxnICnheVk+cyne9esOLmWf53U/10VZowwbLQzF79Zp7MShTR
         Hmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779493441; x=1780098241;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXL3D0+dMa2UOOeAgGRhlD8/4KWumO8zjBDfLZKAFeU=;
        b=Ks5/tLP0lG/+cqDemI9wiSO5vgMyrNjRbRX97YZ7m0Ma1qv3UhhKLdqMj3YD/Ayem3
         4szIQegwmXl7DQoDfNZQnCUFbIj+qxCMfPVVuqVXj4fkd9Ks5JbJeeFvfrkuxuOSe6cJ
         XPsIvhiRc/jx8SaDVSH8f2hUg9WY1lPmKQz6x/0igRNngWsOc8ciAKahXKdw9NgUUrDM
         /7SbfcfYuhWM3iJLuMbVRpBMGAEFD1evWYvYZ/Tg7SvzdIoyazQl/aHG5fojtgZOLDwz
         P0VJIczhPl9Z8OqQ3kOwPaunGR7wcqhFVDbAAdNvArgZWzUQsuzvKvB4GfFh3UXigcRr
         3KBw==
X-Forwarded-Encrypted: i=1; AFNElJ9n+sBHU2EfQ7LxEMSGt+41Lsr7Z7KRzEQbLJ6ltj/zYaQMkzuZpjT52lJAcc/GL+Kk7gBo/gafFfPKez8nog==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIAkI3JM3tGnx+LwVNh7CvmJhRGmFaH/kkBOpGfy85V94T6xl8
	sbr20Z8LTil/CdUjQ9mArDXqHdGgtDlyQmYpgzOBHAEz12ezVUcuaXwc
X-Gm-Gg: Acq92OGu4w7N6wnkf/6hctqt+eV494cc0mRqnFIVCyHpUN6GJUAEzIUkt2NI2Z6nn79
	RLbV+mNlyA0WRe30uwVFqs/KKhoU4BVT2k6gVg70Z7nPl+otfd/Nu08/JWIUEb11/gcFeqaCHIm
	tjwIP79L3968J8ksr+DpzWDuhGb4DlHgwrg0qqUQiA5l0JZd1QVfAAO3filRT2SJzpxBR3jW1Pj
	RUsr8iuxOayGXN4B0xsQfqenSsUgxuWI/F4xtIc8FtXRoBdczUOY0Iwq+WKdisdcMAw9pq7Fda0
	yVRG0pliy7UKfIbUCZ4DEzSRRBzXUXaddjTdgxlvUlbBpYJoO2aV9U1FmQbZ53FcFdKGjqsHGt/
	lHZpKoFMUiJ7hn6B60lrmg5nigHcPEMxuhqn2HDvZTnNF4c5XQUKUYy9E2do+Eqw34MMzk1SFHh
	+mI3Fjr0t9tEh/bZ2CQKNc+YdnzEIs3L6YUC9BqIWh1c6egQg2I8q/F01wnlp1ZuwLz6sS4xikm
	U2X45B377s=
X-Received: by 2002:a05:7300:c89:b0:2db:2089:460f with SMTP id 5a478bee46e88-30449141cfcmr2720949eec.19.1779493440865;
        Fri, 22 May 2026 16:44:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304524610f7sm2091363eec.29.2026.05.22.16.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 16:44:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0f1388a6-3326-4113-98c7-5f19a1f75186@roeck-us.net>
Date: Fri, 22 May 2026 16:43:59 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] watchdog: ath79: modernize and broaden build coverage
To: Rosen Penev <rosenp@gmail.com>, linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260522232553.44748-1-rosenp@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260522232553.44748-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/26 16:25, Rosen Penev wrote:
> Two cleanups for the Atheros AR71XX/AR724X/AR913X watchdog driver.
> 
> Patch 1 splits OF out as a hard dependency (the driver has always been
> OF-only) and broadens COMPILE_TEST coverage from ARM to all
> architectures, so the driver can be built on non-MIPS targets.
> 
> Patch 2 moves the driver off the legacy miscdevice/file_operations
> interface to the watchdog_device framework.  This drops ~100 lines of
> hand-rolled ioctl, open/release, and busy/expect-close bookkeeping in
> favor of framework callbacks, fixes get_timeleft() to return seconds
> instead of raw clock ticks, and properly propagates -EPROBE_DEFER from
> clk_get().  nowayout, the timeout module parameter, and module .owner
> are wired through the standard helpers.
> 
> Tested on an Archer C7v2; sysupgrade watchdog handoff still works.
> 
> Rosen Penev (2):
>    watchdog: ath79_wdt: select OF and COMPILE_TEST
>    watchdog: ath79: convert to watchdog_device
> 
>   drivers/watchdog/Kconfig     |   3 +-
>   drivers/watchdog/ath79_wdt.c | 248 +++++++++++------------------------
>   2 files changed, 76 insertions(+), 175 deletions(-)
> 

Is this a resend, ignoring the code review feedback, or v2 without
v2 tag and no change log ?

Since there is neither a v2 tag nor a change log, I assume it is a resend.
I am going to ignore it, assuming that the code review comments have not
been addressed.

Guenter

