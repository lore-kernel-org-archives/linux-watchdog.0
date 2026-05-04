Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF233D903B
	for <linux-watchdog@vger.kernel.org>; Mon,  4 May 2026 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903242; cv=none; b=qMsKhpLtW2NeSOBeOqt8W2JZ4t+jESXKS9UnADCqEa0yzHTgYXyM47pvwJB2FS+haj2iE5KxKxZhT50TBhscRdPdXHvWR0fBFkYnj8BVEUgwMLyGMvY4O/smiuI9L1e6psj7HSWAVQKMh1Z9KyQlnlYZA+39A3fQp5CHVL6Wbbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903242; c=relaxed/simple;
	bh=iHaftcTqitqfEL8aKeac2JITawARGyqIIZiSUd8g2zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Go3QZajtyPH+7YcIisgff+JfppSHn+YjG2uOdun7F7GBAlQ2O/rkADBnXjYBUCkz/VElgSRDLdpZgItFF1Y2u5uK+wiAaSRZY9SapDM1XTFxeZh06MYtHvXt1CkVETRtroWIji9nn0VjeCm/PlWJiqZBYf22sIuyyKv+Mkkgj8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEP5FsOp; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEP5FsOp"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ef84d016d9so5754513eec.0
        for <linux-watchdog@vger.kernel.org>; Mon, 04 May 2026 07:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777903240; x=1778508040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/YTk2nDKYd7OY/nacfXAHyEI+eJLH72/J35x49WHgEM=;
        b=DEP5FsOpaheoxXcvoNBbDrHeIGbJ1X8Ca6aegsVR/FxPLQ0SAxVYQBEtZwobNxMogL
         ftJ/FvMpBwxpmSh8THnYpmiZIeY6r0iZapyK9Ss2zi3AAy0yUyg3P4/XC+gfw79b7jt6
         3hnr4XBcKqieDR0L8743gI1fnGkDXx6kBmd+o9iGmTnc2Yet20cAY63+hD+FLy5pCAlk
         kOLLoqfUgsNbYx/CsFMetAbn0kzwBVVRrNQC/1f3KPxcpRGet03XGZTb2qPVn+nrQpQj
         tA3eWIpNgjzXsHvNZyVc1NlR+Ivw3PLP32Whns0tJvdyQrReN0OdAcAr3FoNQvBjeCvE
         FTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903240; x=1778508040;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YTk2nDKYd7OY/nacfXAHyEI+eJLH72/J35x49WHgEM=;
        b=kLc2fmNCPKWYdJbcBWjLyBtbeFjVK3WNKREPd6wmZL+c6ULhELx2ovFZLb7hTEy6fW
         UpllZqDxGxzcQmYSsSf0pGJl4uDdn1cOagl8+veNnYzlF15SaYoroZyqlpBJmfqRyZp7
         RHdjki6J+F6grCg/Sc4AlbvRkQw8HuL/QIhmDpVCFE50is5sVyCdZ5h1frPDb+z7LUOk
         PcYWJIflZY0nrEQIwBq0yQWYAI1SLpBH5auLTOWt0KtVSLzmHjqxeLN+zHZ9L1eYTqHc
         3W6cSmkWsEP+r30JEPvNzu1xaV1OYsouIILsvuKiQhIvA75mLJX3su0Rd4GKKe9YhHHZ
         nOiA==
X-Forwarded-Encrypted: i=1; AFNElJ/ywp42N17cZYJOV7JDrkJx68L2tqNp+n9Q/NZMzG3NV6Syl25SzKPXpcn5gkfXiN0zn9LZwlNIKaq6mHuauA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9NZOwfD8McsJGWIT7XLY2WFPtHSaO+i3D5ChcOBqu+xlA+kqg
	JLbOn8VOyffRhEH22lqiq/56qu+d+059J2f+UTYpGG1pbkSYurRm5pcCoYHPtg==
