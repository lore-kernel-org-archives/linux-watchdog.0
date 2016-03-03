Return-path: <romain.izard@mobile-devices.fr>
MIME-Version: 1.0
Sender: romain.izard@mobile-devices.fr
In-Reply-To: <56D829A7.1020201@roeck-us.net>
References: <1457000979-15717-1-git-send-email-romain.izard.pro@gmail.com> <56D829A7.1020201@roeck-us.net>
From: Romain Izard <romain.izard.pro@gmail.com>
Date: Thu, 3 Mar 2016 13:53:47 +0100
Message-ID: <CAGkQfmMFAJ7dQ-BMXNFdgW8ZvGhJ87h+gh3RHPecgFm9WjKoMQ@mail.gmail.com>
Subject: Re: [PATCH v1] watchdog: sama5d4_wdt: Reset delay on start
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Wim Van Sebroeck <wim@iguana.be>,
	Wenyou Yang <wenyou.yang@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

2016-03-03 13:10 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
> On 03/03/2016 02:29 AM, Romain Izard wrote:
>>
>> If the internal counter is not refreshed when the watchdog is started
>> for the first time, the watchdog will trigger very rapidly. For
>> example, opening /dev/watchdog without writing in it will immediately
>> trigger a reboot, instead of waiting for the delay to expire.
>>
>> To avoid this problem, reload the timer on opening the watchdog
>> device.
>>
>> Command: "while sleep 5; do echo 1; done > /dev/watchdog"
>> Before: system reset
>> After: the watchdog runs correctly
>>
>> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
>
>
> Subject might better read "ping watchdog on start" or similar.
>
OK. I'll change it for a v2.

> Does the watchdog have to be pinged before it is enabled ?  I am a bit
> concerned that there may still be a 125 uS window during which the
> system could restart.
>

According to the SAMA5D2 & SAMA5D4 datasheets, the timer ought to be
reloaded when the watchdog is enabled by a write in the MR register.
Unfortunately, it does not work as described, as I encountered the
problem on a SAMA5D2 Xplained board.

The 4 clock delay is not in the datasheet either, but without any delay
the timer is clearly not reloaded, as my issue stays the same. As there
is a required delay before writing to MR after writing to CR, I applied
the same type of delay in the reverse case.

Perhaps Nicolas or Wenyou have more information on this.

Best regards,
-- 
Romain Izard
