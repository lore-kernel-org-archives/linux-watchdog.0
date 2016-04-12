Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34429 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757242AbcDLSBZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 12 Apr 2016 14:01:25 -0400
Date: Tue, 12 Apr 2016 11:01:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Haavard Skinnemoen <hskinnemoen@gmail.com>,
	Hans-Christian Egtvedt <egtvedt@samfundet.no>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	kernel-testers@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: dw_wdt: dont build for avr32
Message-ID: <20160412180128.GA6965@roeck-us.net>
References: <1460440303-20640-1-git-send-email-sudipm.mukherjee@gmail.com>
 <570CF2CB.2050200@roeck-us.net>
 <570CFA90.4060100@gmail.com>
 <CAHp75VcrmiP0GWR-zCBmqc7zA6uiC4dD8-HDikmWZxyEwXkRLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcrmiP0GWR-zCBmqc7zA6uiC4dD8-HDikmWZxyEwXkRLw@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Apr 12, 2016 at 05:58:20PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 12, 2016 at 4:39 PM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> > On Tuesday 12 April 2016 06:36 PM, Guenter Roeck wrote:
> >>
> >> On 04/11/2016 10:51 PM, Sudip Mukherjee wrote:
> >>>
> >>> The build of avr32 allmodconfig fails with the error:
> >>> ERROR: "__avr32_udiv64" [drivers/watchdog/kempld_wdt.ko] undefined!
> >>>
> >> This means there is a direct 64 bit divide operation in the driver,
> >> which we should identify and fix.
> 
> This driver will quite likely never be used on AVR32. Do we need to
> fix this due to some other architectures?
> 
> > yes, there is.
> >
> > in function: kempld_wdt_set_stage_timeout()
> > remainder = do_div(stage_timeout64, prescaler);
> 
> > Any idea how to fix it?
> 
> Not easy, however, prescaler value is ((1 << 21) - 1) which someone
> might consider as (1 << 21) with lost in precision.
> 
> Thus, shift on 20 bits right, add last bit to the value and shift on 1
> bit right more.
> 
Sorry, I am missing something. do_div() should work fine with any 32 bit value
as divisor, no matter what that value is. Why does it fail here ? And why does
it work if I pass 0x1fffff as second parameter to do_div() directly ?

Thanks,
Guenter

> -- 
> With Best Regards,
> Andy Shevchenko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
