Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58185 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752603AbdDDQwA (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Apr 2017 12:52:00 -0400
Subject: Re: [PATCH] watchdog: core: Make use of
 devm_register_reboot_notifier()
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
References: <20170404141048.16828-1-andrew.smirnov@gmail.com>
 <CAHp75VfeNMQNwdW0VYmAYic6RgV3nUXO8r7URPxiqWW16HzS4w@mail.gmail.com>
Cc: linux-watchdog@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Andrew Morton <akpm@linux-foundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d42ffbf3-d06f-a36a-f220-eba7b88a56a3@roeck-us.net>
Date: Tue, 4 Apr 2017 09:51:57 -0700
MIME-Version: 1.0
In-Reply-To: <CAHp75VfeNMQNwdW0VYmAYic6RgV3nUXO8r7URPxiqWW16HzS4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/04/2017 08:47 AM, Andy Shevchenko wrote:
> On Tue, Apr 4, 2017 at 5:10 PM, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>> Save a bit of cleanup code by leveraging newly added
>> devm_register_reboot_notifier().
>
>> @@ -247,7 +247,8 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
>>         if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status)) {
>>                 wdd->reboot_nb.notifier_call = watchdog_reboot_notifier;
>>
>> -               ret = register_reboot_notifier(&wdd->reboot_nb);
>
>> +               ret = devm_register_reboot_notifier(wdd->parent,
>> +                                                   &wdd->reboot_nb);
>
> I'm not sure it's logically correct. Perhaps binding to the actual
> watchdog device would be better.
> Though, Guenter can correct me.
>

As mentioned in my other reply, it doesn't work since wdd->parent can be NULL.
It might be possible to move the code into watchdog_dev_register() and tie it
to the watchdog device, but I have not explored what that would require.

Guenter

> Could it be one line after all?
>
>>                 if (ret) {
>>                         pr_err("watchdog%d: Cannot register reboot notifier (%d)\n",
>>                                wdd->id, ret);
>> @@ -302,9 +303,6 @@ static void __watchdog_unregister_device(struct watchdog_device *wdd)
>>         if (wdd->ops->restart)
>>                 unregister_restart_handler(&wdd->restart_nb);
>>
>> -       if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status))
>> -               unregister_reboot_notifier(&wdd->reboot_nb);
>> -
>

