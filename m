Return-path: <arndbergmann@gmail.com>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170228214203.GE6651@roeck-us.net>
References: <20170228210123.3404816-1-arnd@arndb.de> <20170228210123.3404816-3-arnd@arndb.de>
 <20170228214203.GE6651@roeck-us.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 28 Feb 2017 22:47:02 +0100
Message-ID: <CAK8P3a3iu-2MAdD+-nRQfeOme--LLSAH1LRkREVGRo78m_ra7Q@mail.gmail.com>
Subject: Re: [PATCH 2/8] mfd: db8500-prcmu: fix stub helper interface
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	Lee Jones <lee.jones@linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Feb 28, 2017 at 10:42 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Tue, Feb 28, 2017 at 10:01:17PM +0100, Arnd Bergmann wrote:
>> When the db8500 watchdog is enabled without the PRCMU, we get a lot of
>> warnings about duplicate or missing helper functions:
>>
>> In file included from drivers/watchdog/ux500_wdt.c:21:0:
>> include/linux/mfd/dbx500-prcmu.h:422:19: error: redefinition of 'prcmu_abb_read'
>>  static inline int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size)
>>
>> This removes the duplicate function definitions and moves the helpers in
>> dbx500-prcmu outside of the #ifdef that hides them.
>>
>
> Is that appropriate ? Maybe we should just disable COMPILE_TEST
> for this driver instead.

Or we could do both. The MFD driver was written to support this in principle,
it just hasn't worked in a long time.

     Arnd
