Return-path: <dianders@google.com>
MIME-Version: 1.0
Sender: dianders@google.com
In-Reply-To: <20150122132200.4729d38b@xhacker>
References: <1421882243-3631-1-git-send-email-dianders@chromium.org>
	<20150122132200.4729d38b@xhacker>
Date: Thu, 22 Jan 2015 09:09:28 -0800
Message-ID: <CAD=FV=UMmfNAEQVKCxTBapwO=pgno+cWUJNiMS7_uFK7NPevkw@mail.gmail.com>
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

On Wed, Jan 21, 2015 at 9:22 PM, Jisheng Zhang <jszhang@marvell.com> wrote:
> Dear Doug,
>
> On Wed, 21 Jan 2015 15:17:22 -0800
> Doug Anderson <dianders@chromium.org> wrote:
>
>> On some dw_wdt implementations the "top" register may be initted to 0
>> at bootup.  In such a case, each "pat" of the watchdog will reset the
>> timer to 0xffff.  That's pretty short.
>
> + Guenter Roeck
>
> This should have been fixed by dfa07141e7a792("watchdog: dw_wdt: initialise
> TOP_INIT in dw_wdt_set_top()")

I will admit that I'm testing on a tree that doesn't have your patch
(I'm on a 3.14 kernel with lots of backports).  ...but I did try
cherry-picking your patch before I wrote up mine and it didn't fix my
problem.  I believe that the watchdog that's in Rockchip rk3288 must
be a slightly different version of the IP block than you're working
with.

Specifically I see the register WDT_TORR that has an offset of 0x4.
That's the RANGE_REG in your code.  It shows bits 3:0 set the timeout
period (0 = 0xffff and 15 = 0x7fffffff).  It shows bits 31:4 as
"reserved".


> In fact, my original fix is as similar as your patch
>
> http://www.spinics.net/lists/arm-kernel/msg363658.html

Yup, except that I pat the watchdog before enabling it and you pat it
after...  It probably doesn't matter as long as the two instructions
are within 2.5ms of each other, but it seems nice to be safer.

-Doug
