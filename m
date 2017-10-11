Return-Path: <linus.walleij@linaro.org>
Return-path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1507693686.5452.174.camel@aj.id.au>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-12-linus.walleij@linaro.org> <1507693686.5452.174.camel@aj.id.au>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Oct 2017 08:32:49 +0200
Message-ID: <CACRpkdYQ8WE_-nVza=GnNBvfXV=WpcEipoJhVVn=atcqyQZbpw@mail.gmail.com>
Subject: Re: [PATCH 11/11] ARM: dts: Add PCLK to the Aspeed watchdogs
To: Andrew Jeffery <andrew@aj.id.au>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Jonas Jensen <jonas.jensen@gmail.com>, Joel Stanley <joel@jms.id.au>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Oct 11, 2017 at 5:48 AM, Andrew Jeffery <andrew@aj.id.au> wrote:
> On Sat, 2017-08-12 at 20:43 +0200, Linus Walleij wrote:
>> This adds the PCLK clock to the Aspeed watchdog blocks.
>> I am not directly familiar with the Aspeed clocking, but
>> since the IP is derived from Faraday FTWDT010 it probably
>> has the ability to run the watchdog on the PCLK if
>> desired
>
> This is true for the AST2400, but not the AST2500 where the only option
> is EXTCLK (1MHz).

The IP block/cell certainly has a PCLK even if it cannot be used
to drive the watchdog timer. It is necessary to interface the
SoC interconnect.

>> > +                           clocks = <&clk_apb>;
>> +                             clock-names = "PCLK";
>
> Given the comment above, shouldn't we be doing something like the
> following instead for each of the watchdogs?
>
> +                               faraday,use-extclk;
> +                               clock-names = "EXTCLK";

So that will be added too, later, when there is a 1MHz clock
to reference in the device tree. I guess after Joel's patches.

Yours,
Linus Walleij
