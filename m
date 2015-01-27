Return-path: <jszhang@marvell.com>
Date: Tue, 27 Jan 2015 11:44:03 +0800
From: Jisheng Zhang <jszhang@marvell.com>
To: Doug Anderson <dianders@chromium.org>
CC: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Lunxue Dai <lunxue.dai@rock-chips.com>,
        Dinh Nguyen <dinguyen@altera.com>,
        "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] watchdog: dw_wdt: pat the watchdog before enabling
 it
Message-ID: <20150127114403.71736c3f@xhacker>
In-Reply-To: <CAD=FV=WKeH2hmgsB1Hh8G6LWGqSVf_nOTCs7PVqLZV_gB_VqhA@mail.gmail.com>
References: <1421882243-3631-1-git-send-email-dianders@chromium.org>
	<20150122132200.4729d38b@xhacker>
	<CAD=FV=UMmfNAEQVKCxTBapwO=pgno+cWUJNiMS7_uFK7NPevkw@mail.gmail.com>
	<20150126142210.4cd0b33f@xhacker>
	<CAD=FV=WKeH2hmgsB1Hh8G6LWGqSVf_nOTCs7PVqLZV_gB_VqhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Dear Doug,

On Mon, 26 Jan 2015 09:01:37 -0800
Doug Anderson <dianders@chromium.org> wrote:

> Jisheng,
> 
> On Sun, Jan 25, 2015 at 10:22 PM, Jisheng Zhang <jszhang@marvell.com> wrote:
> >> Specifically I see the register WDT_TORR that has an offset of 0x4.
> >> That's the RANGE_REG in your code.  It shows bits 3:0 set the timeout
> >> period (0 = 0xffff and 15 = 0x7fffffff).  It shows bits 31:4 as
> >> "reserved".
> >
> > Could you please dump registers' value at offset 0xf4 and 0xf8 if you
> > don't mind?
> 
> Those are not documented in the user manual that I have, but:
> 
> >>> r(0xff8000f4)
> 0x10000a02
> >>> r(0xff8000f8)
> 0x3130332a

Thanks. Now I got some information about your platform:

wdt version: v1.02a

WDT_DUAL_TOP is configured as false, so there's no TOP_INIT
WDT_DFLT_TOP is configured as 0, so it will timeout soon.

However, it doesn't hurt anything if we have an extra pat before
enabling WDT

Thanks,
Jisheng
