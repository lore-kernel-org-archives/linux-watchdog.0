Return-path: <sudipm.mukherjee@gmail.com>
Date: Sat, 30 Apr 2016 19:38:28 +0100
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Haavard Skinnemoen <hskinnemoen@gmail.com>,
	Hans-Christian Egtvedt <egtvedt@samfundet.no>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	kernel-testers@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Chris Mason <clm@fb.com>
Subject: Re: [PATCH] watchdog: dw_wdt: dont build for avr32
Message-ID: <20160430183828.GC25043@sudip-laptop>
References: <1460440303-20640-1-git-send-email-sudipm.mukherjee@gmail.com>
 <570CF2CB.2050200@roeck-us.net>
 <570CFA90.4060100@gmail.com>
 <CAHp75VcrmiP0GWR-zCBmqc7zA6uiC4dD8-HDikmWZxyEwXkRLw@mail.gmail.com>
 <20160412180128.GA6965@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160412180128.GA6965@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Apr 12, 2016 at 11:01:28AM -0700, Guenter Roeck wrote:
> On Tue, Apr 12, 2016 at 05:58:20PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 12, 2016 at 4:39 PM, Sudip Mukherjee
> > <sudipm.mukherjee@gmail.com> wrote:
> > > On Tuesday 12 April 2016 06:36 PM, Guenter Roeck wrote:
> > >>
> > >> On 04/11/2016 10:51 PM, Sudip Mukherjee wrote:
> > >>>
> > >>> The build of avr32 allmodconfig fails with the error:
> > >>> ERROR: "__avr32_udiv64" [drivers/watchdog/kempld_wdt.ko] undefined!
> > >>>
> > >> This means there is a direct 64 bit divide operation in the driver,
> > >> which we should identify and fix.
> > 
> > This driver will quite likely never be used on AVR32. Do we need to
> > fix this due to some other architectures?
> > 
> > > yes, there is.
> > >
> > > in function: kempld_wdt_set_stage_timeout()
> > > remainder = do_div(stage_timeout64, prescaler);
> > 
> > > Any idea how to fix it?
> > 
> > Not easy, however, prescaler value is ((1 << 21) - 1) which someone
> > might consider as (1 << 21) with lost in precision.
> > 
> > Thus, shift on 20 bits right, add last bit to the value and shift on 1
> > bit right more.
> > 
> Sorry, I am missing something. do_div() should work fine with any 32 bit value
> as divisor, no matter what that value is. Why does it fail here ? And why does
> it work if I pass 0x1fffff as second parameter to do_div() directly ?

Please let me know what i can do here to help solve the problem.
linux-next continues to fail for avr32, and to make matters worse we
also have the similar problem in btrfs.

ERROR: "__avr32_udiv64" [fs/btrfs/btrfs.ko] undefined!
ERROR: "__avr32_udiv64" [drivers/watchdog/kempld_wdt.ko] undefined!

Adding Chris to CC if he has some idea how to solve this error for btrfs.
Build log for next-20160429 is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/126581065

regards
sudip
