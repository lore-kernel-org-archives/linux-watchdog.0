Return-Path: <joel.stan@gmail.com>
Return-path: <joel.stan@gmail.com>
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20170918054905.16470-2-andrew@aj.id.au>
References: <20170918054905.16470-1-andrew@aj.id.au> <20170918054905.16470-2-andrew@aj.id.au>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 20 Sep 2017 11:17:09 +0930
Message-ID: <CACPK8XezE6ZSfSQ7Aq7g85imqXLuahWGu_SQzG=+LAq0UxSdyA@mail.gmail.com>
Subject: Re: [PATCH 1/4] watchdog: aspeed: Retain watchdog enabled state
To: Andrew Jeffery <andrew@aj.id.au>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	linux-aspeed@lists.ozlabs.org, Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Sep 18, 2017 at 3:19 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> An unintended post-condition of probe() is that the watchdog is
> disabled. Rework probe() such that we retain the value of the "enabled"
> bit from the control register, and take the appropriate actions with
> respect to the watchdog core if so. Otherwise, just configure the
> watchdog as directed.
>

This should have a fixes line. The code as it stands in 4.14-rc1
unconditionally disables the watchdog at boot :(

> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  drivers/watchdog/aspeed_wdt.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index 79cc766cd30f..99bc6fbd8852 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -221,7 +221,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         config = ofdid->data;
>
> -       wdt->ctrl = WDT_CTRL_1MHZ_CLK;
> +       wdt->ctrl |= readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE;

If we go back to before b7f0b8ad25f3 ("drivers/watchdog: ASPEED
reference dev tree properties for config"), the driver set up the
cached ctrl value and then tested the hardware state to decide if we
should have the watchdog enabled.

Looking at the driver now there's little reason to keep the cached
ctrl value. I'd suggest reworking the driver to not have it so we can
avoid bugs like the ones that b7f0b8ad25f3 introduced.

Cheers,

Joel

> +       wdt->ctrl |= WDT_CTRL_1MHZ_CLK;
>
>         /*
>          * Control reset on a per-device basis to ensure the
> @@ -243,11 +244,11 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>         if (of_property_read_bool(np, "aspeed,external-signal"))
>                 wdt->ctrl |= WDT_CTRL_WDT_EXT;
>
> -       writel(wdt->ctrl, wdt->base + WDT_CTRL);
> -
> -       if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
> +       if (wdt->ctrl & WDT_CTRL_ENABLE) {
>                 aspeed_wdt_start(&wdt->wdd);
>                 set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
> +       } else {
> +               writel(wdt->ctrl, wdt->base + WDT_CTRL);
>         }
>
>         if (of_device_is_compatible(np, "aspeed,ast2500-wdt")) {
> --
> 2.11.0
>
