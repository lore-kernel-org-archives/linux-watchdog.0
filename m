Return-Path: <wim@linux-watchdog.org>
Return-path: <wim@linux-watchdog.org>
Date: Sat, 6 Oct 2018 11:25:56 +0200
From: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, Joe Perches <joe@perches.com>,
	Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Fix file pattern for MEN Z069 watchdog
 driver
Message-ID: <20181006092556.GA27693@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

> The file name is menz69_wdt.c, not menz069_wdt.c.
> 
> Reported-by: Joe Perches <joe@perches.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Johannes Thumshirn <jth@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ad052aeac39..4c1a6e88bc5f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9478,7 +9478,7 @@ MEN Z069 WATCHDOG DRIVER
>  M:	Johannes Thumshirn <jth@kernel.org>
>  L:	linux-watchdog@vger.kernel.org
>  S:	Maintained
> -F:	drivers/watchdog/menz069_wdt.c
> +F:	drivers/watchdog/menz69_wdt.c
>  
>  MESON AO CEC DRIVER FOR AMLOGIC SOCS
>  M:	Neil Armstrong <narmstrong@baylibre.com>
> -- 
> 2.7.4
> 

Reviewed-by: Wim Van Sebroeck <wim@linux-watchdog.org>

Kind regards,
Wim.
