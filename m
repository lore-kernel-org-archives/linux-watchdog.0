Return-Path: <SRS0=HvdG=SI=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01BEC10F06
	for <linux-watchdog@archiver.kernel.org>; Sat,  6 Apr 2019 13:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE122173C
	for <linux-watchdog@archiver.kernel.org>; Sat,  6 Apr 2019 13:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJctJba1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfDFNZs (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 6 Apr 2019 09:25:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37584 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfDFNZr (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 6 Apr 2019 09:25:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so4591787pgc.4
        for <linux-watchdog@vger.kernel.org>; Sat, 06 Apr 2019 06:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cevJo2Jo7yfvVt7gVLi3oL+dNJ61LRUnV+scT4C7YFM=;
        b=NJctJba1lXx7CFAZz71wpnGiiqvBOHyYwbektPRtk91/jfGTEYS0R524b6ZHNfYUD0
         HKPo/OajaFMXf4fY1aZBxLfIjoaVd4fg3bktrsKlRW33JWDvygqzfn988wv2tXvP7VC7
         izgw12PUJEkvF2taZjqEvyoyIspeYx0TlLaF/MHGM1323llJ7R61Iyg+mcI9yycg9IQf
         KPS8OH/Mb0r0pZSB4iWU9EQKb/+iABaxl7zKTuEyZnTikkNFrrftfQCEwXSHgcEHJ2+G
         6LKcaIcIjFqjtCWMr/TjF9dUfaxQRwEfCnkFSbZz5osjdDyGZOeP4VfqFnO0lr+EXLYk
         XNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cevJo2Jo7yfvVt7gVLi3oL+dNJ61LRUnV+scT4C7YFM=;
        b=Fn/jKMDJpevd0bLMBquDLpX9Rbwks1+v7jVBOETpwcpw6j5eADkn2sH4ZK2Tw6YjWF
         VQPkskjOS4f8aXQcyfqJSt63EuhGMGcqNilQUYQAnWq9ouG6xbNIknpK6PzH5xoXkT0+
         YRQpMNx71p/vIzkv39RfJVxeilO7f9AP7YJK0jmOsYJ7BPhmXjkgNROglWJBk3G+sEnM
         9T8eBrOb9r4Xq25m59Ns2ZcmxJv7kvRNpnFW2pvnf4/6ndtstS17CclkQ3eo3x2CIUro
         FV8SItoYBnG5Yu20aQJ26J4Dct1w99BVwUcn3i4M58oIJ+DW2wAcygA/1i3RmzISokGI
         xKHw==
X-Gm-Message-State: APjAAAX/oNp2pgBijA6dhhNhvkOvXgI/Ukoo7Vci74R8Zyt0jUjTPp0E
        Tx6u34jSu4VlZhmo4CZrc/AWXRPW
X-Google-Smtp-Source: APXvYqwfzAza3adEZAV3AHheaIyhbJPVpWQn0ung+XxqwYVkZKCHSVMBP2wJZZ1HE7hxH68hG04ePA==
X-Received: by 2002:a63:88c3:: with SMTP id l186mr18139521pgd.148.1554557146773;
        Sat, 06 Apr 2019 06:25:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h8sm33745509pfo.149.2019.04.06.06.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 06:25:45 -0700 (PDT)
Subject: Re: [PATCH] Fix set_timeout for big timeout values
To:     Georg Hofmann <georg@hofmannsweb.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org
References: <1274287303.1911.1554545863744.JavaMail.zimbra@hofmannsweb.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2a7af85e-486d-26dc-17bf-9f6e2c3ddf8a@roeck-us.net>
Date:   Sat, 6 Apr 2019 06:25:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1274287303.1911.1554545863744.JavaMail.zimbra@hofmannsweb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 4/6/19 3:17 AM, Georg Hofmann wrote:
> This patch implements the documented behavior: if max_hw_heartbeat_ms is
> implemented, the minimum of the set_timeout argument and
> max_hw_heartbeat_ms should be used.
> Previously only the first 7 bits were used and the input argument was
> returned.
> 
> Signed-off-by: Georg Hofmann <georg@hofmannsweb.com>
> ---
>   drivers/watchdog/imx2_wdt.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 2b52514..3c13adc 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -178,9 +178,11 @@ static void __imx2_wdt_set_timeout(struct watchdog_device *wdog,
>   static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
>   				unsigned int new_timeout)
>   {
> -	__imx2_wdt_set_timeout(wdog, new_timeout);
> +	unsigned int actual;
>   
> -	wdog->timeout = new_timeout;
> +	actual = min(new_timeout, wdog->max_hw_heartbeat_ms * 1000);
> +	__imx2_wdt_set_timeout(wdog, actual);
> +	wdog->timeout = actual;

That defeats the purpose of having an internal maximum. wdog->timeout
should still be set to the requested value.

Guenter
