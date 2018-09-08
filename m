Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39435 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeIHSey (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 8 Sep 2018 14:34:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so8327281pff.6
        for <linux-watchdog@vger.kernel.org>; Sat, 08 Sep 2018 06:49:03 -0700 (PDT)
Subject: Re: [PATCH] watchdog: fix a small number of "watchog" typos in
 comments
To: "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Linux watchdog mailing list <linux-watchdog@vger.kernel.org>
Cc: wim@linux-watchdog.org
References: <alpine.LFD.2.21.1809071400230.14610@localhost.localdomain>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <6356e46a-cc74-6a05-c8fb-fb3e1edccbe9@roeck-us.net>
Date: Sat, 8 Sep 2018 06:49:01 -0700
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1809071400230.14610@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/08/2018 03:20 AM, Robert P. J. Day wrote:
> 
> All typos in comments, should not affect functionality.
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
> 
> diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
> index 3ad1e44bef44..6e78a34c2370 100644
> --- a/drivers/watchdog/booke_wdt.c
> +++ b/drivers/watchdog/booke_wdt.c
> @@ -25,7 +25,7 @@
>   /* If the kernel parameter wdt=1, the watchdog will be enabled at boot.
>    * Also, the wdt_period sets the watchdog timer period timeout.
>    * For E500 cpus the wdt_period sets which bit changing from 0->1 will
> - * trigger a watchog timeout. This watchdog timeout will occur 3 times, the
> + * trigger a watchdog timeout. This watchdog timeout will occur 3 times, the
>    * first time nothing will happen, the second time a watchdog exception will
>    * occur, and the final time the board will reset.
>    */
> diff --git a/drivers/watchdog/via_wdt.c b/drivers/watchdog/via_wdt.c
> index b085ef1084ec..d56d0a927a1e 100644
> --- a/drivers/watchdog/via_wdt.c
> +++ b/drivers/watchdog/via_wdt.c
> @@ -30,7 +30,7 @@
>   #define VIA_WDT_CONF_MMIO	0x02	/* 1: enable watchdog MMIO */
> 
>   /*
> - * The MMIO region contains the watchog control register and the
> + * The MMIO region contains the watchdog control register and the
>    * hardware timer counter.
>    */
>   #define VIA_WDT_MMIO_LEN	8	/* MMIO region length in bytes */
> @@ -82,7 +82,7 @@ static inline void wdt_reset(void)
>   /*
>    * Timer tick: the timer will make sure that the watchdog timer hardware
>    * is being reset in time. The conditions to do this are:
> - *  1) the watchog timer has been started and /dev/watchdog is open
> + *  1) the watchdog timer has been started and /dev/watchdog is open
>    *     and there is still time left before userspace should send the
>    *     next heartbeat/ping. (note: the internal heartbeat is much smaller
>    *     then the external/userspace heartbeat).
> 
