Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35157 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756171AbcDLSRo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 12 Apr 2016 14:17:44 -0400
MIME-Version: 1.0
In-Reply-To: <20160412180128.GA6965@roeck-us.net>
References: <1460440303-20640-1-git-send-email-sudipm.mukherjee@gmail.com>
	<570CF2CB.2050200@roeck-us.net>
	<570CFA90.4060100@gmail.com>
	<CAHp75VcrmiP0GWR-zCBmqc7zA6uiC4dD8-HDikmWZxyEwXkRLw@mail.gmail.com>
	<20160412180128.GA6965@roeck-us.net>
Date: Tue, 12 Apr 2016 21:17:43 +0300
Message-ID: <CAHp75Vd28EChCHs0YTKrF_31OsEzJcgX8XFRwMmy9WGOeukTMg@mail.gmail.com>
Subject: Re: [PATCH] watchdog: dw_wdt: dont build for avr32
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Haavard Skinnemoen <hskinnemoen@gmail.com>,
	Hans-Christian Egtvedt <egtvedt@samfundet.no>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	kernel-testers@vger.kernel.org, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Apr 12, 2016 at 9:01 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Tue, Apr 12, 2016 at 05:58:20PM +0300, Andy Shevchenko wrote:
>> On Tue, Apr 12, 2016 at 4:39 PM, Sudip Mukherjee
>> <sudipm.mukherjee@gmail.com> wrote:
>> > On Tuesday 12 April 2016 06:36 PM, Guenter Roeck wrote:
>> >>

> Sorry, I am missing something. do_div() should work fine with any 32 bit value
> as divisor, no matter what that value is. Why does it fail here ? And why does
> it work if I pass 0x1fffff as second parameter to do_div() directly ?

Perhaps compare assembly code in both cases?



-- 
With Best Regards,
Andy Shevchenko
