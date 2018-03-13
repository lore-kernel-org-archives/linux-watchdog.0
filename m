Return-Path: <joel.stan@gmail.com>
Return-path: <joel.stan@gmail.com>
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <1520632700-25800-3-git-send-email-eajames@linux.vnet.ibm.com>
References: <1520632700-25800-1-git-send-email-eajames@linux.vnet.ibm.com> <1520632700-25800-3-git-send-email-eajames@linux.vnet.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 13 Mar 2018 14:59:20 +1030
Message-ID: <CACPK8XetpM0d9-y4mbm9Q7NoN9gSsjVZ7y0Vm5-BuRH5AQR8jw@mail.gmail.com>
Subject: Re: [PATCH 2/2] watchdog: aspeed: Allow configuring for alternate boot
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Milton Miller <miltonm@us.ibm.com>,
	Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Sat, Mar 10, 2018 at 8:28 AM, Eddie James <eajames@linux.vnet.ibm.com> wrote:
> From: Milton Miller <miltonm@us.ibm.com>
>
> Allow the device tree to specify a watchdog to fallover to
> the alternate boot source.
>
> The aspeeed watchdog can set a latch directing flash chip select 0 to
> chip select 1, allowing boot from an alternate media if the watchdog
> is not reset in time.  On the ast2400 bank 1 also goes to flash bank 1,
> while on the ast2500 the chip selects are swapped.
>
> Signed-off-by: Milton Miller <miltonm@us.ibm.com>
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> ---
>  drivers/watchdog/aspeed_wdt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index d1987d6..f41d246 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -46,6 +46,7 @@ struct aspeed_wdt_config {
>  #define WDT_RELOAD_VALUE       0x04
>  #define WDT_RESTART            0x08
>  #define WDT_CTRL               0x0C
> +#define   WDT_CTRL_BOOT_SECONDARY      BIT(7)
>  #define   WDT_CTRL_RESET_MODE_SOC      (0x00 << 5)
>  #define   WDT_CTRL_RESET_MODE_FULL_CHIP        (0x01 << 5)
>  #define   WDT_CTRL_RESET_MODE_ARM_CPU  (0x10 << 5)
> @@ -245,6 +246,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>         }
>         if (of_property_read_bool(np, "aspeed,external-signal"))
>                 wdt->ctrl |= WDT_CTRL_WDT_EXT;
> +       if (of_property_read_bool(np, "aspeed,alt-boot"))
> +               wdt->ctrl |= WDT_CTRL_BOOT_SECONDARY;

If a user sets this property on the only watchdog in the system, then
they will trigger this behaviour when doing a normal 'reboot'. That
would not be desirable.

We could mitigate this by:

- not registering the watchdog as a reboot device if this property is enabled

- clearing the WDT_CTRL_BOOT_SECONDARY bit in the aspeed_wdt_restart path

The second option is neater as it allows the watchdog to behave
normally when only one is enabled. The first would be confusing if a
system didn't have more than one watchdog enabled.

Cheers,

Joel
