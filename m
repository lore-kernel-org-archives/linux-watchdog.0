Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0314A13A0
	for <linux-watchdog@vger.kernel.org>; Tue, 15 Sep 2026 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483620; cv=none; b=P05j9n78KVEbn4VQgomKu3DUslmGKjaU/512BsVSUPWltyXgGx93u04l66oL3x/NXIo4k5GCt5xpLoJ2SiBkXq0oOkP/8Vh/m5Y4NAoBjMomkitCNTD8JnzXchS+axxjqUcf9xAc1I2a7vmt2ePDcDmXSlMpjM3fSJ9KHnaHKmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483620; c=relaxed/simple;
	bh=4KTUFVXZq0YyrkBUNaPs8mBTwyF9Gv70vl75i2fK2JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOh4c9y5zv3a7Cvj49cNlO9nJingg7om/noCz5v6c7gkr1QuwzDyJ9asT6WbthNvvX0j69IxWIZsmrtVCCdIyrzk4pFInJGTLyRSGj35n2dgE0awvPIzBjLRJy3Mzml5sqMiS9Z1J00sisGJzH3slNbfzZ4HcP/sDjTEVO/Ct2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGCaIQ2/; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGCaIQ2/"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4d2fe2056so237541a12.2
        for <linux-watchdog@vger.kernel.org>; Tue, 15 Sep 2026 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789483611; x=1790088411; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E1LZAg6q4rWMjzbWM0CQcGELHdk9ZPac+zdYJa0KG74=;
        b=XGCaIQ2/xHq/RAimifxNZAo3iP4+yT4/y/aL64eTMmoncYdeZv35nijZ6dlu0zUUnx
         YMQN9Ky+D5QllJ9Ff2Znc/dnw9FIFnxZFI1lbupKI3rXHZF+qSrPwYkosvsPgPiMkS2g
         c92RmlCFOysOogcv4eM/rTYx8CeqvfNwPNVhm3A+V8OZnjfLRUCS7wfcNvtx5P8xI5I8
         f4qlLWL2zukhyERZwWt4cLsKukaLv+vojw5/gghdKEj8Dw8cqYpEx8aiDC7m4ErIUEYf
         YHQx1+UkakZ1yQv/gQxzX/WS5EhWtG2xd8PVbP6BDxbOMUnxcqajdA1GomUM5jxkAc5p
         HgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789483611; x=1790088411;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E1LZAg6q4rWMjzbWM0CQcGELHdk9ZPac+zdYJa0KG74=;
        b=JUORmtkRkRKbB8k0iIoEoAbm3YndK10I8VNQtg3gihlggtRiCErxkzKmU6uSKqYLgw
         WXxw2SvaHL4/XYYqPrwRdJsZFDauSZudp2HjKjivgptIRFiypzlJ4sOairqCwABvQNaQ
         zPevslKZbCfMd914B5gtxC1BpgETqaIp+hCTkH/YARH9lRYOweZeSTFEbKYAmg8wz6ij
         CEC8dHJSu1Pz7W1VDTLhzqH0mDhJ5GlK4NaShyMne84LQO4WSiGlN28eC64qBUyx6zHz
         cEyN8oZ5YShTpigPaRLlr98s+g3skEwjP/E/HhRVktxmVHg8ntMlUIhltjQs+T6fXYGk
         n/tQ==
X-Forwarded-Encrypted: i=1; AKwUvBzhSR0ggW6qTrF6l24u1RHh106/Ha+MaUwD65cOVJZBKFvcSZU94ki797LKjqoB1JmenN8RH2a0Om+rIfR/Gw==@vger.kernel.org
X-Gm-Message-State: AFuF++lglmSnqor1zSHiDrEAaIAxrRpRsR9cIn3yLFScESjRXTNAeehP
	oyQltXAmtcWOyxkBFAgaDC52pvuNP3rlFKOGvSZY5sFWGPNX+3ntH9CD
X-Gm-Gg: AYBFou3pMlgsLvg2J0KZ4i/IMEt1ffUPgRPWTdf+DbNVKEnnz/TZ9r0jQsgnRMnvhX8
	9g3ZwvuZhcr6S6ww7QsNQRyhr66SaGzHzr7wajSQogkYqp1T8hnAaLv2KgnkkXTxGYkkW1EDgps
	au+WdvO1g1xtm/s7enYqcf9VA1PR4F5pD/l16sp8Wtff6r9JNbMOEkF3F0XOI9AvqVPQ4gbk1Ru
	Zj5n5tmbBRb+SoRyiXvVg5y1TuOpM7TmCwZii7LqZqdSJLoJQOePpbu7ruQiDJNr8qPmK++j4h6
	nlx20hjxneeWUgXhnIHCQVi6EwC2TBb/m89ERBbrVnRV6wFn+TVvNoYChICRWyu7lvn5ImkGluV
	pFOaEPOclV4av8wAdo+9ja9V4pcpuErtha0+ziwOP4N/VFTEsFmX0dHq5vUfxL0K0j3yD0Q0Yih
	hn5S4IIrVnGTvcCW/anM72KEPLi3oRlXpy2JKlme84Oijb7oX5K7ddDrbO5F3XPK8FcA0CKbp8j
	cjW79fSL0onv4Ano/Oi9sMAMtg3XkXU5xn2XvqS4Keh5K38YzNfNSN3xoc=
X-Received: by 2002:a17:90a:10c8:b0:39e:131d:4510 with SMTP id 98e67ed59e1d1-39e131d5278mr1375266a91.13.1789483611301;
        Tue, 15 Sep 2026 07:46:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfda39eb4sm5627503a91.8.2026.09.15.07.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 07:46:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cdf915e4-406c-4c54-9883-bcdce560942b@roeck-us.net>
Date: Tue, 15 Sep 2026 07:46:49 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: davinci_wdt: fix comment typo
To: Ruslan Vagner <rusya92266@gmail.com>, linux-watchdog@vger.kernel.org
Cc: wim@linux-watchdog.org
References: <CAF9RqJ5zHTLu2xpr02u781dvDG+MXiRS5WmCarMZFsQ2U4TAQQ@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAF9RqJ5zHTLu2xpr02u781dvDG+MXiRS5WmCarMZFsQ2U4TAQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/26 05:56, Ruslan Vagner wrote:
> Fix the spelling in comments. No functional change.
> 
> Signed-off-by: Ruslan Vagner <rusya92266@gmail.com>
> ---
>   drivers/watchdog/davinci_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
> index 6ea0434f45c2..748dd24affb3 100644
> --- a/drivers/watchdog/davinci_wdt.c
> +++ b/drivers/watchdog/davinci_wdt.c
> @@ -120,7 +120,7 @@ static unsigned int
> davinci_wdt_get_timeleft(struct watchdog_device *wdd)
>   	u32 val;
>   	struct davinci_wdt_device *davinci_wdt = watchdog_get_drvdata(wdd);
> 
> -	/* if timeout has occured then return 0 */
> +	/* if timeout has occurred then return 0 */
>   	val = ioread32(davinci_wdt->base + WDTCR);
>   	if (val & WDFLAG)
>   		return 0;

Already fixed with "watchdog: fix typos in comments", queued in watchdog-next.

Thanks,
Guenter

