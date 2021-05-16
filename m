Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44545C433B4
	for <linux-watchdog@archiver.kernel.org>; Sun, 16 May 2021 23:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 115196100A
	for <linux-watchdog@archiver.kernel.org>; Sun, 16 May 2021 23:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhEPXJw (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 16 May 2021 19:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhEPXJw (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 16 May 2021 19:09:52 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC3DC06174A;
        Sun, 16 May 2021 16:08:36 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 5so2313162qvk.0;
        Sun, 16 May 2021 16:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aS+m6sE8NzB45PTVzNTHpFy2bUZH9byQtihXf5XCKaE=;
        b=QOa7udPYTBHZpUEm31xL583DD1La9FLPg1Zq6CODuToXONsWuXgccL/iTCXTFuhHod
         T0P2yFNliohjvdGoZ4lw0dZ6wurwnAGrXrw3jRv3K6WkUwqKX1/a7I5fmP8slaLe6p2T
         zRJqianM0L0Vg7X8fV0IpgmYV7r1RWf/BQK7y6PCW+me0d0RSvkUbV+Z80vgmifSibBG
         SlFIe2R7D1zqoWpzSsZn5I7lpjmP+zzJ5SRuUDJpknkXQwDPh+oXkaaGLLDeC+7CQWHr
         2YDIn6VgmItaDcUge/JqRxgniNOFkN7uvO3vtG0hwwHYU4qH/omWY/jKhnVSSYkkBXsS
         X9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aS+m6sE8NzB45PTVzNTHpFy2bUZH9byQtihXf5XCKaE=;
        b=N8ZZFVZhN5ejnnXNePQjp92qoFLIOlKGuIG7z5Ftgej9bHkxaTW6KYsm94tl2CbIYB
         kQDjZcLgXa6OfFVbPudHcfhVppRXTiF+TrfPUUYe+j3FnILJoP0pYPKJh18z1lrQllEE
         iiRE+msjAECWlyYqhf59p53SLQrhFo9gcSULXNuEwpxy4nHmeOhorCxMwRNbuwygwcu3
         6hfy6Zn1ohld1s4KdEfsq0XrHFy8ux+xUvgbOqEewAdZY2/uCsnHRSNbFpyujqksbTMU
         POjQhRUibcDEwynUzSwsviWvZxSjfDZ4YX1ZchjA7HoRFYUY81MDfsYDs5YRkv+ViWaS
         lrUg==
X-Gm-Message-State: AOAM530CfFepddezr79ct+dvIXz902MM6O2FGTlANoFVCDSFOcGTqBIp
        1RXXhFW+B8+U/2t5F9cqW7g=
X-Google-Smtp-Source: ABdhPJzd0iG0rLDkL5WnbMh1/5cqx9Tx5c+DdUE69doEvKYT+/DaHTLtetSLgUwMIazFOc9g/T2SSQ==
X-Received: by 2002:a0c:99e2:: with SMTP id y34mr33093914qve.29.1621206515440;
        Sun, 16 May 2021 16:08:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r10sm9625555qke.9.2021.05.16.16.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 May 2021 16:08:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] watchdog: mtx-1: drop au1000.h header file
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
References: <20210516211703.25349-1-rdunlap@infradead.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a1df3bdf-b883-008f-2989-27bbfe1c9b9e@roeck-us.net>
Date:   Sun, 16 May 2021 16:08:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210516211703.25349-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 5/16/21 2:17 PM, Randy Dunlap wrote:
> The mtx-1_wdt driver does not need the au1000.h header file.
> Instead, the header file causes build errors, so drop it.
> 
> This change fixes multiple build errors, all in au1000.h. E.g.:
> 
> In file included from ../drivers/watchdog/mtx-1_wdt.c:44:
> ../arch/mips/include/asm/mach-au1x00/au1000.h: In function 'alchemy_rdsys':
> ../arch/mips/include/asm/mach-au1x00/au1000.h:603:36: error: implicit declaration of function 'KSEG1ADDR'; did you mean 'CKSEG1ADDR'? [-Werror=implicit-function-declaration]
>    603 |  void __iomem *b = (void __iomem *)KSEG1ADDR(AU1000_SYS_PHYS_ADDR);
> ../arch/mips/include/asm/mach-au1x00/au1000.h:603:20: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>    603 |  void __iomem *b = (void __iomem *)KSEG1ADDR(AU1000_SYS_PHYS_ADDR);
> 
> Fixes: 04bf3b4f5fc0 ("[WATCHDOG] MTX-1 Watchdog driver")

More like

Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org
> Cc: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/mtx-1_wdt.c |    2 --
>   1 file changed, 2 deletions(-)
> 
> --- linux-next-20210514.orig/drivers/watchdog/mtx-1_wdt.c
> +++ linux-next-20210514/drivers/watchdog/mtx-1_wdt.c
> @@ -41,8 +41,6 @@
>   #include <linux/uaccess.h>
>   #include <linux/gpio/consumer.h>
>   
> -#include <asm/mach-au1x00/au1000.h>
> -
>   #define MTX1_WDT_INTERVAL	(5 * HZ)
>   
>   static int ticks = 100 * HZ;
> 

