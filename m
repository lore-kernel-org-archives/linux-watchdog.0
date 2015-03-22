Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59267 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbbCVTAQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 22 Mar 2015 15:00:16 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YZl6c-001Cmf-Rg
	for linux-watchdog@vger.kernel.org; Sun, 22 Mar 2015 19:00:15 +0000
Message-ID: <550F111F.9060400@roeck-us.net>
Date: Sun, 22 Mar 2015 11:59:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Baruch Siach <baruch@tkos.co.il>
CC: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] watchdog: digicolor: driver for Conexant Digicolor
 CX92755 SoC
References: <6bc6e867b500cd3cfc629b96f90442f5c0aced3a.1427028036.git.baruch@tkos.co.il> <409ece75204d3911dc526a9bc0c908fc30893b26.1427028036.git.baruch@tkos.co.il> <550EF4DA.6040407@roeck-us.net> <20150322180857.GI2825@tarshish>
In-Reply-To: <20150322180857.GI2825@tarshish>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/22/2015 11:08 AM, Baruch Siach wrote:
> Hi Guenter,
>
> On Sun, Mar 22, 2015 at 09:59:06AM -0700, Guenter Roeck wrote:
>> On 03/22/2015 05:40 AM, Baruch Siach wrote:
>>> This commit add a driver for the watchdog functionality of the Conexant CX92755
>>> SoC, from the Digicolor series of SoCs. Of 8 system timers provided by the
>>> CX92755, the first one, timer A, can reset the chip when its counter reaches
>>> zero. This driver uses this capability to provide userspace with a standard
>>> watchdog, using the watchdog timer driver core framework. This driver also
>>> implements a reboot handler for the reboot(2) system call.
>>>
>>> The watchdog driver shares the timer registers with the CX92755 timer driver
>>> (drivers/clocksource/timer-digicolor.c). The timer driver, however, uses only
>>> timers other than A, so both drivers should coexist.
>>>
>>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>>
>> Looks pretty good. Couple of comments below.
>
> Thanks. Please see my responses below.
>
>>>   drivers/watchdog/Kconfig         |  10 ++
>>>   drivers/watchdog/Makefile        |   1 +
>>>   drivers/watchdog/digicolor_wdt.c | 203 +++++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 214 insertions(+)
>>>   create mode 100644 drivers/watchdog/digicolor_wdt.c
>>>
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>> index 16f202350997..7d73d6c78cf6 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -515,6 +515,16 @@ config MEDIATEK_WATCHDOG
>>>   	  To compile this driver as a module, choose M here: the
>>>   	  module will be called mtk_wdt.
>>>
>>> +config DIGICOLOR_WATCHDOG
>>> +	tristate "Conexant Digicolor SoCs watchdog support"
>>> +	depends on ARCH_DIGICOLOR
>>> +	select WATCHDOG_CORE
>>
>> This doesn't (directly) depend on HAVE_CLK, meaning clk_get can return NULL
>> if HAVE_CLK is not configured. Can that happen ?
>
> ARCH_DIGICOLOR depends on ARCH_MULTI_V7 which depends on ARCH_MULTIPLATFORM,
> which in turn selects COMMON_CLK. So using the clk API should be safe.
>
> [...]
>
>>> +#define DC_WDT_DEFAULT_TIME	5
>>
>> Five seconds is an extremely low default timeout. More common would be
>> 30 or 60 seconds. Any special reason for selecting this default ?
>
> I copied this value from an old Conexant provided watchdog driver, so I
> thought it should be a safe default. In fact, the RTC timer is clocked at
> 200MHz by default, and since the counter is only 32bit wide, we can't set
> timeout much longer than 20 seconds anyway.
>
That really depends on the application, user space load, and watchdogd
application configuration.

You declare that since someone else is doing it in a different watchdog
driver, it is safe to do it here. This is not really a good argument.

Remember we are talking about the default setting here, not about some
target specific setting. I would have thought that the default setting
would be on the relaxed side of the timeout (probably actually the
maximum if the maximum is in the 20 seconds range), not a low limit.
After all, it is always possible to overwrite a relaxed value with a
stricter one. Overwriting a strict value with a more relaxed one may
be more difficult if the application handling the watchdog doesn't
start in time to prevent the first timeout from happening.

Anyway, I am fine if you think that 5 seconds is ok; that is really
your call to make. But I really think your logic should be a bit better
than "someone else is doing it as well".

