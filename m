Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38516 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbbAXQ6d (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 24 Jan 2015 11:58:33 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YF42Z-001yIw-8D
	for linux-watchdog@vger.kernel.org; Sat, 24 Jan 2015 16:58:32 +0000
Message-ID: <54C3CF23.5040404@roeck-us.net>
Date: Sat, 24 Jan 2015 08:58:11 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH V2] watchdog: bcm47xx_wdt.c: add restart handler support
References: <1422107244-32097-1-git-send-email-zajec5@gmail.com>	<1422107918-8043-1-git-send-email-zajec5@gmail.com>	<54C3C950.3060001@roeck-us.net> <CACna6rzT7uPONFAh=utv3r+JyJ3r1-NanmyPF4joERt+X+Rqog@mail.gmail.com>
In-Reply-To: <CACna6rzT7uPONFAh=utv3r+JyJ3r1-NanmyPF4joERt+X+Rqog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/24/2015 08:48 AM, Rafał Miłecki wrote:
> On 24 January 2015 at 17:33, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 01/24/2015 05:58 AM, Rafał Miłecki wrote:
>>>
>>> Just like in case of other watchdog drivers, use the new kernel core
>>> API to provide restart support.
>>>
>>> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>>> ---
>>> V2: Include changes to include/linux/bcm47xx_wdt.h
>>> ---
>>>    drivers/watchdog/bcm47xx_wdt.c | 22 ++++++++++++++++++++--
>>>    include/linux/bcm47xx_wdt.h    |  1 +
>>>    2 files changed, 21 insertions(+), 2 deletions(-)
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
>>
>>
>> Unnecessary whitespace change.
>
> I changed it to improve code readability. Now you have two seprated
> code blocks. First one setups notification and registers it. Second
> setups handler and registers it.
>

That is not how it works; this is a logically separate change,
which should be submitted as separate patch if at all.

Keep in mind though that this is a personal preference; if we accept
this change, someone else may come along tomorrow asking to change it
back "to improve readability by removing unnecessary empty lines".
Normally I would leave that alone unless you get a checkpatch
warning or error, and even then it is advisable to know the maintainer's
position on accepting coding style changes.

Thanks,
Guenter

