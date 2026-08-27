Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D9D4756CF
	for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837156; cv=none; b=cnwt5vmG+eTuP68zhWeXVfic9eLS0ZxLumrQ7JNn3Ws/SqYjYMB7uUdTZVAs7GChVqNyEA9EMke15gWLpkP6uaAC/5xVhupDC+gFrkkw1eqwfFUQSqqKBB4jYrGWy8mV1eKJvbfAsD/EeNaDlAG6pu6YvUStcFtHsUwBVmJG7FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837156; c=relaxed/simple;
	bh=Ev9496wX/GmZ0M5RMEVi2p22hgJdEnNH9+JHMnghZlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zfb5a3cQtKa3QncKyHzoZfet5j9iCrEQ4im04TbNqsMsvPrynOzSpZW5Avtavw/Mwfcf2zyzvHlRofHhIE1V/vG2A4Hy4dGkoTATdCyVPe2MyuO0ZSZR+9rp0ImaSXfqkzG746tLrjTTTYk8hmCqERzcFeAipOCveXrQ55S98n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9D/cIZz; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9D/cIZz"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1c8d4a959so1396050a12.3
        for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 06:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787837134; x=1788441934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Un2xD3niCIxDwPX+RYBO+nQcggpod9FBbKzFwsZnNlw=;
        b=W9D/cIZzlvPNQLuq1bye5ky9kNXdAuq7+gecm8fQswpYGNfnMqS7bcgW/LwPmPDbjg
         tfUEt4J8YnfAVsGSxdimn6Sy9PiwkcuMafvxsOELH+GwdBKJISxDWCsFqIqv3dpNv5Bu
         RPFvcmQK2Krgm2R3W/G/ufaL6ndHgG7lZYPvTFxCc71w6ydFipQRISyxdODt/U4HfWsN
         4fPdoDqaQA3AZZiCwMQLIExWF4+Dus1AJHHliZ0j3qgBpmLxvL2qyEo4PN+O5Z/PPlJk
         Ey4JU0b2K2por4UQS8/GW0hZ6PxxxAZ9fvW0q1AGydOSgswc5csSkrPrFRTW8TBCdD1B
         13hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787837134; x=1788441934;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Un2xD3niCIxDwPX+RYBO+nQcggpod9FBbKzFwsZnNlw=;
        b=QL37rzkXrj532hIjHv+6rQWYlkWCYg82PoNIfrCKqchAA9O/GAlEejXBDt7pnDO4/K
         SfLi8csc8ZGyWCmUbEmjyujwVf9YmFHI08VEqrB36pZxNeYSQVG1NcthnPmgEo9z6G/a
         th7/uu1LL9E8EAYquL7U+vtMck9taWxUcfI2kpR+YwlnpqVHUGb1HIoco0H/tMVKG/k2
         11ib2z/TwdmifqR6gsh0bX25/HjLPYLOXLYWi2nO42kWMTbcBe8vu969aRfIyFNenZur
         jc1CjDZtxfjOSWfAqja9DoELcYjsPQJwQ3Fp+SfOiN4jZdbPtRCvjgnJgN5qrXrrulcU
         CDCA==
X-Forwarded-Encrypted: i=1; AHgh+RpEC+wEWHJg6sDmV1GDH1rHoZvvPrtd8oKq1Jd+x4Y+U6MWo0tywiRpyHdCGMjKQQ6/EDFlKcix0bxbUgfKBA==@vger.kernel.org
X-Gm-Message-State: AFuF++m/ZNPz0FL9VHTjJbWlFS3WcyKlI4MVPrav+tvKLZU8J3HjpIhi
	g8zqnfOEbj2b2V/qZJSgCZfIaTGljW72Wr65tEZpzLP1q1jfDYQazX/NybEkQg==
X-Gm-Gg: AR+sD12xeC3TGJOQyyg0OixkFYoeSiyG002aJBHkV18T9kTtIeGOYS2eplzWIuBAvNG
	Qd+3Tqy1MZNX7FC9yaAgHRkqB3MR4uFM87/jWtIvhPmJFz4KhqAnN7BUMPhnpABJddKKrqeG9KY
	aBP5r+mpsgqsY9VNL2+enUlDmsrJavihRC+9DrtPwLBsOV1XsrjBixGKPZr2h1dkCQ7odL7cMVy
	L3Hr3uiN6IedJ7kwMoyYfUtmJhF07Ts3oD7aG6Ys2b33iQKXWqvgmoZdLV8jAE3VH5zQr3GfeW5
	O0GI9aTuUjjfaDwLXiq9ikX2i2WFvpLtu8QTurWCkjAzuFtUF2Bfw+zu3OIK39tK/mcrogGSDm4
	qSFs6dyZUv+cNYaU+QwyVJF8Sm0USIjwoNFBPHIhfKO3jex3htsmWM1svlfFag7rBUdzNj5BDuH
	CCRggTdu+DnN0lVvR7nTnJMnPzEfmifH1g5MCtF/U5W6pXsBS5aojCweXKvDG1ZLmq60DWBtND7
	0KG/pSwg7h9JncLyjl1BEz75aDGUHKY/QzpDw==
X-Received: by 2002:a05:6a20:4b93:b0:3d0:c5c0:d9b3 with SMTP id adf61e73a8af0-3d0c5c0dd51mr12555652637.18.1787837134346;
        Thu, 27 Aug 2026 06:25:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1becae882sm2185217a12.29.2026.08.27.06.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 06:25:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9f099c1c-ccc8-41f7-bae4-d0354bb4eec7@roeck-us.net>
Date: Thu, 27 Aug 2026 06:25:30 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] watchdog: da9062: Convert to
 DEFINE_SIMPLE_DEV_PM_OPS()
To: Tzung-Bi Shih <tzungbi@kernel.org>,
 Triet Hoang <triet.hoang.dev@gmail.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260826060839.203297-1-triet.hoang.dev@gmail.com>
 <20260826060839.203297-3-triet.hoang.dev@gmail.com>
 <ao_qdLdFmcyIkLM1@google.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <ao_qdLdFmcyIkLM1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/26 00:42, Tzung-Bi Shih wrote:
> On Wed, Aug 26, 2026 at 01:08:33PM +0700, Triet Hoang wrote:
>> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
> ...
>> -static SIMPLE_DEV_PM_OPS(da9062_wdt_pm_ops,
>> +static DEFINE_SIMPLE_DEV_PM_OPS(da9062_wdt_pm_ops,
>>   			 da9062_wdt_suspend, da9062_wdt_resume);
> 
> To be neat, it'd probably like to align the parameters to '(' or simply
> combine them into a single line if it fits within the 100-col limit.
> 
> The suggestion applies to all other patches in the series as well.


I agree.

Thanks,
Guenter

