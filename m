Return-path: <joel.stan@gmail.com>
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <5730A339.80006@roeck-us.net>
References: <1462797277-14969-1-git-send-email-joel@jms.id.au>
 <1462797277-14969-3-git-send-email-joel@jms.id.au> <5730A339.80006@roeck-us.net>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 10 May 2016 20:40:21 +0930
Message-ID: <CACPK8XfK4Qt2GaSL7eVoNkCawbtXqFX9bGRcgyAyq7R2yuSZkA@mail.gmail.com>
Subject: Re: [PATCH 2/2] watchdog: Add Aspeed watchdog driver
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Jeremy Kerr <jk@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hey Guenter,

Thanks for the review.

On Tue, May 10, 2016 at 12:18 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> +#define WDT_STATUS             0x00
>> +#define WDT_RELOAD_VALUE       0x04
>> +#define WDT_RESTART            0x08
>> +#define WDT_CTRL               0x0C
>> +#define   WDT_CTRL_RESET_MODE_SOC      (0x00 << 5)
>> +#define   WDT_CTRL_RESET_MODE_FULL_CHIP        (0x01 << 5)
>> +#define          WDT_CTRL_1MHZ_CLK             BIT(4)
>> +#define          WDT_CTRL_WDT_EXT              BIT(3)
>> +#define          WDT_CTRL_WDT_INTR             BIT(2)
>> +#define   WDT_CTRL_RESET_SYSTEM                BIT(1)
>> +#define   WDT_CTRL_ENABLE              BIT(0)
>> +
>> +#define        WDT_RESTART_MAGIC       0x4755
>
>
> Please don't use tabs after #define.

Oops, typo. Thanks.

