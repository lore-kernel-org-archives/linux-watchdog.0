Return-Path: <joel.stan@gmail.com>
Return-path: <joel.stan@gmail.com>
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20170920053020.6860-3-andrew@aj.id.au>
References: <20170920053020.6860-1-andrew@aj.id.au> <20170920053020.6860-3-andrew@aj.id.au>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 20 Sep 2017 15:37:53 +0930
Message-ID: <CACPK8Xf+sirCvKLJcLvew3onRvSHrozQr=ZX_cJZHa4pqpdNrw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] watchdog: aspeed: Fix 'Apseed' typo in Kconfig
To: Andrew Jeffery <andrew@aj.id.au>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	linux-aspeed@lists.ozlabs.org, Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Sep 20, 2017 at 3:00 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> Apseed sounds like a good name for a web/mobile start-up incubator, but
> isn't a reflection of Aspeed themselves.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c722cbfdc7e6..b562d2e03eb9 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -746,7 +746,7 @@ config ASPEED_WATCHDOG
>         select WATCHDOG_CORE
>         help
>           Say Y here to include support for the watchdog timer
> -         in Apseed BMC SoCs.
> +         in Aspeed BMC SoCs.

lol.

Reviewed-by: Joel Stanley <joel@jms.id.au>
