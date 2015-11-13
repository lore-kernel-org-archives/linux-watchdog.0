Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:34073 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932444AbbKMQxq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Nov 2015 11:53:46 -0500
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [RESEND][PATCH] watchdog: add support for Sigma Designs SMP86xx
References: <1447420459-5301-1-git-send-email-mans@mansr.com>
	<56461155.80808@roeck-us.net>
Date: Fri, 13 Nov 2015 16:53:37 +0000
In-Reply-To: <56461155.80808@roeck-us.net> (Guenter Roeck's message of "Fri,
	13 Nov 2015 08:35:33 -0800")
Message-ID: <yw1x37w9lu26.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:

> On 11/13/2015 05:14 AM, Mans Rullgard wrote:
>> This adds support for the Sigma Designs SMP86xx family built-in
>> watchdog.
>>
>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>> ---
>>   drivers/watchdog/Kconfig      |   7 ++
>>   drivers/watchdog/Makefile     |   1 +
>>   drivers/watchdog/tangox_wdt.c | 185 ++++++++++++++++++++++++++++++++++++++++++
>
> Why tangox_wdt instead of smp86xx_wdt.c ?
>
> tangox also implies that this would (should) work for SMP87xx as well,
> about which no statement is made. So why not tango3_wdt ?
>
> [ ok, I see all drivers are named tangox, so if the other maintainers
>   are ok with that, so am I. ]
>
> Is it known if the driver will work for any of the other chips of the
> series (SMP86XX/SMP87XX) ?

It does work on SMP87xx (tango4) as well.  I wrote the driver before I
had any such hardware, then forgot to update the help text and commit
message.

> I think it would be helpful to describe in more detail which chips
> are supported, or at least which chips should work but are untested.
>
>>   3 files changed, 193 insertions(+)
>>   create mode 100644 drivers/watchdog/tangox_wdt.c
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 79e1aa1..0ed5ee8 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -1337,6 +1337,13 @@ config RALINK_WDT
>>   	help
>>   	  Hardware driver for the Ralink SoC Watchdog Timer.
>>
>> +config TANGOX_WDT
>> +	tristate "SMP86xx watchdog"
>> +	select WATCHDOG_CORE
>> +	depends on ARCH_TANGOX
>> +	help
>> +	  Watchdog driver for Sigma Designs SMP86xx.
>
> Not really; it is for SMP8642, and we don't know if other (later ?) chips
> will be supported by the same driver. You should be explicit here. More chips
> can be added later (that would be needed for the devicetree bindings anyway)
> as they are tested.

I have tested it on SMP8642 and SMP8759.  The documentation for SMP8654
agrees.

>> +static int tangox_wdt_set_timeout(struct watchdog_device *wdt,
>> +				  unsigned int new_timeout)
>> +{
>> +	struct tangox_wdt_device *dev = watchdog_get_drvdata(wdt);
>> +
>> +	wdt->timeout = new_timeout;
>> +	dev->timeout = 1 + new_timeout * clk_get_rate(dev->clk);
>
> Why "1 +" ?

The counter counts down from the loaded value and asserts the reset pin
when it reaches 1.  Setting it to zero disables the watchdog.

>> +static int tangox_wdt_restart(struct notifier_block *nb, unsigned long action,
>> +			      void *data)
>> +{
>> +	struct tangox_wdt_device *dev =
>> +		container_of(nb, struct tangox_wdt_device, restart);
>> +
>> +	writel(1, dev->base + WD_COUNTER);
>> +
>
> A comment might be useful here, explaining what this does (reset after minimum timeout ?).
> Also, the code should wait a bit to ensure that the reset 'catches'
> before the function returns.

Writing 1 to the counter asserts the reset immediately.

>> +static const struct of_device_id tangox_wdt_dt_ids[] = {
>> +	{ .compatible = "sigma,smp8642-wdt" },
>
> So this is really for smp8642 only, not for any other chips in the series ?

It's for about a dozen SMP86xx, SMP87xx, and SMP89xx chips.  Should I
list them all?  I don't even know where to find a comprehensive list of
device numbers.

-- 
Måns Rullgård
mans@mansr.com
