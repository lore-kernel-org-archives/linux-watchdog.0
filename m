Return-path: <dianders@google.com>
MIME-Version: 1.0
Sender: dianders@google.com
In-Reply-To: <20150126142210.4cd0b33f@xhacker>
References: <1421882243-3631-1-git-send-email-dianders@chromium.org>
	<20150122132200.4729d38b@xhacker>
	<CAD=FV=UMmfNAEQVKCxTBapwO=pgno+cWUJNiMS7_uFK7NPevkw@mail.gmail.com>
	<20150126142210.4cd0b33f@xhacker>
Date: Mon, 26 Jan 2015 09:01:37 -0800
Message-ID: <CAD=FV=WKeH2hmgsB1Hh8G6LWGqSVf_nOTCs7PVqLZV_gB_VqhA@mail.gmail.com>
Subject: Re: [PATCH 1/2] watchdog: dw_wdt: pat the watchdog before enabling it
From: Doug Anderson <dianders@chromium.org>
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>, Heiko Stuebner <heiko@sntech.de>,
	Lunxue Dai <lunxue.dai@rock-chips.com>, Dinh Nguyen <dinguyen@altera.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Jisheng,

On Sun, Jan 25, 2015 at 10:22 PM, Jisheng Zhang <jszhang@marvell.com> wrote:
>> Specifically I see the register WDT_TORR that has an offset of 0x4.
>> That's the RANGE_REG in your code.  It shows bits 3:0 set the timeout
>> period (0 = 0xffff and 15 = 0x7fffffff).  It shows bits 31:4 as
>> "reserved".
>
> Could you please dump registers' value at offset 0xf4 and 0xf8 if you don't mind?

Those are not documented in the user manual that I have, but:

>>> r(0xff8000f4)
0x10000a02
>>> r(0xff8000f8)
0x3130332a

-Doug
