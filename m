Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3F2388879
	for <linux-watchdog@vger.kernel.org>; Tue, 23 Jun 2026 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782240297; cv=none; b=BZmBOzQJX/G9H2TJzOIptPMXUJ26oPnt2roOBZLNe38Mn9Lky7I5MIZhKQ25qw6Jk4mrDrzejJbszoqm4pueFiOG5RxnxMPCbT878EZedlpifKmaZn6mZau1QxyZAA2Xa3PaCmO5NnOEeAgT01VxwUi47iQlFfDvMDtm9o5jdwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782240297; c=relaxed/simple;
	bh=c25CyKD4TDzM8bCkhGJAAOrIygw2QltFIUCFv3cU9Y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ney/VapetMXRejfMAu0nxpv8FwkmhE2M1alv7z1RtuOvAhNwqjyZlNHDKVP93QXFQGb67xckSSheP7KgghEkskWgab3O+maqjYtFv6jak2J1z7dDCUfV3IlAQG0HkJ467iv3OBcle7ohHDog+lE7XejeXWs3e+dAllzry4Wjw4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHezxdDy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHezxdDy"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c7cfa17fe0so1066045ad.3
        for <linux-watchdog@vger.kernel.org>; Tue, 23 Jun 2026 11:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782240296; x=1782845096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PVnFFhSx6CDqZubFa8ElYAY4cBYEPlZEe5EfKGTBxwE=;
        b=sHezxdDy80hw2SxNPaFYJeJGeuHHvKm1TOCO9HSq9hvCSxBVtzvtylQ7QMJNF/3FU7
         deE6PCpddkrubvvo5u1z8miT8gAl5X6SBbtT83s1fzM9WYt6irMCPMxArU8UseurVoPW
         50vvkGMh3Aqs78Hc+kDGkGRe6UXNuLFCstrOR1ToRI2/7MCAKM3WwHlY1P9wzkiz0Evi
         WfDEbdL2wY3VGAc44O7V4b+EVY4qaMyKjgJ8sPa6vpTXRwpJ7bonxlUbaRQffRte6BGt
         1F/uiAs7cs6hEKqtZjPE/XjehdugRRgzRO0P7z2ZJtaxhl3OrhWajEV/u1k2Gv6p3WPY
         okhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782240296; x=1782845096;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PVnFFhSx6CDqZubFa8ElYAY4cBYEPlZEe5EfKGTBxwE=;
        b=FUb7mAv+4RbqAAiqQCXEMksxadUglxssrWU2ucX4XNwp9rtWA46+7mDR99LnvzMouY
         gNEwAVXEj3ADMks3Mc0IWRDxjxdG+A40YJBoawtAui8fl3OIj4TiCSyfwM7jZv4VECu4
         rn8yytkfaxbb4Df+x8z6GykR5YJ8sI9I4qLNKyAfRjEGc55plKahn4aJ0O1NA2p2Lnr7
         Lv2VvrhVfDfg7j6RaKaXY2nnUhZ6uG50HXf1OpdyKamuSIdqrs3szzV/YQubSt4aq/xc
         IQ7uCD9cqvRtssHwF/gmPxZkS7KYE87kIqKW77aweZFOuwXw4xAYh4ul7kskA8U/ZOd+
         wwtg==
X-Forwarded-Encrypted: i=1; AHgh+RrNj+ih9kgql4HOo8XPF1S01uJD1QS/vVE78IeQ279ldRi8CiZJn/AptBLYZESZPpx5Ia6Otnn0/B1SnFPJiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvbfU4JYeplNKidXqqdeiB3cyzlWWNcDnBd6Y4WJnUS7hVJ68w
	fxnzO0Uw8XpFlZm8D1tGIC+GA/hARYMQwGCMtCKF0xedU7J4dOsxUKaH
X-Gm-Gg: AfdE7cnYgFFcsJEpAAtIn5msmsDd9bkXpTlCCjA90HBcptBbwFtPB+qK81YbftuDHZ/
	S9trKr6bbEF/+k8/HJI8ifgHGirqbGO8f906jA3PZiwyzki2M0Lkx5TrEX7B/1ePRyEoQBouPRr
	czshbT+IDDYzg8o4PzKPwXZ/39sjelXCfxCo7KJZPy0jRGJYs12+cbjOKjkjUL91Gj1ZRvOpQaM
	jpAy2MvhkgelooX48+XkyQtucP9+s2SPoMEaJ4XSOh4BPyTgglxftgqcHygbjhWLMNg4wMaWnfk
	rszG7HA1K1+HE8PXfSIxqKSSqo8F/8O1XkyO+LpzgM2WYMGsWvFuNH9EQa0MkmLWMkaXWQpt+Sc
	3ciPXHCZ2PsbHYdnSfJUCOIsLKl3dkZ51g51IunjlPV1PMhIcxG/WXOn8oE0MoTDtKr+VEmAVaT
	oXtgJYUsW8bTb58rcun6Vz1mKfDLcVd77BgKkMNZ0hSDKpzKoph/tZkfpTamRQgQ==
X-Received: by 2002:a17:902:cf05:b0:2c1:737:bed9 with SMTP id d9443c01a7336-2c7e15e3618mr693145ad.30.1782240295824;
        Tue, 23 Jun 2026 11:44:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743bfdc97sm137577285ad.65.2026.06.23.11.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 11:44:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ce37814e-d275-4b0c-a50b-7b164aebd262@roeck-us.net>
Date: Tue, 23 Jun 2026 11:44:54 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] watchdog: realtek-otto: Make use of regmap API
To: Rustam Adilov <adilov@disroot.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Sander Vanheule <sander@svanheule.net>, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260519182329.24472-1-adilov@disroot.org>
 <05dd2b1d95985e303af332ec81cd830f@disroot.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <05dd2b1d95985e303af332ec81cd830f@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/20/26 04:23, Rustam Adilov wrote:
> Hello,
> 
> I have noticed the status for this patch series is "Changes Requested"
> in the patchwork site but the maintainer opposes the requested changes
> by Sander in [1], so what do i do here? It is just one the roadblocks
> to get USB stuff supported for Realtek chips.
> 
> I have already sent a reply week later in [2] but didn't get a response
> back. Maybe this email could be served as a gentle remainder.
> 

I said:
	So this is now a NACK if unnecessary error handling is indeed added,
	unless someone convinces me that this would add some benefits that I
	am unable to see.

Your response did not explain the benefits of adding the unnecessary error
handling. I did not see a rationale from Sander either.

On top of that, your patch did not explain the real reason for the patch,
as stated in your reply. This means that, for me, it was just a patch making
no functional changes for no good reason other than to potentially _increase_
code complexity by adding unnecessary error handling while at the same time
claiming that code complexity would be reduced.

Also, I do not recall even an attempt to address (or even comment on) the
actual problem with the driver as reported by Sashiko.

Guenter

> [1] - https://lore.kernel.org/linux-watchdog/1d5091ff-e497-4b5a-a906-7cc02c31c4c0@roeck-us.net/
> [2] - https://lore.kernel.org/linux-watchdog/b4b09be5ff456a23d15a5af3237b9b46@disroot.org/
> 
> Best,
> Rustam

