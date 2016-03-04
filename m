Return-path: <wimvs@spo001.leaseweb.nl>
Date: Fri, 4 Mar 2016 20:40:17 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Martyn Welch <martyn.welch@collabora.co.uk>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rename "trigger" reset reason "hw watchdog"
Message-ID: <20160304194017.GG6900@spo001.leaseweb.nl>
References: <1456502712-25965-1-git-send-email-martyn.welch@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456502712-25965-1-git-send-email-martyn.welch@collabora.co.uk>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Martyn,

> The Zodiac watchdog is implemented on a microcontoller. The reset reason
> currently labelled "trigger" is not to detect when the watchdog has
> triggered (as had been initially understood and suggested by the naming),
> but to inform the reader that the watchdog, which in fact has it's own
> hardware watchdog, has been reset because the hardware watchdog has
> triggered. Renaming to "hw watchdog".
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
> ---
>  drivers/watchdog/ziirave_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
> index 0c7cb73..cbe373de 100644
> --- a/drivers/watchdog/ziirave_wdt.c
> +++ b/drivers/watchdog/ziirave_wdt.c
> @@ -36,7 +36,7 @@
>  #define ZIIRAVE_STATE_OFF	0x1
>  #define ZIIRAVE_STATE_ON	0x2
>  
> -static char *ziirave_reasons[] = {"power cycle", "triggered", NULL, NULL,
> +static char *ziirave_reasons[] = {"power cycle", "hw watchdog", NULL, NULL,
>  				  "host request", NULL, "illegal configuration",
>  				  "illegal instruction", "illegal trap",
>  				  "unknown"};
> -- 
> 2.1.4
> 

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.
