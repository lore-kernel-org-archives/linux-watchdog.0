Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41593B8932
	for <linux-watchdog@vger.kernel.org>; Thu, 12 Mar 2026 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352984; cv=none; b=rDVDrfk2VPjvq7Hvud3vp62ifsEdrVgeAoyRWtTtDuqF7eZhMYZfIkvjJfy+Ir99cQhgOqMS7Zfz9jxLX3zAyFVwalMzLdTWkUveA4hbZaY1oXNzhIRScSXL8QzalQckDhhvoljBNpoNAvVbt/cBlacrv6wDr3uCVoIHu0D6PQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352984; c=relaxed/simple;
	bh=6q1I7GWkgFvz45j6Au781r+RYdyLrpn/D3EoL8dn2yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QF60OyEcJ76+kRjSEaCIg/NSde1JPpxZBHFWBipnV9+GnRj8kOWZJ6i1c9WT9R08SUUOXDc1j3RuhkLcdyJhQ/nTz7QoIJKRAa+TjGLgkuupgkJV8mMB//4h+C194Rg7klr7PpekadC6UWxLGlNuTWO8Hk0X17vZvuuLZW9iJXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SprKnPmf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SprKnPmf"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae527552acso6700645ad.0
        for <linux-watchdog@vger.kernel.org>; Thu, 12 Mar 2026 15:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773352982; x=1773957782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=x+8SB7B4vmhyiX4LIxugd9ysQFK0LgnTArE5FURLdrE=;
        b=SprKnPmf2ELfciDioGh7KvtIIqme+Fanknr/FkUnDkC46SiISO8qo7V+Rj6pHh3zbE
         68FxO/GSjaq0zmHcu/+ngACudHbw2eEs3GKzImxCjyBTRXW1b92nb75nvsIplXmDa14T
         EnH6J9W1nqGZPZ4A/QumXi4uu1+lViR7MUc87He3sFNk5nZB/H5SRhpqKwdDwR6MrI3Y
         GiTBbYYSj1A+mciPYej14EoDsMjpcyCIKbdzDniGE3z4AdAa1Zy1+I3hQA5EZFtY+pEO
         iWMd/o+F10KUk8TVSvwEO0FAZUQ27FDC39lAXLzg85/1WILFRC2Z+Z9oSNOwxoVyyeTl
         hwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773352982; x=1773957782;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+8SB7B4vmhyiX4LIxugd9ysQFK0LgnTArE5FURLdrE=;
        b=KOlmMts1+rVOOudk8NoVHcJZgAOMdbdJ20XrOZ6o5BKabfUU+qOhlU4Ow5fMxX20Mt
         MsXYhz8x1L7tYb1PK2e9QnZqJDJvQ7vb4OB4AZKhi0nUmUow7R8XgRQop0uiThpSU5Of
         xPLkim6PgPKzc1TUddZp55cVqqbUZIfo53O4pm/eDQxlRLELaNuwsJ6bazcPGWlPSoyB
         qNTMcIsplB2yxnMT6EOr6jlRsgBZn9fjNzkJIFLDBDTyZBI5UPXZZqnZiChHp4OIU3ac
         jGndWde6znrIqUq6uFtVoHuogV9NhTEVRNzczVPZTYKQKyc3bDo3aPkXdkAnuHtHtlUH
         sEYg==
X-Gm-Message-State: AOJu0YzjCf4dxV1b5btj3jfXPaS5q4WqwmQR/8dQEHfN2RJo3ogp6f7A
	G5ell8FZoCbC+iG47sDpInv/rfXYpc63nTvrBwCkiIFN1wfp2EjSvrv+
X-Gm-Gg: ATEYQzyzLRXWXC74TCpXk39TjWUSfXOMyUiZ3zTkuxSv5Zn8FnaOmfN35xJ0mPBEAdv
	olLCvUunITXTV3MyO8E23oyyzEzGfx7cDwHWYcnDIh4mz2ifUga+oSgIbPo06Fv/2yAEEmFI1sp
	NfFGl4aRotYWU9A/Tc6kDRA4/I4cxwanCNLzMhlVYEZ637m6WiZgvB5w4loxp69yBv/tABT6lC/
	lEIETK9c/QyEmj/tjBJAuLgVjqXKkqnWAFWbGD05P1nDUiDlkVlOMGyrKKyMxmfeTCxlq+x2TR8
	KuGtK22NrHX93NBItlE7ISLUgV7BJh/1FWMF0Z3F9HsbGZExYS6zsKD0HMCXbsgsPrRSZAFepQ1
	eLF6lDul+jFza1hPHcy0KmYuo4wBnmn7PK16nyqvCs/ad5ejQ3TxYJ03ejqK0DJaCO//pivP+CL
	y6eg7OwZOVFIjKN4hDUzZYoOa127ps7NZQpp1ziQpg/+Lfn322wbYlvdfq767tUfG738NTtXk8o
	P/I6yW2b8k=
X-Received: by 2002:a17:902:c950:b0:2ae:80b8:df16 with SMTP id d9443c01a7336-2aecac7f9e1mr8858055ad.49.1773352981910;
        Thu, 12 Mar 2026 15:03:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aebacfc71fsm50515815ad.21.2026.03.12.15.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 15:03:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2fda8e21-ac59-42d1-af17-292f68d14ec2@roeck-us.net>
Date: Thu, 12 Mar 2026 15:02:59 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: mtx-1_wdt: synchronize timer teardown in remove
To: aviv.daum@gmail.com, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260312210645.10613-1-aviv.daum@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260312210645.10613-1-aviv.daum@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/26 14:06, aviv.daum@gmail.com wrote:
> From: avivdaum <aviv.daum@gmail.com>
> 
> Replace the ad-hoc completion based teardown path with a proper
> timer synchronization call in remove.
> 
> Stop the watchdog and delete the timer synchronously using
> timer_delete_sync(), then deregister the misc device.
> 
> This removes the open FIXME about locking/testing of queue teardown
> and makes the driver follow the current timer API pattern used in
> watchdog drivers.
> 
> Compile-tested: ARCH=mips CROSS_COMPILE=mips-linux-gnu-
>    32r2el_defconfig (drivers/watchdog/mtx-1_wdt.o, W=1/W=2)
> Compile-tested: ARCH=mips CROSS_COMPILE=mips-linux-gnu-
>    mtx1_defconfig (drivers/watchdog/mtx-1_wdt.o, W=1/W=2)
> Compile-tested: ARCH=mips CROSS_COMPILE=mips-linux-gnu-
>    malta_defconfig + WATCHDOG=y + COMPILE_TEST=y + WDT_MTX1=m
>    (drivers/watchdog/mtx-1_wdt.o, W=1/W=2)
> Signed-off-by: avivdaum <aviv.daum@gmail.com>

NACK, sorry. If you want to do anything with this driver, consider converting
it to use the watchdog subsystem (which would take care care of the timer
functionality).

Guenter

