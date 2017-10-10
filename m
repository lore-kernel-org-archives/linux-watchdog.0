Return-Path: <linus.walleij@linaro.org>
Return-path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170827170641.GF22819@roeck-us.net>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-5-linus.walleij@linaro.org> <20170814160536.GC7025@roeck-us.net>
 <CACRpkdYcEbWkHdgxA-3=6JiZTxecQcTYgqx4xDH23=NxF8zg_Q@mail.gmail.com> <20170827170641.GF22819@roeck-us.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 10 Oct 2017 21:51:26 +0200
Message-ID: <CACRpkdbg3KdVvSMvzTv-rr4mAg_TPs6JLo3N_==G9BBS17B3Rg@mail.gmail.com>
Subject: Re: [PATCH 04/11] watchdog: ftwdt010: Add clock support
To: Guenter Roeck <linux@roeck-us.net>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>,
	Wim Van Sebroeck <wim@iguana.be>, Jonas Jensen <jonas.jensen@gmail.com>, Andrew Jeffery <andrew@aj.id.au>,
	Joel Stanley <joel@jms.id.au>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, Aug 27, 2017 at 7:06 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, Aug 24, 2017 at 10:32:22PM +0200, Linus Walleij wrote:
>> On Mon, Aug 14, 2017 at 6:05 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> >> +     gwdt->pclk = devm_clk_get(dev, "PCLK");
>> >> +     if (!IS_ERR(gwdt->pclk)) {
>> >
>> > devm_clk_get() can return NULL (if the clock subsystem is not enabled).
>>
>> That is fine I think? Because if the clock subsysten is not enabled
>> all the clk_prepare() etc becomes stubs as well and the driver
>> is happy. I think this is intended.
>
> If I understand your comment below correctly, the driver won't work
> without clock subsystem because the clock frequency would in that case
> be 0. Why not catch that situation here, or even better make the driver
> depends on the clock subsystem ?

OK fair enough I can do that.

I think Aspeed is merging its clock driver this kernel cycle
so all variant SoCs actually have clocks.

>> The driver strictly needs this frequency
>> so we cannot really work without it and it needs to fail
>> over here.
>>
> Repeating from above, doesn't that mean that the driver depends
> on the clock subsystem ? Or am I missong some context ?

Usually in the kernel, it is acceptable to let stub clocks
kick in when compiling out the clock subsystem.

I think people assume that in this state, all clocks are simply
turned on and at nominal speed, all over the place. So it
usually doesn't matter that it gets compiled out.

But in a sense that is simplistic and as this driver shows
we really do depend on the clocks to run some business
like timers, so in practice it is a bad idea. Clocksources
definately cannot live without their clocks for example.
So I think strictly requireing it is OK.

>> > Note that I would
>> > resist replacing all the devm_ functions with non-devm equivalents just
>> > because the clock subsystem doesn't provide the necessary API functions.
>>
>> I've seen people do this for this reason though :/
>>
> Yes, but that doesn't make it better.

Stephen Boyd <sboyd@codeaurora.org> wrote:

> I'd still prefer we just disable clks on clk_put(),

Which means that devm_clk_get() will do the job
implicitly already.

> but Russell
> said we needed to fix all non-common clk implementations of the
> clk API to do that and then I forgot about the topic (so
> anti-climatic). I'm pretty much OK with us merging the temporary
> solution.

I guess that means the watchdog-local hack that
Guenther suggested.

But I'm not in any hurry. Instead of solving the simple problem,
why not solve the supercomplicated problem.

So the task is to look over all non generic clock implementations
and make them conform to disabling the clocks on clk_put().
No big deal. (Famous last words.)

How many local clock implementations can there be?
I will look into it.

Yours,
Linus Walleij
