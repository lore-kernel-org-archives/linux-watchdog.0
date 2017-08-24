Return-Path: <linus.walleij@linaro.org>
Return-path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170814160536.GC7025@roeck-us.net>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-5-linus.walleij@linaro.org> <20170814160536.GC7025@roeck-us.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 Aug 2017 22:32:22 +0200
Message-ID: <CACRpkdYcEbWkHdgxA-3=6JiZTxecQcTYgqx4xDH23=NxF8zg_Q@mail.gmail.com>
Subject: Re: [PATCH 04/11] watchdog: ftwdt010: Add clock support
To: Guenter Roeck <linux@roeck-us.net>, Stephen Boyd <sboyd@codeaurora.org>,
	Michael Turquette <mturquette@baylibre.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Jonas Jensen <jonas.jensen@gmail.com>,
	Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Aug 14, 2017 at 6:05 PM, Guenter Roeck <linux@roeck-us.net> wrote:

>> +     gwdt->pclk = devm_clk_get(dev, "PCLK");
>> +     if (!IS_ERR(gwdt->pclk)) {
>
> devm_clk_get() can return NULL (if the clock subsystem is not enabled).

That is fine I think? Because if the clock subsysten is not enabled
all the clk_prepare() etc becomes stubs as well and the driver
is happy. I think this is intended.

>> +             ret = clk_prepare_enable(gwdt->pclk);
>
> Why enable pclk if extclk is used ?

It is used to clock the silicon in the IP block (so one can access the
registers etc) even if the timer per se uses EXTCLK.

So it must always be enabled.

>> +             if (ret) {
>> +                     dev_err(&pdev->dev, "unable to enable PCLK\n");
>> +                     return ret;
>> +             }
>> +             if (!gwdt->use_extclk)
>> +                     gwdt->clk_freq = clk_get_rate(gwdt->pclk);
>> +     } else {
>> +             dev_info(dev, "PCLK clock not found assume always-on\n");
>
> Those info messages seem more like debug messages to me. Is this and the message
> below about 5MHz clock on Gemini really necessary ?

Depends on whether one is pr_info()/dev_info() minimalist or
maximalist or something. I guess the extreme minimalist would be
happiest of their dmesg was 0 lines if all is fine. Maybe it could
just say the Linux version.

I even had the idea to add the subsystem maintainers preference
for this to MAINTAINERS.

I tend to like a bit of blather about the state of things in dmesg,
(as in *info has a purpose) but I'm happy to do whatever the
subsystem maintainer likes.

So I can surely cut a whole slew of them if that is your preference?

>> +     gwdt->extclk = devm_clk_get(dev, "EXTCLK");
>> +     if (!IS_ERR(gwdt->extclk)) {
>
> devm_clk_get() can return NULL.

Same answer: should be fine.

>> +     if (gwdt->clk_freq == 0) {
>> +             dev_err(dev, "no clocking available\n");
>> +             return -EINVAL;
>
> So far this situation defaulted to 5 MHz (as there was nothing else).
> Is this a new restriction or did it just not happen ?

This comes from Jonas' Moxart driver.

I guess this only happens if someone compiles out the
clk subsystem so they get frequency 0 from the stub.

The driver strictly needs this frequency
so we cannot really work without it and it needs to fail
over here.

> Also, this can at least in theory happen if clk_get_rate() returns 0,
> which would leave the clock enabled (although that would be an odd
> situation).

Yeah I should clk_disable_unprepare() on the error path,
thanks. Fixing it.

> devm_watchdog_register_device() can fail, which would leave the clocks
> enabled. Also see below.

Fixed it.

>> +     if (!IS_ERR(gwdt->pclk))
>> +             clk_disable_unprepare(gwdt->pclk);
>> +     if (!IS_ERR(gwdt->extclk) && gwdt->use_extclk)
>> +             clk_disable_unprepare(gwdt->extclk);
>
> One of those many situations where devm_clk_prepare_enable() would have
> been very useful :-(. This disables the clocks while the watchdog itself
> as well as its interrupt handler is still registered.

Oh hm yeah. I ran into this thing with the IRQs still being
enabled while the clocking get shut off. It is a problem in the
entire kernel. I don't even have a good intuition for what
order the devm_* things get cleaned up, I guess in the
inverse order that one use them in probe()?

>I don't know if this
> will have adverse affects, but it makes me quite concerned. Please consider
> adding devm_add_action() calls to clean up the clocks.

I don't know if that is a very good idea. If we later get proper
devm_* clock disabling functions then that gets messy
to clean up.

Stephen/Mike: what's your opinion?

> Note that I would
> resist replacing all the devm_ functions with non-devm equivalents just
> because the clock subsystem doesn't provide the necessary API functions.

I've seen people do this for this reason though :/

> Side note: Maybe we _should_ introduce devm_watchdog_clk_prepare_enable()
> since this problem affects several watchdog drivers.

Hmmmmmmmmm a special watchdog primitive may be apropriate.
Dunno what the clk maintainers think?

Stephen/Mike: do you like that or would you rather see a primitive
inside the clock subsystem for this?

Yours,
Linus Walleij
