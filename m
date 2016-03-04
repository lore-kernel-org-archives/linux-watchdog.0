Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59721 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbcCDN4X (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 Mar 2016 08:56:23 -0500
Subject: Re: [PATCH v1] watchdog: sama5d4_wdt: Reset delay on start
To: Romain Izard <romain.izard.pro@gmail.com>
References: <1457000979-15717-1-git-send-email-romain.izard.pro@gmail.com>
 <56D8E649.8030500@atmel.com> <56D91BDC.1030604@roeck-us.net>
 <CAGkQfmN9wDkrc=frsSdBYYtMPf4VaTpcmYjX6_wARs=a78-bPQ@mail.gmail.com>
 <56D988F0.8050803@roeck-us.net>
 <CAGkQfmOLVwpckKP+axdi1501ghqq_UAmCygJv_tfa=bCOLvCzA@mail.gmail.com>
Cc: "Yang, Wenyou" <wenyou.yang@atmel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56D99404.60305@roeck-us.net>
Date: Fri, 4 Mar 2016 05:56:20 -0800
MIME-Version: 1.0
In-Reply-To: <CAGkQfmOLVwpckKP+axdi1501ghqq_UAmCygJv_tfa=bCOLvCzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/04/2016 05:26 AM, Romain Izard wrote:
> 2016-03-04 14:09 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
>> On 03/04/2016 01:06 AM, Romain Izard wrote:
>>> 2016-03-04 6:23 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
>>>> On 03/03/2016 05:35 PM, Yang, Wenyou wrote:
>>>>> On 2016/3/3 18:29, Romain Izard wrote:
>>>>>>
>>>>>> If the internal counter is not refreshed when the watchdog is
>>>>>> started for the first time, the watchdog will trigger very
>>>>>> rapidly.  For example, opening /dev/watchdog without writing in it
>>>>>> will immediately trigger a reboot, instead of waiting for the
>>>>>> delay to expire.
>>>>>>
>>>>>> To avoid this problem, reload the timer on opening the watchdog
>>>>>> device.
>>>>>>
>>>>>> Command: "while sleep 5; do echo 1; done > /dev/watchdog" Before:
>>>>>> system reset After: the watchdog runs correctly
>>>>>
>>>>>
>>>>> I didn't reproduce your issue on my side,
>>>>>
>>>>> run the your commands as follows, it works fine,  the system reset
>>>>> doesn't happen.
>>>
>>>
>>> I've just verified with the factory image provided on the SAMA5D2
>>> Xplained board. It does not display this behaviour.
>>>
>>> But the difference is that in the case without the issue, I'm using
>>> the AT91bootstrap SPL, U-Boot, and the kernel from the QSPI chip.
>>> When I have the issue, I have a U-Boot based SPL, U-Boot itself and
>>> the kernel that come from the FAT partition of an SD-Card.
>>>
>>> Userspace does not seem to be involved in the issue, as I can
>>> reproduce it both with my buildroot environment, and the Yocto
>>> environment from the factory image.
>>>
>>>> Different chip revision ? Different chip type ? Different chip
>>>> initialization by ROMMON ?
>>>>
>>>> Can we get exact chip revisions and types for both cases (working
>>>> and not working), and (if it might be relevant) a dump of all
>>>> associated chip registers ?
>>>
>>>
>>>
>>>>> I also check the WDT_MR register before and after enabling
>>>>> watchdog, the WDV and WDD fields are correct.
>>>>>
>>>>> Can you check it again? thank you.
>>>
>>>
>>> Working case:
>>> MR on kernel startup:   0x3fffafff
>>> MR after watchdog init: 0x0fffafff
>>> MR after start:         0x0fff2fff
>>>
>>> Problem case:
>>> MR on kernel startup:   0x00008000
>>> MR after watchdog init: 0x0fffafff
>>> MR after start:         0x0fff2fff
>>>
>>> So this means that the counter reload does not seem to work very well
>>> if WDD/WDV have been set to 0 in the past. The other question is why
>>> does U-Boot (from the Atmel branch based on 2015.1) put this stange
>>> value in this register.
>>>
>>
>> Can you check the value of AT91_WDT_SR ? Maybe it tells us something.
>>
> I didn't report it because it contained 0 at all times. So no information.
>
>> Also, in the error case, can you check if the watchdog times out at all
>> after you applied your patch ?
>
> It times out after 16s as expected, and reboot occurs correctly.
>

Interesting. So it looks like AT91_WDT_WDRSTT has to be set if the timer
values in MR are changed from 0 to another value, or maybe after each
timer value change. Wonder if that should be done in the init function,
after MR is set (with the watchdog disabled).

Thoughts, anyone ?

Thanks,
Guenter




