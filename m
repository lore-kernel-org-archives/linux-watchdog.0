Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38126 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbbAXQy0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 24 Jan 2015 11:54:26 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YF3yc-001wsS-7c
	for linux-watchdog@vger.kernel.org; Sat, 24 Jan 2015 16:54:26 +0000
Message-ID: <54C3CE2C.1000107@roeck-us.net>
Date: Sat, 24 Jan 2015 08:54:04 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH] watchdog: bcm47xx_wdt.c: add restart handler support
References: <1422107244-32097-1-git-send-email-zajec5@gmail.com>	<54C3C90B.1060503@roeck-us.net> <CACna6rwZN0XcdhCcUMef-=awk_FUG+z7LWt5t2xsLT5L6ddT4A@mail.gmail.com>
In-Reply-To: <CACna6rwZN0XcdhCcUMef-=awk_FUG+z7LWt5t2xsLT5L6ddT4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/24/2015 08:45 AM, Rafał Miłecki wrote:
> On 24 January 2015 at 17:32, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 01/24/2015 05:47 AM, Rafał Miłecki wrote:
>>>
>>> Just like in case of other watchdog drivers, use the new kernel core
>>> API to provide restart support.
>>>
>>> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>>> ---
>>>    drivers/watchdog/bcm47xx_wdt.c | 22 ++++++++++++++++++++--
>>>    1 file changed, 20 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/bcm47xx_wdt.c
>>> b/drivers/watchdog/bcm47xx_wdt.c
>>> index 9816485..dac3c5d 100644
>>> --- a/drivers/watchdog/bcm47xx_wdt.c
>>> +++ b/drivers/watchdog/bcm47xx_wdt.c
>>> @@ -169,6 +169,17 @@ static int bcm47xx_wdt_notify_sys(struct
>>> notifier_block *this,
>>>          return NOTIFY_DONE;
>>>    }
>>>
>>> +static int bcm47xx_wdt_restart(struct notifier_block *this, unsigned long
>>> mode,
>>> +                              void *cmd)
>>> +{
>>> +       struct bcm47xx_wdt *wdt;
>>> +
>>> +       wdt = container_of(this, struct bcm47xx_wdt, restart_handler);
>>> +       wdt->timer_set(wdt, 1);
>>> +
>>> +       return NOTIFY_DONE;
>>> +}
>>> +
>>>    static struct watchdog_ops bcm47xx_wdt_soft_ops = {
>>>          .owner          = THIS_MODULE,
>>>          .start          = bcm47xx_wdt_soft_start,
>>> @@ -204,20 +215,27 @@ static int bcm47xx_wdt_probe(struct platform_device
>>> *pdev)
>>>          watchdog_set_nowayout(&wdt->wdd, nowayout);
>>>
>>>          wdt->notifier.notifier_call = &bcm47xx_wdt_notify_sys;
>>> -
>>>          ret = register_reboot_notifier(&wdt->notifier);
>>>          if (ret)
>>>                  goto err_timer;
>>>
>>> -       ret = watchdog_register_device(&wdt->wdd);
>>> +       wdt->restart_handler.notifier_call = &bcm47xx_wdt_restart;
>>> +       wdt->restart_handler.priority = 128;
>>
>>
>> This should be low priority since it doesn't immediately restart the system
>> but uses a watchdog timeout.
>
> I think this is also the only way to reboot Broadcom device. Is there
> some howto on values I should use? Should I change it to sth like 64?
> Or what number?
>

64 is fine.

You never know if someone using that chip implements, for example, reset
with a gpio pin.

Guenter

