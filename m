Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BA33F210C
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Mar 2026 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774354375; cv=none; b=p1MtkTUizw77MGNptPwBHQMSFRiZ/cIVXgKXmUIJcV1oRDjqfde5vsgwXO9mchd736hV/X0HzytHhkP76CsmNKcIQUGCf+DNmVWwD0A/3FPtsVY3ockTOEdAYifexyFs5dsR4BzYIG393No4lYuQPinnIhR5yORmS/duNs8SJrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774354375; c=relaxed/simple;
	bh=sCtex8QLEBQd1Iaa4RTPc5h8fhMUPxFyELPd8IKBgYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6QaI1Vyo46SviBiwfe5LFa/joDqBxg2nY/KiSBLkuEGjoIT68s025s9LizI945Z//TqSlMw1paJVlaVd78cuj6eMVKPn4oni/oitazAVECt88bfLhV1QDWWdoNoZcVC0Eke40w5cszUka8SNP/6dWJ16+gavYNHyz0pkLycLak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXKk0Y2h; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXKk0Y2h"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c11c43aca0so1906755eec.1
        for <linux-watchdog@vger.kernel.org>; Tue, 24 Mar 2026 05:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774354371; x=1774959171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dd7ld8QgGMmhxeSAt+yc27mRDHtyBCuQTPG9sSAJi90=;
        b=VXKk0Y2hgOESFLRjAMVgeVD5Z5zcg7pM2ez6Nsl7A+b4pQXHhWSiQ34ydNOXTIIlrC
         xgD/1O0nEVTpgarMp3wEK0z7QEREYCxqQnPWvQFtoEZkpRpiq61trXU7PxxvAIxcgylu
         p9XRtDrAi8fRBkiXa6YNjnkd1dEhcWqaMKMYsqQ9mgNsSazBjEIhvBiZGESwiGL9mJbl
         qUDbabmQx0JA1bk8/rlfmoFcTwSeIlweEMSlVtuLLLcgKLA70wZj3SdnBToK2WuPU3nf
         7oGG0W5EFISu7Gj/cMNs7UYUcYwInPgcrfSwROgA3i5PyBdR7E2iphq9sSifWvlrPpaW
         Um+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774354371; x=1774959171;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dd7ld8QgGMmhxeSAt+yc27mRDHtyBCuQTPG9sSAJi90=;
        b=aepfFYewPweCOSJjHG+OmDEdf1yB864Aa4reD7Xvg+9ZX+nzxdNs+lNoD1eJpJTa5g
         cbn5ZTV2hRL5Wr9l1EjfkMqN7VYbA+CK02E+v4/HjbIkUfaI6/Rg65hL4t7dRiiyHs47
         PtK16/xKfB3e/ezWuk5HpnEIMrm+DdTta2ypIGqaB2JMSAlWtkBk9EV3ic2PMrn+csdz
         5vQsM3aAL9MAK54iWbJ/v2vaywUJHSgSIW0TQe64xEwQiKN2aPRdHNZ/naYcd0DLh5CN
         Rx/eJi3LEBgR2/5uKGGhrnuJ6flHDGzIuFTBOJwgk+qF3Ya1HrTH0GuI+PVatk2I5TS+
         6Mew==
X-Forwarded-Encrypted: i=1; AJvYcCUeBtJh7h6tEltL5kDR4NnKrxQC/b9PA6LNlD/YOTEe/VZSbG3dgRIWy8Ilrr0/1Yen/BLEOdpH+QdxO1FQzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJNY43SpX5BPaK52LpcryiEsEmWmp1RCu48Vhp66PYQP87a9I5
	bfqb+mty0TB2XeBTZokvksAeCEIo3Vo3wjZVg/+OX4jpuo+7QKjM/dSdp5M24w==
X-Gm-Gg: ATEYQzyXo8C+BzlKZEZk49CS8blHpzPgro0mo8C1dXGAZfevIQapzlp2jAmxzaBDYnR
	mBYaDjSxaRqoGVfUpV7SfFIacajHE8OM35jI1MRT57LPf/h0dx5QwYeLQ5p+U+tBg96d/pM00bf
	rfB+IEjqOdCoCzU/gDsCxBcEj1SAXDSb98URFGLzb+1tO+NLabST0vkp806wfwQxGnTHp4sGgDb
	062Icc8LxVFb805xmCRfE2yT8y5fksUjcFtO9TXIdBlP9cHTH7rWDpdI/qdalUtFLOK0G5ch13w
	ldHA4Pir1m7KEf3nQjig9gZf8SA2uafrTvl1OXolQ4mOU/GNPPLyNmRQtWPXDr4UxUBX2t/SBvT
	QOPA5uSM+oVpxAkGENpYLMOqtfv8vnIoQef8crMFc1EzFSyV7aAmzdSZlqjhAfEYKTI0tk5psuy
	q00I2eFnOLFHnSTJjSt8d/Mwri1O1pUR1ducEkjrbgzfVsgUqMlVMuo3j0cv6hyakhXZTpSlFlw
	Xc4BRzx2NQ=
X-Received: by 2002:a05:7301:4195:b0:2be:1f56:ed2a with SMTP id 5a478bee46e88-2c14b554283mr1610081eec.16.1774354370883;
        Tue, 24 Mar 2026 05:12:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b3253d0sm15177748eec.29.2026.03.24.05.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 05:12:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ca9f8846-9560-473d-b5f1-542950c7cf71@roeck-us.net>
Date: Tue, 24 Mar 2026 05:12:48 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] watchdog: rzn1: Fix reverse xmas tree declaration
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-renesas-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pascal Eberhard <pascal.eberhard@se.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20260324114849.242755-1-herve.codina@bootlin.com>
 <20260324114849.242755-2-herve.codina@bootlin.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260324114849.242755-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/26 04:48, Herve Codina (Schneider Electric) wrote:
> Variables declared in probe() don't follow the reverse xmas
> tree convention.
> 
> Fix the declaration in order to follow the convention.
> 
> Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/rzn1_wdt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/rzn1_wdt.c b/drivers/watchdog/rzn1_wdt.c
> index 96fd04fbc2a2..b7034eac91d0 100644
> --- a/drivers/watchdog/rzn1_wdt.c
> +++ b/drivers/watchdog/rzn1_wdt.c
> @@ -101,10 +101,10 @@ static const struct watchdog_ops rzn1_wdt_ops = {
>   static int rzn1_wdt_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> -	struct rzn1_watchdog *wdt;
>   	struct device_node *np = dev->of_node;
> -	struct clk *clk;
> +	struct rzn1_watchdog *wdt;
>   	unsigned long clk_rate;
> +	struct clk *clk;
>   	int ret;
>   	int irq;
>   

