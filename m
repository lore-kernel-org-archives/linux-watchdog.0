Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:46032 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbbAXQsD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 24 Jan 2015 11:48:03 -0500
Received: by mail-la0-f43.google.com with SMTP id q1so2200902lam.2
        for <linux-watchdog@vger.kernel.org>; Sat, 24 Jan 2015 08:48:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54C3C950.3060001@roeck-us.net>
References: <1422107244-32097-1-git-send-email-zajec5@gmail.com>
	<1422107918-8043-1-git-send-email-zajec5@gmail.com>
	<54C3C950.3060001@roeck-us.net>
Date: Sat, 24 Jan 2015 17:48:01 +0100
Message-ID: <CACna6rzT7uPONFAh=utv3r+JyJ3r1-NanmyPF4joERt+X+Rqog@mail.gmail.com>
Subject: Re: [PATCH V2] watchdog: bcm47xx_wdt.c: add restart handler support
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 24 January 2015 at 17:33, Guenter Roeck <linux@roeck-us.net> wrote:
> On 01/24/2015 05:58 AM, Rafał Miłecki wrote:
>>
>> Just like in case of other watchdog drivers, use the new kernel core
>> API to provide restart support.
>>
>> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>> ---
>> V2: Include changes to include/linux/bcm47xx_wdt.h
>> ---
>>   drivers/watchdog/bcm47xx_wdt.c | 22 ++++++++++++++++++++--
>>   include/linux/bcm47xx_wdt.h    |  1 +
>>   2 files changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/watchdog/bcm47xx_wdt.c
>> b/drivers/watchdog/bcm47xx_wdt.c
>> index 9816485..dac3c5d 100644
>> --- a/drivers/watchdog/bcm47xx_wdt.c
>> +++ b/drivers/watchdog/bcm47xx_wdt.c
>> @@ -169,6 +169,17 @@ static int bcm47xx_wdt_notify_sys(struct
>> notifier_block *this,
>>         return NOTIFY_DONE;
>>   }
>>
>> +static int bcm47xx_wdt_restart(struct notifier_block *this, unsigned long
>> mode,
>> +                              void *cmd)
>> +{
>> +       struct bcm47xx_wdt *wdt;
>> +
>> +       wdt = container_of(this, struct bcm47xx_wdt, restart_handler);
>> +       wdt->timer_set(wdt, 1);
>> +
>> +       return NOTIFY_DONE;
>> +}
>> +
>>   static struct watchdog_ops bcm47xx_wdt_soft_ops = {
>>         .owner          = THIS_MODULE,
>>         .start          = bcm47xx_wdt_soft_start,
>> @@ -204,20 +215,27 @@ static int bcm47xx_wdt_probe(struct platform_device
>> *pdev)
>>         watchdog_set_nowayout(&wdt->wdd, nowayout);
>>
>>         wdt->notifier.notifier_call = &bcm47xx_wdt_notify_sys;
>> -
>
>
> Unnecessary whitespace change.

I changed it to improve code readability. Now you have two seprated
code blocks. First one setups notification and registers it. Second
setups handler and registers it.
