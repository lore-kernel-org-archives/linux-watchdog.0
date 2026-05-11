Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CBC225A38
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 04:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778474371; cv=none; b=HlZTVe6TBVSJYFp244fpccm77EolG/OA+kUnliHPnAQGQ/fOMiURE5g2x1tFovagf/9HUHO0Snf8XF/DvEuiDUcGf4nICd1GzFLwghcmN/mHP8uvSDvn8D7uy4K8dhtON1tmeEbzl9p0jl/UtgFxPcz7JVC2MizY4uxdIBQVtFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778474371; c=relaxed/simple;
	bh=izNnPT+eNzP59mu8K4DU07JedWp6qBsFDKJ7LKHXwGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFYZS+rRGpyBog0uj8c3kj6sjCcpUjXyVYy/dhlIr4zLz2dSbYUSlIg2/PEnqxKU9QvUNBIfYOFEP4jZqTTbYsYJsNquCkuAuE4slhwBGVqBmOVRdWCF9AQ9cRacsx1pDQWuNHXlXMtCC5OrQptk+n7hSNPRSEpt1j/35CoVgQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHLIvmKi; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHLIvmKi"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso2732715eec.0
        for <linux-watchdog@vger.kernel.org>; Sun, 10 May 2026 21:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778474369; x=1779079169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tFr4ml37iSH7JGVpUrmmoc3/4vkicmtMRvXpv60p2Jw=;
        b=iHLIvmKi7fLtgKlcRueM3cmSU/rx+hJ3sZzbvzQAWYHyYSEyvZ8aRSiRtotNI8URBp
         dy2cOx65rc9txe5TDsRsta23QlkN8Vq3T1jwJmhXp/xlxrE0VR4nvu/NwleO519cdZmO
         6c9XRLoQrWfrNJc5VkNL9LLYnutqe4J7N4vMT5pcDul1kKX+/KUrYcFal4+GrFYSPgC2
         nFBNA+WaHTMbt91J5mTRaQax5hRQPPy08xjZPC93O8fFbEaBXjicJlm9Dcaqsr8iv5jl
         3QMn84RLohm0ZAfSp8/KbIptGDKZ/7wifO1gsiCN7sEnTUUYp1FUQuXoDOXfUGpOelKb
         l4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778474369; x=1779079169;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFr4ml37iSH7JGVpUrmmoc3/4vkicmtMRvXpv60p2Jw=;
        b=TIq7pGf8eSBD+lhl+yvSgQmwJoYix9P5rvUBKrjM7OxGvRA9krBZhFjiIntzlH1ihR
         VvMzS0VyYgnpiZtYBqNuLQYg9DZoWJZNuZRLfJP9LLKid4M04sEGR8oOfQzZhe5xAmLV
         qFPcun17OcuO5OiOOi+UqEtabEL+ddO72OaGr6OkpBJ1Pi0BNi83tymrfH2GfZqapf8k
         H/3mbEIoL8PwZiE9hCPM0P8Lolv/5n/nVioeQGf2JHz/wdOYfs1FY6I35qgFUuwfJPbn
         OrxmGsNSonLHEWNvltSwuD73VVHTx0S6kGBjoRkoRwQKw6BlJtJhB2XKmZcwJBZOjxGK
         8kYw==
X-Forwarded-Encrypted: i=1; AFNElJ/7/47WZRinhWsKtbMbXybdHpRIcFc+yGOY7DOcD+fyXIuIRhNLpgJhukvNiel0aYVihN2mrDe2iiPZ24XrzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/A7LnzksfYhwcTiHLj/d6flLzEoN3CrGLEzwaROGbI/x2QK+v
	Rfh+gd4bH0j2E3FAjj50ZM/LzqqbGdncPumy0Hw2UoAkBshkWU5KbKMw
