Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34536 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965057AbeBMRH1 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 13 Feb 2018 12:07:27 -0500
Date: Tue, 13 Feb 2018 09:07:25 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com
Subject: Re: [PATCH v2 11/11] watchdog/hpwdt: Update driver version.
Message-ID: <20180213170725.GA19405@roeck-us.net>
References: <20180212052111.12010-1-jerry.hoemann@hpe.com>
 <20180212052111.12010-12-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212052111.12010-12-jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Feb 11, 2018 at 10:21:11PM -0700, Jerry Hoemann wrote:
> Update driver version number to reflect changes.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>  drivers/watchdog/hpwdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index bb0dcc8709b8..78168e2f9b4e 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -23,7 +23,7 @@
>  
>  #include <asm/nmi.h>
>  
> -#define HPWDT_VERSION			"1.4.0"
> +#define HPWDT_VERSION			"2.0.0"

I would suggest to drop the version entirely. History and experience shows
that it is not really useful.

Guenter

>  #define SECS_TO_TICKS(secs)		((secs) * 1000 / 128)
>  #define TICKS_TO_SECS(ticks)		((ticks) * 128 / 1000)
>  #define HPWDT_MAX_TIMER			TICKS_TO_SECS(65535)
> -- 
> 2.13.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
