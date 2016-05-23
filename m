Return-path: <wimvs@spo001.leaseweb.nl>
Date: Mon, 23 May 2016 09:07:20 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 52/54] MAINTAINERS: Add file patterns for watchdog device tree bindings
Message-ID: <20160523070720.GA17439@spo001.leaseweb.nl>
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org> <1463907991-7916-53-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1463907991-7916-53-git-send-email-geert@linux-m68k.org>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Geert,

> Submitters of device tree binding documentation may forget to CC
> the subsystem maintainer if this is missing.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org
> ---
> Please apply this patch directly if you want to be involved in device
> tree binding documentation for your subsystem.
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9f54762f002e16de..7202b6565dd98d50 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12400,6 +12400,7 @@ L:	linux-watchdog@vger.kernel.org
>  W:	http://www.linux-watchdog.org/
>  T:	git git://www.linux-watchdog.org/linux-watchdog.git
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/watchdog/
>  F:	Documentation/watchdog/
>  F:	drivers/watchdog/
>  F:	include/linux/watchdog.h
> -- 
> 1.9.1
> 

Patch added to linux-watchdog-next.

Kind regards,
Wim.
