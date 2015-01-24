Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:43325 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770AbbAXRem convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 24 Jan 2015 12:34:42 -0500
Received: by mail-la0-f41.google.com with SMTP id gm9so2310703lab.0
        for <linux-watchdog@vger.kernel.org>; Sat, 24 Jan 2015 09:34:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54C3D3BB.3010103@hauke-m.de>
References: <1422107244-32097-1-git-send-email-zajec5@gmail.com>
	<1422107918-8043-1-git-send-email-zajec5@gmail.com>
	<54C3D3BB.3010103@hauke-m.de>
Date: Sat, 24 Jan 2015 18:34:41 +0100
Message-ID: <CACna6rwLKdN_woa7R3zdcXpsSPOCt+iH-gwVQOtHnR=wOVbxHw@mail.gmail.com>
Subject: Re: [PATCH V2] watchdog: bcm47xx_wdt.c: add restart handler support
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 24 January 2015 at 18:17, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 01/24/2015 02:58 PM, Rafał Miłecki wrote:
>> Just like in case of other watchdog drivers, use the new kernel core
>> API to provide restart support.
>>
>> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>> ---
>> V2: Include changes to include/linux/bcm47xx_wdt.h
>> ---
>>  drivers/watchdog/bcm47xx_wdt.c | 22 ++++++++++++++++++++--
>>  include/linux/bcm47xx_wdt.h    |  1 +
>>  2 files changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
>> index 9816485..dac3c5d 100644
>> --- a/drivers/watchdog/bcm47xx_wdt.c
>> +++ b/drivers/watchdog/bcm47xx_wdt.c
>> @@ -169,6 +169,17 @@ static int bcm47xx_wdt_notify_sys(struct notifier_block *this,
>>       return NOTIFY_DONE;
>>  }
>>
>> +static int bcm47xx_wdt_restart(struct notifier_block *this, unsigned long mode,
>> +                            void *cmd)
>> +{
>> +     struct bcm47xx_wdt *wdt;
>> +
>> +     wdt = container_of(this, struct bcm47xx_wdt, restart_handler);
>> +     wdt->timer_set(wdt, 1);
>
> I assume you want to replace the restart code used in
> arch/mips/bcm47xx/setup.c and use this for restart on the arm SoCs.
>
> On BCM4705 some mips asm is needed to make the restart operation
> reliable, where do you plan to put it?

I think BCM4705 restart it so arch/hw specific, it'll have to stay in
arch/mips/ code. For all other hardware we should be able to use
do_kernel_restart (and the watchdog driver in the result).

Standard do_kernel_restart already works nicely for me when using
Broadcom ARM hardware.
