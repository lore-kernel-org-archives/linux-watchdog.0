Return-path: <jszhang@marvell.com>
Date: Tue, 27 Jan 2015 12:52:02 +0800
From: Jisheng Zhang <jszhang@marvell.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Doug Anderson <dianders@chromium.org>, Wim Van Sebroeck <wim@iguana.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Lunxue Dai <lunxue.dai@rock-chips.com>,
        Dinh Nguyen <dinguyen@altera.com>,
        "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] watchdog: dw_wdt: pat the watchdog before
 enabling it
Message-ID: <20150127125202.59dbd37d@xhacker>
In-Reply-To: <54C70F24.5080100@roeck-us.net>
References: <1422314836-30516-1-git-send-email-dianders@chromium.org>
	<20150127114909.204eeee0@xhacker>
	<54C70F24.5080100@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Dear Guenter,

On Mon, 26 Jan 2015 20:08:04 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> On 01/26/2015 07:49 PM, Jisheng Zhang wrote:
> > Dear Doug,
> >
> > On Mon, 26 Jan 2015 15:27:15 -0800
> > Doug Anderson <dianders@chromium.org> wrote:
> >
> >> On some dw_wdt implementations the "top" register may be initted to 0
> >> at bootup.  In such a case, each "pat" of the watchdog will reset the
> >> timer to 0xffff.  That's pretty short.
> >>
> >> The input clock of the wdt can be any of a wide range of values.  On
> >> an rk3288 system, I've seen the wdt clock be 24.75 MHz.  That means
> >> each tick is ~40ns and we'll count to 0xffff in ~2.6ms.
> >>
> >> Because of the above two facts, it's a really good idea to pat the
> >> watchdog after initting the "top" register properly and before
> >> enabling the watchdog.  If you don't then there's no way we'll get the
> >> next heartbeat in time.
> >>
> >> Jisheng Zhang fixed this problem on some dw_mmc versions by using the
> >
> > s/dw_mmc/dw_wdt
> >
> >> TOP_INIT feature.  However, the dw_wdt on rk3288 doesn't have TOP_INIT
> >> so it's a good idea to also pat the watchdog manually.
> >
> > Based on your register dumping, I see the following configurations on
> > rk3288:
> >
> > WDT_DUAL_TOP is configured as false, so there's no TOP_INIT
> >
> > WDT_DFLT_TOP is configured as 0, so it will timeout soon.
> >
> >
> > So an extra pat is a must on such platforms with similar configurations.
> > And it doesn't hurt anything if we have an extra pat before enabling the
> > WDT
> >
> > All in all, except the "dw_mmc" typo above, the patch looks good to me.
> >
> 
> Jisheng,
> 
> it would be great if you can provide configuration information shown in
> the (undocumented) registers.

The wdt in rk3288 is a bit old, so I'm not sure whether the meaning is the same
or not. The key related configuration here is the so called CP_WDT_DUAL_TOP, bit[2]
of WDT_COMP_PARAMS_1 (0xf4), which indicates whether the TOP_INIT bits exist or
fixed as zero.

Thanks,
Jisheng

> 
> Doug,
> 
> can you send another version with this information added as comment
> to the code ? This will help others to understand what is going on
> (and why) later on.
> 
> Thanks,
> Guenter
> 
