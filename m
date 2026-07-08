Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757C63B8D50
	for <linux-watchdog@vger.kernel.org>; Wed,  8 Jul 2026 05:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783490117; cv=none; b=Wk40eyDYlqOe0bjDDjqFY+RSGE7nujdjaYzQyspErSOqYj17tUy3llh+v4VwrLBPyhKvlwAV2iLUQeGJg31vBaKI0i3irz4iocUK5N6kJNtfqc+TJMylqTxKR3E9KO8PMkHJrP5/blGMhnz+nrh71PVHridaSRQp/O+kScPfLXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783490117; c=relaxed/simple;
	bh=vbsExeXMJHE04FEgLe7kXCcdytrEmJC/xuQMB+Sqmhs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T6tz/NMol7QqV5/Z36LdQGPXnO8wb33C56OReyqzMIWoioDLtx3ZZXSxWezjWbRGtAQKdN25MrUOVcHAGbCn6yf6TqzpZs7fcH+79TPAZK60dNCigNwqpPO9DM5vfAYFunbjYbrOzhHR/eSTsKex647I1Nz7GuMxv5C/9KBRZDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMGBjCrh; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMGBjCrh"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-845ea8924a2so302595b3a.1
        for <linux-watchdog@vger.kernel.org>; Tue, 07 Jul 2026 22:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783490116; x=1784094916; darn=vger.kernel.org;
        h=mime-version:content-type:message-id:date:subject:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vHE2Em/EwNfkDabcKZPdpCzl6Ls5nuS43RoQeeOvxpM=;
        b=UMGBjCrhfBaxOePhTo+kC4Bmg9nWADYj3coCa8oAZN770VeMULqmw24jnAjtQJ5aap
         bPVL5+z/BkVbQaJP8FGt4YPw6Yp/m9a5QAs1tSuuGUggaBy/ezTkTeUymYa8i8vpnsK5
         7vvYyQc/kdYRtS6vEZxp1QZlIjH3SM9jB2Q2l9bD2O7CEmoorRh1V5qUAzzB86LcokWN
         PVjPrgJgj/yEltDLz0MRcsLEY4Ez1FuQ9+1d4cgjPQjTUV3vxC57/piwY0Q7jHNELE5f
         x38gDS7Hwq8xSr/Fbw87R5cThtX+b7yXPa4J6QeVAMaget8Gf03s90voodh1TTpJUsxK
         MGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783490116; x=1784094916;
        h=mime-version:content-type:message-id:date:subject:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vHE2Em/EwNfkDabcKZPdpCzl6Ls5nuS43RoQeeOvxpM=;
        b=UVGZ2V1Q18rQXRBeZRnfOjkMJ2uVEWpIIf1h9ADdNXpZIJvDN8Pq5+kqs2CO1Qzz6z
         /wvPMfJ2U3dia/QlqL2P5Y/SEXwIw907C6TUibAd2XNE03HOvXgDVY8cRxdtYXJlPqHs
         g0kfEMS50CN0P2nseRqRIZw88Y+i6w+xuRUeBquxZJQ5di2QFN2VQHfBlCS4Qam9V6OI
         s33ZBdgqt5JFt/24U8wemg7y72OSesYKntnWmmC32TwUuDy7RJkbyOisgObEaDyzLw9q
         v/bYS4oGeHg6kwMRcGRD8v1+wn6zBRBpXBmiXAA9JlFCkN/T8m+v6BsQGEzNC7A/yhv7
         Qabw==
X-Gm-Message-State: AOJu0Yy4EHV0EZkbYOswB6RnWUYRdz5LeStwVJvIAPIRUxrnqAQSngUC
	qbLaJ4bzFXKw3MTkmKxL1nxLb929L/7duY3JMmyBjirmd9ByQapJCdoXcjlnfzH2
X-Gm-Gg: AfdE7cn/5Py5lxHB8QaRd2ow3B/aJbHDOIy8c/YG24K1UZTkN4i+7I25bUBarALOWHl
	MiomUyRTfUwZpiCxe+aG7uGbBd/HEo7AMVqXHVXhUobAKyAl+gMic/Thx0WB22x9FApao6zbsYN
	u29nlNMDrNzvEYfPUERcLpFVgEg9hz6lEqUBVAY2xN4P04uJ9UoW1akAynuSQ4LM4G9tilhKtXh
	Xi08Ki5NFzL8BtxqtGeJ1HpkACRyW7sFXrt3Y55HyWgc4L/8bxNSNniE5NwuM77+HAlk5dyPPqf
	mpPT6JYjNFgJIDRjHAO1bQTZ/7cqLwFJIYSbTn/RX9ocW+qssvVR/SJw/Hfwnm9oTjFffwB9/cA
	9LmkBtPckZNRM8Di6eEVfeTlrRshLArqDTNUuN5JWXWxzqsuCu3pHC4xTtDbcIrp8nQXPmQ9ujJ
	wqzHeCNQ==
X-Received: by 2002:a05:6a00:1bc9:b0:848:2f73:8ff7 with SMTP id d2e1a72fcca58-84843662835mr1263590b3a.64.1783490115645;
        Tue, 07 Jul 2026 22:55:15 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8480da8bab0sm4955867b3a.8.2026.07.07.22.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:55:15 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Christian Marangi <ansuelsmth@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: airoha: validate heartbeat module parameter
Date: Wed, 08 Jul 2026 13:55:12 +0800
Message-ID: <178349011293.87032.15993825644278020262@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Please do not apply the above patch. It introduces a regression:

The patch removes the direct assignment "wdog_dev->timeout = heartbeat"
and relies on watchdog_init_timeout() instead. However, since wdog_dev
is allocated via devm_kzalloc(), timeout is initialized to 0. If the
heartbeat module parameter is invalid and there is no "timeout-sec" DT
property, watchdog_init_timeout() returns -EINVAL and leaves timeout
at 0. When the watchdog is subsequently started, airoha_wdt_start()
writes 0 * wdt_freq = 0 to WDT_TIMER_LOAD_VALUE, causing an immediate
hardware reboot — which is worse than the original overflow bug.

I will send a v2 patch that:
1. Pre-initializes timeout to WDT_HEARTBEAT before calling
   watchdog_init_timeout(), so the safe default is preserved on failure
2. Sets min_timeout = 1 to prevent timeout = 0 via ioctl

Sorry for the noise.

Wayen

