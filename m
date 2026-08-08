Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAED418A35
	for <linux-watchdog@vger.kernel.org>; Sat,  8 Aug 2026 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786200665; cv=none; b=D5oV/whyY2HwUFa065IFShYFcSU0X7kTArqLnYmJgP7sEbzHCO7m7pd8wDbIHkicbcQ/nUQRe3uhI4eQcklS3CcxA5UazTspM2tynvt2fuMD+NBv+zsuxOJbHyswocqplVublokKcL44PY+18KOFVML/W5ad9WW1/7QibUzy178=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786200665; c=relaxed/simple;
	bh=JBtGh/jLc+8MM0+XevSCD14BakBgA0lIthIu9hnbdwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rb2jZnl9chfvu2Ae7t+4bv8ZNKyFYkXSTXOJIbFM2o+B13otrExTAivFU/0OuTqDNBFs1xcaCLOA+7uNg8X3VKw1ipf19Iiplml5FTxb8xf3KimKPNSthId1VXj9dPacgSzz+JOIiI1zeFONGlpL7gCmerZWmSHPLVUyiDaD28g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=id86zMCS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="id86zMCS"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ccf2360620so4218655ad.3
        for <linux-watchdog@vger.kernel.org>; Sat, 08 Aug 2026 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786200663; x=1786805463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6+/fm2qOcTXIyjtL2DGzrA32WfRZi/Wok9xvh1oVjxM=;
        b=id86zMCS/k5dAh5b9ALud6wvHFzWfeVPFqrxZv6jJ+yqK/O/2Vm0zYRLXseZ4yyqLl
         bskULmF0wsxcmw0Lvyyfgs+QtwYUyAmWweTqgLgO3yhtySrzfwRAqLfmUUizePlVrKuS
         hqovYhg5xMYaZkaBz7+TjR5Fbcux1M3EydWa93eZTPYm4h15BpYXC5fPlKSZLq0zCq8w
         yFb8b/QLA5/puKO7p5Tt6KOlMBLZ5Am/STiTFAqtp+uoDWulF9JDGuhs9UyUhyXYjwsq
         EG6mvGYTrQIcBsmfdFmlDXvMQWuGKfsg+ujyBVwhqiWwzHKGmRPpbCPuhP3bWTb6duCR
         06WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786200663; x=1786805463;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6+/fm2qOcTXIyjtL2DGzrA32WfRZi/Wok9xvh1oVjxM=;
        b=hrgvmLZZ/5lwxtjjzR1+tZm+oy8nRwYhKadK2XTQbmJ79N2onzNPHI3B2DRmLNCLDo
         lZOzpxxWYDUnih58lOCYhbPSycbsOsl1AlBvPKqs+aleNJirGuuOItmNSM+jy0JWsWK5
         ZmlcVaeGtaF0YDjEiiOAVlncmQRWmr/lIvA+juqE/h5k3k9/VnSb07IV7YfQzoP36gY9
         D7hO2n/o0z7RDjml31yNj/A5cTH0alWgTL5Zo929OBOj7mvqjWlin+nG+2n2+FravvfC
         lShlgQC/kj1Sxdj8Fc5cV2d0GL57A3gOqpQqHTIcV1YYuamNihoU4KIHTHoReKKaByMs
         j5zQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr3xjjqvN1O3dsWBBIDSooonPTYRyViX9T+h6f+rCPX0TWa78jHTE+zmlppUNFqwds/j1H+UvgrW0z99fThDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ReMt8M9p776QrkmGCOl7E9DOoNViog2qeEN6CcMOrx7ZiIZp
	aVoSep7ZewRSekmZa7UDWxmLOwAT2+ktGIdo/GU6ur00jo35w6NwS3fN
X-Gm-Gg: AR+sD13dS/13fcUBc7mm2zYg94VXP+BrFeS8uwtsR2JxqFKzXTHs7PB+CF+iKuRjTa6
	IY5URihaiwvLpx8kbqDuAJQfdv6HBTmSNBbQeZx4wgR+9kN1p1LwlOFibFDoJwSQLMV9fu+fCdB
	WaSEbD7F5p6DlE87c3vRVfgJNgkiyH8C8GJKg1DnOA8KNdzWNrUoWaxk21bFAT1yOz/AGZxRQ6Y
	yN3CJtfvT5rxaZUKHuHFaUpiybvRb2hnwKCiKnPBgq6GvLb1PidD4ctfqHgS/Aw2lXNM9FPPccy
	GkKlGR1cAOAkwJAMf5R6RUxwsWbotaxjMe9Rv29Q590ag8vz64bMV3UdkDXZv2XKgLV0m0d6A9z
	nFwLFwvVjgZelZ07Zsh+S0L3wkHFSAMkvWd451Z7LXhgOJ57PocRboTrAH+csJIeuXf2on16ddF
	9ePxV3q9VOYJTQ/Y+Ooz+XeJ8qcnRlbJRymlK/zMfoEEKPPT4p0YnoY+eq/chFN9qrkGXWpK/Fs
	nYVY4WUxtV+XslyeWhaFtffVd6dnfkutArmyQ==
X-Received: by 2002:a17:902:e787:b0:2c9:c083:cd50 with SMTP id d9443c01a7336-2d106e333f0mr206689685ad.17.1786200663232;
        Sat, 08 Aug 2026 07:51:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14ccac170sm19398045ad.8.2026.08.08.07.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Aug 2026 07:51:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9971b3aa-cb1f-44a9-9d58-4f75f0c6ccea@roeck-us.net>
Date: Sat, 8 Aug 2026 07:51:01 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] watchdog: qcom: Propagate errors from optional IRQ
 lookup
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20260807081652.38692-1-phucduc.bui@gmail.com>
 <2eb8b31e-a3c6-4310-b9cc-7acd135b6c99@roeck-us.net>
 <CAABR9nHqKKbxkzBNkENadhFJgC_HuetV+ab7SVsGH+cwbF+OFw@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAABR9nHqKKbxkzBNkENadhFJgC_HuetV+ab7SVsGH+cwbF+OFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/26 01:59, Bui Duc Phuc wrote:
> Hi Guenter,
> 
> Thanks for the review.
> 
>>
>> This is wrong. Check the if() path - the code ends up here if pretimeout == 0,
>> even if irq > 0.
>>
> 
> You're right. I misunderstood the condition in the if() path.
> I'll rewrite it as follows:
> 
>   irq = platform_get_irq_optional(pdev, 0);
> +if (irq < 0 && irq != -ENXIO)
> +        return irq;

This is still wrong. If there is no pretimeout, it does not matter if there is an error.

Guenter

> if (data->pretimeout && irq > 0) {
> .....
>   } else {
> - if (irq == -EPROBE_DEFER)
> -       return -EPROBE_DEFER;
>    wdt->wdd.info = &qcom_wdt_info;
>   }
> 
> Best regards,
> Phuc

