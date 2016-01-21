Return-path: <mans@mansr.com>
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To: Mason <slash.tmp@free.fr>
Cc: Wim Van Sebroeck <wim@iguana.be>,  Guenter Roeck <linux@roeck-us.net>,  linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: tango: rename ARCH_TANGOX to ARCH_TANGO
References: <56A0EABB.3090901@free.fr>
Date: Thu, 21 Jan 2016 14:28:53 +0000
In-Reply-To: <56A0EABB.3090901@free.fr> (Mason's message of "Thu, 21 Jan 2016
	15:27:07 +0100")
Message-ID: <yw1xtwm7nh0a.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

Mason <slash.tmp@free.fr> writes:

> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>
> This change was requested by arm-soc maintainer Kevin Hilman
> because the X in TANGOX is a wildcard.
>
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Mans Rullgard <mans@mansr.com>

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 4f0e7be0da34..e723e0169f88 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -145,7 +145,7 @@ config MENF21BMC_WATCHDOG
>  config TANGOX_WATCHDOG
>  	tristate "Sigma Designs SMP86xx/SMP87xx watchdog"
>  	select WATCHDOG_CORE
> -	depends on ARCH_TANGOX || COMPILE_TEST
> +	depends on ARCH_TANGO || COMPILE_TEST
>  	help
>  	  Support for the watchdog in Sigma Designs SMP86xx (tango3)
>  	  and SMP87xx (tango4) family chips.
>

--=20
M=E5ns Rullg=E5rd