X-Gm-Gg: Acq92OGtPT7MzTWBHyNrbJSWo2bVEChH+1kCwp+L0UKV1SCt5QDQds3UgPWdKJ1P/ZO
	v4Q4GXrwWo+bEaal8mUxtyKc+r9+rYPgDvrICXCFZvmu+1iMbbn/SxovNbjh0QRNo37XxNB7XIU
	IJE5nL/O7YOfaCOX6ji0whBr9S/nC+RcJ5BFhlmLb5sILo+aKvR8DdmCv3qqjQ2kAnk0tpcA1Jf
	ALFTrnx5yeUJlZ8HSRoWTzdY8Y0RVSTRXrBNcyT/5RrAo1O0g1n3KdEb/2CCPRBaFJc0y7slzNg
	bQTvHkRbKiBoyD+bMEBQtzQQQ+sTOuwxBIS3KaEBlRIfmuZKeCrQnfOBQSbubCZDug7259YhtIJ
	G9X7ogUL7tcy3+AnPG+Vs+RdvemGLLyLAhFj4TKqg67fV2zbAlT4+fmMEVsY4Bah/lgwuyhg9vk
	PDaKuuuWGEMcQuVyorw16g3ndDBT0mhrF4kjyWY/HASqnBu6ki8MRPDY5PTCnFRf/xXBSBRtne/
	XPzVTFXpdQ=
X-Received: by 2002:a05:7301:4186:b0:2c0:df3b:ec1e with SMTP id 5a478bee46e88-2f6e3f9012amr6554095eec.11.1778474368600;
        Sun, 10 May 2026 21:39:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8893441absm16042011eec.31.2026.05.10.21.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 21:39:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a32f5c51-1e72-4208-92db-c5a000f3d43d@roeck-us.net>
Date: Sun, 10 May 2026 21:39:26 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: wdt_pci: Fix shared IRQ storm and complete
 system lockup
To: w15303746062 <w15303746062@163.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>
References: <20260509121655.275311-1-w15303746062@163.com>
 <f182256d-0623-4c9b-a18a-acca8457bb08@roeck-us.net>
 <1fc8bb5a.1346.19e14a548fb.Coremail.w15303746062@163.com>
 <5acea672-0550-478e-8f49-e5e43c72d7e2@roeck-us.net>
 <15f8c180.3519.19e1501ebbc.Coremail.w15303746062@163.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <15f8c180.3519.19e1501ebbc.Coremail.w15303746062@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/10/26 20:08, w15303746062 wrote:
> 
> 
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> 
> Hi Guenter,
> 
> You are correct; standard QEMU does not support the WDT500/501.
> 
> We observed this issue using DevGen, an automated framework we are developing. It synthesizes QEMU virtual device models directly from Linux driver source code using LLM guidance, allowing us to fuzz legacy or obscure drivers that lack physical hardware or official emulators.
> 
> Because the synthesized device is an imperfect model, it generated unexpected interrupt loads on a heavily shared PCI IRQ line (shared with the i2c-i801 controller in our setup). However, this successfully exposed a real logic flaw: the `wdt_pci` driver registers an `IRQF_SHARED` handler but fails to verify the `WDC_SR_IRQ` bit. It erroneously claimed the interrupts, bypassed the kernel's spurious IRQ defenses, and caused a livelock.
> 
> I understand this hardware is essentially obsolete. The patch provides a purely defensive fix for a legitimate API violation (unverified shared IRQ).
> 
> If applying this adds unnecessary churn, please feel free to drop it, or perhaps consider marking the driver as BROKEN. I leave it entirely to your judgment.
> 

That is entirely not the problem. The problem is that your AI implemented
a QEMU emulation without really knowing what the hardware is doing while
guessing what status bits unused by the driver mean for the real hardware.
We (and the AI) actually don't know what the WDC_SR_IRQ does, or if it
is indeed low active. That is just a guess. I can not accept a patch
based on a guess, much less one making unconfirmed claims.

If the driver is indeed unused or obsolete is a completely different
question. Marking it as BROKEN without real evidence that it is indeed
broken, just because some AI believes that it is broken, would be
inappropriate.

Please note that I also find the patch description inappropriate and
misleading. It suggests that the problem was observed on real hardware,
while it was actually observed with a qemu implementation implemented by AI
based on the driver itself, including guesswork about status bits unused
by the driver.

Guenter

