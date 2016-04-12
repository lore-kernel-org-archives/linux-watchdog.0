Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36236 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964905AbcDLO6V (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 12 Apr 2016 10:58:21 -0400
MIME-Version: 1.0
In-Reply-To: <570CFA90.4060100@gmail.com>
References: <1460440303-20640-1-git-send-email-sudipm.mukherjee@gmail.com>
	<570CF2CB.2050200@roeck-us.net>
	<570CFA90.4060100@gmail.com>
Date: Tue, 12 Apr 2016 17:58:20 +0300
Message-ID: <CAHp75VcrmiP0GWR-zCBmqc7zA6uiC4dD8-HDikmWZxyEwXkRLw@mail.gmail.com>
Subject: Re: [PATCH] watchdog: dw_wdt: dont build for avr32
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	Haavard Skinnemoen <hskinnemoen@gmail.com>,
	Hans-Christian Egtvedt <egtvedt@samfundet.no>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	kernel-testers@vger.kernel.org, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Apr 12, 2016 at 4:39 PM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> On Tuesday 12 April 2016 06:36 PM, Guenter Roeck wrote:
>>
>> On 04/11/2016 10:51 PM, Sudip Mukherjee wrote:
>>>
>>> The build of avr32 allmodconfig fails with the error:
>>> ERROR: "__avr32_udiv64" [drivers/watchdog/kempld_wdt.ko] undefined!
>>>
>> This means there is a direct 64 bit divide operation in the driver,
>> which we should identify and fix.

This driver will quite likely never be used on AVR32. Do we need to
fix this due to some other architectures?

> yes, there is.
>
> in function: kempld_wdt_set_stage_timeout()
> remainder = do_div(stage_timeout64, prescaler);

> Any idea how to fix it?

Not easy, however, prescaler value is ((1 << 21) - 1) which someone
might consider as (1 << 21) with lost in precision.

Thus, shift on 20 bits right, add last bit to the value and shift on 1
bit right more.

-- 
With Best Regards,
Andy Shevchenko