>
>> +
>> +static struct aspeed_wdt *to_aspeed_wdt(struct watchdog_device *wdd)
>> +{
>> +       return container_of(wdd, struct aspeed_wdt, wdd);
>> +}
>> +
>> +
>
> Please no double empty lines.
>
>> +static void aspeed_wdt_enable(struct aspeed_wdt *wdt, int count)
>> +{
>> +       wdt->ctrl |= WDT_CTRL_ENABLE;
>> +
>> +       writel(0, wdt->base + WDT_CTRL);
>> +       writel(count, wdt->base + WDT_RELOAD_VALUE);
>> +       writel(WDT_RESTART_MAGIC, wdt->base + WDT_RESTART);
>> +       writel(wdt->ctrl, wdt->base + WDT_CTRL);
>
>
> Is it really necessary to write 0 into the ctrl register when enabling
> the watchdog ? Problem with it is two-fold: It changes the clock rate
> for a brief period of time, and it disables the watchdog while updating
> the timeout. Both is undesirable unless really needed.

In general I agree. However, the datasheet explicitly spells out these
four steps in this order. Writing zero is a shortcut; I could write
ctrl with the enable bit set to zero.

We've been using the driver in this fashion for the past year.

>> +}
>> +
>> +static int aspeed_wdt_start(struct watchdog_device *wdd)
>> +{
>> +       struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
>> +
>> +       dev_dbg(wdd->parent, "starting with timeout of %d (rate %lu)\n",
>> +                       wdd->timeout, wdt->rate);
>
>
> Are those dev_dbg() really useful ?

I did use them in writing the driver. They can go.

>
>> +       aspeed_wdt_enable(wdt, wdd->timeout * wdt->rate);
>> +
>> +       return 0;
>> +}
>> +
>> +static int aspeed_wdt_stop(struct watchdog_device *wdd)
>> +{
>> +       struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
>> +
>> +       wdt->ctrl &= ~WDT_CTRL_ENABLE;
>> +       writel(wdt->ctrl, wdt->base + WDT_CTRL);
>> +
>> +       return 0;
>> +}
>> +
>> +static int aspeed_wdt_ping(struct watchdog_device *wdd)
>> +{
>> +       struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
>> +
>> +       dev_dbg(wdd->parent, "ping\n");
>> +       writel(WDT_RESTART_MAGIC, wdt->base + WDT_RESTART);
>> +       return 0;
>> +}
>> +
>> +static int aspeed_wdt_set_timeout(struct watchdog_device *wdd,
>> +                                 unsigned int timeout)
>> +{
>> +       dev_dbg(wdd->parent, "timeout set to %u\n", timeout);
>> +       wdd->timeout = timeout;
>> +
>> +       return aspeed_wdt_start(wdd);
>> +}
>> +
>> +static int aspeed_wdt_restart(struct watchdog_device *wdd,
>> +                             unsigned long action, void *data)
>> +{
>> +       struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
>> +
>> +       aspeed_wdt_enable(wdt, 128 * wdt->rate / 1000);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct watchdog_ops aspeed_wdt_ops = {
>> +       .start          = aspeed_wdt_start,
>> +       .stop           = aspeed_wdt_stop,
>> +       .ping           = aspeed_wdt_ping,
>> +       .set_timeout    = aspeed_wdt_set_timeout,
>> +       .restart        = aspeed_wdt_restart,
>> +       .owner          = THIS_MODULE,
>> +};
>> +
>> +static const struct watchdog_info aspeed_wdt_info = {
>> +       .options        = WDIOF_KEEPALIVEPING
>> +                       | WDIOF_MAGICCLOSE
>> +                       | WDIOF_SETTIMEOUT,
>> +       .identity       = KBUILD_MODNAME,
>> +};
>> +
>> +static int aspeed_wdt_remove(struct platform_device *pdev)
>> +{
>> +       struct aspeed_wdt *wdt = platform_get_drvdata(pdev);
>> +
>> +       watchdog_unregister_device(&wdt->wdd);
>> +
>> +       return 0;
>> +}
>> +
>> +static int aspeed_wdt_probe(struct platform_device *pdev)
>> +{
>> +       struct aspeed_wdt *wdt;
>> +       struct resource *res;
>> +       int ret;
>> +
>> +       wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>> +       if (!wdt)
>> +               return -ENOMEM;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       wdt->base = devm_ioremap_resource(&pdev->dev, res);
>> +       if (IS_ERR(wdt->base))
>> +               return PTR_ERR(wdt->base);
>> +
>> +       /*
>> +        * The ast2400 wdt can run at PCLK, or 1MHz. The ast2500 only
>> +        * runs at 1MHz. We chose to always run at 1MHz, as there's no
>> +        * good reason to have a faster watchdog counter.
>> +        */
>> +       wdt->rate = 1000000;
>
>
> Why not just use a define ?

I will add one.

The comment is informative though for people who read the ast2400
datasheet and wonder why we don't provide the option clocking with
pclk, I will leave it in.

>> +       wdt->wdd.info = &aspeed_wdt_info;
>> +       wdt->wdd.ops = &aspeed_wdt_ops;
>> +       wdt->wdd.min_timeout = 1;
>> +       wdt->wdd.max_timeout = 0x10000000U / wdt->rate;
>> +       wdt->wdd.parent = &pdev->dev;
>> +
>> +       wdt->wdd.timeout = min(wdt->wdd.max_timeout, 30U);
>
>
> Pretty much the same here. Since max_timeout is a constant,
> it is well known that it is larger than 30 seconds.
> Might as well use defines for max_timeout and timeout.

Ok.

>
>> +       watchdog_init_timeout(&wdt->wdd, 0, &pdev->dev);
>> +
>> +       wdt->ctrl = WDT_CTRL_RESET_MODE_SOC |
>
>
> Only reset tha SoC ? Are you sure this is what you want ?

I think this is left over from experiments when tracking down a reset
bug in u-boot. I will confirm and change it back to FULL_CHIP.

>
>> +               WDT_CTRL_1MHZ_CLK |
>> +               WDT_CTRL_RESET_SYSTEM;
>> +
>> +       /* Ensure hardware is in consistent state */
>> +       aspeed_wdt_stop(&wdt->wdd);
>> +
>
> An alternative might be to check if the watchdog is running, and inform
> the watchdog core about it so it can generate heartbeats as required
> until user space opens the watchdog device. This would ensure that the
> system is protected during boot.

I will implement this.

> ctrl is really static except for the enable flag. Not really sure
> if having a variable for it has any real benefits - you might as well
> just read the register and update the enable flag instead as needed when
> starting or stopping the watchdog. Is there a reason for not doing that ?

Not really. I find it cleaner to keep a copy of the register instead
of read-modify-write, but if you feel strongly about it I can change.

>
>> +       ret = watchdog_register_device(&wdt->wdd);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "failed to register\n");
>> +               goto err;
>
>
> Unnecessary goto. Just return.

Ok.

>
>
>> +       }
>> +
>> +       dev_info(&pdev->dev, "rate %lu, max timeout %u, timeout %d\n",
>> +                wdt->rate, wdt->wdd.max_timeout, wdt->wdd.timeout);
>> +
>> +       platform_set_drvdata(pdev, wdt);
>> +err:
>> +       return ret;
>> +}
>> +
>> +static struct platform_driver aspeed_watchdog_driver = {
>> +       .probe = aspeed_wdt_probe,
>> +       .remove = aspeed_wdt_remove,
>> +       .driver = {
>> +               .name = KBUILD_MODNAME,
>> +               .of_match_table = of_match_ptr(aspeed_wdt_of_table),
>> +       },
>> +};
>> +module_platform_driver(aspeed_watchdog_driver);
>> +
>> +MODULE_DESCRIPTION("Aspeed Watchdog Driver");
>> +MODULE_LICENSE("GPL");
>>
>
