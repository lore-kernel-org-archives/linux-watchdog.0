Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43063 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932744AbbKMRz2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Nov 2015 12:55:28 -0500
Subject: Re: [RESEND][PATCH] watchdog: add support for Sigma Designs SMP86xx
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
References: <1447420459-5301-1-git-send-email-mans@mansr.com>
 <56461155.80808@roeck-us.net> <yw1x37w9lu26.fsf@unicorn.mansr.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5646240C.5070105@roeck-us.net>
Date: Fri, 13 Nov 2015 09:55:24 -0800
MIME-Version: 1.0
In-Reply-To: <yw1x37w9lu26.fsf@unicorn.mansr.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/13/2015 08:53 AM, Måns Rullgård wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
>
>> On 11/13/2015 05:14 AM, Mans Rullgard wrote:
>>> This adds support for the Sigma Designs SMP86xx family built-in
>>> watchdog.
>>>
>>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>>> ---
>>>    drivers/watchdog/Kconfig      |   7 ++
>>>    drivers/watchdog/Makefile     |   1 +
>>>    drivers/watchdog/tangox_wdt.c | 185 ++++++++++++++++++++++++++++++++++++++++++
>>
>> Why tangox_wdt instead of smp86xx_wdt.c ?
>>
>> tangox also implies that this would (should) work for SMP87xx as well,
>> about which no statement is made. So why not tango3_wdt ?
>>
>> [ ok, I see all drivers are named tangox, so if the other maintainers
>>    are ok with that, so am I. ]
>>
>> Is it known if the driver will work for any of the other chips of the
>> series (SMP86XX/SMP87XX) ?
>
> It does work on SMP87xx (tango4) as well.  I wrote the driver before I
> had any such hardware, then forgot to update the help text and commit
> message.
>
>> I think it would be helpful to describe in more detail which chips
>> are supported, or at least which chips should work but are untested.
>>
>>>    3 files changed, 193 insertions(+)
>>>    create mode 100644 drivers/watchdog/tangox_wdt.c
>>>
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>> index 79e1aa1..0ed5ee8 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -1337,6 +1337,13 @@ config RALINK_WDT
>>>    	help
>>>    	  Hardware driver for the Ralink SoC Watchdog Timer.
>>>
>>> +config TANGOX_WDT
>>> +	tristate "SMP86xx watchdog"
>>> +	select WATCHDOG_CORE
>>> +	depends on ARCH_TANGOX
>>> +	help
>>> +	  Watchdog driver for Sigma Designs SMP86xx.
>>
>> Not really; it is for SMP8642, and we don't know if other (later ?) chips
>> will be supported by the same driver. You should be explicit here. More chips
>> can be added later (that would be needed for the devicetree bindings anyway)
>> as they are tested.
>
> I have tested it on SMP8642 and SMP8759.  The documentation for SMP8654
> agrees.
>

We should have that information somewhere - maybe in the driver header.
It is very useful to know which hardware this was tested with and which
hardware is supposed to work.

>>> +static int tangox_wdt_set_timeout(struct watchdog_device *wdt,
>>> +				  unsigned int new_timeout)
>>> +{
>>> +	struct tangox_wdt_device *dev = watchdog_get_drvdata(wdt);
>>> +
>>> +	wdt->timeout = new_timeout;
>>> +	dev->timeout = 1 + new_timeout * clk_get_rate(dev->clk);
>>
>> Why "1 +" ?
>
> The counter counts down from the loaded value and asserts the reset pin
> when it reaches 1.  Setting it to zero disables the watchdog.
>

You might want to explain that somewhere. Maybe use a define, explain it there,
and use the define here and below.

>>> +static int tangox_wdt_restart(struct notifier_block *nb, unsigned long action,
>>> +			      void *data)
>>> +{
>>> +	struct tangox_wdt_device *dev =
>>> +		container_of(nb, struct tangox_wdt_device, restart);
>>> +
>>> +	writel(1, dev->base + WD_COUNTER);
>>> +
>>
>> A comment might be useful here, explaining what this does (reset after minimum timeout ?).
>> Also, the code should wait a bit to ensure that the reset 'catches'
>> before the function returns.
>
> Writing 1 to the counter asserts the reset immediately.
>
>>> +static const struct of_device_id tangox_wdt_dt_ids[] = {
>>> +	{ .compatible = "sigma,smp8642-wdt" },
>>
>> So this is really for smp8642 only, not for any other chips in the series ?
>
> It's for about a dozen SMP86xx, SMP87xx, and SMP89xx chips.  Should I
> list them all?  I don't even know where to find a comprehensive list of
> device numbers.
>
I thought so, but I am not a devicetree expert, and I see some "xx" in existing
devicetree bindings. Something to ask when you submit the bindings to the
devicetree mailing list. Either case, I think it would be either something
like "sigma,smp86xx-wdt" or a list of all of them, but not "sigma,smp8642-wdt"
to be used for all chips.

As for which chips to list, the easy answer would be to only list the IDs
for chips known to work.

Thanks,
Guenter

