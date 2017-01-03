Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35004 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752738AbdACWiO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 3 Jan 2017 17:38:14 -0500
MIME-Version: 1.0
In-Reply-To: <1483454364-28650-4-git-send-email-linux@roeck-us.net>
References: <1483454364-28650-1-git-send-email-linux@roeck-us.net> <1483454364-28650-4-git-send-email-linux@roeck-us.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Jan 2017 00:38:03 +0200
Message-ID: <CAHp75VdfeBsuM1o_k5mEk8tnPT-gzRV_jQ5RnHONXpDZYd=4iA@mail.gmail.com>
Subject: Re: [PATCH 4/4] watchdog: iTCO_wdt: Simplify module init function
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matt Fleming <matt.fleming@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 3, 2017 at 4:39 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> The 'ret' variable in iTCO_wdt_init_module() does not add any value;
> drop it.

Perhaps 'err', otherwise:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/iTCO_wdt.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index ad29ae03a30b..fc7712112412 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -612,15 +612,9 @@ static struct platform_driver iTCO_wdt_driver = {
>
>  static int __init iTCO_wdt_init_module(void)
>  {
> -       int err;
> -
>         pr_info("Intel TCO WatchDog Timer Driver v%s\n", DRV_VERSION);
>
> -       err = platform_driver_register(&iTCO_wdt_driver);
> -       if (err)
> -               return err;
> -
> -       return 0;
> +       return platform_driver_register(&iTCO_wdt_driver);
>  }
>
>  static void __exit iTCO_wdt_cleanup_module(void)
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
