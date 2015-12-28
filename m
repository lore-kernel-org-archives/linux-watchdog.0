Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 28 Dec 2015 23:20:42 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Guenter Roeck as reviewer of watchdog drivers
Message-ID: <20151228222042.GA1927@spo001.leaseweb.nl>
References: <1449382705-7033-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1449382705-7033-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

> I have been reviewing watchdog drivers for years, so we might
> as well make it official.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cba790b42f23..b1e3da7dc393 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11602,6 +11602,7 @@ F:	drivers/input/tablet/wacom_serial4.c
>  
>  WATCHDOG DEVICE DRIVERS
>  M:	Wim Van Sebroeck <wim@iguana.be>
> +R:	Guenter Roeck <linux@roeck-us.net>
>  L:	linux-watchdog@vger.kernel.org
>  W:	http://www.linux-watchdog.org/
>  T:	git git://www.linux-watchdog.org/linux-watchdog.git
> -- 
> 2.1.4
> 

I think I forgot to tell you that this patch was added in linux-watchdog-next,
but I am sure you allready saw it :-).

Kind regards,
Wim.
