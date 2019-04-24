Return-Path: <SRS0=EMH8=S2=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29822C10F03
	for <linux-watchdog@archiver.kernel.org>; Wed, 24 Apr 2019 01:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BF5217D9
	for <linux-watchdog@archiver.kernel.org>; Wed, 24 Apr 2019 01:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNCeWuiH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfDXBWE (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:22:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40709 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfDXBWE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 23 Apr 2019 21:22:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so8392342plr.7
        for <linux-watchdog@vger.kernel.org>; Tue, 23 Apr 2019 18:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gIUVJSzlXIpTw1HAqbwBhapwoFEHFIxJ9+eWO7OznG0=;
        b=YNCeWuiHlMZkUhG6nJ1M3R/uDhvtgNKJpbgswoAX1IvQXsJzA//PfqNWt4irgEOsjD
         cXWMNvhFP5Oa/BQsv7Eo17voVwDhxNocV3ySQcUqpOlvm5w68LwGINXB0dY3+9b6J6zU
         iloo7GVoSRuonK5XI09FnkqAyoRR8StIvaejfoiF+rJWcXtDkMLJ6XALlJflhKf/zHVM
         3iVcALgEJT7YglL1sJPhIQg4zuIAMJqSWHQbiOpv1Hm7D4zdc7omhppqg0UmoP+HKV2E
         zToss1G5wkc+uT8kG6Ag/W+gyHjOEcsJk7gaU6LTAvaPUp7AJZ8NONW/+3FRzI/sTbbS
         KQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gIUVJSzlXIpTw1HAqbwBhapwoFEHFIxJ9+eWO7OznG0=;
        b=Dp5u/Z/H8xkBuXgzQs7wGYgeNN2IUkNrGj19b9cPkXqaDKPWk8+yF+vJBOQ+9PEqYr
         mk75MBDo2TsPA8yDEOQxMJ3r9CCjZcxmfTJq0XeOHMih2o2kACcrLJCmhpg3opPhSI3n
         hYnvrKxf8c8D77WftkQgagB9i32oXDch/O8VBxdNiEte5ONKpmMSvOTUf9x62+EFd65c
         /M17/Lk6rRbrCgKwUbOLlweUXF7k7Ow3Fl8paCcVmUvRsQHXKI7WrIHyJytyLqHGDW2Z
         IBuie0TIb7DJ75e468MKymM8B0Um2avvGdod/9Sl2LKwRR+nSQ4yAF/g2mO8tBdytbR6
         0Deg==
X-Gm-Message-State: APjAAAV0OX+hp3Xt5GGezDNhXZgntMSEV7CcXS642RnteeslaqVjPmn3
        p662n0XQlXXNfG7rq1keCkU=
X-Google-Smtp-Source: APXvYqzttcAlz+dfAvZj/o18fJJCUJaIAkbh1zH4Wgl/iuVuOLs1Jwh3NjRED0vq82AIFQGqc0UvaA==
X-Received: by 2002:a17:902:28e4:: with SMTP id f91mr29067638plb.321.1556068923355;
        Tue, 23 Apr 2019 18:22:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f7sm8229706pgp.77.2019.04.23.18.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 18:22:01 -0700 (PDT)
Subject: Re: [PATCH 2/5] watchdog: watchdog_core: make it explicitly
 non-modular
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <1556034515-28792-1-git-send-email-paul.gortmaker@windriver.com>
 <1556034515-28792-3-git-send-email-paul.gortmaker@windriver.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <439d89d7-bae6-c5c8-e9bf-5477304bc065@roeck-us.net>
Date:   Tue, 23 Apr 2019 18:22:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556034515-28792-3-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 4/23/19 8:48 AM, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> config WATCHDOG_CORE
>         bool "WatchDog Timer Driver Core"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> We replace module.h with export.h since the file does export some
> symbols.  We don't add init.h since the file already has that.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
> 

I must admit that I am not at all happy about this change. While not
configurable by default, I used tristate a lot (after enabling it
manually) to test watchdog core code while changing it. It saves a
lot of time to be able to reload the watchdog core without having
to reboot the entire system after each change. Removing the ability
to do that just because it is not enabled in the field and just
to save a few lines of code (and because having modules seems to
have come out of favor lately) does not make sense to me.

I won't NACK the series outright, but I'll leave it up to Wim as
the senior maintainer to decide what he wants to do with it.

Guenter

> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: linux-watchdog@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>   drivers/watchdog/watchdog_core.c | 15 +--------------
>   1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index eb8fa25f8eb2..f9f88f59d181 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -28,7 +28,7 @@
>   
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>   
> -#include <linux/module.h>	/* For EXPORT_SYMBOL/module stuff/... */
> +#include <linux/export.h>	/* For EXPORT_SYMBOL stuff */
>   #include <linux/types.h>	/* For standard types */
>   #include <linux/errno.h>	/* For the -ENODEV/... values */
>   #include <linux/kernel.h>	/* For printk/panic/... */
> @@ -359,17 +359,4 @@ static int __init watchdog_init(void)
>   	watchdog_deferred_registration();
>   	return 0;
>   }
> -
> -static void __exit watchdog_exit(void)
> -{
> -	watchdog_dev_exit();
> -	ida_destroy(&watchdog_ida);
> -}
> -
>   subsys_initcall_sync(watchdog_init);
> -module_exit(watchdog_exit);
> -
> -MODULE_AUTHOR("Alan Cox <alan@lxorguk.ukuu.org.uk>");
> -MODULE_AUTHOR("Wim Van Sebroeck <wim@iguana.be>");
> -MODULE_DESCRIPTION("WatchDog Timer Driver Core");
> -MODULE_LICENSE("GPL");
> 

