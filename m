Message-ID: <5416E820.3070305@roeck-us.net>
Date: Mon, 15 Sep 2014 06:22:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
CC: Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
Subject: Re: [RFC 13/18] watchdog: add Atheros AR2315 watchdog driver
References: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>  <1410723213-22440-14-git-send-email-ryazanov.s.a@gmail.com>     <541656A3.8030906@roeck-us.net> <CAHNKnsT5AHT9xaaY44yTo7uMiOGL9fekGkEzjQuYvdUyJs-WQA@mail.gmail.com>
In-Reply-To: <CAHNKnsT5AHT9xaaY44yTo7uMiOGL9fekGkEzjQuYvdUyJs-WQA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <linux@roeck-us.net>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

On 09/15/2014 02:42 AM, Sergey Ryazanov wrote:
> 2014-09-15 7:01 GMT+04:00, Guenter Roeck <linux@roeck-us.net>:
>> On 09/14/2014 12:33 PM, Sergey Ryazanov wrote:
>>> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>>> Cc: Wim Van Sebroeck <wim@iguana.be>
>>> Cc: linux-watchdog@vger.kernel.org
>>> ---
>>>    arch/mips/ar231x/ar2315.c     |  26 +++++-
>>>    drivers/watchdog/Kconfig      |   7 ++
>>>    drivers/watchdog/Makefile     |   1 +
>>>    drivers/watchdog/ar2315-wtd.c | 202
>>> ++++++++++++++++++++++++++++++++++++++++++
>>
>> This should be two patches: One to instantiate the watchdog,
>> the second the watchdog driver itself. The weatchdog driver
>> should use the watchdog infrastructure.
>>
> Ok. Will do in v2.
>
> [skipped]
>
>>> + *
>>> + * Copyright (C) 2008 John Crispin <blogic@openwrt.org>
>>> + * Based on EP93xx and ifxmips wdt driver
>>
>> 2008 ?
>>
> Yes. This driver is pretty old.
>
> [skipped]
>
>>> +
>>> +#define CLOCK_RATE 40000000
>>> +#define HEARTBEAT(x) (x < 1 || x > 90 ? 20 : x)
>>> +
>> Whatever the logic is here, it does not make much sense to me.
>>
> 90 second is maximal value which we could write to register, and value
> below 1 second is senseless. So this macros always return a value
> which make sense: specified by user or default.
>
I would agree that the value generates would be clamped, for example
by using the clamp_val macro. Bit your logic is such that the user
gets a timeout of 90 seconds when specifying 90 seconds, and 20
seconds when specifying 91 seconds.

Doesn't really matter much if you use the watchdog framework,
as it takes care of range checking.

Guenter
