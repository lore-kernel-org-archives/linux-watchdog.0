Return-path: <andy.shevchenko@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1484091325-9199-24-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net> <1484091325-9199-24-git-send-email-linux@roeck-us.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 12 Jan 2017 01:36:15 +0200
Message-ID: <CAHp75VfBJs4ZYMxiZU=-Uqdiu-3X_8ck3G8YysCOiYss4J1qpA@mail.gmail.com>
Subject: Re: [PATCH 23/62] watchdog: intel-mid_wdt: Convert to use device
 managed functions
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Jan 11, 2017 at 1:34 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> Use device managed functions to simplify error handling, reduce
> source code size, improve readability, and reduce the likelyhood of bugs.
>
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts used
> to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
>
> - Drop assignments to otherwise unused variables
> - Drop remove function
> - Drop platform_set_drvdata()
> - Use devm_watchdog_register_driver() to register watchdog device

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/intel-mid_wdt.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
> index a4b729259b12..45e4d02221b5 100644
> --- a/drivers/watchdog/intel-mid_wdt.c
> +++ b/drivers/watchdog/intel-mid_wdt.c
> @@ -137,7 +137,6 @@ static int mid_wdt_probe(struct platform_device *pdev)
>         wdt_dev->parent = &pdev->dev;
>
>         watchdog_set_drvdata(wdt_dev, &pdev->dev);
> -       platform_set_drvdata(pdev, wdt_dev);
>
>         ret = devm_request_irq(&pdev->dev, pdata->irq, mid_wdt_irq,
>                                IRQF_SHARED | IRQF_NO_SUSPEND, "watchdog",
> @@ -151,7 +150,7 @@ static int mid_wdt_probe(struct platform_device *pdev)
>         /* Make sure the watchdog is not running */
>         wdt_stop(wdt_dev);
>
> -       ret = watchdog_register_device(wdt_dev);
> +       ret = devm_watchdog_register_device(&pdev->dev, wdt_dev);
>         if (ret) {
>                 dev_err(&pdev->dev, "error registering watchdog device\n");
>                 return ret;
> @@ -162,16 +161,8 @@ static int mid_wdt_probe(struct platform_device *pdev)
>         return 0;
>  }
>
> -static int mid_wdt_remove(struct platform_device *pdev)
> -{
> -       struct watchdog_device *wd = platform_get_drvdata(pdev);
> -       watchdog_unregister_device(wd);
> -       return 0;
> -}
> -
>  static struct platform_driver mid_wdt_driver = {
>         .probe          = mid_wdt_probe,
> -       .remove         = mid_wdt_remove,
>         .driver         = {
>                 .name   = "intel_mid_wdt",
>         },
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
