Return-Path: <linus.walleij@linaro.org>
Return-path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170814150434.GH14491@roeck-us.net>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-10-linus.walleij@linaro.org> <20170814150434.GH14491@roeck-us.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 Aug 2017 22:41:56 +0200
Message-ID: <CACRpkdYVHXqX-f6hvP4Qhi4+vawyiqdzqRamH_JbbHec2cEf9Q@mail.gmail.com>
Subject: Re: [PATCH 09/11] watchdog: ftwdt010/aspeed: Merge Aspeed into FTWDT010
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, Jonas Jensen <jonas.jensen@gmail.com>,
	Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Aug 14, 2017 at 5:04 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Sat, Aug 12, 2017 at 08:43:16PM +0200, Linus Walleij wrote:
>> These two drivers is for the almost the same hardware,
>> the only differences are:
>> - The Aspeed IP block has been hacked to use a different
>>   magic value.
>> - The Aspeed has hard-wired 1MHz to the EXTCLK and
>>   apparently even disabled the use of PCLK for clocking
>>   the block on AST2500.
>>
> Confused. I thought the ast2500 is an EC. Am I missing something ?

Sorry I'm confused too now... What is EC?
Can you spell out that acronym, I never heard
it, or forgot it.

Yours,
Linus Walleij
