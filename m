Return-Path: <linus.walleij@linaro.org>
Return-path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <CACPK8XetQJ_=CD4TPOmyigQZv2pRankWYew31Yf_ep4fai6X-g@mail.gmail.com>
References: <20170812184318.10144-1-linus.walleij@linaro.org> <CACPK8XetQJ_=CD4TPOmyigQZv2pRankWYew31Yf_ep4fai6X-g@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 14 Aug 2017 14:31:35 +0200
Message-ID: <CACRpkdbXsE9KM62Pu1y_AwCGfspkA=pwHkvJb5jXoZD09f6-mA@mail.gmail.com>
Subject: Re: [PATCH 00/11] watchdog: Consolidate FTWDT010 derivatives
To: Joel Stanley <joel@jms.id.au>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Jonas Jensen <jonas.jensen@gmail.com>, Andrew Jeffery <andrew@aj.id.au>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Aug 14, 2017 at 3:24 AM, Joel Stanley <joel@jms.id.au> wrote:
> On Sun, Aug 13, 2017 at 4:13 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> The MOXA ART and Aspeed watchdogs are clearly based on the
>> Faraday Technology FTWDT010 IP block.
>
> They have a similar register interface, but I'm told they are not the same IP.

They are too similar to not be related somehow.

I guess it is one of those Shanzhai-mindset things where IP VHDL
or Verilog code is being copied around at silicon foundries in Asia
and turn up in different chips "independently" of each other.

It doesn't really matter if they "are" the same (as in: silicon vendor
admits that they are), if it walks like a duck, act and talks like a duck,
it is a duck. And we use the same driver.

> We've got some patches on the list that add some extra registers to
> the driver for the ast2500. If we decide to merge the drivers, that
> support will need to be included.

Hm I was not aware, need to read up on it.

> Andrew was working on that, I'll let him follow up on the details.
>
> The clock isn't called PCLK in the Aspeed documentation (similarly for
> the timer, but I was too slow to speak up in that case).

"PCLK" is just short for "peripheral block", just like other such
shorthands like "APB" (AMBA peripheral bridge clock). It's
a generic term.

Preferrably it should use the name from the IP vendor, but when in
conflict about names, it's too much trouble to use different names
IMO so I think "PCLK" is just fine.

Yours,
Linus Walleij
