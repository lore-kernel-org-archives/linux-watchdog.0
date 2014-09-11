Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36364 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbaIKPmJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 11 Sep 2014 11:42:09 -0400
Received: by mail-pa0-f44.google.com with SMTP id kx10so10194292pab.31
        for <linux-watchdog@vger.kernel.org>; Thu, 11 Sep 2014 08:42:09 -0700 (PDT)
Date: Thu, 11 Sep 2014 08:42:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH] watchdog: simplify definitions of
 WATCHDOG_NOWAYOUT(_INIT_STATUS)?
Message-ID: <20140911154204.GA27637@roeck-us.net>
References: <1410293911-18392-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1410293911-18392-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Sep 09, 2014 at 10:18:31PM +0200, Uwe Kleine-König wrote:
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> maybe it's arguable if the newly introduced way to define
> WATCHDOG_NOWAYOUT and WATCHDOG_NOWAYOUT_INIT_STATUS is really simpler.
> But at least it's five lines shorter and makes the questionable naming
> of cpp symbols more obvious. (Who can tell the difference between
> the semantic of WATCHDOG_NOWAYOUT and WDOG_NO_WAY_OUT without further
> checking?)
> 
I like it.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> Best regards
> Uwe
> 
>  include/linux/watchdog.h | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index 2a3038ee17a3..395b70e0eccf 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -97,13 +97,8 @@ struct watchdog_device {
>  #define WDOG_UNREGISTERED	4	/* Has the device been unregistered */
>  };
>  
> -#ifdef CONFIG_WATCHDOG_NOWAYOUT
> -#define WATCHDOG_NOWAYOUT		1
> -#define WATCHDOG_NOWAYOUT_INIT_STATUS	(1 << WDOG_NO_WAY_OUT)
> -#else
> -#define WATCHDOG_NOWAYOUT		0
> -#define WATCHDOG_NOWAYOUT_INIT_STATUS	0
> -#endif
> +#define WATCHDOG_NOWAYOUT		IS_BUILTIN(CONFIG_WATCHDOG_NOWAYOUT)
> +#define WATCHDOG_NOWAYOUT_INIT_STATUS	(WATCHDOG_NOWAYOUT << WDOG_NO_WAY_OUT)
>  
>  /* Use the following function to check whether or not the watchdog is active */
>  static inline bool watchdog_active(struct watchdog_device *wdd)
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
