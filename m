Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D4A3DE443
	for <linux-watchdog@vger.kernel.org>; Mon,  4 May 2026 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904202; cv=none; b=L6BafOOAd4f9lEgM9kh0yfK+vJyKbM+gxoQcVrlviKXGTTa8lhmtoZP+UovyVmgR+C4dx+8wuPu/xeTDpEGvj5EESbZ1lZQ8brng2vhqArEnWhmsRDNteqrcqj0BylZwB7Gvx3Ahn1yl0k0exZvesZC4zls6dfXniL3flL9dAhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904202; c=relaxed/simple;
	bh=8NpFRk5qaRCO0QWiYuYd00LdSkCVjtBob+PJLV4SjKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GqQOzQfkgMG+xSzYmCmuc80rnq2YFHnJ2mrjuSnnGJExhIeAAqLG0UOv52HnJ/uC1lNlNBk4UjQe6+KR1ACKUo1UYF5ApFtHMtl8Q6eAUiWxdr4FPg95fAf+ZNdhflxHIRzRFY+NpOHUcqbkVVvM9+Lh3ZYwx0l6vRYr5o3z/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2BHYhaJ; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2BHYhaJ"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ee1054627bso2678482eec.1
        for <linux-watchdog@vger.kernel.org>; Mon, 04 May 2026 07:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777904200; x=1778509000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3ARTaXEgvtjMhd/qQb8EhGE66tnkubR0b6AJQjnyMQo=;
        b=A2BHYhaJ792plBzRRYh0R9zTqlI7T5DumxRKbZxOkuAkpkTAQj669C/nsHo1fakZRZ
         qbExDfWz90sYsWrJ8pvOvigcRUKeML4ByXMDNvBhhTIH0lN8TVk2jqIV8JgX9Jg68G/O
         okxLL5N4P6bQCt5TXGC0DcbqopZ2NCzb7/+n/8p3glShcNKFsUORY+Lj2U7x8xuRWiop
         Opy1geAlTCC2Wo6e/zxynd/WBhQJFOmlAKv1srt58KbPm2GMlPcA2pYYLGlZNxmSXaXM
         4kgkxb+SQZf3uvzxAc01FX4+y0Tb0MzZL2VwOPcvvaFzE9zi2VDwW7IOabb8fb7xPjdf
         EGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777904200; x=1778509000;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ARTaXEgvtjMhd/qQb8EhGE66tnkubR0b6AJQjnyMQo=;
        b=HyzoFgY94g9gUj/k5SJO5cHVMxzG60yoNYcldQqAQxDOICnkMVolia/RM+2BiyHhxs
         TYJu6T0mg1o1eqIumTSIYsbR0Y8mJI0O5kiNvYKmdZxDSEhBPBuoiyfJMoS8j42YiklI
         /9Bovxgg0D0xobjmerAD8QfilT2SBQzpDGXRiqeL8MmzbVifHpW7KKY4/rJR17mHaupx
         QPnPai0R0Su4OSbA2bbPI2DbrCzc2hUDt6mJUNraMZQhxkY3a9Oo/Sm5yEV7klLNTnJm
         SVz82G+u7hv4FBzj3CAQ7DTT7+7veUbClIHFcLHPyT/Wr06ngs7D9qGAI50TbGq7S/fF
         v2MQ==
X-Forwarded-Encrypted: i=1; AFNElJ/LT47BSpyvi4PE1zbNpwz6UOtXaHz/wmqIisA00j5MR19G82ovGlCrP6nRjcpEIqobvw7emZirmoUxAJoSFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhADZqNPyYWpkojtvPB9CG//UkdTq1X/A10c7eTso384it3fCK
	Mb62sjP2uQMTqV+WvHsOnbimhjT8x8vpF5v/3XkrdX0ieC5O4vhARoqz
X-Gm-Gg: AeBDievecRvWbHcOUWDnihigIJD2GRW1KbYY7rQkm8iZVKb6YJ3wVyh05f5P8qpekLA
	fZU6EeCR+XLmiEyi7PaLie/od3Zc09VX7IaExd4WUBDwCMcpR/7GVvzYu2pVSdSlLZwRVT0tfHt
	vZQqO+zwMLNibm5sojvTNsIXvvXwhr+u9aR8mWo01Hrrb250PJ2wycvFicr4w3hOL9M5DOqxlMt
	hAPRRc9uK/RUr6Esonp0ZeCsLXhh5Hm2XkZEhotxq0BmOHRQ3CU3SNc/aNRD8LLVJeabVzItZYw
	MxPdCSP4bB9QEHPjVSLdZ8df2rUc2fXq1w7eKc4te4BVmBuI7+IrwgaLPttPqpES/RepbdjBYiJ
	KFGvCCQKOsN7r6GPvbmInGbaeEGQut2bpX8K+aFzgBxCpD5IeR5XNuhkpvOYHXZdM87dF8324pl
	/tyZEqC0isz7ViZZRR/ktQZUXUQJ3zBy5bm+7v/VbsjZMLGEkkBZx/UWnKONtmOpuMgVO9BHnCf
	lZQA25CYWM=
X-Received: by 2002:a05:7301:9f03:b0:2ca:bd22:6102 with SMTP id 5a478bee46e88-2ed4f6d8911mr8121748eec.14.1777904200272;
        Mon, 04 May 2026 07:16:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3bb60811sm15836284eec.24.2026.05.04.07.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 07:16:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <86e12259-002b-457c-bb5f-c180a452c736@roeck-us.net>
Date: Mon, 4 May 2026 07:16:38 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: lenovo_se10_wdt: Add support for SE10 Gen 2
 platform
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20260428124954.1193450-1-mpearson-lenovo@squebb.ca>
 <d9beb8ff-0ffe-42ff-8249-e12f1a4c2e2c@roeck-us.net>
 <51993cb1-f032-488e-92a2-2b2e65af767c@app.fastmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <51993cb1-f032-488e-92a2-2b2e65af767c@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/4/26 06:13, Mark Pearson wrote:
> Hi Guenter,
> 
> On Sun, May 3, 2026, at 5:53 PM, Guenter Roeck wrote:
>> On 4/28/26 05:49, Mark Pearson wrote:
>>> The Lenovo SE10 Gen 2 platform uses a watchdog chip from the same family.
>>> Watchdog functionality is the same, so update the driver with the new chip
>>> ID.
>>>
>>> Add the Gen 2 MTM's to enable support on the platform.
>>>
>>> Tested on SE10 G2.
>>>
>>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>
>> ... but you might want to have a look at the AI review.
>> It appears that the driver has some issues.
>>
>> https://sashiko.dev/#/patchset/20260428124954.1193450-1-mpearson-lenovo%40squebb.ca
>>
>> Patches welcome ...
>>
> Thanks for the review.
> 
> Ack on the AI review patch - thanks for flagging that as I was unaware of those (I'd heard about sashiko.dev - but hadn't thought to check it for results).
> It looks like a valid/good thing to fix. I assume it's OK if I push that as a separate patch rather than combining it with this?
> 

Yes, please.

I updated Sashiko's configuration to reply directly to the author
and to the mailing list for watchdog patches, so going forward you
(and everyone on the list) will get its feedback on watchdog patches
by e-mail.

Thanks,
Guenter