> [...]
>
>>> +static int dc_wdt_start(struct watchdog_device *wdog)
>>> +{
>>> +	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
>>> +	unsigned long flags;
>>> +
>>> +	spin_lock_irqsave(&wdt->lock, flags);
>>> +
>>> +	writel_relaxed(0, wdt->base + TIMER_A_CONTROL);
>>> +	writel_relaxed(wdog->timeout * clk_get_rate(wdt->clk),
>>> +		       wdt->base + TIMER_A_COUNT);
>>> +	writel_relaxed(TIMER_A_ENABLE_COUNT | TIMER_A_ENABLE_WATCHDOG,
>>> +		       wdt->base + TIMER_A_CONTROL);
>>> +
>>> +	spin_unlock_irqrestore(&wdt->lock, flags);
>>> +
>> You have this sequence twice, so a little helper function taking
>> wdt and the timeout as parameters might be useful.
>
> Right. Will do.
>
>>> +	return 0;
>>> +}
>>> +
>>> +static int dc_wdt_stop(struct watchdog_device *wdog)
>>> +{
>>> +	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
>>> +
>>> +	writel_relaxed(0, wdt->base + TIMER_A_CONTROL);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int dc_wdt_set_timeout(struct watchdog_device *wdog, unsigned int t)
>>> +{
>>> +	wdog->timeout = t;
>>> +
>> No updating the timer count register ?
>>
>> If you increase the timeout significantly, the next ping may come too late.
>
> Some other drivers are doing the same (e.g. bcm2835_wdt, orion_wdt). Are they
> buggy? Will fix, anyway.
>

I always like that kind of argument ;-). Others do it, therefore I can do it as well.

Why don't you give it a try.

Here is the logic: Say, you increase the timeout from 5 seconds to 20 seconds.
User space now believes it has to ping the watchdog every 10 seconds or so.
However, you did not update the HW timeout immediately, meaning the watchdog will
time out no later than 5 seconds after the timeout change, even thought the timeout
is now supposed to be 20 seconds. If user space does not ping the watchdog immediately
after changing the timeout, but starts using the 10-second ping schedule, you may
have a problem.

Sure, you can declare that you expect user space to ping the watchdog immediately
after changing the timeout, but that does not necessarily happen just because
you expect it to happen.

>>> +	return 0;
>>> +}
>>> +
>>> +static unsigned int dc_wdt_get_timeleft(struct watchdog_device *wdog)
>>> +{
>>> +	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
>>> +	uint32_t count = readl_relaxed(wdt->base + TIMER_A_COUNT);
>>> +
>>> +	return (count / clk_get_rate(wdt->clk));
>>> +}
>>> +
>>> +static struct watchdog_ops dc_wdt_ops = {
>>> +	.owner		= THIS_MODULE,
>>> +	.start		= dc_wdt_start,
>>> +	.stop		= dc_wdt_stop,
>>
>> Since you don't have a ping function, each ping will stop the watchdog,
>> update the timer, and restart it. Is this intentional ?
>
> No. Just copied other drivers. I guess I can set .ping to dc_wdt_start as
> well.
>
That would be pretty pointless, since the watchdog core calls the start
function if no ping function is available.

Other hardware may mandate the sequence (turn off watchdog, set timer,
turn on watchdog). Other driver developers may have used the sequence
for convenience. That doesn't mean that this watchdog driver should use
the same sequence or logic just because others do it.

Specific problem: Assume your system hangs itself hard just after the
watchdog is disabled, due to some other CPU core doing something really
bad. Oops ... no more watchdog, system is dead.

Sure, this may be the mandated sequence on this architecture. That would be
bad enough, since it leaves the system unprotected for a couple of instructions
every few seconds. That doesn't mean it should be the default behavior,
though, if the sequence is _not_ mandated by the hardware.

So, if your argument was that the hardware mandates the sequence, fine,
nothing we can do about it. Yet, your argument is that you do it because
others do it. Think about it.

> [...]
>
>>> +static int dc_wdt_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device *dev = &pdev->dev;
>>> +	struct device_node *np = dev->of_node;
>>> +	struct dc_wdt *wdt;
>>> +	int ret;
>>> +
>>> +	wdt = devm_kzalloc(dev, sizeof(struct dc_wdt), GFP_KERNEL);
>>> +	if (!wdt)
>>> +		return -ENOMEM;
>>> +	platform_set_drvdata(pdev, wdt);
>>> +
>>> +	wdt->base = of_iomap(np, 0);
>>> +	if (!wdt->base) {
>>> +		dev_err(dev, "Failed to remap watchdog regs");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	wdt->clk = clk_get(&pdev->dev, NULL);
>>> +	if (IS_ERR(wdt->clk))
>>> +		return PTR_ERR(wdt->clk);
>>
>> iounmap missing.
>
> Will fix.
>
>>> +	dc_wdt_wdd.max_timeout = U32_MAX / clk_get_rate(wdt->clk);
>>> +
>>> +	spin_lock_init(&wdt->lock);
>>> +
>>> +	watchdog_set_drvdata(&dc_wdt_wdd, wdt);
>>> +	watchdog_init_timeout(&dc_wdt_wdd, timeout, dev);
>>> +	ret = watchdog_register_device(&dc_wdt_wdd);
>>> +	if (ret) {
>>> +		dev_err(dev, "Failed to register watchdog device");
>>> +		iounmap(wdt->base);
>>
>> I don't see clk_put in any of the error cases. How about using devm_clk_get above ?
>
> Will fix.
>
>>
>>> +		return ret;
>>> +	}
>>> +
>>> +	wdt->restart_handler.notifier_call = dc_restart_handler;
>>> +	wdt->restart_handler.priority = 128;
>>
>> Is 128 intentional, ie is this the expected reset method for this platform ?
>> If not, it may be better to select a lower priority (eg 64). Using a watchdog
>> to reset a system should in general be a method of last resort.
>
> Copied this value from imx2_wdt. grep indicates that almost all other watchdog
> drivers implementing restart_handler use priority of 128 (except bcm47xx_wdt).
> What is the policy here?
>

The policy is to do what is sensible for the platform. That can only be decided
on a case-by-case basis. The documentation suggests to use 128 for "Default restart
handler; use if no other restart handler is expected to be available, and/or if
restart functionality is sufficient to restart the entire system".

So if this is the only means expected to be available to reset the system
for this architecture/platform, and if the watchdog resets the entire system
(not just the CPU), 128 may be ok to use. If, however, there may be other
means to reset the system, such as a GPIO pin, maybe not.

Thanks,
Guenter

