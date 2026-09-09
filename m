Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6653493D27
	for <linux-watchdog@vger.kernel.org>; Wed,  9 Sep 2026 23:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994980; cv=none; b=S0c06Je9awoJf/APnkWZaBe1mgvMoDcMbZSV4b+7fmUrspThWfM9kKqEFtOcSQqQy/uyI8LqIq31Aft8cpSrVPb5VHx4LPwL679eNj/uAjIlyaVZJ304bYjV+7yxUeUYKQ9Ya9PtjNtuFpcoZpDaGEyWGFs8bZjpFrl6gq0z7ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994980; c=relaxed/simple;
	bh=1j7l0Y1ODaK0ozctul3/9zDe7XSdhaAbWCE6M5p2n44=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VqtxPy1tqgmHIZgQd2FAzvcndBNAz50Ui41xF/hJo8U7vOW9hxjG4Ny9dnYwVrOE5ooCZRt8XzHabqUjRfRGUncwsY6TvkoWj0yeOBQgAe4hqP2bOfMkIZ1qg6WPsrwYXu7Lb7eAN+chHtVR70ZOdQCUQpewI5JKQtCwu5b/apg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIH6HTvF; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIH6HTvF"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3964e480f76so7529282a91.1
        for <linux-watchdog@vger.kernel.org>; Wed, 09 Sep 2026 16:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788994974; x=1789599774; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=784UGVAwRi/KDZ/caVwu4a+8R3qNa4Fis8BmntQvL/8=;
        b=QIH6HTvFYiMoljAFJM37PXU2qG6lLXHOQLEcKObGsdiiI5sDa1nT7pdO2Kidu7MHl5
         Tqm5JRir8S5Dgnnyi3byyJPB6/4eW6PZQqDcduktWDZ6zMLkmcEYjDIIKHEN963P1eEk
         JcOaoLQHuHmvoG4nkuMv6UH6xqdaNe5jjNgdAV7RDd9ilatmDs2ZRSj8V4bpQTA7mUii
         x4Luo3gf84GhXFQvEBfTGnyQla++KL8Wc66ki7I0gsG4HdILsv6rBFl/QusRUzJiuPOG
         a+nctBKtFOIb0BCRiBETf6BP7P6vIPgVkHC1fIkWroTuCEqA2d1jp5uYQloOH5U2pBub
         KhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788994974; x=1789599774;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:sender:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=784UGVAwRi/KDZ/caVwu4a+8R3qNa4Fis8BmntQvL/8=;
        b=p/5resoM9CXyn55NorudVzI43vL0IfxHcJL0l3Qf3yZSmVnck6SFnFQxqNNPfgJOQD
         sXMNX5esm9S6smXin3xR7fjDGzIAboAR67YAVPOz/M/Wg+iBEre1Pn0aIEfm4moAa8bI
         wUVqHC7hE9qhroj0G8i+sOcvCOoH3FM0KEeMpJYyxUiWTP8iIiY2nO41igTKgzHMDC0L
         BzzpGVIuLmuZTy1fHxZuN4NbUFOgUrKl5dhSI03ZtMfJkEc+HayHqslro/hD1vJEGUh7
         GxS/CDZbv4QEfjiIol0jLfmOvbhKGmWgnGdD2tk/vI6sDhkP/hitxNcJJEM0puqu3YuA
         pm2w==
X-Forwarded-Encrypted: i=1; AKwUvBwW0wWEKyhIIH2VyJpSIoXgEicULDwObihy0RvbLZBT3ZpWL2TEzqoi17L1yb0/RJFuvgShbq7hzOIOwPQbzw==@vger.kernel.org
X-Gm-Message-State: AFuF++mjYD+pmRF00gAf6vGTILC5MpoJDxinSRobtXLWVGN5Q9KVTbSw
	AFevCEJCpZwL1pnRt5pTwWbojm6oHtsplXygFAWb+gTA8oKgbbDofEoP
X-Gm-Gg: AYBFou24ak2Cl9AGVSlPbMSaSl4Nb4ka8YnGzZoOodzoRs3/Td9ubAuGbrOMeqJaN5E
	fjBF5jsMzfvgpORH+/qsJ8DWq53klZL51xo7srxc1Cg/TiPM6P/Xs1uATSsjwn1LUGEl0NF5Mwp
	+rQYjVYFq0wFaFsUMn0EvDGMX5qlYQgL/SKCYPe2ApcjgdstRBSyT2u2Hge5G8PBvKuj80f+qad
	uWnkv1eVgDOOtYXz8MzFjvELPZqIcErEu7R4C6RD7+LJsZbHCDSx0YbknzBxXfZug06kLT0W3Pg
	w3OBA8VijOYHcwc/LtaC3zPT4H4lQncX5hEpobxDC6pqcF7u8Tw1SGt8SM/yYDDI+yoA9Vv9X3F
	4AwYeGrngp+QB565nptpL9XqLfvZRqX2yhK6pbGEIwE9uqMggpnHOKriHsU7kYKCBpNcgxGv+um
	mxt+T01uoNw1Gkdp0bWntxGpz2EdgZIPMgIgEMVfadP8nJ/4AKN//1lMivMps/NFlOEIW1hxene
	xs5amQkbWSApdz9o3YihwJMb9YNE6WKUrRLimBI2w3DvTyaeJTKMJ45Dnk=
X-Received: by 2002:a17:90a:dfcd:b0:396:4cbf:45a2 with SMTP id 98e67ed59e1d1-39b84cce5a8mr26071124a91.14.1788994973628;
        Wed, 09 Sep 2026 16:02:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d7e3f603dsm393786a91.2.2026.09.09.16.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 16:02:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fb43fbf4-aa89-4cd2-895c-a5f3ef4bfab4@roeck-us.net>
Date: Wed, 9 Sep 2026 16:02:51 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] watchdog: msc313e: Fix spurious reset on suspend
From: Guenter Roeck <linux@roeck-us.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Daniel Palmer <daniel@thingy.jp>, Romain Perier <romain.perier@gmail.com>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260828161348.13212-1-tzungbi@kernel.org>
 <20260828161348.13212-6-tzungbi@kernel.org>
 <b28e620d-4508-4287-a8e2-7d44cb062a67@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <b28e620d-4508-4287-a8e2-7d44cb062a67@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/26 14:16, Guenter Roeck wrote:
> On Sat, Aug 29, 2026 at 12:13:44AM +0800, Tzung-Bi Shih wrote:
>> If the hardware watchdog was started by the bootloader and the device is
>> suspended before userspace opens it, the ping worker (from watchdog
>> core) is frozen and the active hardware timer continues running.  This
>> leads to a spurious system reset.
>>
>> Check both watchdog_active() and watchdog_hw_running() when deciding
>> whether to start or stop the watchdog during suspend and resume.
>>
>> Additionally, call watchdog_stop_ping_on_suspend() to ensure the ping
>> worker be correctly paused and restarted during suspend and resume.
>>
>> Fixes: ffd264bd152c ("watchdog: msc313e: Check if the WDT was running at boot")
>> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> 
> Applied.
> 
> Sashiko has a point about the bug in the watchdog core, though. We'll have
> to fix that at some point.
> 
Never mind, that fix is already queued.

Thanks,
Guenter

