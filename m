Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D5837B007
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778537237; cv=none; b=qhwK4sTOxyKlWdFJtAfS8zbv1sVn0CdbNYlyITh2TlUQAf2LB+vAoR/IOAOYcY9ZrdfMOjMq1iQHU92jaqNi8ILuUo5F7pBUN7nsUKFD2kdr1obs8Ung8XfVPCA8hKPztPL0j8yXTk5QwwX/fDJ6IybZclW6ademc6NxICuqSTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778537237; c=relaxed/simple;
	bh=QFs7nqmR7JrzXgxD6Zs6LaHqdsxyrpd3DgLmBmmARGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=foxQf1wC9sCsIrz4kb4tKXMxWLM2115c8fx+QQ8M15FxphUxFPXQ34DbZJzbmJd/mXFcHkGNVAFSD83sK1Ke8Zxuk6PHGT0QmWFd3bU4OH328y3FQDHSKvVpBsi6ru1a2+GuqIBy7BgFNm9ipFIEmhoI6LYs66HCfatyBeiSWXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPu3Cbv/; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPu3Cbv/"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso3569580eec.0
        for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 15:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778537235; x=1779142035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CAvhfSv90Ak/uTTdL6mDlstvJH9p4n8pmJ+MU06fBxo=;
        b=WPu3Cbv/n9P3FBhTft76+a54qXbDb2jhOLgxGpinpEb6E4KOBfe8QCiXn4HmvV4Uxr
         xEOrFlU6xaNACZ0OnCbXWXh7dD83+/EuR6QWeuEgGj5HQSbjVAh06iHhYzlKAdWnXq83
         1qyV38UF6vke5GFWBJz4GFhlagMGugpfxffBMuaqJQ28ixUr4CErpDOwGiAmwNmJWV64
         X2F8EWU+gWDSi0hYgHrcwVCS+x2Zz8k8Wzn21MmRXXh216k0VcL7M+ylTTooDDzMZ96Q
         MJCTdEUOCH4C0CMBjiCXlu5n4cRp1tGEDIJSj6Vp+cTltoIMkrKcjowuHXLbvuI/1kHq
         PdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778537235; x=1779142035;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAvhfSv90Ak/uTTdL6mDlstvJH9p4n8pmJ+MU06fBxo=;
        b=pIQg2hFSH0gxVUkjup4kk3ussYc/yt0pMYCqq2QuR2aAyb6ynsfdLqL0/lNr4WsKsS
         gh+8Gpoy0DoCRRP3vfsHmAcdpgWC1XTvf0BZNoDD8ynu2kAhmOx8LQN1mJBGLPkWPX6S
         N00yT6RdI0eOQh7nrpa7JgfGRP70vNyudWE5JorU16I35TQpRlzlo0ZtQYPQqX6ox0JP
         eDXYiAHfgBDL2Wghs61g4GVOJe70dNpz5AF9WAJSv0Vs59HBwnUXRY1nHxCglpKn8luz
         +eJhEiFdNwmHesUMWZMLf6txpGLlo0yd78AsbN63O6S113ajXPs3KsVmAeJ0dBcPSPG+
         DPqw==
X-Gm-Message-State: AOJu0YzImXSdyoY9qyjXFEji7Y29IpFuLAy+25jS4f8/ou7j0xH/n4GZ
	wSo1tdJQu/GhZCdNquv1bUlq6zxNMkik+tAHdkwASf8adQlf1n2P/xRK
X-Gm-Gg: Acq92OE4p3S3ySB9oQBza42VPSFhat19jph2frLayKrTKrqh9CK7Q9O2ixgEzNyhKFK
	ScvHBPvUC3FpDo7DUguuTic1I7B3lqT2gqmGAnxGwJ4aNLxkX4eAD5Sjn7xMJafLA0vBA0i2gXP
	3lUzdFrC4QD/BGjUHgn9q3Q+bukWVZONlRK9FuYic3UO4XBScvCgxQSInh+6A/30sbzeYtyqEQE
	QC3vc4AkhITtl5qTEJikX3G/X1brZENLy532omWWvD9XQaMG+YuyKTBxNZnQuNhCDohS1KNQ3wT
	Glu2KmOAGML82ZA3evxdKWdTA9xGw/kHOXgYk/WI2ai4tMwr0M3DzKPi3msb4vUSPvSVk7PwHGp
	6NyxOL4QylHWOkdBLgHCZRbAWfUsxNN9AYWFBRonFZSd1nMjDn7xG6vD4KLnX8l6y5GuxHu2T8w
	u7/NshiLON88eCUhqFOYUvri3BsF/QeDQdTLhnuD2f0b9sU32SmttRv9qpTgyWp7Epnj8SXYw19
	aRGSRq50fY=
X-Received: by 2002:a05:7300:5353:b0:2be:9c19:b34b with SMTP id 5a478bee46e88-2ff9352aa93mr922471eec.4.1778537234947;
        Mon, 11 May 2026 15:07:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88914523csm15057986eec.29.2026.05.11.15.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 15:07:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7eac96a6-b538-4519-b239-2e193939ccc0@roeck-us.net>
Date: Mon, 11 May 2026 15:07:12 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: sb_wdog: add missing SPDX license identifier
To: sashiko@lists.linux.dev, Mayur Kumar <kmayur809@gmail.com>
Cc: linux-watchdog@vger.kernel.org
References: <20260510191847.50499-1-kmayur809@gmail.com>
 <20260511214422.1FDEFC2BCB0@smtp.kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260511214422.1FDEFC2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/11/26 14:44, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The applied SPDX-License-Identifier (GPL-2.0-only) contradicts the explicit license boilerplate already present in the file.
> --
> 
> commit 64e66089a6e522c77284fd01a8849e12869d23c7
> Author: Mayur Kumar <kmayur809@gmail.com>
> 
> watchdog: sb_wdog: add missing SPDX license identifier
> 
> This patch resolves a checkpatch warning by adding an SPDX license
> identifier to the driver source file. It defaults the license to
> GPL-2.0-only.
> 
>> diff --git a/drivers/watchdog/sb_wdog.c b/drivers/watchdog/sb_wdog.c
>> index eaa68b54cf567..03db71a43d6fe 100644
>> --- a/drivers/watchdog/sb_wdog.c
>> +++ b/drivers/watchdog/sb_wdog.c
>> @@ -1,3 +1,4 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>>   /*
>>    * Watchdog driver for SiByte SB1 SoCs
>>    *
> 
> Does the GPL-2.0-only SPDX identifier contradict the explicit license
> boilerplate already present in this file?
> 
> Looking at the existing header comment block:
> 
> drivers/watchdog/sb_wdog.c:
>   *	This program is free software; you can redistribute it and/or
>   *	modify it under the terms of the GNU General Public License
>   *	version 1 or 2 as published by the Free Software Foundation.
> 
> Applying GPL-2.0-only restricts the file to GPLv2 only, which strips the
> explicitly granted GPLv1 permission and creates a licensing ambiguity for
> downstream users.
> 
> Should the SPDX identifier be updated to match the existing boilerplate text?
> 

Sashiko has a point here. I don't know how to handle this without effectively
changing the license. I'll drop this patch.

Guenter

