Return-path: <noralf@tronnes.org>
Subject: Re: [PATCH v3] watchdog: bcm2835: Fix poweroff behaviour
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
 Eric Anholt <eric@anholt.net>
References: <1434549844-11704-1-git-send-email-noralf@tronnes.org>
 <558241F7.6070600@roeck-us.net>
Cc: linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <55F5CDE2.5020703@tronnes.org>
Date: Sun, 13 Sep 2015 21:26:26 +0200
MIME-Version: 1.0
In-Reply-To: <558241F7.6070600@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>


Den 18.06.2015 05:58, skrev Guenter Roeck:
> On 06/17/2015 07:04 AM, Noralf Trønnes wrote:
>> Currently poweroff/halt results in a reboot on the Raspberry Pi.
>> The firmware uses the RSTS register to know which partiton to
>> boot from. The partiton value is spread into bits
>> 0, 2, 4, 6, 8, 10. Partiton 63 is a special partition used by
>> the firmware to indicate halt.
>>
>> The firmware made this change in 19 Aug 2013 and was matched
>> by the downstream commit:
>> Changes for new NOOBS multi partition booting from gsh
>>
>> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>

It seems that this has slipped through the cracks, at least it didn't
enter in the 4.3 merge window.


Noralf.
