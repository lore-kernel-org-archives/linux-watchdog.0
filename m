Return-Path: <SRS0=hjSj=RP=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A84C43381
	for <linux-watchdog@archiver.kernel.org>; Tue, 12 Mar 2019 00:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF942087F
	for <linux-watchdog@archiver.kernel.org>; Tue, 12 Mar 2019 00:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1yk9Q60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfCLAHQ (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:07:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35155 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfCLAHQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 11 Mar 2019 20:07:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id e17so381284pgd.2
        for <linux-watchdog@vger.kernel.org>; Mon, 11 Mar 2019 17:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H127FDyAv51kZWchexKLKln9XY4l5MkiyRSFxsKNnS4=;
        b=t1yk9Q60NPYLLb20nNf1qu+4d5FK/oRvz42l9IGtG2jxBgAV31Z+WVw0aHGMD8vo65
         gQQKpiAmcFiWMvwOSk6BR9L0Tvw6EBVJsXUmY8g+Tu/njGv7nuFjabCAZ19dtsZJ0IGA
         6/Gypen50H2lnPqlEC88XYSdcrMSdgNjNnaLIswC7/+tOJboHwUJkMR1/+V3VrUgtOkM
         OJlPbQlUEccRkJvANoiuP7j+gmtUpK50+C8z5rGmTIu7ArYHoeqwVOMhextT4QYTLD7d
         3K/mMrg7JmrSXeKGSiEv2aS3nqpOwK/VcwbDTtLzLnupjKcMlBCnCUN+0wd+bUewVkDi
         sZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H127FDyAv51kZWchexKLKln9XY4l5MkiyRSFxsKNnS4=;
        b=tTUajm0n5jfEnp8zDr5lfHMTPPf6rLPLlmLHKvrNKjw+ZeXaC22EABCKLgDjtIgrP4
         4BM49Vl+Xf4q0CFY7iimBYM4GcxYZ4I1pUWXrU1I2tRxjreGBqO4T9u9AF69qVKfIJz3
         E0t/K0vxfv//iCek1xRFEOhMkfn2WNTPcad6PD59mhg8ZBbNgQI4Jyhym9y0p+XZSH1z
         uqTu53S0W1tkN4tX0P6cx/2kpXTD6JkMOyBGIX8DAXL5m1MvuWlDWbHk9QBxvzZIFLUI
         n0gn7nQ1wougKkYXrlNLclu6Jk1uAlAwN25Itw8XVaeitn5680pq8fo508KhlFZv9JJL
         sf3g==
X-Gm-Message-State: APjAAAV1qA5/ssWjaZdBM/ab4NBzFv9U4OqNeeXWEd8qT+FUekYK4PBH
        wvS1XfpuBMHjRDK7+oesYO1PBoEv
X-Google-Smtp-Source: APXvYqzSUCw4THySVT3gMjjJUP0qUPw9sGU/DTyPC8BUsvfllsIUBawWVvApI9sjlxXeccRZ/DIpOA==
X-Received: by 2002:a65:6559:: with SMTP id a25mr22018325pgw.99.1552349235309;
        Mon, 11 Mar 2019 17:07:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n15sm11169406pfi.173.2019.03.11.17.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 17:07:14 -0700 (PDT)
Subject: Re: [PATCH] watchdog: fix compile time error of pretimeout governors
To:     Vladimir Zapolskiy <vz@mleia.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, Hsuan-Chi <hckuo2@illinois.edu>
References: <20190311235425.1748-1-vz@mleia.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <afb20fe6-282c-c141-262f-b323d491e749@roeck-us.net>
Date:   Mon, 11 Mar 2019 17:07:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190311235425.1748-1-vz@mleia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 3/11/19 4:54 PM, Vladimir Zapolskiy wrote:
> CONFIG_WATCHDOG_PRETIMEOUT_GOV build symbol adds watchdog_pretimeout.o
> object to watchdog.o, the latter is compiled only if CONFIG_WATCHDOG_CORE
> is selected, so it rightfully makes sense to add it as a dependency.
> 
> The change fixes the next compilation errors, if CONFIG_WATCHDOG_CORE=n
> and CONFIG_WATCHDOG_PRETIMEOUT_GOV=y are selected:
> 
>    drivers/watchdog/pretimeout_noop.o: In function `watchdog_gov_noop_register':
>    drivers/watchdog/pretimeout_noop.c:35: undefined reference to `watchdog_register_governor'
>    drivers/watchdog/pretimeout_noop.o: In function `watchdog_gov_noop_unregister':
>    drivers/watchdog/pretimeout_noop.c:40: undefined reference to `watchdog_unregister_governor'
> 
>    drivers/watchdog/pretimeout_panic.o: In function `watchdog_gov_panic_register':
>    drivers/watchdog/pretimeout_panic.c:35: undefined reference to `watchdog_register_governor'
>    drivers/watchdog/pretimeout_panic.o: In function `watchdog_gov_panic_unregister':
>    drivers/watchdog/pretimeout_panic.c:40: undefined reference to `watchdog_unregister_governor'
> 
> Reported-by: Kuo, Hsuan-Chi <hckuo2@illinois.edu>
> Fixes: ff84136cb6a4 ("watchdog: add watchdog pretimeout governor framework")
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 242eea859637..fa325b49672e 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -2028,6 +2028,7 @@ comment "Watchdog Pretimeout Governors"
>   
>   config WATCHDOG_PRETIMEOUT_GOV
>   	bool "Enable watchdog pretimeout governors"
> +	depends on WATCHDOG_CORE
>   	help
>   	  The option allows to select watchdog pretimeout governors.
>   
> 