X-Gm-Gg: AeBDiet33IBozZ5KqihwptWacEBuS2jIYoZYO2U0qcN8rYlCbbie/RMQKiGEQ8wSdi5
	nfs9C4vl/YLQ7PO3TGQuhevcIdYz7NEWx2msD4GFH3HUY04L1BJ4FDnYfJbvj9faHaSrEi6EUui
	hMcyKP8rSaCRZWATb3/EEa2yf/5RDlGYmdjBe6HGhmpH/EaRIhaTzHlKD2xxVeyxKgCTHdFTick
	vw66C23vPIPAaGV3Zk0/UmLweTvDe/wBIAGEdOo0K+LYqpOXn9/AlctLIpNIGgxw8Gzy4mRCBpw
	arMrKs78mnWFw1x+CQVLKIri7tCh8mgpr/XJNshS1CxCkzDhTFnS7LxHM+4TEHdCN07r1hPe10U
	/mBWS5Z9ATcDtu7yvunW59GhRu4f7iuU7ndb3qejfzz6WDfeVf+z1GDZ+ADz/lHb6R903N3joHE
	KH67Z+qP1y/NYYk860uRlUjStmD9aZFcDoSDgLcBgewf/ib7NataL/v8zlk0vkeK0XPOoe/QUCj
	GiMhvFospc=
X-Received: by 2002:a05:693c:3111:b0:2ef:9961:27fa with SMTP id 5a478bee46e88-2efb999a952mr4556878eec.18.1777903238837;
        Mon, 04 May 2026 07:00:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3c24e738sm15688941eec.31.2026.05.04.07.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 07:00:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4bebbb8f-ee24-4aa2-8ab2-a46dac145f06@roeck-us.net>
Date: Mon, 4 May 2026 07:00:36 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] watchdog: Prefix WDT with ICS for clarity
To: Philipp Hahn <p.hahn@avm.de>, Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Philipp Hahn <phahn-oss@avm.de>, linux-watchdog@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1777892508.git.phahn-oss@avm.de>
 <a0a05dca5531c6a5ce0cc772dfa0c0522538e23f.1777892508.git.phahn-oss@avm.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <a0a05dca5531c6a5ce0cc772dfa0c0522538e23f.1777892508.git.phahn-oss@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/4/26 04:02, Philipp Hahn wrote:
> From: Philipp Hahn <phahn-oss@avm.de>
> 
> `wdt.rst` is only about the Watchdog timer from "Industrial Computer
> Source" (ICS). Change the title to better express this.
> 

Please also explain "ICS" into the documentation file.

We can not rename the Kconfig symbol, but I'd also suggest to rename
the documentation to icswdt.rst or maybe better watchdog-ics.rst.

Additional comment below.

Thanks,
Guenter

> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>   Documentation/watchdog/wdt.rst | 6 +++---
>   drivers/watchdog/Kconfig       | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/watchdog/wdt.rst b/Documentation/watchdog/wdt.rst
> index d97b0361535b0..be8cc0b9f31e1 100644
> --- a/Documentation/watchdog/wdt.rst
> +++ b/Documentation/watchdog/wdt.rst
> @@ -1,6 +1,6 @@
> -============================================================
> -WDT Watchdog Timer Interfaces For The Linux Operating System
> -============================================================
> +================================================================
> +ICS WDT Watchdog Timer Interfaces For The Linux Operating System
> +================================================================
>   
>   Last Reviewed: 10/05/2007
>   
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index dc78729ba2a5d..2cbf0391a065a 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -2270,10 +2270,10 @@ config MIXCOMWD
>   	  Most people will say N.
>   
>   config WDT
> -	tristate "WDT Watchdog timer"
> +	tristate "ICS WDT Watchdog timer"

WDT is now redundant. Maybe "ICS WDT500P/WDT501P Watchdog timer" to
match the PCI variant.

>   	depends on ISA
>   	help
> -	  If you have a WDT500P or WDT501P watchdog board, say Y here,
> +	  If you have an ICS WDT500P or WDT501P watchdog board, say Y here,
>   	  otherwise N. It is not possible to probe for this board, which means
>   	  that you have to inform the kernel about the IO port and IRQ that
>   	  is needed (you can do this via the io and irq parameters)
> @@ -2304,7 +2304,7 @@ config PCIPCWATCHDOG
>   	  Most people will say N.
>   
>   config WDTPCI
> -	tristate "PCI-WDT500/501 Watchdog timer"
> +	tristate "ICS PCI-WDT500/501 Watchdog timer"
>   	depends on PCI && HAS_IOPORT
>   	help
>   	  If you have a PCI-WDT500/501 watchdog board, say Y here, otherwise N.

