Return-Path: <linus.walleij@linaro.org>
Return-path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <CACRpkdbg3KdVvSMvzTv-rr4mAg_TPs6JLo3N_==G9BBS17B3Rg@mail.gmail.com>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-5-linus.walleij@linaro.org> <20170814160536.GC7025@roeck-us.net>
 <CACRpkdYcEbWkHdgxA-3=6JiZTxecQcTYgqx4xDH23=NxF8zg_Q@mail.gmail.com>
 <20170827170641.GF22819@roeck-us.net> <CACRpkdbg3KdVvSMvzTv-rr4mAg_TPs6JLo3N_==G9BBS17B3Rg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 10 Oct 2017 22:06:48 +0200
Message-ID: <CACRpkdZ-OkJpMd-Q+jiGPBV8DFrBxNAcm5UOJNgY_Lkd02Tg6w@mail.gmail.com>
Subject: Re: [PATCH 04/11] watchdog: ftwdt010: Add clock support
To: Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>,
	Wim Van Sebroeck <wim@iguana.be>, Jonas Jensen <jonas.jensen@gmail.com>, Andrew Jeffery <andrew@aj.id.au>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

So need info from Joel Stanley here:

On Tue, Oct 10, 2017 at 9:51 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sun, Aug 27, 2017 at 7:06 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On Thu, Aug 24, 2017 at 10:32:22PM +0200, Linus Walleij wrote:
>>> On Mon, Aug 14, 2017 at 6:05 PM, Guenter Roeck <linux@roeck-us.net> wrote:

>> If I understand your comment below correctly, the driver won't work
>> without clock subsystem because the clock frequency would in that case
>> be 0. Why not catch that situation here, or even better make the driver
>> depends on the clock subsystem ?
>
> OK fair enough I can do that.
>
> I think Aspeed is merging its clock driver this kernel cycle
> so all variant SoCs actually have clocks.

So when I later in the patch series convert Aspeed to use this driver
we get a problem because Joel is currently working on the clock
driver for Aspeed and it's not ready for merge yet as it looks.

I can of course wait with the Aspeed conversion to use the common
driver.

Also I can slap in a fixed-rate clock in the device tree @1 MHz.
But that is cheating.

So I guess I rest the Aspeed conversion.

Joel: does your clock patch set cover the 1MHz used by
the watchdog EXTCLK?

Yours,
Linus Walleij
