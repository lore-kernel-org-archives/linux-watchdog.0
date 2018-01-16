Return-Path: <lyude@redhat.com>
Return-path: <lyude@redhat.com>
Message-ID: <1516131289.18904.6.camel@redhat.com>
Subject: Re: [02/12] watchdog: sp5100_tco: Fix watchdog disable bit
From: Lyude Paul <lyude@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?ISO-8859-1?Q?Zolt=E1n_B=F6sz=F6rm=E9nyi?=
	 <zboszor@pr.hu>
Date: Tue, 16 Jan 2018 14:34:49 -0500
In-Reply-To: <1514149448-20214-3-git-send-email-linux@roeck-us.net>
References: <1514149448-20214-3-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, 2017-12-24 at 13:03 -0800, Guenter Roeck wrote:
> According to all published information, the watchdog disable bit for SB800
> compatible controllers is bit 1 of PM register 0x48, not bit 2. For the
> most part that doesn't matter in practice, since the bit has to be cleared
> to enable watchdog address decoding, which is the default setting, but it
> still needs to be fixed.
Reviewed-by: Lyude Paul <lyude@redhat.com>

> 
> Cc: Zoltán Böszörményi <zboszor@pr.hu>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/sp5100_tco.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sp5100_tco.h b/drivers/watchdog/sp5100_tco.h
> index f495fe03887a..2622cfe23dc1 100644
> --- a/drivers/watchdog/sp5100_tco.h
> +++ b/drivers/watchdog/sp5100_tco.h
> @@ -52,7 +52,7 @@
>  #define SB800_PM_WATCHDOG_CONFIG	0x4C
>  
>  #define SB800_PCI_WATCHDOG_DECODE_EN	(1 << 0)
> -#define SB800_PM_WATCHDOG_DISABLE	(1 << 2)
> +#define SB800_PM_WATCHDOG_DISABLE	(1 << 1)
>  #define SB800_PM_WATCHDOG_SECOND_RES	(3 << 0)
>  #define SB800_ACPI_MMIO_DECODE_EN	(1 << 0)
>  #define SB800_ACPI_MMIO_SEL		(1 << 1)
-- 
Cheers,
	Lyude Paul
