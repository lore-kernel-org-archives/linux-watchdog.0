Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D963DA5D1
	for <linux-watchdog@vger.kernel.org>; Fri, 10 Apr 2026 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837303; cv=none; b=YsEIjxICWVHb7Zt/l4UyvB+8rwimDH34lalWfw493pIGgs40u9VBCcb0qMua5LM0pmuVYN8tN88YycA7z49wEsZbNaaEDJynvF27LN3yWFyv6+dqUCKuxm+Fo52j6UxjkPJcWz73QEJMf7/4Dyp7vtIE7rZ3CnhIMnVWQRnPsk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837303; c=relaxed/simple;
	bh=GVukrtkLhsJP+dAEdJoIS35mlh6OyWpfKZ0T+5RTBk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ER/B5MXYz18hj1hzHYIzacB7dILVoAeTmfWgKzdV1prjhD9L7ko+/DGBlSPZRCHenIkm80bxaEfIDZWveLQCU6P4FEysglpMM5mCyfVOBvceZowvmGgSIHf9dv0UTlIw8kCwMUOLA6bcadsfHB6BBl/RsJbSWpFMIvxCnOboZec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEazk/0b; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEazk/0b"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so1888454eec.1
        for <linux-watchdog@vger.kernel.org>; Fri, 10 Apr 2026 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775837301; x=1776442101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=E/mppZDgSCNHAeq+ub9wfQA7kQLGgmIwsgBif974LNY=;
        b=gEazk/0bFeC7DqpkhkYygP7KXSxULyGTayiSBPR/ayApY+lDhnGPn/VpIHrFrjNG+S
         JEIV0WF0pVlVT7Hb7x4hpDReAqU6YynZfX3DAkmH7SPZgQh3mfIzlF5jHdQ2Epz3etOV
         7qQaYT1uR5uF21COzhYce5lW+9X6mk0f1W+4tfIfXRDs66YUERXrne6IlXv896D+COwh
         okUzxlg93+j71ry+zMnf54ir7pY7P0VDQQ5DomBFmozWnPs3iTHUwIgjtWkCHQqqVI8c
         y9dwpldm5Fa4mvKAyGaL6l/uZSvT8pfLuNmwoShmmSjsxUUEwc3GYFwaQZjqS53GzWab
         5RVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775837301; x=1776442101;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/mppZDgSCNHAeq+ub9wfQA7kQLGgmIwsgBif974LNY=;
        b=q9rvY5tilqnIuyWBckU3cjXLdD0R/5x3rayBh2Jz0hfLyfNGd27b/5YmQhb4K6+9JT
         IEw/eNF2kut4yW54nF0b4Je/98iM4kdre6QjMTgVXjQPuKJC2DR26L8LaHZsSxlXszxC
         d2TGTm4UDVt2/70CvqRPa60kKZtQpCfgXe//GUQcDfMzcMowHiLONxgcLKGuAOR3zZqA
         aiQw6+L+w0PNW1KBaVXRfZbfsj3Ce6LsCLsap0co1MS058VXLA95SMhn13yIQ6Gr4t5J
         D1tm0/cCqKtiDEx90NubrorASaGrqfRNuaahGSW8ol2iXIDZNEGa1iSBD5jiibil5pf7
         8sXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMrHFwEFVlBTWAYKrFJTMqFTpmMeyF/jtV0D7nEywbHlAed4YNdepUoi8UG/sM2yc17neoM6OCmBQmQD83Uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkQNbAPHi/gJLFW4HNy3i6h9IenKu7lP7dwP39aCHC5Cp6NxaC
	f5+NPI62Y1kVhf06G6O/q9nWnxsoNr/kdC+MY0AoPSl3mhEY+FbWRMuI4Ev0mw==
X-Gm-Gg: AeBDiet71ct6T9F1EiGsk8bFS3nMySGUCoCY7nBRYWdDlkg4eI1cImHkqSshN7XDCT5
	6Fyhzs1SaY9ZBhvVSD0RBNxnXT/AaJONPHjtO6ozLOWBETtnStnm4X0gINUK1BziPNf7UPW+f8E
	fFqmIdVVniDN8JyTyupyE33tnKm+wui+zOr0gu3haOMvLEMipz3x8NT75ek9JC+8ZJjzz+NMpSw
	ZrMll2jzFGFLo/rEyDKYyhdSO4kb6aGjrsoEvce/NcPWRQlekomULMWv004LBR/4Zd6QwUBGyRr
	+yBuxZxE1ier9Oh5DqLYwUNLQra0OWARn1UgbN288PB7BWGJoLMBjfJl9UkhPpATtqjuF8lalU5
	5HM/O8S+Bqu2A9G7CzUiEihBGF1p+xW6BVpYBebve53N5fapJRsbnVRE+d25PJ0TSdG5Q26aLvS
	rZyAIo0PmeMflNuxj2KC/GW0AGexpKpHZpRymf/3vOKyh+0oQ+Pi3v5jCxNouJKWcj4C5nFHNR
X-Received: by 2002:a05:7300:e2cc:b0:2c1:7793:7bbb with SMTP id 5a478bee46e88-2d5898a59fdmr2382600eec.27.1775837300784;
        Fri, 10 Apr 2026 09:08:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561cd2c09sm5933501eec.18.2026.04.10.09.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 09:08:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <041d8784-ab6a-4bcf-8377-cfc9038be2f9@roeck-us.net>
Date: Fri, 10 Apr 2026 09:08:19 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] watchdog: sp5100_tco: Use EFCH MMIO for newer Hygon
 FCH
