Return-Path: <SRS0=7ngW=PM=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166D6C43387
	for <linux-watchdog@archiver.kernel.org>; Fri,  4 Jan 2019 13:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB63E2070C
	for <linux-watchdog@archiver.kernel.org>; Fri,  4 Jan 2019 13:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jggf6rqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfADNws (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 4 Jan 2019 08:52:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37311 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfADNws (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 4 Jan 2019 08:52:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so18357657pfb.4;
        Fri, 04 Jan 2019 05:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SZ1QXZZIh8XEqrTjOBDsB19WJys5upYZk0sO2U9Tio0=;
        b=Jggf6rqtNiCNNAomjZyC2W0YZCiKs0A9VKnnt65m8uaq16yt7H5cNeGBO9t6dM3KvO
         gwcfcYwBKpQ9Hr0b07MjWt7kMO7Xp0drUdHPLim54mGuPph8yC/9dbCEY1X1WuRtaYzV
         5y3zXO+NeoO6s0BV/gTVSiUByIZUH0yLPL0ZJtxZjtwJH/ETO37s9gmQYZbULCLAvH8U
         qCesuTu2i0hinj/exetEDeKcK2VDNW5r+dB2Qsv4j4TUqsgCZPDGaLDjRC2mUOJTJ1E5
         Tj2mS3OS6OE+cXyp2zqW4OHaJuoYW3jMXbh6cq3BjkfhMxVfj/8AEdpN4JGjdC+iI7JU
         wcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SZ1QXZZIh8XEqrTjOBDsB19WJys5upYZk0sO2U9Tio0=;
        b=Jr7jVq9oBSTZerw72Q4sq/YvjFzq1nIh6LusQrOk3hYnHzytOtxHZpYYZe3M3CBaDG
         hpXFUFTTHVsSsVpUnyhHcj1omRMnBXIgo7DcIUbqXmWIKOpPIcO4U2Wtn6uxzhzHshnn
         ycxu1njeXvwEC0lOiygY6bBseUqHlcLrioLbhyv6lreg2qcxWUNnsB56F1enZ+c/Ihm7
         AHocAazaoqFpbkYTxW6J9JRZtGTOMiwxWJw+JvxgmllpIyvrYndg336b7w752k1czJOl
         TqA4eZjtu82A96NYanEkomSbr/d6qSWFerA5R21QGBri4AIoDoICcI3hFwDQYl+NG/Lj
         UOkg==
X-Gm-Message-State: AA+aEWZImcDpH3o+83WvGJQBghxGf0+Q1fednJZYNaVfwzAxY3UE/sf5
        aa4SBnLcPVMAaIGtCOb7UK38oND1
X-Google-Smtp-Source: AFSGD/VYsyuNgJQYDWxtdzgKL6FQTFTITo0oCiwGhDW6HCWHhkfVfeAHwz5/eVMA3S2jwLp79hivWA==
X-Received: by 2002:a62:83ce:: with SMTP id h197mr52108780pfe.187.1546609966890;
        Fri, 04 Jan 2019 05:52:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f6sm86456355pfg.188.2019.01.04.05.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 05:52:45 -0800 (PST)
Subject: Re: [PATCH] watchdog: tqmx86: Fix a couple IS_ERR() vs NULL bugs
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-watchdog@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190104064725.GC30627@kadam>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <01349336-3543-ba8b-b44b-9993f5bc2319@roeck-us.net>
Date:   Fri, 4 Jan 2019 05:52:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190104064725.GC30627@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 1/3/19 10:47 PM, Dan Carpenter wrote:
> These functions return NULL on error but we accidentally check
> for IS_ERR() instead.
> 
> Fixes: e3c21e088f89 ("watchdog: tqmx86: Add watchdog driver for the IO controller")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/tqmx86_wdt.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/tqmx86_wdt.c b/drivers/watchdog/tqmx86_wdt.c
> index 0d3a0fbbd7a5..52941207a12a 100644
> --- a/drivers/watchdog/tqmx86_wdt.c
> +++ b/drivers/watchdog/tqmx86_wdt.c
> @@ -79,13 +79,13 @@ static int tqmx86_wdt_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> -	if (IS_ERR(res))
> -		return PTR_ERR(res);
> +	if (!res)
> +		return -ENODEV;
>   
>   	priv->io_base = devm_ioport_map(&pdev->dev, res->start,
>   					resource_size(res));
> -	if (IS_ERR(priv->io_base))
> -		return PTR_ERR(priv->io_base);
> +	if (!priv->io_base)
> +		return -ENOMEM;
>   
>   	watchdog_set_drvdata(&priv->wdd, priv);
>   
> 

