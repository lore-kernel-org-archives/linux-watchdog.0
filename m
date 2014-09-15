Return-path: <ryazanov.s.a@gmail.com>
MIME-Version: 1.0
In-Reply-To: <541656A3.8030906@roeck-us.net>
References: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
	<1410723213-22440-14-git-send-email-ryazanov.s.a@gmail.com>
	<541656A3.8030906@roeck-us.net>
Date: Mon, 15 Sep 2014 13:42:36 +0400
Message-ID: <CAHNKnsT5AHT9xaaY44yTo7uMiOGL9fekGkEzjQuYvdUyJs-WQA@mail.gmail.com>
Subject: Re: [RFC 13/18] watchdog: add Atheros AR2315 watchdog driver
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, Linux MIPS <linux-mips@linux-mips.org>,
	Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-watchdog@vger.kernel.org>

2014-09-15 7:01 GMT+04:00, Guenter Roeck <linux@roeck-us.net>:
> On 09/14/2014 12:33 PM, Sergey Ryazanov wrote:
>> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>> Cc: Wim Van Sebroeck <wim@iguana.be>
>> Cc: linux-watchdog@vger.kernel.org
>> ---
>>   arch/mips/ar231x/ar2315.c     |  26 +++++-
>>   drivers/watchdog/Kconfig      |   7 ++
>>   drivers/watchdog/Makefile     |   1 +
>>   drivers/watchdog/ar2315-wtd.c | 202
>> ++++++++++++++++++++++++++++++++++++++++++
>
> This should be two patches: One to instantiate the watchdog,
> the second the watchdog driver itself. The weatchdog driver
> should use the watchdog infrastructure.
>
Ok. Will do in v2.

[skipped]

>> + *
>> + * Copyright (C) 2008 John Crispin <blogic@openwrt.org>
>> + * Based on EP93xx and ifxmips wdt driver
>
> 2008 ?
>
Yes. This driver is pretty old.

[skipped]

>> +
>> +#define CLOCK_RATE 40000000
>> +#define HEARTBEAT(x) (x < 1 || x > 90 ? 20 : x)
>> +
> Whatever the logic is here, it does not make much sense to me.
>
90 second is maximal value which we could write to register, and value
below 1 second is senseless. So this macros always return a value
which make sense: specified by user or default.

-- 
BR,
Sergey
