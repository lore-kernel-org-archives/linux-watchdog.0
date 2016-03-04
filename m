Return-path: <romain.izard@mobile-devices.fr>
MIME-Version: 1.0
Sender: romain.izard@mobile-devices.fr
In-Reply-To: <56D91BDC.1030604@roeck-us.net>
References: <1457000979-15717-1-git-send-email-romain.izard.pro@gmail.com>
 <56D8E649.8030500@atmel.com> <56D91BDC.1030604@roeck-us.net>
From: Romain Izard <romain.izard.pro@gmail.com>
Date: Fri, 4 Mar 2016 10:06:34 +0100
Message-ID: <CAGkQfmN9wDkrc=frsSdBYYtMPf4VaTpcmYjX6_wARs=a78-bPQ@mail.gmail.com>
Subject: Re: [PATCH v1] watchdog: sama5d4_wdt: Reset delay on start
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Yang, Wenyou" <wenyou.yang@atmel.com>, LKML <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Wim Van Sebroeck <wim@iguana.be>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Wenyou, Guenter,

2016-03-04 6:23 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
> On 03/03/2016 05:35 PM, Yang, Wenyou wrote:
>> On 2016/3/3 18:29, Romain Izard wrote:
>>>
>>> If the internal counter is not refreshed when the watchdog is
>>> started for the first time, the watchdog will trigger very rapidly.
>>> For example, opening /dev/watchdog without writing in it will
>>> immediately trigger a reboot, instead of waiting for the delay to
>>> expire.
>>>
>>> To avoid this problem, reload the timer on opening the watchdog
>>> device.
>>>
>>> Command: "while sleep 5; do echo 1; done > /dev/watchdog" Before:
>>> system reset After: the watchdog runs correctly
>>
>> I didn't reproduce your issue on my side,
>>
>> run the your commands as follows, it works fine,  the system reset
>> doesn't happen.

I've just verified with the factory image provided on the SAMA5D2
Xplained board. It does not display this behaviour.

But the difference is that in the case without the issue, I'm using the
AT91bootstrap SPL, U-Boot, and the kernel from the QSPI chip. When I
have the issue, I have a U-Boot based SPL, U-Boot itself and the kernel
that come from the FAT partition of an SD-Card.

Userspace does not seem to be involved in the issue, as I can reproduce
it both with my buildroot environment, and the Yocto environment from
the factory image.

> Different chip revision ? Different chip type ? Different chip
> initialization by ROMMON ?
>
> Can we get exact chip revisions and types for both cases (working and
> not working), and (if it might be relevant) a dump of all associated
> chip registers ?


>> I also check the WDT_MR register before and after enabling watchdog,
>> the WDV and WDD fields are correct.
>>
>> Can you check it again? thank you.

Working case:
MR on kernel startup:   0x3fffafff
MR after watchdog init: 0x0fffafff
MR after start:         0x0fff2fff

Problem case:
MR on kernel startup:   0x00008000
MR after watchdog init: 0x0fffafff
MR after start:         0x0fff2fff

So this means that the counter reload does not seem to work very well if
WDD/WDV have been set to 0 in the past. The other question is why does
U-Boot (from the Atmel branch based on 2015.1) put this stange value in
this register.

Best regards,
-- 
Romain Izard
