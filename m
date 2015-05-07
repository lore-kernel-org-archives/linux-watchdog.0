Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:50101 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752226AbbEGGmt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 May 2015 02:42:49 -0400
Message-ID: <554B0964.9030501@offcode.fi>
Date: Thu, 07 May 2015 09:42:44 +0300
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com,
	Wenyou.Yang@atmel.com
Subject: Re: [PATCHv7 8/8] watchdog: omap_wdt: Convert to use new core extensions
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi> <1429701102-22320-9-git-send-email-timo.kokkonen@offcode.fi> <20150503185601.GD25193@pengutronix.de> <55470AA7.9050605@offcode.fi> <20150504070452.GE25193@pengutronix.de>
In-Reply-To: <20150504070452.GE25193@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04.05.2015 10:04, Uwe Kleine-König wrote:
> Hello Timo,
>
> On Mon, May 04, 2015 at 08:59:03AM +0300, Timo Kokkonen wrote:
>> Hi, 03.05.2015 21:56, Uwe Kleine-König wrote:
>>> On Wed, Apr 22, 2015 at 02:11:42PM +0300, Timo Kokkonen wrote:
>>>> +static int omap_wdt_is_running(struct omap_wdt_dev *wdev)
>>>> +{
>>>> +	void __iomem *base = wdev->base;
>>>> +
>>>> +	return readl_relaxed(base + OMAP_WATCHDOG_SPR) == 0x4444;
>>>> +}
>>> This isn't reliable. The sequence needed to enable the watchdog is
>>> 	writel(0xbbbb, base + OMAP_WATCHDOG_SPR);
>>> 	writel(0x4444, base + OMAP_WATCHDOG_SPR);
>>>
>>> The sequence to stop is:
>>> 	writel(0xaaaa, base + OMAP_WATCHDOG_SPR);
>>> 	writel(0x5555, base + OMAP_WATCHDOG_SPR);
>>>
>>> But:
>>>
>>> barebox@TI AM335x BeagleBone black:/ md 0x44e35048+4
>>> 44e35048: 00005555                                           UU..
>>> barebox@TI AM335x BeagleBone black:/ mw 0x44e35048 0x4444
>>> barebox@TI AM335x BeagleBone black:/ md 0x44e35048+4
>>> 44e35048: 00004444                                           DD..
>>>
>>> So the register contains 0x4444 but the timer doesn't run. So at best
>>> testing for 0x4444 is a good heuristic.
>>
>> Yeah.. I don't think we can get any better than that. Unless we
>> start checking the counter register and see whether it really counts
>> or not, and I think that's a bit overkill.. So I'd say we should be
>> safe when assuming bootloader is doing things correctly. Although,
>> we could add a comment to the code that the test may not be 100%
>> reliable in case the start sequence have not been issued properly.
>>
>> Thanks for pointing this out!
> It doesn't seem to much overhead to do:
>
> 	/*
> 	 * There is no register that tells us if the timer is running,
> 	 * so we have to resort to sample twice. The minimal frequency
> 	 * is 256 Hz (32768 Hz prescaled with 2**7).
> 	 */
> 	counter1 = readl(base + OMAP_WATCHDOG_CCR);
> 	mdelay(4);
> 	counter2 = readl(base + OMAP_WATCHDOG_CCR);
> 	return counter1 != counter2;
>
> I'd say it's even worth to do:
>
> 	cntrl = readl(base + OMAP_WATCHDOG_CNTRL);
> 	if (cntrl & (1 << 5))
> 		shift = (cntrl >> 2) & 0x7;
> 	else
> 		shift = 0;
> 	counter1 = readl(base + OMAP_WATCHDOG_CCR);
> 	udelay(31 << shift);
> 	counter2 = readl(base + OMAP_WATCHDOG_CCR);
> 	return counter1 != counter2;
>
> For some bonus points add some defines for the magic constants.
>
> This is save as the OMAP_WATCHDOG_CNTRL doesn't seem to accept reads
> while the counter is running. Maybe even this could be used to detect a
> running timer?:

Maybe, but you will get a data abort when the HW doesn't accept a read. 
How do you recover from that?

Also, it seems that for some reason the watchdog HW is very picky about 
which registers can be read in what condition. If I add the code to read 
watchdog counter register, I will get a data abort later at the end of 
the probe when the watchdog revision is read. I don't understand why 
that happens, this does not seem logica. Maybe it has got something to 
do with the fact that the watchdog is stopped? If I can't read the 
counter register, I can't really implement the above heuristic.. Any ideas?

-Timo

>
>   - enable timer:
> 	barebox@TI AM335x BeagleBone black:/ mw 0x44e35048 0xbbbb
> 	barebox@TI AM335x BeagleBone black:/ mw 0x44e35048 0x4444
>
>   - read out WCLR
> 	barebox@TI AM335x BeagleBone black:/ md 0x44e35024+4
> 	44e35024: 00000020                                            ...
>
>   - write to WCLR
> 	barebox@TI AM335x BeagleBone black:/ mw 0x44e35024 0x0
>
>   - check result; didn't work
> 	barebox@TI AM335x BeagleBone black:/ md 0x44e35024+4
> 	44e35024: 00000020                                            ...
>
>   - stop timer
> 	barebox@TI AM335x BeagleBone black:/ mw 0x44e35048 0xaaaa
> 	barebox@TI AM335x BeagleBone black:/ mw 0x44e35048 0x5555
>
>   - recheck WCLR
> 	barebox@TI AM335x BeagleBone black:/ md 0x44e35024+4
> 	44e35024: 00000020                                            ...
>
>   - write to WCLR
> 	barebox@TI AM335x BeagleBone black:/ mw 0x44e35024 0x0
>
>   - check result; write succeeded
> 	barebox@TI AM335x BeagleBone black:/ md 0x44e35024+4
> 	44e35024: 00000000                                           ....
>
> (This is was tested on an AM335x.)
>
> Best regards
> Uwe
>