To: Yingjie Gao <gaoyingjie@uniontech.com>, wim@linux-watchdog.org
Cc: yuechao.zhao@advantech.com.cn, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260402071617.634563-1-gaoyingjie@uniontech.com>
 <20260402071617.634563-2-gaoyingjie@uniontech.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAmgrMyQFCSbODQkACgkQyx8mb86fmYGcWRAA
 oRwrk7V8fULqnGGpBIjp7pvR187Yzx+lhMGUHuM5H56TFEqeVwCMLWB2x1YRolYbY4MEFlQg
 VUFcfeW0OknSr1s6wtrtQm0gdkolM8OcCL9ptTHOg1mmXa4YpW8QJiL0AVtbpE9BroeWGl9v
 2TGILPm9mVp+GmMQgkNeCS7Jonq5f5pDUGumAMguWzMFEg+Imt9wr2YA7aGen7KPSqJeQPpj
 onPKhu7O/KJKkuC50ylxizHzmGx+IUSmOZxN950pZUFvVZH9CwhAAl+NYUtcF5ry/uSYG2U7
 DCvpzqOryJRemKN63qt1bjF6cltsXwxjKOw6CvdjJYA3n6xCWLuJ6yk6CAy1Ukh545NhgBAs
 rGGVkl6TUBi0ixL3EF3RWLa9IMDcHN32r7OBhw6vbul8HqyTFZWY2ksTvlTl+qG3zV6AJuzT
 WdXmbcKN+TdhO5XlxVlbZoCm7ViBj1+PvIFQZCnLAhqSd/DJlhaq8fFXx1dCUPgQDcD+wo65
 qulV/NijfU8bzFfEPgYP/3LP+BSAyFs33y/mdP8kbMxSCjnLEhimQMrSSo/To1Gxp5C97fw5
 3m1CaMILGKCmfI1B8iA8zd8ib7t1Rg0qCwcAnvsM36SkrID32GfFbv873bNskJCHAISK3Xkz
 qo7IYZmjk/IJGbsiGzxUhvicwkgKE9r7a1rOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAmgrMyQFCSbODQkACgkQyx8mb86fmYHlgg/9
 H5JeDmB4jsreE9Bn621wZk7NMzxy9STxiVKSh8Mq4pb+IDu1RU2iLyetCY1TiJlcxnE362kj
 njrfAdqyPteHM+LU59NtEbGwrfcXdQoh4XdMuPA5ADetPLma3YiRa3VsVkLwpnR7ilgwQw6u
 dycEaOxQ7LUXCs0JaGVVP25Z2hMkHBwx6BlW6EZLNgzGI2rswSZ7SKcsBd1IRHVf0miwIFYy
 j/UEfAFNW+tbtKPNn3xZTLs3quQN7GdYLh+J0XxITpBZaFOpwEKV+VS36pSLnNl0T5wm0E/y
 scPJ0OVY7ly5Vm1nnoH4licaU5Y1nSkFR/j2douI5P7Cj687WuNMC6CcFd6j72kRfxklOqXw
 zvy+2NEcXyziiLXp84130yxAKXfluax9sZhhrhKT6VrD45S6N3HxJpXQ/RY/EX35neH2/F7B
 RgSloce2+zWfpELyS1qRkCUTt1tlGV2p+y2BPfXzrHn2vxvbhEn1QpQ6t+85FKN8YEhJEygJ
 F0WaMvQMNrk9UAUziVcUkLU52NS9SXqpVg8vgrO0JKx97IXFPcNh0DWsSj/0Y8HO/RDkGXYn
 FDMj7fZSPKyPQPmEHg+W/KzxSSfdgWIHF2QaQ0b2q1wOSec4Rti52ohmNSY+KNIW/zODhugJ
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260402071617.634563-2-gaoyingjie@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/2/26 00:16, Yingjie Gao wrote:
> Commit 009637de1f65 ("watchdog: sp5100_tco: support Hygon FCH/SCH
> (Server Controller Hub)") added Hygon vendor matching to the efch
> layout selection, but newer Hygon 0x790b SMBus devices still need the
> efch_mmio path.
> 
> The efch_mmio path enables EFCH_PM_DECODEEN_WDT_TMREN before probing the
> watchdog MMIO block. If firmware leaves that bit clear and the driver
> picks the legacy efch path instead, probe falls back to the alternate
> window and fails with "Watchdog hardware is disabled".
> 
> Select efch_mmio for Hygon 0x790b devices with revision 0x51 or later,
> matching the equivalent AMD behavior and allowing the watchdog to
> initialize on those systems.
> 
> Fixes: 009637de1f65 ("watchdog: sp5100_tco: support Hygon FCH/SCH (Server Controller Hub)")
> Signed-off-by: Yingjie Gao <gaoyingjie@uniontech.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/sp5100_tco.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> index 2bd3dc25cb03..7e99c3b1f367 100644
> --- a/drivers/watchdog/sp5100_tco.c
> +++ b/drivers/watchdog/sp5100_tco.c
> @@ -92,7 +92,8 @@ static enum tco_reg_layout tco_reg_layout(struct pci_dev *dev)
>   	    dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
>   	    dev->revision < 0x40) {
>   		return sp5100;
> -	} else if (dev->vendor == PCI_VENDOR_ID_AMD &&
> +	} else if ((dev->vendor == PCI_VENDOR_ID_AMD ||
> +		    dev->vendor == PCI_VENDOR_ID_HYGON) &&
>   	    sp5100_tco_pci->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
>   	    sp5100_tco_pci->revision >= AMD_ZEN_SMBUS_PCI_REV) {
>   		return efch_mmio;

