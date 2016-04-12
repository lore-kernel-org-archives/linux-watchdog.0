Return-path: <sudipm.mukherjee@gmail.com>
Message-ID: <570D1453.9020005@gmail.com>
Date: Tue, 12 Apr 2016 20:59:23 +0530
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 kernel-testers@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: dw_wdt: dont build for avr32
References: <1460440303-20640-1-git-send-email-sudipm.mukherjee@gmail.com>	<570CF2CB.2050200@roeck-us.net>	<570CFA90.4060100@gmail.com> <CAHp75VcrmiP0GWR-zCBmqc7zA6uiC4dD8-HDikmWZxyEwXkRLw@mail.gmail.com>
In-Reply-To: <CAHp75VcrmiP0GWR-zCBmqc7zA6uiC4dD8-HDikmWZxyEwXkRLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On Tuesday 12 April 2016 08:28 PM, Andy Shevchenko wrote:
> On Tue, Apr 12, 2016 at 4:39 PM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
>> On Tuesday 12 April 2016 06:36 PM, Guenter Roeck wrote:
>>>
>>> On 04/11/2016 10:51 PM, Sudip Mukherjee wrote:
>>>>
>>>> The build of avr32 allmodconfig fails with the error:
>>>> ERROR: "__avr32_udiv64" [drivers/watchdog/kempld_wdt.ko] undefined!
>>>>
>>> This means there is a direct 64 bit divide operation in the driver,
>>> which we should identify and fix.
>
> This driver will quite likely never be used on AVR32. Do we need to
> fix this due to some other architectures?

I have not seen failure in the architecture builds I monitor. And since 
no one reported anything so I guess its only avr32.

regards
sudip
