Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46854 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLFR5u (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 6 Dec 2018 12:57:50 -0500
Date: Thu, 6 Dec 2018 09:57:47 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] watchdog/hpwdt: Update driver version.
Message-ID: <20181206175747.GD11808@roeck-us.net>
References: <1544056943-79958-1-git-send-email-jerry.hoemann@hpe.com>
 <1544056943-79958-4-git-send-email-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544056943-79958-4-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Dec 05, 2018 at 05:42:23PM -0700, Jerry Hoemann wrote:
> Bump version number to reflect recent minor changes.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/hpwdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index c8e8055..ef30c7e 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -26,7 +26,7 @@
>  #include <linux/watchdog.h>
>  #include <asm/nmi.h>
>  
> -#define HPWDT_VERSION			"2.0.1"
> +#define HPWDT_VERSION			"2.0.2"
>  #define SECS_TO_TICKS(secs)		((secs) * 1000 / 128)
>  #define TICKS_TO_SECS(ticks)		((ticks) * 128 / 1000)
>  #define HPWDT_MAX_TIMER			TICKS_TO_SECS(65535)
> -- 
> 1.8.3.1
> 
