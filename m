Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 52/54] MAINTAINERS: Add file patterns for watchdog device
 tree bindings
To: Geert Uytterhoeven <geert@linux-m68k.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
 <1463907991-7916-53-git-send-email-geert@linux-m68k.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5741EAF5.2080907@roeck-us.net>
Date: Sun, 22 May 2016 10:23:01 -0700
MIME-Version: 1.0
In-Reply-To: <1463907991-7916-53-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

On 05/22/2016 02:06 AM, Geert Uytterhoeven wrote:
> Submitters of device tree binding documentation may forget to CC
> the subsystem maintainer if this is missing.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Please apply this patch directly if you want to be involved in device
> tree binding documentation for your subsystem.
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9f54762f002e16de..7202b6565dd98d50 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12400,6 +12400,7 @@ L:	linux-watchdog@vger.kernel.org
>   W:	http://www.linux-watchdog.org/
>   T:	git git://www.linux-watchdog.org/linux-watchdog.git
>   S:	Maintained
> +F:	Documentation/devicetree/bindings/watchdog/
>   F:	Documentation/watchdog/
>   F:	drivers/watchdog/
>   F:	include/linux/watchdog.h
>
