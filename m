Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:35167 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932131AbdDDPru (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Apr 2017 11:47:50 -0400
MIME-Version: 1.0
In-Reply-To: <20170404141048.16828-1-andrew.smirnov@gmail.com>
References: <20170404141048.16828-1-andrew.smirnov@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Apr 2017 18:47:44 +0300
Message-ID: <CAHp75VfeNMQNwdW0VYmAYic6RgV3nUXO8r7URPxiqWW16HzS4w@mail.gmail.com>
Subject: Re: [PATCH] watchdog: core: Make use of devm_register_reboot_notifier()
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-watchdog@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Apr 4, 2017 at 5:10 PM, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> Save a bit of cleanup code by leveraging newly added
> devm_register_reboot_notifier().

> @@ -247,7 +247,8 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
>         if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status)) {
>                 wdd->reboot_nb.notifier_call = watchdog_reboot_notifier;
>
> -               ret = register_reboot_notifier(&wdd->reboot_nb);

> +               ret = devm_register_reboot_notifier(wdd->parent,
> +                                                   &wdd->reboot_nb);

I'm not sure it's logically correct. Perhaps binding to the actual
watchdog device would be better.
Though, Guenter can correct me.

Could it be one line after all?

>                 if (ret) {
>                         pr_err("watchdog%d: Cannot register reboot notifier (%d)\n",
>                                wdd->id, ret);
> @@ -302,9 +303,6 @@ static void __watchdog_unregister_device(struct watchdog_device *wdd)
>         if (wdd->ops->restart)
>                 unregister_restart_handler(&wdd->restart_nb);
>
> -       if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status))
> -               unregister_reboot_notifier(&wdd->reboot_nb);
> -

-- 
With Best Regards,
Andy Shevchenko
