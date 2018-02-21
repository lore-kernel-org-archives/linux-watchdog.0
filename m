Return-Path: <yamada.masahiro@socionext.com>
Return-path: <yamada.masahiro@socionext.com>
MIME-Version: 1.0
In-Reply-To: <20180210203623.17832-1-marcus.folkesson@gmail.com>
References: <20180210203623.17832-1-marcus.folkesson@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 21 Feb 2018 10:29:38 +0900
Message-ID: <CAK7LNAT2T5UHgx_iyui43=GMTTYam0bk6FViD_cdpoRSkq3y+A@mail.gmail.com>
Subject: Re: [PATCH 1/4] watchdog: uniphier: change order for setting default timeout
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

2018-02-11 5:36 GMT+09:00 Marcus Folkesson <marcus.folkesson@gmail.com>:
> watchdog_init_timeout() will preserve wdd->timeout value if no parameter
> nor timeout-secs dt property is set.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/watchdog/uniphier_wdt.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/watchdog/uniphier_wdt.c b/drivers/watchdog/uniphier_wdt.c
> index 0ea2339d9702..0e4f8d53ce3c 100644
> --- a/drivers/watchdog/uniphier_wdt.c
> +++ b/drivers/watchdog/uniphier_wdt.c
> @@ -212,11 +212,10 @@ static int uniphier_wdt_probe(struct platform_device *pdev)
>         wdev->wdt_dev.ops = &uniphier_wdt_ops;
>         wdev->wdt_dev.max_timeout = WDT_PERIOD_MAX;
>         wdev->wdt_dev.min_timeout = WDT_PERIOD_MIN;
> +       wdev->wdt_dev.timeout = WDT_DEFAULT_TIMEOUT;
>         wdev->wdt_dev.parent = dev;
>
> -       if (watchdog_init_timeout(&wdev->wdt_dev, timeout, dev) < 0) {
> -               wdev->wdt_dev.timeout = WDT_DEFAULT_TIMEOUT;
> -       }
> +       watchdog_init_timeout(&wdev->wdt_dev, timeout, dev);
>         watchdog_set_nowayout(&wdev->wdt_dev, nowayout);
>         watchdog_stop_on_reboot(&wdev->wdt_dev);
>
> --
> 2.15.1
>

I am pasting Acked-by from the author here just in case.

Acked-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>


You can see his original tag here.
https://www.spinics.net/lists/linux-watchdog/msg13513.html



-- 
Best Regards
Masahiro Yamada
