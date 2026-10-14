Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF4D3A839B
	for <linux-watchdog@vger.kernel.org>; Wed, 14 Oct 2026 22:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792018351; cv=none; b=Y4qAyXblxriJoo1XUcBTDQ4cXDDGNXqqbvVInDOVM+zzgIOgE97jkd53dEWA71O0YRJjPX68VbtFzueg6s2W6Jxa0onZnRECsqcsXsG4wynb0TPvnqJeODTihE+rLI6yn2nUZmq21NWJHlwi96LPEtl3bHRJuV/3ndj4xicPtXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792018351; c=relaxed/simple;
	bh=Dv285TdB37LnSxZIpZgzQxZqoHxKE3YfdfhzW1DhwWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QP2+p6UwYanOB2f36zgJH6YiC60Q7Ovz2qcyY5XOCXt7AiD3VOPxkcoT7Osn9Qq47dJRPn1rqHFnGlhVqNeBVYf3K1nSW4owx6T+VXTXb/qPz3HqEkhckZZByMvCzmeU9QbsySssLHumMpmeIWVMjKqRWRMWRRzPSTBqumda8LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SS3Pe35T; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SS3Pe35T"
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-66fca0709caso949570d50.1
        for <linux-watchdog@vger.kernel.org>; Wed, 14 Oct 2026 15:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792018349; x=1792623149;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dgs0jfbzLr54cDGLw+/qa6h/ifV1QNwCX2SE9JA4qX4=;
        b=rsrKjqnB6EYqo0SQcG2kwtrvKR9HqkKByJFBkJaf9XlJMeiPrUewAagcAQO+9eCDgj
         kAj4cOoaKyGTfvQPGd0fnerMcG4H8/rUn1ojh1bN3KnAmIK6J6QrvyDLQpzpP0uE67s0
         t+Y7e5+qX47vF0/0YzMP5I8bfSjimI8oDpbqpi+TI1be7Ln37afhcjyqjiw0Uzjf6ltx
         KUkB0fLjJrFD2T6GNa7immDmTNf5I4Gsi4XjWlsF7ZhyEN53v1Ri2uLetYpdOHIX6Hrq
         K6qxb6zNZsCLdcufBaEJnEGofrdxK5MQsRmj/9IS1BIyyDuXfsXaUM98FmTNXGPOVZ/5
         UcMA==
X-Gm-Message-State: AFq9FYI2rBceBxYnm3ZrkVwUhoFf4xvXT7XXU2kiBCt/8FOCSHZCaInJ
	l+YRCoehDhwuU6rrQ0YRIJ1ijMtns78F1R3FCYKka/UTpapPLSoWMUZMOteKmLAvoaVdBmgcrcP
	9dkQuuPvtBhRLKbNXYrKgpIsW+Pvhs0eOG9qlwgVRDMnX9h5WbIGQAf63G0FCcVoqbg3dziKPyz
	t6KjCtXuFwQu8V9hAAYm5Wk8Zwqbduc1OwGVoUGUtO3jm+aML4gimMxPUhGI1cmKS7Sl8dP0z8m
	ip2DPzQWkE82vrIAoJq6erxW+Q=
X-Gm-Gg: AYBFou06u2TJRAwf65JG0IErxybfxPGzp9FRfXZho/Im92b67r/vYXbiX8zhdzhs1qg
	NnJ0EvdzPKPPPEzOygeLiOwLJdad3+wYamFpyh0v+hcXFpxzqyoH6Fvs53kKwkU2Gmqc6AR4WyN
	oRlO0cC0nG9+SDFVkjC92LacHZfojfQ29DPeh15+qZw1xZJMKFS1CqAteAKE/xWeOy8+/Dx8ORp
	YVP9hm65fMK4TBX5RHvT1M0ErokPi7ai+JRGu3v2vVPfIQpQ/gOpcR3QVI9d4f5ZM4S7Z+m1GJ/
	PP4dDpr/gM6kpld4cyVdRcw7BQcg7+KWmAgrVIzsjNiI9jPJYqOYbIiHjZ1Qg5XnXEYdSFENzqU
	NPswbemeczpl6JF5fjjyaAfpRdt8Hmb+SGLvAe2YANx/wlJhL4LCY7BrO+Ng0lEuVphWXvSg3Kc
	ObnSnAkCqF55xMDfkCz24SYSJ+VE0YLWWQn3+GhnqRU2I=
X-Received: by 2002:a05:690e:c46:b0:679:9340:acb6 with SMTP id 956f58d0204a3-6799340bcb4mr1081987d50.98.1792018348815;
        Wed, 14 Oct 2026 15:52:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6798bb6ac76sm176467d50.13.2026.10.14.15.52.27
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2026 15:52:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-14fed306427so482179c88.1
        for <linux-watchdog@vger.kernel.org>; Wed, 14 Oct 2026 15:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792018346; x=1792623146; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dgs0jfbzLr54cDGLw+/qa6h/ifV1QNwCX2SE9JA4qX4=;
        b=SS3Pe35TXiIJrhWZkAid5jTQ7INzqeM1fJTM2PMDxaq2xiz0GNCesy0pL2Q5Ivbyjj
         199vc2F45JiquUyHfScAPpr+tlLmwh3bC/sp9umCnSL9pb13C1I7X3z+PDx8tNYQAmr/
         M2iFPwqIy+YlMpMc3zfw2qHYEEXBy8dn8Lg8E=
X-Received: by 2002:a05:7022:1703:b0:166:b307:5855 with SMTP id a92af1059eb24-16a4ee7e657mr21482625c88.0.1792018346332;
        Wed, 14 Oct 2026 15:52:26 -0700 (PDT)
X-Received: by 2002:a05:7022:1703:b0:166:b307:5855 with SMTP id a92af1059eb24-16a4ee7e657mr21482585c88.0.1792018345526;
        Wed, 14 Oct 2026 15:52:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a2d2db98sm46889860c88.10.2026.10.14.15.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 15:52:24 -0700 (PDT)
Message-ID: <76ae9a74-7ea2-404f-b933-80ae29d113c4@broadcom.com>
Date: Wed, 14 Oct 2026 15:52:23 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: bcm7038: Add a restart callback
To: Linus Walleij <linusw@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Justin Chen <justin.chen@broadcom.com>
Cc: linux-watchdog@vger.kernel.org
References: <20261015-genexis-xg6846-watchdog-reset-v1-1-9577d65223d5@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20261015-genexis-xg6846-watchdog-reset-v1-1-9577d65223d5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

+CC Justin,

On 10/14/26 15:39, Linus Walleij wrote:
> The watchdog in BCM6846 can reset the system, but bcm7038_wdt
> does not provide a restart callback. Add this.
> 
> The vendor kernel also uses a short watchdog timeout to reset
> this SoC.
> 
> Implement the restart operation by stopping the watchdog, loading the
> minimum count of two ticks and starting it again. A count below two
> does not trigger a reset, as also documented by the U-Boot BCM6345
> watchdog driver.
> 
> Disable local interrupts across the register sequence and
> reset wait  so preemptible uniprocessor MIPS kernels cannot run
> a competing watchdog operation.
> 
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

We could also implement the .bootstatus callback by reading the WDCR 
register at offset 0x10 and check for bit 0 being set to indicate a 
watchdog reset or not.
-- 
Florian
