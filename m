Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:45326 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751585AbbEDF7J (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 May 2015 01:59:09 -0400
Message-ID: <55470AA7.9050605@offcode.fi>
Date: Mon, 04 May 2015 08:59:03 +0300
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com,
	Wenyou.Yang@atmel.com
Subject: Re: [PATCHv7 8/8] watchdog: omap_wdt: Convert to use new core extensions
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi> <1429701102-22320-9-git-send-email-timo.kokkonen@offcode.fi> <20150503185601.GD25193@pengutronix.de>
In-Reply-To: <20150503185601.GD25193@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi, 03.05.2015 21:56, Uwe Kleine-König wrote:
> Hello,
>
> On Wed, Apr 22, 2015 at 02:11:42PM +0300, Timo Kokkonen wrote:
>> Use the new watchdog core extensions to let watchdog core take over
>> boot time watchdog behavior. The difference is that early-timeout-sec
>> device tree property becomes available for this driver and a running
>> watchdog is not stopped unless the core decides to stop it.
>>
>> Omap watchdog is running by default in the boot up but bootloader
>> might have stopped it. Therefore we fill the WDOG_HW_RUNNING_AT_BOOT
>> bit depending on the actual watchdog state so that the watchdog core
>> can act properly.
>>
>> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
>> ---
>>   drivers/watchdog/omap_wdt.c | 28 +++++++++++++++++++++++++++-
>>   1 file changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
>> index bbaf39a..7164f2e 100644
>> --- a/drivers/watchdog/omap_wdt.c
>> +++ b/drivers/watchdog/omap_wdt.c
>> @@ -78,6 +78,13 @@ static void omap_wdt_reload(struct omap_wdt_dev *wdev)
>>   	/* reloaded WCRR from WLDR */
>>   }
>>
>> +static int omap_wdt_is_running(struct omap_wdt_dev *wdev)
>> +{
>> +	void __iomem *base = wdev->base;
>> +
>> +	return readl_relaxed(base + OMAP_WATCHDOG_SPR) == 0x4444;
>> +}
> This isn't reliable. The sequence needed to enable the watchdog is
> 	writel(0xbbbb, base + OMAP_WATCHDOG_SPR);
> 	writel(0x4444, base + OMAP_WATCHDOG_SPR);
>
> The sequence to stop is:
> 	writel(0xaaaa, base + OMAP_WATCHDOG_SPR);
> 	writel(0x5555, base + OMAP_WATCHDOG_SPR);
>
> But:
>
> barebox@TI AM335x BeagleBone black:/ md 0x44e35048+4
> 44e35048: 00005555                                           UU..
> barebox@TI AM335x BeagleBone black:/ mw 0x44e35048 0x4444
> barebox@TI AM335x BeagleBone black:/ md 0x44e35048+4
> 44e35048: 00004444                                           DD..
>
> So the register contains 0x4444 but the timer doesn't run. So at best
> testing for 0x4444 is a good heuristic.

Yeah.. I don't think we can get any better than that. Unless we start 
checking the counter register and see whether it really counts or not, 
and I think that's a bit overkill.. So I'd say we should be safe when 
assuming bootloader is doing things correctly. Although, we could add a 
comment to the code that the test may not be 100% reliable in case the 
start sequence have not been issued properly.

Thanks for pointing this out!

-Timo

